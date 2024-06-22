# Haidra-Org docker images
A collection of docker images used by Haidra-Org.
Projects which rely on the images found in this repo for either production deployments or CI/CD:
- [AI-Horde](https://github.com/Haidra-Org/AI-Horde)

## Contributing
### Adding Docker Bake Definitions

To add additional Docker Bake definitions to this repository, follow these steps:

- **Copy Existing Definition**
    - Locate a `docker-bake.hcl` file in the repository (such as found in `ai-horde/postgres/`)
    - Make a copy of this file

- **Modify Variables**
    - Update the appropriate `variable` blocks at the top of the file to reflect the new project or service. This includes:
        - `REPO_OWNER`: The GitHub username or organization name owning the repository.
        - `INTENDED_PROJECT`: The name of the project for which the Docker image is being built.
          - **Important**: This should be the same as the name of the second-level folder
          - For example, `ai-horde` for AI-Horde related images
        - `IMAGE_PURPOSE`: A brief description of what the Docker image is intended for.
          - **Important**: This should be the same as the name of the third-level folder
          - For example `postgres` (as in `ai-horde/postgres/`)
        - `IMAGE_NAME`: The name of the Docker image as published.
    - Update the `target` to match the `IMAGE_NAME`
    - If you need to support multiple images, you should visit the [official docker bake file reference.](https://docs.docker.com/build/bake/reference/).

- **Adjust Labels**
    - Modify the `labels` within the `target` block to reflect the new image's metadata if needed. If you follow the guide above, this is optional.


- **Save and Test**
    - Save your changes to the `docker-bake.hcl` file.
    - Test your new Docker Bake definition by running `docker buildx bake --file ./path/to/docker-bake.hcl`
    - If all is well, open a pull request for the changes to be reviewed and accepted.

Remember, each `target` block defines a buildable Docker image. You can have multiple `target` blocks in a single `docker-bake.hcl` file to manage multiple images within the same project if needed. This may be required for different supported versions of certain software (such as versions of python) or for multiple architectures.