# Homebrew Formula for PyVisionAI

This directory contains the Homebrew formula for installing PyVisionAI.

## Formula Structure

- `Formula/pyvisionai.rb`: The main Homebrew formula file
  - Defines dependencies (Python, LibreOffice, Poppler)
  - Handles installation process
  - Sets up virtual environment
  - Installs Playwright and its dependencies
  - Provides post-installation instructions

## Updating the Formula

1. After creating a new release:
   ```bash
   # Get the tarball URL
   VERSION="v0.1.0"  # Update this
   URL="https://github.com/MDGrey33/pyvisionai/archive/refs/tags/${VERSION}.tar.gz"

   # Download and generate SHA256
   curl -L $URL | shasum -a 256
   ```

2. Update `Formula/pyvisionai.rb`:
   - Update the version in the URL
   - Update the SHA256 hash
   - Test the formula locally

3. Test Installation:
   ```bash
   brew install --build-from-source ./Formula/pyvisionai.rb
   ```

## Dependencies

The formula manages:
- Python 3.8 or higher
- LibreOffice (via cask)
- Poppler
- Playwright and its browser dependencies

## Post-Installation

The formula will:
1. Create a Python virtual environment
2. Install PyVisionAI and its dependencies
3. Install and set up Playwright
4. Display instructions for API key and Ollama setup
