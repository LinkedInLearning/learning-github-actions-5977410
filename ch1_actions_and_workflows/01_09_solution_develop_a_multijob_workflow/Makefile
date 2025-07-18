.PHONY: format build run clean

# Default target
all: clean format build run

# Format Go code
format:
	go fmt main.go

# Build the Go program
build:
	go build -o main main.go

# Run the Go program
run:
	go run main.go

# Clean build artifacts
clean:
	rm -f main

# Format and run in one command
dev: format run
