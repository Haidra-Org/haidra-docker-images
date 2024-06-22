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

group "default" {
  targets = ["${IMAGE_NAME}"]
}

target "ai-horde-postgres" {
  context = "./${PROJECT_PATH}"
  dockerfile = "Dockerfile"
  tags = ["ghcr.io/${REPO_OWNER}/${IMAGE_NAME}:latest"]
  labels = {
    "org.opencontainers.image.title" = "${IMAGE_NAME}"
    "org.opencontainers.image.description" = "${IMAGE_PURPOSE} configured for use by the AI Horde"
    "org.opencontainers.image.version" = "latest"
    "org.opencontainers.image.url" = "https://github.com/${REPO_OWNER}/haidra-docker-images/tree/release/${PROJECT_PATH}"
    "org.opencontainers.image.source" = "https://github.com/${REPO_OWNER}/haidra-docker-images/tree/release/${PROJECT_PATH}"
    "org.opencontainers.image.licenses" = "AGPL-3.0"
    "org.opencontainers.image.authors" = "${REPO_OWNER}"
  }
}
