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
	bun install

# Build executables using pkg
build: install
	@echo "Building executables..."
	bun run build
	@ls -ltr random-number-generator-*

# Run the script directly with bun
run: install
	@echo "Running random number generator..."
	bun $(SCRIPT_NAME)

# Run with a specific seed
seed-run: install
	@echo "Running with seed: $(SEED)"
	@if [ -z "$(SEED)" ]; then \
		echo "Usage: make seed-run SEED=12345"; \
		exit 1; \
	fi
	bun $(SCRIPT_NAME) $(SEED)

# Test the script with different seeds
test: install
	@echo "Testing with different seeds..."
	@echo "=== Test 1: Timestamp seed ==="
	@bun $(SCRIPT_NAME)
	@echo ""
	@echo "=== Test 2: Seed 'hello' ==="
	@bun $(SCRIPT_NAME) hello
	@echo ""
	@echo "=== Test 3: Seed 1906 ==="
	@bun $(SCRIPT_NAME) 1906

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	rm -f random-number-generator-*
	rm -f report.txt

# Clean everything including node_modules
nuke: clean
	@echo "Cleaning all dependencies..."
	rm -vf bun.lock package-lock.json
	rm -vf .*.bun-build
	rm -rvf node_modules

.PHONY: all install build run seed-run test clean nuke
