# TODO List for PyVisionAI Homebrew Formula

## Critical Requirements

- [x] **Create GitHub Release**
  - [x] Create a git tag (e.g., v0.2.7) in the main repository
  - [x] Create a proper GitHub release
  - [x] Verify the release tarball is accessible
  - [x] Update formula with correct tarball URL and SHA256

## Pre-Release Checklist

- [x] **Package Requirements Verification**
  - [x] Verify package meets Homebrew's requirements:
    - [x] Check it's not already in Homebrew (`brew search pyvisionai`)
    - [x] Stable tagged version created (v0.2.7)
    - [x] Verify upstream support (no extensive patching needed)
    - [x] Confirm license is DFSG-compatible (Apache-2.0)

- [x] **Dependencies**  
   - [x] Update Python requirement (changed to python@3.11)
   - [x] Fix LibreOffice dependency:
     - [x] Changed to recommended dependency
     - [x] Removed explicit cask requirement
   - [x] Add Poppler dependency with comment
   - [x] Add key Python package resources
   - [x] Verify Playwright installation process

- [x] **Python Package Resources**
   - [x] requests 2.31.0
   - [x] pillow 10.2.0
   - [x] ollama 0.4.7
   - [x] python-docx 1.1.2
   - [x] python-pptx 1.0.2
   - [x] openai 1.61.0

## Next Steps (Priority Order)
1. Test installation in clean environment
2. Run formula audit checks
3. Verify Playwright browser installation
4. Test functional requirements (CLI commands, document extraction, etc.)

## Current Issues to Fix
1. Need to update Command Line Tools (blocking installation tests)
2. LibreOffice cask dependency needs proper setup
3. Need to verify all Python resources are properly staged
4. Need to verify Playwright browser installation

## Testing Checklist

- [ ] **Local Installation Tests**  
   ```bash
   # Set development mode
   export HOMEBREW_NO_INSTALL_FROM_API=1
   
   # Test build from source
   brew install --build-from-source Formula/pyvisionai.rb
   
   # Run audit checks
   brew audit --strict --online Formula/pyvisionai.rb
   
   # Test installation
   brew test Formula/pyvisionai.rb
   
   # Test uninstall/reinstall
   brew uninstall pyvisionai
   brew install pyvisionai
   ```

- [ ] **Formula Audit**
   - [ ] Run `brew audit --new-formula Formula/pyvisionai.rb`
   - [ ] Check style guidelines compliance
   - [ ] Verify all dependencies are declared
   - [ ] Check for any deprecation warnings
   - [ ] Verify license declaration

- [ ] **Functional Verification**  
   - [ ] Run the PyVisionAI CLI commands:
     ```bash
     pyvisionai --help
     file-extract --help
     describe-image --help
     ```
   - [ ] Test with required environment variables:
     - [ ] `OPENAI_API_KEY` for cloud features
     - [ ] Verify optional Ollama setup
   - [ ] Test document extraction functionality
   - [ ] Test image description features

## Publication Checklist

- [ ] **Pre-Publication**
   - [ ] Update formula comments and documentation
   - [ ] Verify all tests pass
   - [ ] Check for any security considerations
   - [ ] Update README with installation instructions

- [ ] **Publication**
   - [ ] Push formula changes to tap
   - [ ] Verify tap installation:
     ```bash
     brew tap roland/pyvisionai
     brew install pyvisionai
     ```
   - [ ] Test in a clean environment
   - [ ] Document any known issues

- [ ] **Post-Publication**
   - [ ] Monitor initial installations for issues
   - [ ] Update documentation with common issues/solutions
   - [ ] Set up process for future updates
   - [ ] Create update guide for maintainers

## Formula Maintenance

- [ ] **Update Process**
   - [ ] Document version update procedure
   - [ ] Create checklist for dependency updates
   - [ ] Plan for Python version updates
   - [ ] Set up monitoring for upstream changes

- [ ] **Documentation**
   - [ ] Complete README with all installation scenarios
   - [ ] Document troubleshooting steps
   - [ ] Add contribution guidelines
   - [ ] Include update/maintenance procedures 

## Active Issues Investigation

### Current Issue: Formula Loading and Virtualenv Setup
Error: "Failed to load cask: ./Formula/pyvisionai.rb" and "Cask 'pyvisionai' is unreadable"

**Priority**: High - Blocking formula installation and testing

**Expected Outcomes**:
1. Formula loads correctly as a formula, not a cask
2. Python virtualenv setup follows Homebrew best practices
3. All dependencies are properly staged and installed
4. Installation process is reliable and repeatable

**Investigation Steps**:
1. Root Cause Analysis
   - [ ] Investigate why formula is being treated as a cask
   - [ ] Check formula location and naming conventions
   - [ ] Verify formula class structure matches Homebrew standards

2. Research Phase
   - [ ] Study successful Python formulas in Homebrew core
   - [ ] Document common patterns for Python package installation
   - [ ] Identify best practices for virtualenv setup

3. Implementation Strategy
   - [ ] Create minimal working formula example
   - [ ] Incrementally add features with testing at each step
   - [ ] Validate against Homebrew's Python formula standards

4. Validation
   - [ ] Test in clean environment
   - [ ] Verify all dependencies are properly handled
   - [ ] Ensure virtualenv is correctly configured 

# PyVisionAI Homebrew Formula Investigation

## Current Status
- Formula class name updated from `Pyvisionai` to `PyVisionAI`
- Build dependencies added for Pillow
- Environment variables set for system libraries
- Build flags added for compiler paths
- Successfully registered tap
- Latest audit revealed specific formatting issues:
  1. sha256 format and spacing issues
  2. Dependency ordering needs adjustment
  3. Libreoffice dependency handling
  4. Python version reference mismatch (3.12 vs 3.11)

## Issues to Resolve (Prioritized)

### 1. Formula Syntax Issues (BLOCKING)
- [ ] Fix sha256 formatting:
  - [ ] Remove invalid characters
  - [ ] Convert to lowercase
  - [ ] Fix unnecessary spacing
- [ ] Fix dependency ordering:
  - [ ] Move libreoffice before python@3.11
  - [ ] Move poppler before python@3.11
- [ ] Remove any useless variable assignments

### 2. Dependency Management (HIGH)
- [ ] Handle libreoffice dependency properly:
  - [ ] Research best practice for cask dependencies
  - [ ] Update cask requirement syntax
  - [ ] Verify cask detection logic
- [ ] Verify Python version consistency:
  - [ ] Check all references to Python version (3.11 vs 3.12)
  - [ ] Update version requirements if needed

### 3. Build Environment (MEDIUM)
- [ ] Pillow build configuration:
  - [ ] Verify all build dependencies
  - [ ] Check environment variables
  - [ ] Test build flags
- [ ] Python environment setup:
  - [ ] Verify virtualenv creation
  - [ ] Check package installation order

### 4. Testing and Validation (LOW)
- [ ] Installation testing:
  - [ ] Clean environment test
  - [ ] Dependency resolution
  - [ ] Post-install hooks
- [ ] Functionality testing:
  - [ ] Command availability
  - [ ] Feature verification

## Investigation Steps (Updated)

### 1. Formula Syntax Fixes
- [ ] Run `brew style` check
- [ ] Compare with core Python formulas
- [ ] Verify SHA256 format
- [ ] Test dependency ordering

### 2. Dependency Resolution
- [ ] Research cask dependency patterns
- [ ] Test Python version requirements
- [ ] Verify build dependencies

### 3. Build Configuration
- [ ] Test Pillow compilation
- [ ] Verify environment setup
- [ ] Check resource staging

### 4. Installation Validation
- [ ] Test in clean environment
- [ ] Verify all features
- [ ] Document any issues

## Progress Log
- [x] Updated formula class name to `PyVisionAI`
- [x] Added Pillow build dependencies
- [x] Set environment variables for system libraries
- [x] Successfully registered tap
- [x] Identified specific audit issues

## Next Actions (In Order)
1. Fix SHA256 formatting issues (highest priority, blocking)
2. Correct dependency ordering
3. Update libreoffice dependency handling
4. Verify Python version consistency
5. Test build environment
6. Validate installation

## Notes
- SHA256 issues are blocking further progress
- Dependency ordering affects formula parsing
- Need to research cask dependency best practices
- Python version mismatch needs investigation 

## Error Count Analysis

### Current Errors (7)
1. sha256 contains invalid characters
2. sha256 should be lowercase
3. Unnecessary spacing detected
4. dependency "libreoffice" ordering
5. dependency "poppler" ordering
6. Useless assignment to variable - `venv`
7. Can't find dependency 'libreoffice'

### Root Cause Analysis
1. SHA256 Issues (1-3):
   - Quotes might be causing "invalid characters"
   - Case sensitivity needs to be enforced
   - Spacing around the hash needs to be exact

2. Dependency Issues (4-5, 7):
   - Ordering is still incorrect despite alphabetical sorting
   - LibreOffice is being treated as a formula dependency instead of a cask
   - Python version reference mismatch (3.12 vs 3.11)

3. Variable Assignment (6):
   - The `venv` variable assignment error is a false positive
   - The error is likely due to the audit tool misinterpreting virtualenv_install_with_resources
   - Looking at pdm formula, we can see they use the same pattern successfully

### New Strategy
1. Focus on SHA256 and dependency issues first:
   - Ignore the `venv` error as it appears to be a false positive
   - Fix SHA256 formatting (blocking)
   - Address dependency ordering and types

## Fix Attempts Log

### SHA256 Formatting (CURRENT)
**Issue**: Invalid characters, incorrect case, and unnecessary spacing in sha256
**Previous Attempts**:
1. First attempt:
   - [x] Verified SHA256 against source tarball
   - [x] Removed quotes around SHA256
   - [-] Failed: Added more issues
2. Second attempt:
   - [x] Examined python@3.11 formula format
   - [-] Failed: Issues persisted
3. Third attempt:
   - [x] Ran `brew style` for detailed requirements
   - [-] Failed: Issues remained
4. Fourth attempt:
   - [x] Comprehensive formatting update
   - [-] Failed: All SHA256 issues still present
5. Fifth attempt (Current):
   - [x] Examined multiple Python formulas (python@3.11, pdm, poetry)
   - [x] Removed quotes and adjusted spacing
   - [ ] Verify with brew audit
**Status**: Fifth attempt verification pending
**Learnings**: 
- Other formulas use quotes around SHA256
- Spacing appears to be significant
- Need to ensure exact format matches

### Dependency Management
**Issue**: Multiple dependency-related issues
**Strategy**:
1. Handle LibreOffice properly:
   - [ ] Research cask dependency syntax
   - [ ] Update to use proper cask requirement
2. Fix dependency ordering:
   - [ ] Move Python dependency last
   - [ ] Ensure consistent order
3. Version references:
   - [ ] Update all Python version references to 3.11

### Dependency Ordering
**Issue**: Dependencies need reordering (libreoffice, poppler before python@3.11)
**Attempts**: 
1. First attempt (Current):
   - [x] Reordered all dependencies alphabetically
   - [x] Removed inline comments
   - [ ] Verify with brew audit
**Status**: Verification pending

### Variable Assignment
**Issue**: Useless variable assignment detected
**Attempts**: 
1. First attempt (Current):
   - [x] Removed unnecessary variable assignments
   - [ ] Verify with brew audit
**Status**: Verification pending

## Testing Environment Strategy

### Style Issues (IN PROGRESS)
1. **Whitespace Issues** (Current Focus):
   - [ ] Remove trailing whitespace (12 locations)
   - [x] Fix line ending string concatenation indentation
   - [ ] Fix end alignment in caveats section

2. **Code Style** (Partially Fixed):
   - [x] Use `unless` instead of `if !` for negative conditions
   - [x] Fix method ordering (moved post_install before caveats)
   - [ ] Fix line length in test section (138/118 chars)

3. **Progress**:
   - Initial: 17 issues (16 autocorrectable)
   - Current: 14 issues (13 autocorrectable)
   - Fixed:
     - Method ordering
     - Negative conditions
     - String concatenation indentation
   - Remaining:
     - Trailing whitespace
     - End alignment
     - Line length

4. **Next Actions**:
   - [ ] Fix trailing whitespace
   - [ ] Fix end alignment
   - [ ] Split long line in test section
   - [ ] Rerun style check

## Current Status
- Formula class name updated from `Pyvisionai` to `PyVisionAI`
- Build dependencies added for Pillow
- Environment variables set for system libraries
- Build flags added for compiler paths
- Successfully registered tap
- Latest audit revealed specific formatting issues:
  1. sha256 format and spacing issues
  2. Dependency ordering needs adjustment
  3. Libreoffice dependency handling
  4. Python version reference mismatch (3.12 vs 3.11)

## Issues to Resolve (Prioritized)

### 1. Formula Syntax Issues (BLOCKING)
- [ ] Fix sha256 formatting:
  - [ ] Remove invalid characters
  - [ ] Convert to lowercase
  - [ ] Fix unnecessary spacing
- [ ] Fix dependency ordering:
  - [ ] Move libreoffice before python@3.11
  - [ ] Move poppler before python@3.11
- [ ] Remove any useless variable assignments

### 2. Dependency Management (HIGH)
- [ ] Handle libreoffice dependency properly:
  - [ ] Research best practice for cask dependencies
  - [ ] Update cask requirement syntax
  - [ ] Verify cask detection logic
- [ ] Verify Python version consistency:
  - [ ] Check all references to Python version (3.11 vs 3.12)
  - [ ] Update version requirements if needed

### 3. Build Environment (MEDIUM)
- [ ] Pillow build configuration:
  - [ ] Verify all build dependencies
  - [ ] Check environment variables
  - [ ] Test build flags
- [ ] Python environment setup:
  - [ ] Verify virtualenv creation
  - [ ] Check package installation order

### 4. Testing and Validation (LOW)
- [ ] Installation testing:
  - [ ] Clean environment test
  - [ ] Dependency resolution
  - [ ] Post-install hooks
- [ ] Functionality testing:
  - [ ] Command availability
  - [ ] Feature verification

## Investigation Steps (Updated)

### 1. Formula Syntax Fixes
- [ ] Run `brew style` check
- [ ] Compare with core Python formulas
- [ ] Verify SHA256 format
- [ ] Test dependency ordering

### 2. Dependency Resolution
- [ ] Research cask dependency patterns
- [ ] Test Python version requirements
- [ ] Verify build dependencies

### 3. Build Configuration
- [ ] Test Pillow compilation
- [ ] Verify environment setup
- [ ] Check resource staging

### 4. Installation Validation
- [ ] Test in clean environment
- [ ] Verify all features
- [ ] Document any issues

## Progress Log
- [x] Updated formula class name to `PyVisionAI`
- [x] Added Pillow build dependencies
- [x] Set environment variables for system libraries
- [x] Successfully registered tap
- [x] Identified specific audit issues

## Next Actions (In Order)
1. Fix SHA256 formatting issues (highest priority, blocking)
2. Correct dependency ordering
3. Update libreoffice dependency handling
4. Verify Python version consistency
5. Test build environment
6. Validate installation

## Notes
- SHA256 issues are blocking further progress
- Dependency ordering affects formula parsing
- Need to research cask dependency best practices
- Python version mismatch needs investigation 

## Error Count Analysis

### Current Errors (7)
1. sha256 contains invalid characters
2. sha256 should be lowercase
3. Unnecessary spacing detected
4. dependency "libreoffice" ordering
5. dependency "poppler" ordering
6. Useless assignment to variable - `venv`
7. Can't find dependency 'libreoffice'

### Root Cause Analysis
1. SHA256 Issues (1-3):
   - Quotes might be causing "invalid characters"
   - Case sensitivity needs to be enforced
   - Spacing around the hash needs to be exact

2. Dependency Issues (4-5, 7):
   - Ordering is still incorrect despite alphabetical sorting
   - LibreOffice is being treated as a formula dependency instead of a cask
   - Python version reference mismatch (3.12 vs 3.11)

3. Variable Assignment (6):
   - The `venv` variable assignment error is a false positive
   - The error is likely due to the audit tool misinterpreting virtualenv_install_with_resources
   - Looking at pdm formula, we can see they use the same pattern successfully

### New Strategy
1. Focus on SHA256 and dependency issues first:
   - Ignore the `venv` error as it appears to be a false positive
   - Fix SHA256 formatting (blocking)
   - Address dependency ordering and types

## Fix Attempts Log

### SHA256 Formatting (CURRENT)
**Issue**: Invalid characters, incorrect case, and unnecessary spacing in sha256
**Previous Attempts**:
1. First attempt:
   - [x] Verified SHA256 against source tarball
   - [x] Removed quotes around SHA256
   - [-] Failed: Added more issues
2. Second attempt:
   - [x] Examined python@3.11 formula format
   - [-] Failed: Issues persisted
3. Third attempt:
   - [x] Ran `brew style` for detailed requirements
   - [-] Failed: Issues remained
4. Fourth attempt:
   - [x] Comprehensive formatting update
   - [-] Failed: All SHA256 issues still present
5. Fifth attempt (Current):
   - [x] Examined multiple Python formulas (python@3.11, pdm, poetry)
   - [x] Removed quotes and adjusted spacing
   - [ ] Verify with brew audit
**Status**: Fifth attempt verification pending
**Learnings**: 
- Other formulas use quotes around SHA256
- Spacing appears to be significant
- Need to ensure exact format matches

### Dependency Management
**Issue**: Multiple dependency-related issues
**Strategy**:
1. Handle LibreOffice properly:
   - [ ] Research cask dependency syntax
   - [ ] Update to use proper cask requirement
2. Fix dependency ordering:
   - [ ] Move Python dependency last
   - [ ] Ensure consistent order
3. Version references:
   - [ ] Update all Python version references to 3.11

### Dependency Ordering
**Issue**: Dependencies need reordering (libreoffice, poppler before python@3.11)
**Attempts**: 
1. First attempt (Current):
   - [x] Reordered all dependencies alphabetically
   - [x] Removed inline comments
   - [ ] Verify with brew audit
**Status**: Verification pending

### Variable Assignment
**Issue**: Useless variable assignment detected
**Attempts**: 
1. First attempt (Current):
   - [x] Removed unnecessary variable assignments
   - [ ] Verify with brew audit
**Status**: Verification pending 