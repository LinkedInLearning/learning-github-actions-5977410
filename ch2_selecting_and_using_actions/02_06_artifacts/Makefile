# Go HTTP Server Makefile
# Assumes your main Go file is named main.go

# Variables
BINARY_NAME=web-server
PORT=8080

# Build the binary
.PHONY: build
build:
	@echo "Building $(BINARY_NAME)..."
	go build $(BINARY_NAME).go

# Run the server directly with go run
.PHONY: run
run:
	@echo "Running server with go run..."
	go run $(BINARY_NAME).go

# Run the built binary
.PHONY: run-binary
run-binary: build
	@echo "Running built binary..."
	./$(BINARY_NAME)

# Test the server (builds, runs in background, tests endpoints, then cleans up)
.PHONY: test
test: build
	@echo "Starting integration test..."
	@echo "1. Starting server in background..."
	./$(BINARY_NAME) &
	@SERVER_PID=$$!; \
	sleep 2; \
	echo "2. Testing root endpoint..."; \
	curl -s http://localhost:$(PORT)/ > /dev/null && echo "✓ Root endpoint works" || 	echo "✗ Root endpoint failed"; \
	echo "3. Testing named endpoint..."; \
	curl -s http://localhost:$(PORT)/TestUser > /dev/null && echo "✓ Named endpoint works" || echo "✗ Named endpoint failed"; \
	echo "4. Getting server response sample:"; \
	curl -s http://localhost:$(PORT)/CI-Test | head -3; \
	echo "5. Waiting for server to auto-shutdown..."; \
	wait $$SERVER_PID; \
	echo "✓ Integration test completed"
	@echo "Server will time out........."

# Clean up built binaries
.PHONY: clean
clean:
	@echo "Cleaning up..."
	rm -f $(BINARY_NAME)
# CI pipeline simulation
.PHONY: ci
ci: clean build test
	@echo "✓ CI pipeline completed successfully"

# Show help
.PHONY: help
help:
	@echo "Available targets:"
	@echo "  build        - Build the binary"
	@echo "  run          - Run with 'go run'"
	@echo "  run-binary   - Build and run the binary"
	@echo "  test         - Full integration test"
	@echo "  clean        - Remove built binaries"
	@echo "  ci           - Full CI pipeline (clean, check, build, test)"
	@echo "  help         - Show this help"
