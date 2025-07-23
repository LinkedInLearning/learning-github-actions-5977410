# Makefile for the Random Number Generator

# Variables
SCRIPT_NAME = random-number-generator.js

# Automatically detect platform and set package name
UNAME_S := $(shell uname -s)
UNAME_M := $(shell uname -m)

# Determine package name based on platform
ifeq ($(UNAME_S),Darwin)
    ifeq ($(UNAME_M),arm64)
        PACKAGE_NAME = random-number-generator-macos-arm64
    else
        PACKAGE_NAME = random-number-generator-macos-x64
    endif
else ifeq ($(UNAME_S),Linux)
    PACKAGE_NAME = random-number-generator-linux-x64
else ifeq ($(OS),Windows_NT)
    PACKAGE_NAME = random-number-generator-win-x64.exe
else
    # Fallback for unknown platforms
    PACKAGE_NAME = random-number-generator-unknown
endif

# Default target
all: clean test build run

# Install dependencies
install:
	@echo "Installing dependencies..."
	npm install

# Build executables using pkg
build: install
	@echo "Building executables..."
	npm run build
	@ls -ltr random-number-generator-*

# Run the script directly with Node.js
run: install
	@echo "Running random number generator..."
	node $(SCRIPT_NAME)

# Run with a specific seed
seed-run: install
	@echo "Running with seed: $(SEED)"
	@if [ -z "$(SEED)" ]; then \
		echo "Usage: make seed-run SEED=12345"; \
		exit 1; \
	fi
	node $(SCRIPT_NAME) $(SEED)

# Test the script with different seeds
test: install
	@echo "Testing with different seeds..."
	@echo "=== Test 1: Default seed ==="
	node $(SCRIPT_NAME)
	@echo ""
	@echo "=== Test 2: Seed 42 ==="
	node $(SCRIPT_NAME) 42
	@echo ""
	@echo "=== Test 3: Seed 'hello' ==="
	node $(SCRIPT_NAME) hello
	@echo ""
	@echo "=== Test 4: Seed 999999 ==="
	node $(SCRIPT_NAME) 999999

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -f random-number-generator-macos-arm64
	rm -f random-number-generator-macos-x64
	rm -f random-number-generator-linux-x64
	rm -f random-number-generator-win-x64.exe
	rm -f random-number-generator-unknown
	rm -f report.txt

# Clean everything including node_modules
nuke: clean
	@echo "Cleaning all dependencies..."
	rm -rf node_modules
	rm -f package-lock.json

.PHONY: all install build run seed-run test clean nuke
