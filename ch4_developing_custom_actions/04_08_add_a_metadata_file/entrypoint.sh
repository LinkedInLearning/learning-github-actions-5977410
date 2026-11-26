#!/bin/bash
set -e

# Entrypoint for test-scout GitHub Action

# Outline for test-scout action
# 1. Count total Python files (*.py)
# 2. Count test files based on pattern (default: test_*.py)
# 3. If no test files are found, do something (warn or fail)
# 4. Otherwise, exit gracefully

# --- CONFIG ---
DEFAULT_PATTERN="test_*.py"
PATTERN="${INPUT_PATTERN:-$DEFAULT_PATTERN}"
STRICT_MODE="${INPUT_STRICT_MODE:-false}"

echo "🧭 test-scout is running..."

# --- CONFIG ---
DEFAULT_PATTERN="test_*.py"
PATTERN="${INPUT_PATTERN:-$DEFAULT_PATTERN}"
STRICT_MODE="${INPUT_STRICT_MODE:-false}"

# --- GITHUB CONTEXT ---
REPO="${GITHUB_REPOSITORY:-local/dev}"
WORKSPACE="${GITHUB_WORKSPACE:-$PWD}"
RUN_ID="${GITHUB_RUN_ID:-Null}"

echo "🧭 Repository.         : $REPO"
echo "📁 Workspace directory : $WORKSPACE"
echo "🏃 Workflow run ID     : $RUN_ID"
echo "🔍 Test file pattern.  : $PATTERN"

# --- SEARCH FILESYSTEM ---
PY_FILES=$(find "$WORKSPACE" -type f -name "*.py")
TOTAL_PY_FILES=$(echo "$PY_FILES" | grep -c . || true)

# If no Python files are found, exit successfully
if [[ "$TOTAL_PY_FILES" -eq 0 ]]; then
  echo "ℹ️ No Python files found in the repo. Nothing to do."
  echo
  exit 0
fi

TEST_FILES=$(find "$WORKSPACE" -type f -name "$PATTERN")
TOTAL_TESTS=$(echo "$TEST_FILES" | grep -c . || true)

# --- REPORTING ---
echo -e "\n📊 Summary:"
echo "🧾 Python files found: $TOTAL_PY_FILES"
echo "🧪 Test files matching '$PATTERN': $TOTAL_TESTS"

# --- OUTCOME ---
if [[ "$TOTAL_TESTS" -eq 0 ]]; then
  echo "⚠️ No test files found!"
  if [[ "$STRICT_MODE" == "true" ]]; then
    echo "🚫 STRICT_MODE is enabled — failing the workflow."
    echo
    exit 1
  fi
else
  echo "✅ Test files detected. All good!"
fi

echo
exit 0
