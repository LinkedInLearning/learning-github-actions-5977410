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
	"strings"
	"sync"
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
	srv := &http.Server{Addr: ":8080"}

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

func main() {
	// add more time here to let the server run longer
	sleepTime := 10 * time.Second

	printBanner()
	log.Printf("\033[1;32m[INFO]\033[0m main: starting HTTP server")
	log.Printf("\033[1;32m[INFO]\033[0m main: access the server via http://localhost:8080")

	httpServerExitDone := &sync.WaitGroup{}

	httpServerExitDone.Add(1)
	srv := startHttpServer(httpServerExitDone)

	log.Printf("\033[1;34m[INFO]\033[0m main: serving for 10 seconds")

	time.Sleep(sleepTime)

	log.Printf("\033[1;31m[INFO]\033[0m main: stopping HTTP server")

	// now close the server gracefully ("shutdown")
	// timeout could be given with a proper context
	// (in real world you shouldn't use TODO()).
	if err := srv.Shutdown(context.TODO()); err != nil {
		panic(err) // failure/timeout shutting down the server gracefully
	}

	// wait for goroutine started in startHttpServer() to stop
	httpServerExitDone.Wait()

	log.Printf("\033[1;32m[INFO]\033[0m main: done. exiting")
}
