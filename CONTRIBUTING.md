# Contributing to Vaani

## Welcome Contributors! 🚀

We appreciate your interest in contributing to Vaani. This guide will help you navigate the contribution process effectively.

## How to Contribute

### Reporting Bugs 🐞

1. **Check Existing Issues**: 
   - Search through the [GitHub Issues](https://github.com/Dr-Blank/Vaani/issues)

2. **Create a Detailed Bug Report**:
   - Provide:

     * Exact steps to reproduce
     * Relevant error logs or screenshots

### Development Workflow

#### Setting Up the Development Environment

1. **Prerequisites**:
   - [Git](https://git-scm.com/)
   - [Flutter SDK](https://flutter.dev/)
   - Recommended IDE: [VS Code](https://code.visualstudio.com/)

2. **Repository Setup**:

   1. [Fork the repo](https://github.com/Dr-Blank/Vaani/fork)
   1. Clone the forked repository to your local machine
      ```bash
         # Fork the main repository on GitHub
         git clone --recursive https://github.com/[YOUR_USERNAME]/Vaani.git
         cd Vaani

         # Initialize and update submodules
         git submodule update --init --recursive

         # Install dependencies for the main app and submodules
         flutter pub get
         ```


#### Coding Standards

1. **Code Style**:
   - Follow [Flutter's style guide](https://dart.dev/guides/language/effective-dart/style)
   - Use `dart format` and `flutter analyze`

   

```bash
   dart format .
   flutter analyze
   ```

2. **Testing**:
   - Write unit and widget tests
   - Ensure tests pass for both the main app and submodules
   

```bash
   flutter test
   ```

### Pull Request Process

1. **Branch Naming**:
   - Use descriptive branch names
   - Prefix with feature/, bugfix/, or docs/
   

```bash
   git checkout -b feature/add-accessibility-support
   ```

2. **Commit Messages**:
   - Use clear, concise descriptions
   - Reference issue numbers when applicable
   - Follow conventional commits format:

 `<type>(scope): <description>`

3. **Pull Request Guidelines**:
   - Clearly describe the purpose of your changes
   - Include screenshots for visual changes
   - Specify if changes affect specific submodules
   - Ensure all CI checks pass

## Communication

* [Open an Issue](https://github.com/Dr-Blank/Vaani/issues)
* [Discussion Forum](https://github.com/Dr-Blank/Vaani/discussions)

## Code of Conduct

* Be respectful and inclusive
* Constructive feedback is welcome
* Collaborate and support fellow contributors

Happy Contributing! 🌟
