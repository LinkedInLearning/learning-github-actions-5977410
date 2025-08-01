# Default test pattern
PATTERN ?= test_*.py
IMAGE_NAME := test-scout

# Build the Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Run container using current directory
run:
	docker run --rm \
		-v $(PWD):/workspace \
		-w /workspace \
		-e STRICT_MODE=$(STRICT_MODE) \
		$(IMAGE_NAME) $(PATTERN)

# Run tests with the script
script-test:
	echo "\nTest 1: No Python files present"
	rm -f test_*.py *.py
	./entrypoint.sh $(PATTERN)

	echo "\nTest 2: Python files present, but no test files"
	echo "print('Hello, world')" > app.py
	./entrypoint.sh $(PATTERN)
	rm -f app.py

	echo "\nTest 3: Python files and matching test files present"
	echo "print('Hello, world')" > app.py
	echo "def test_sample(): pass" > test_utils.py
	./entrypoint.sh $(PATTERN)
	rm -f app.py test_utils.py

	echo "\nTest 4: STRICT_MODE enabled with no test files (expected failure)"
	echo "print('just a script')" > lonely.py
	-STRICT_MODE=true ./entrypoint.sh $(PATTERN) || echo "⚠️ Expected failure occurred"
	rm -f lonely.py

	echo "\n✅ Test suite complete!"

# Run tests with the image
image-test: build
	echo "\nTest 1: No Python files present"
	rm -f test_*.py *.py
	$(MAKE) --no-print-directory run

	echo "\nTest 2: Python files present, but no test files"
	echo "print('Hello, world')" > app.py
	$(MAKE) --no-print-directory run
	rm -f app.py

	echo "\nTest 3: Python files and matching test files present"
	echo "print('Hello, world')" > app.py
	echo "def test_sample(): pass" > test_utils.py
	$(MAKE) --no-print-directory run
	rm -f app.py test_utils.py

	echo "\nTest 4: STRICT_MODE enabled with no test files (expected failure)"
	echo "print('just a script')" > lonely.py
	-$(MAKE) --no-print-directory run STRICT_MODE=true \
		|| echo "⚠️ Expected failure occurred"
	rm -f lonely.py

	echo "\n✅ Test suite complete!"

.SILENT: script-test image-test
.PHONY: build run script-test image-test
