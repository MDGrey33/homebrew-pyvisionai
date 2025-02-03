# PyVisionAI Homebrew Formula TODO

## High Priority
- [ ] Fix Git merge conflict in formula (remove Playwright auto-installation)
- [ ] Fix libreoffice dependency (currently "Can't find dependency 'libreoffice'")
- [ ] Test clean installation flow on a new machine:
  ```bash
  brew tap mdgrey33/pyvisionai
  brew install pyvisionai
  playwright install chromium
  brew install --cask libreoffice  # optional
  ```

## Documentation
- [ ] Update repository links in README (currently pointing to roland/homebrew-pyvisionai instead of mdgrey33/homebrew-pyvisionai)
- [ ] Add troubleshooting guide for common installation issues:
  - Playwright browser installation
  - LibreOffice setup
  - Python environment issues
- [ ] Document version upgrade process
- [ ] Add contribution guidelines for formula maintenance

## Future Improvements
- [ ] Add version compatibility matrix:
  - Python version requirements (currently 3.11)
  - Playwright version compatibility (currently 1.41.0)
  - LibreOffice version requirements
  - Ollama version compatibility
- [ ] Add automated testing for formula installation
- [ ] Consider making LibreOffice a required dependency if it's essential 