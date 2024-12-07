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

### Submodule Contribution Workflow 🧩

#### Understanding Vaani's Submodule Structure

Vaani uses Git submodules to manage interconnected components. This means each submodule is a separate Git repository nested within the main project.

#### Working with Submodules

1. **Identifying Submodules**:
   - List all submodules in the project
   ```bash
   git submodule status
   ```

2. **Initializing Submodules**:
   ```bash
   # Ensure all submodules are initialized
   git submodule update --init --recursive
   ```

3. **Contributing to a Specific Submodule**:

   a. **Navigate to Submodule Directory**:
      ```bash
      cd path/to/submodule
      ```

   b. **Create a Separate Branch**:
      ```bash
      git checkout -b feature/your-submodule-feature
      ```

   c. **Make and Commit Changes**:
      ```bash
      # Stage changes
      git add .
      
      # Commit with descriptive message
      git commit -m "feat(submodule): describe specific change"
      ```

   d. **Push Submodule Changes**:
      ```bash
      git push origin feature/your-submodule-feature
      ```

4. **Updating Submodule References**:
   After making changes to a submodule:
   ```bash
   # From the main repository root
   git add path/to/submodule
   git commit -m "Update submodule reference to latest changes"
   ```

5. **Pulling Latest Submodule Changes**:
   ```bash
   # Update all submodules
   git submodule update --recursive --remote
   
   # Or update a specific submodule
   git submodule update --remote path/to/specific/submodule
   ```

#### Submodule Contribution Best Practices

- Always work in a feature branch within the submodule
- Ensure submodule changes do not break the main application
- Write tests for submodule-specific changes
- Update documentation if the submodule's interface changes
- Create a pull request for the submodule first, then update the main project's submodule reference

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

### Signing the app

once the keystore is created, you can sign the app with the keystore.

but for github action you need to make a base64 encoded string of the keystore.

```bash
# convert keystore to base64
cat android/key.properties | base64 > key.base64

# convert keystore to base64
cat android/upload.jks | base64 > keystore.base64
```

## Communication

* [Open an Issue](https://github.com/Dr-Blank/Vaani/issues)
* [Discussion Forum](https://github.com/Dr-Blank/Vaani/discussions)

## Code of Conduct

* Be respectful and inclusive
* Constructive feedback is welcome
* Collaborate and support fellow contributors

Happy Contributing! 🌟