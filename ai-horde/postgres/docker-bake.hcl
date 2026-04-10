variable "REPO_OWNER" {
  default = "haidra-org"
}

variable "INTENDED_PROJECT" {
  default = "ai-horde"
}

variable "IMAGE_PURPOSE" {
  default = "postgres"
}

variable "IMAGE_NAME" {
  default = "ai-horde-postgres"
}

variable "PROJECT_PATH" {
  default = "${INTENDED_PROJECT}/${IMAGE_PURPOSE}"
}

# Keep in sync with the matrix in .github/workflows/publish.yml and freshness.yml
variable "PG_VERSIONS" {
  default = ["14", "15", "16", "17", "18"]
}

variable "LATEST_PG_VERSION" {
  default = "18"
}

# Set by CI to record which upstream postgres digest was used
variable "BASE_DIGEST" {
  default = ""
}

group "default" {
  targets = ["ai-horde-postgres"]
}

target "ai-horde-postgres" {
  matrix = {
    pg_version = PG_VERSIONS
  }
  name       = "ai-horde-postgres-pg${pg_version}"
  context    = "./${PROJECT_PATH}"
  dockerfile = "Dockerfile"
  args = {
    PG_MAJOR = pg_version
  }
  tags = concat(
    ["ghcr.io/${REPO_OWNER}/${IMAGE_NAME}:pg${pg_version}"],
    equal(pg_version, LATEST_PG_VERSION) ? ["ghcr.io/${REPO_OWNER}/${IMAGE_NAME}:latest"] : []
  )
  labels = {
    "org.opencontainers.image.title"       = "${IMAGE_NAME}"
    "org.opencontainers.image.description" = "PostgreSQL ${pg_version} with pg_cron for use by the AI Horde"
    "org.opencontainers.image.version"     = "pg${pg_version}"
    "org.opencontainers.image.url"         = "https://github.com/${REPO_OWNER}/haidra-docker-images/tree/release/${PROJECT_PATH}"
    "org.opencontainers.image.source"      = "https://github.com/${REPO_OWNER}/haidra-docker-images/tree/release/${PROJECT_PATH}"
    "org.opencontainers.image.licenses"    = "AGPL-3.0"
    "org.opencontainers.image.authors"     = "${REPO_OWNER}"
    "org.opencontainers.image.base.digest" = BASE_DIGEST
  }
}
