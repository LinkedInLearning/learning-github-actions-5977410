#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
# Pipestatus is non-zero if any command in a pipeline fails.
set -euo pipefail

# --- Helper for colored output ---
readonly COLOR_BLUE='\033[0;34m'
readonly COLOR_GREEN='\033[0;32m'
readonly COLOR_NONE='\033[0m'

info() {
  printf "${COLOR_BLUE}%s${COLOR_NONE}\n" "$1"
}

success() {
  printf "${COLOR_GREEN}%s${COLOR_NONE}\n" "$1"
}

# --- User Input & Validation ---
GITHUB_USER_NAME=""
while [ -z "$GITHUB_USER_NAME" ]; do
  read -p "Enter your GitHub username: " GITHUB_USER_NAME
done

GITHUB_REPO_NAME=""
while [ -z "$GITHUB_REPO_NAME" ]; do
  read -p "Enter your GitHub repository name: " GITHUB_REPO_NAME
done

read -p "Enter your desired GCP region (default: us-central1): " REGION
REGION=${REGION:-us-central1}

echo
info "--- Configuration ---"
echo "- GitHub User:    $GITHUB_USER_NAME"
echo "- GitHub Repo:    $GITHUB_REPO_NAME"
echo "- GCP Region:     $REGION"
echo

# --- GCP Project Configuration ---
PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects describe "$PROJECT_ID" --format="value(projectNumber)")

info "--- Using project $PROJECT_ID (Number: $PROJECT_NUMBER) ---"

# Enable required GCP services
info "Enabling required GCP APIs..."
# Note: artifactregistry.googleapis.com is used for Artifact Registry.
gcloud services enable \
  iamcredentials.googleapis.com \
  cloudbuild.googleapis.com \
  run.googleapis.com \
  artifactregistry.googleapis.com \
  --project="$PROJECT_ID"

# --- Workload Identity Federation Setup ---
POOL_ID="github-pool"
PROVIDER_ID="github-provider"

info "Checking for Workload Identity Pool..."
if ! gcloud iam workload-identity-pools describe "$POOL_ID" --location="global" --project="$PROJECT_ID" &>/dev/null; then
  info "Creating Workload Identity Pool '$POOL_ID'..."
  gcloud iam workload-identity-pools create "$POOL_ID" \
    --project="$PROJECT_ID" \
    --location="global" \
    --display-name="GitHub Actions Pool"
else
  info "Workload Identity Pool '$POOL_ID' already exists."
fi

info "Checking for Workload Identity Provider..."
if ! gcloud iam workload-identity-pools providers describe "$PROVIDER_ID" --location="global" --workload-identity-pool="$POOL_ID" --project="$PROJECT_ID" &>/dev/null; then
  info "Creating Workload Identity Provider '$PROVIDER_ID'..."
  gcloud iam workload-identity-pools providers create-oidc "$PROVIDER_ID" \
    --project="$PROJECT_ID" \
    --location="global" \
    --workload-identity-pool="$POOL_ID" \
    --display-name="GitHub OIDC Provider" \
    --issuer-uri="https://token.actions.githubusercontent.com" \
    --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
    --attribute-condition="assertion.repository_owner=='$GITHUB_USER_NAME'"
else
  info "Workload Identity Provider '$PROVIDER_ID' already exists."
fi

# --- Artifact Registry Setup ---
info "Checking for Artifact Registry repository..."
if ! gcloud artifacts repositories describe "${GITHUB_REPO_NAME}" --location="${REGION}" --project="$PROJECT_ID" &>/dev/null; then
  info "Creating Artifact Registry repository '${GITHUB_REPO_NAME}'..."
  gcloud artifacts repositories create "${GITHUB_REPO_NAME}" \
    --project="$PROJECT_ID" \
    --location="${REGION}" \
    --repository-format="docker" \
    --description="Docker repository for ${GITHUB_REPO_NAME}"
else
  info "Artifact Registry repository '${GITHUB_REPO_NAME}' already exists."
fi

# --- Service Account Setup ---
SERVICE_ACCOUNT_NAME="${GITHUB_REPO_NAME}-sa" # Using a shorter suffix
SERVICE_ACCOUNT_EMAIL="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

info "Checking for Service Account..."
if ! gcloud iam service-accounts describe "$SERVICE_ACCOUNT_EMAIL" --project="$PROJECT_ID" &>/dev/null; then
  info "Creating Service Account '$SERVICE_ACCOUNT_NAME'..."
  gcloud iam service-accounts create "$SERVICE_ACCOUNT_NAME" \
    --project="$PROJECT_ID" \
    --display-name="GitHub Actions SA for ${GITHUB_REPO_NAME}"
else
  info "Service Account '$SERVICE_ACCOUNT_NAME' already exists."
fi

# Add IAM policy bindings
info "Assigning IAM roles to Service Account..."

gcloud iam service-accounts add-iam-policy-binding \
  ${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/iam.serviceAccountUser"

# Grant Artifact Registry Writer role to push images.
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/artifactregistry.writer"

# Grant Cloud Run Admin role to deploy and manage Cloud Run services.
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:${SERVICE_ACCOUNT_EMAIL}" \
  --role="roles/run.admin"

# Grant the Service Account permission to be impersonated by GitHub Actions.
# This binding allows identities from a specific GitHub repo to impersonate the SA.
gcloud iam service-accounts add-iam-policy-binding \
  "$SERVICE_ACCOUNT_EMAIL" \
  --project="$PROJECT_ID" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/github-pool/attribute.repository/${GITHUB_USER_NAME}/${GITHUB_REPO_NAME}"

WORKLOAD_PROVIDER=$(gcloud iam workload-identity-pools providers describe github-provider \
  --project="$PROJECT_ID" \
  --location="global" \
  --workload-identity-pool="github-pool" \
  --format="value(name)")

echo
info "----------------------------------------------------------------"
success "✅ Setup complete. Add the following as GitHub repository secrets:"
info "----------------------------------------------------------------"
printf "GCP_PROJECT_ID: %s\n" "$PROJECT_ID"
printf "GCP_REGION: %s\n" "$REGION"
printf "GCP_REGISTRY_NAME: %s\n" "$GITHUB_REPO_NAME"
printf "GCP_SERVICE_ACCOUNT: %s\n" "$SERVICE_ACCOUNT_EMAIL"
printf "GCP_WORKLOAD_IDENTITY_PROVIDER: %s\n" "$WORKLOAD_PROVIDER"
echo
