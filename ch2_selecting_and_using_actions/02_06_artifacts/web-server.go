// Credits:
// https://yourbasic.org/golang/http-server-example/
// https://stackoverflow.com/a/42533360/2308522
// https://www.digitalocean.com/community/tutorials/how-to-build-go-executables-for-multiple-platforms-on-ubuntu-16-04
package main

import (
	"context"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"os"
	"os/signal"
	"strings"
	"sync"
	"syscall"
	"time"
)

func printBanner() {
	banner := `
 __        __   _
 \ \      / /__| | ___ ___  _ __ ___   ___
  \ \ /\ / / _ \ |/ __/ _ \| '_ ' _ \ / _ \
   \ V  V /  __/ | (_| (_) | | | | | |  __/
    \_/\_/ \___|_|\___\___/|_| |_| |_|\___|
`
	fmt.Println("\033[1;36m" + banner + "\033[0m")
}

func randomFact() string {
	facts := []string{
		"Go was developed at Google in 2007.",
		"The mascot of Go is a gopher.",
		"Go compiles very quickly.",
		"Go has built-in concurrency support.",
		"Go is sometimes called Golang.",
	}
	return facts[rand.Intn(len(facts))]
}

func startHttpServer(wg *sync.WaitGroup) *http.Server {
	srv := &http.Server{
		Addr:         ":8080",
		ReadTimeout:  15 * time.Second,
		WriteTimeout: 15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		// Log request details
		log.Printf("\033[1;33m[REQUEST]\033[0m %s %s from %s", r.Method, r.URL.Path, r.RemoteAddr)

		name := strings.TrimPrefix(r.URL.Path, "/")
		if name == "" {
			name = "World"
		}
		currentTime := time.Now().Format("Mon Jan 2 15:04:05 MST 2006")
		fact := randomFact()
		response := fmt.Sprintf(`<!DOCTYPE html>
<html>
<head><title>Hello, %s!</title></head>
<body style=\"font-family:sans-serif;\">
	<h1 style=\"color:#2d8cf0;\">Hello, %s!</h1>
	<p>Current server time: <b>%s</b></p>
	<p>Fun fact: <i>%s</i></p>
</body>
</html>`, name, name, currentTime, fact)
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		fmt.Fprint(w, response)
	})

	go func() {
		defer wg.Done() // let main know we are done cleaning up

		// always returns error. ErrServerClosed on graceful close
		if err := srv.ListenAndServe(); err != http.ErrServerClosed {
			// unexpected error. port in use?
			log.Fatalf("ListenAndServe(): %v", err)
		}
	}()

	// returning reference so caller can call Shutdown()
	return srv
}

func gracefulShutdown(srv *http.Server) {
	// Create a context with a reasonable timeout for shutdown
	// 30 seconds should be enough for most applications
	shutdownCtx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
	defer cancel()

	log.Printf("\033[1;31m[INFO]\033[0m main: initiating graceful shutdown with 30s timeout")

	// Attempt graceful shutdown
	if err := srv.Shutdown(shutdownCtx); err != nil {
		// Log the error instead of panicking in production
		log.Printf("\033[1;31m[ERROR]\033[0m Server forced to shutdown due to timeout: %v", err)

		// Optional: Force close if graceful shutdown fails
		if closeErr := srv.Close(); closeErr != nil {
			log.Printf("\033[1;31m[ERROR]\033[0m Error force-closing server: %v", closeErr)
		}
	} else {
		log.Printf("\033[1;32m[INFO]\033[0m Server gracefully stopped")
	}
}

func main() {
	// Configuration for demo/CI purposes - set how long to run
	sleepTime := 10 * time.Second // Change this for your CI needs (1-15 seconds)

	// Set up signal handling for graceful shutdown
	quit := make(chan os.Signal, 1)
	signal.Notify(quit, syscall.SIGINT, syscall.SIGTERM)

	printBanner()
	log.Printf("\033[1;32m[INFO]\033[0m main: starting HTTP server")
	log.Printf("\033[1;32m[INFO]\033[0m main: access the server via http://localhost:8080")
	log.Printf("\033[1;32m[INFO]\033[0m main: server will auto-stop after %v (or press Ctrl+C)", sleepTime)

	httpServerExitDone := &sync.WaitGroup{}

	httpServerExitDone.Add(1)
	srv := startHttpServer(httpServerExitDone)

	log.Printf("\033[1;34m[INFO]\033[0m main: serving for %v", sleepTime)

	// Wait for either timeout or interrupt signal
	select {
	case <-time.After(sleepTime):
		log.Printf("\033[1;31m[INFO]\033[0m main: timeout reached, stopping HTTP server")
	case <-quit:
		log.Printf("\033[1;31m[INFO]\033[0m main: shutdown signal received, stopping HTTP server")
	}

	// Use the production-ready graceful shutdown
	gracefulShutdown(srv)

	// wait for goroutine started in startHttpServer() to stop
	httpServerExitDone.Wait()

	log.Printf("\033[1;32m[INFO]\033[0m main: done. exiting")
}
