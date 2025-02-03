# Homebrew PyVisionAI

This is the official Homebrew tap for PyVisionAI, a tool for extracting and describing content from documents using Vision Language Models.

## Installation

```bash
# Add the tap
brew tap mdgrey33/pyvisionai

# Install PyVisionAI
brew install pyvisionai

# Install Playwright browsers (required for web content)
playwright install chromium

# Optional: Install LibreOffice for document processing
brew install --cask libreoffice
```

## Version Compatibility

| Component | Version | Notes |
|-----------|---------|-------|
| Python | 3.11+ | Required for all functionality |
| Playwright | 1.41.0 | Required for web content processing |
| LibreOffice | 7.5+ | Required for document processing features |
| Ollama | 0.1.17+ | Required for local model inference |

## Setup Guide

### 1. Required Setup - OpenAI API Key

For cloud-based image description (recommended):

1. Get your OpenAI API key:
   - Go to [OpenAI API Keys](https://platform.openai.com/api-keys)
   - Create a new API key if you don't have one
   
2. Set up the environment variable:
   ```bash
   export OPENAI_API_KEY='your-api-key'
   ```

3. Make it persistent:
   ```bash
   # For zsh (default on macOS)
   echo 'export OPENAI_API_KEY=your-api-key' >> ~/.zshrc
   source ~/.zshrc

   # For bash
   echo 'export OPENAI_API_KEY=your-api-key' >> ~/.bashrc
   source ~/.bashrc
   ```

### 2. Optional Components

#### Local Image Description
If you want to use local models instead of OpenAI:
```bash
# Install Ollama
brew install ollama

# Pull the vision model
ollama pull llama2-vision

# Start the Ollama service
ollama serve
```

#### Office Document Processing
For full document processing capabilities:
```bash
# Install LibreOffice
brew install --cask libreoffice

# For specific language support (optional)
brew install --cask libreoffice-language-pack
```

## Usage Examples

### Image Description
```bash
# Using OpenAI (requires API key)
describe-image -i path/to/image.jpg -u gpt4

# Using local model (requires Ollama)
describe-image -i path/to/image.jpg -u llama
```

### Document Text Extraction
```bash
# Extract from PDF
file-extract -t pdf -s path/to/document.pdf -o output/dir

# Extract from Word document
file-extract -t docx -s path/to/document.docx -o output/dir

# Extract from PowerPoint
file-extract -t pptx -s path/to/presentation.pptx -o output/dir
```

## Troubleshooting

### Common Issues

1. **Installation Issues**
   ```bash
   # If installation fails, try:
   brew update && brew upgrade
   brew uninstall pyvisionai
   brew install pyvisionai
   
   # If you get permission errors:
   sudo chown -R $(whoami) $(brew --prefix)/*
   ```

2. **Playwright Issues**
   ```bash
   # Reinstall Playwright
   /opt/homebrew/opt/pyvisionai/libexec/bin/pip install playwright==1.41.0
   
   # Reinstall browsers
   /opt/homebrew/opt/pyvisionai/libexec/bin/playwright install chromium
   
   # If you get browser launch errors:
   /opt/homebrew/opt/pyvisionai/libexec/bin/playwright install-deps
   ```

3. **LibreOffice Issues**
   - Ensure LibreOffice is installed: `brew install --cask libreoffice`
   - Check if LibreOffice is in PATH: `which libreoffice`
   - If document processing fails:
     ```bash
     # Verify LibreOffice installation
     /Applications/LibreOffice.app/Contents/MacOS/soffice --version
     
     # Try reinstalling
     brew uninstall --cask libreoffice
     brew install --cask libreoffice
     ```

4. **Python Environment Issues**
   ```bash
   # Check installed packages
   /opt/homebrew/opt/pyvisionai/libexec/bin/pip list
   
   # Verify Python version
   /opt/homebrew/opt/pyvisionai/libexec/bin/python --version
   
   # If packages are missing:
   /opt/homebrew/opt/pyvisionai/libexec/bin/pip install -r <(brew cat pyvisionai | grep -A 999 "resource.*do$" | grep -B 999 "^end$" | grep "^  resource")
   ```

5. **API Key Issues**
   - Check if the key is set: `echo $OPENAI_API_KEY`
   - Verify key format: Should start with 'sk-'
   - Test API access:
     ```bash
     curl https://api.openai.com/v1/models \
       -H "Authorization: Bearer $OPENAI_API_KEY"
     ```

6. **Local Model Issues**
   ```bash
   # Check Ollama service
   ollama list
   
   # Restart Ollama service
   brew services restart ollama
   
   # Pull model again
   ollama pull llama2-vision
   ```

### Version Upgrade Process

When upgrading PyVisionAI:
1. Update Homebrew: `brew update`
2. Upgrade package: `brew upgrade pyvisionai`
3. Verify installation: `pyvisionai --version`
4. Update Playwright: `playwright install chromium`
5. Test functionality with a simple command: `describe-image --help`

### Getting Help

- For installation and packaging issues: [Homebrew Tap Issues](https://github.com/mdgrey33/homebrew-pyvisionai/issues)
- For general usage and features: [PyVisionAI Issues](https://github.com/MDGrey33/pyvisionai/issues)
- For API and usage docs: [PyVisionAI Documentation](https://github.com/MDGrey33/pyvisionai#readme)

## Additional Resources

- [Homebrew Tap Repository](https://github.com/mdgrey33/homebrew-pyvisionai) - Installation and packaging
- [PyVisionAI Repository](https://github.com/MDGrey33/pyvisionai) - Core functionality and usage
- [OpenAI API Documentation](https://platform.openai.com/docs/introduction)
- [Ollama Documentation](https://github.com/ollama/ollama)

## Contributing

### Reporting Issues

If you find issues with the Homebrew installation or packaging:
1. Check if the issue is already reported in our [Issues](https://github.com/mdgrey33/homebrew-pyvisionai/issues)
2. If not, open a new issue with:
   - Your system information (`brew config`)
   - Installation logs
   - Steps to reproduce

For issues with PyVisionAI functionality, please report them to the [main repository](https://github.com/MDGrey33/pyvisionai/issues).

### Contributing to the Formula

1. **Fork and Clone**
   ```bash
   git clone https://github.com/mdgrey33/homebrew-pyvisionai.git
   cd homebrew-pyvisionai
   ```

2. **Make Changes**
   - Update formula in `Formula/pyvisionai.rb`
   - Test locally:
     ```bash
     brew uninstall pyvisionai
     brew install --build-from-source ./Formula/pyvisionai.rb
     ```
   - Run brew audit:
     ```bash
     brew audit --strict --online Formula/pyvisionai.rb
     ```

3. **Submit Changes**
   - Create a new branch: `git checkout -b feature/your-feature`
   - Commit changes: `git commit -am "Description of changes"`
   - Push to fork: `git push origin feature/your-feature`
   - Open a Pull Request

### Development Guidelines

1. **Version Updates**
   - Update SHA256 hash: `brew fetch pyvisionai --build-from-source`
   - Test with fresh installation
   - Update version compatibility matrix

2. **Dependencies**
   - Keep dependencies minimal and well-documented
   - Test with both required and optional dependencies
   - Document any changes in dependency requirements

3. **Testing**
   - Test on a fresh macOS installation
   - Verify all installation paths
   - Check both Intel and Apple Silicon compatibility
