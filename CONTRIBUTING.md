# Contributing to Docker-Ikaros

Thank you for your interest in contributing to Docker-Ikaros! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Issues

If you encounter any problems or have suggestions for improvements:

1. Check the [existing issues](https://github.com/birgerjohansson/docker-ikaros/issues) to avoid duplicates
2. Create a new issue with a clear title and description
3. Include relevant details such as:
   - Your operating system and Docker version
   - Steps to reproduce the problem
   - Expected vs. actual behavior
   - Error messages or logs

### Submitting Pull Requests

1. Fork the repository
2. Create a new branch for your feature or bugfix:
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. Make your changes following the coding standards
4. Test your changes thoroughly
5. Commit your changes with clear, descriptive messages
6. Push to your fork and submit a pull request

### Coding Standards

- Keep the Dockerfile clean and well-commented
- Follow Docker best practices:
  - Minimize the number of layers
  - Use specific version tags where appropriate
  - Clean up temporary files in the same layer they're created
- Update documentation to reflect your changes
- Test the Docker image builds successfully before submitting

### Testing Your Changes

Before submitting a pull request, please test:

1. The Docker image builds successfully:
   ```bash
   docker build -t ikaros:test .
   ```

2. The container runs correctly:
   ```bash
   docker run -i -t ikaros:test /bin/bash
   ```

3. The Ikaros installation works inside the container:
   ```bash
   docker run ikaros:test /ikaros/Bin/ikaros -h
   ```

## Code of Conduct

- Be respectful and inclusive in all interactions
- Focus on constructive feedback
- Help create a welcoming environment for all contributors

## Questions?

If you have questions about contributing, feel free to open an issue with the "question" label.

## License

By contributing to this project, you agree that your contributions will be licensed under the same license as the project.
