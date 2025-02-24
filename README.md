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
```

## Version Compatibility

| Component | Version | Notes |
|-----------|---------|-------|
| Python | 3.11+ | Required for all functionality |
| Playwright | 1.41.0 | Required for web content processing |
| Ollama | 0.4.7+ | Optional for local model inference |

## Setup Guide

### 1. Required Setup - API Keys

For cloud-based image description (recommended):

1. Get your API keys:
   - For GPT-4 Vision (default): [OpenAI API Keys](https://platform.openai.com/api-keys)
   - For Claude Vision: [Anthropic Console](https://console.anthropic.com/)
   
2. Set up the environment variables:
   ```bash
   # For GPT-4 Vision (default)
   export OPENAI_API_KEY='your-openai-key'
   
   # For Claude Vision
   export ANTHROPIC_API_KEY='your-claude-key'
   ```

3. Make them persistent:
   ```bash
   # For zsh (default on macOS)
   echo 'export OPENAI_API_KEY=your-openai-key' >> ~/.zshrc
   echo 'export ANTHROPIC_API_KEY=your-claude-key' >> ~/.zshrc
   source ~/.zshrc

   # For bash
   echo 'export OPENAI_API_KEY=your-openai-key' >> ~/.bashrc
   echo 'export ANTHROPIC_API_KEY=your-claude-key' >> ~/.bashrc
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

#### Enhanced Document Processing
For enhanced document processing capabilities, you may want to install LibreOffice:
```bash
# Install LibreOffice (optional)
brew install --cask libreoffice
```

## Usage Examples

### Image Description
```bash
# Using OpenAI (requires API key)
describe-image -s path/to/image.jpg -m gpt4

# Using local model (requires Ollama)
describe-image -s path/to/image.jpg -m llama

# With custom prompt
describe-image -s path/to/image.jpg -p "Describe the colors and composition"
```

### Document Text Extraction
```bash
# Extract from PDF
file-extract -t pdf -s path/to/document.pdf -o output/dir

# Extract from Word document
file-extract -t docx -s path/to/document.docx -o output/dir

# Extract from PowerPoint
file-extract -t pptx -s path/to/presentation.pptx -o output/dir

# Extract with specific model
file-extract -t pdf -s input.pdf -o output_dir -m claude
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

3. **Python Environment Issues**
   ```bash
   # Check installed packages
   /opt/homebrew/opt/pyvisionai/libexec/bin/pip list
   
   # Verify Python version
   /opt/homebrew/opt/pyvisionai/libexec/bin/python --version
   ```

4. **API Key Issues**
   - Check if the key is set: `echo $OPENAI_API_KEY`
   - Verify key format: Should start with 'sk-'
   - Test API access:
     ```bash
     curl https://api.openai.com/v1/models \
       -H "Authorization: Bearer $OPENAI_API_KEY"
     ```

5. **Local Model Issues**
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
3. Verify installation: `brew info pyvisionai`
4. Update Playwright: `playwright install chromium`
5. Test functionality: `describe-image --help`

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

## License

This project is licensed under the Apache License 2.0.
