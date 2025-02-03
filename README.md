# Homebrew PyVisionAI

This is the official Homebrew tap for PyVisionAI, a tool for extracting and describing content from documents using Vision Language Models.

## Installation

```bash
# Add the tap
brew tap roland/pyvisionai

# Install PyVisionAI
brew install pyvisionai
```

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

1. **Playwright Issues**
   ```bash
   # Reinstall Playwright
   /opt/homebrew/opt/pyvisionai/libexec/bin/pip install playwright==1.41.0
   
   # Reinstall browsers
   /opt/homebrew/opt/pyvisionai/libexec/bin/playwright install chromium
   ```

2. **LibreOffice Issues**
   - Ensure LibreOffice is installed: `brew install --cask libreoffice`
   - Check if LibreOffice is in PATH: `which libreoffice`

3. **Python Environment Issues**
   ```bash
   # Check installed packages
   /opt/homebrew/opt/pyvisionai/libexec/bin/pip list
   
   # Verify Python version
   /opt/homebrew/opt/pyvisionai/libexec/bin/python --version
   ```

### Getting Help

- Report issues on GitHub: [PyVisionAI Issues](https://github.com/MDGrey33/pyvisionai/issues)
- Check the [PyVisionAI Documentation](https://github.com/MDGrey33/pyvisionai#readme)
- Review [OpenAI API Documentation](https://platform.openai.com/docs/introduction)

## Additional Resources

- [PyVisionAI Main Repository](https://github.com/MDGrey33/pyvisionai)
- [OpenAI API Documentation](https://platform.openai.com/docs/introduction)
- [Ollama Documentation](https://github.com/ollama/ollama)
