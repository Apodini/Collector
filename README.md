## How to use this repository
### Template

When creating a new repository make sure to select this repository as a repository template.

### Customize the repository

Enter your repository specific configuration
- Replace the "Package.swift", "Sources" and "Tests" folder with your own Swift Package
- Enter your project name instead of "ApodiniTemplate" in .jazzy.yml
- Enter the correct test bundle name in the build-and-test.yml file under the "Convert coverage report" step. Most of the time the name is the name of the Project + "PackageTests".
- Update the README with your information and replace the links to the license with the new repository.
- If you create a new repository in the Apodini organzation you do not need to add a personal access token named "ACCESS_TOKEN". If you create the repo outside of the Apodini organization you need to create such a token with write access to the repo for all GitHub Actions to work.

### ⬆️ Remove everything up to here ⬆️

# Project Name

## Requirements

## Installation/Setup/Integration

## Usage

## Regenerate the Protobuf files

To update and regenerate the generated gRPC and Probuf files you need to follow the following instructions:

1. Install the Protocol Buffer Compiler, e.g. using `brew install protobuf`
2. Install the Swift plugins by downloading the latest compiled version at https://github.com/grpc/grpc-swift/releases. Unpack the .zip and move the plugins to a location listed in your PATH variable. You might have to [make them executable](https://support.apple.com/guide/terminal/make-a-file-executable-apdd100908f-06b3-4e63-8a87-32e71241bab4/mac) and run them manually first as they are not signed for macOS.
3. Run `sh generate.sh` in the root of the repo.

## Contributing
Contributions to this projects are welcome. Please make sure to read the [contribution guidelines](https://github.com/Apodini/.github/blob/release/CONTRIBUTING.md) first.

## License
This project is licensed under the MIT License. See [License](https://github.com/Apodini/Template-Repository/blob/release/LICENSE) for more information.
