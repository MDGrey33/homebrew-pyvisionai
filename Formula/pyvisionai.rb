class Pyvisionai < Formula
  include Language::Python::Virtualenv
  
  desc "Extract and describe content from documents using Vision Language Models"
  homepage "https://github.com/MDGrey33/pyvisionai"
  url "https://github.com/MDGrey33/pyvisionai/archive/refs/tags/v0.2.7.tar.gz"
  sha256 "353f30af39ab266f8a4589053a452cb0122c5fbcfc8297a0e7b61a2bfe69ff3d"
  license "Apache-2.0"
  
  # Formula maintained at: https://github.com/roland/homebrew-pyvisionai
  
  depends_on "pkgconf" => :build
  depends_on "freetype"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "poppler"
  depends_on "python@3.11"
  depends_on "webp"
  depends_on "zlib"
  depends_on "libreoffice" => :optional
  
  # Use Python virtualenv
  uses_from_macos "python"
  
  # Python package resources
  resource "requests" do
    url "https://files.pythonhosted.org/packages/28/a2/423f4d16d6934ef502f10ad56673719dd4345e656aedbd6687ccc359ffc5/requests-2.32.0.tar.gz"
    sha256 "fa5490319474c82ef1d2c9bc459d3652e3ae4ef4c4ebdd18a21145a47ca4b6b8"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/a5/26/0d95c04c868f6bdb0c447e3ee2de5564411845e36a858cfd63766bc7b563/pillow-11.0.0.tar.gz"
    sha256 "72bacbaf24ac003fea9bff9837d1eedb6088758d41e100c1552930151f677739"
  end

  resource "ollama" do
    url "https://files.pythonhosted.org/packages/b0/6d/dc77539c735bbed5d0c873fb029fb86aa9f0163df169b34152914331c369/ollama-0.4.7.tar.gz"
    sha256 "891dcbe54f55397d82d289c459de0ea897e103b86a3f1fad0fdb1895922a75ff"
  end

  resource "python-docx" do
    url "https://files.pythonhosted.org/packages/35/e4/386c514c53684772885009c12b67a7edd526c15157778ac1b138bc75063e/python_docx-1.1.2.tar.gz"
    sha256 "0cf1f22e95b9002addca7948e16f2cd7acdfd498047f1941ca5d293db7762efd"
  end

  resource "python-pptx" do
    url "https://files.pythonhosted.org/packages/52/a9/0c0db8d37b2b8a645666f7fd8accea4c6224e013c42b1d5c17c93590cd06/python_pptx-1.0.2.tar.gz"
    sha256 "479a8af0eaf0f0d76b6f00b0887732874ad2e3188230315290cd1f9dd9cc7095"
  end

  resource "openai" do
    url "https://files.pythonhosted.org/packages/32/2a/b3fa8790be17d632f59d4f50257b909a3f669036e5195c1ae55737274620/openai-1.61.0.tar.gz"
    sha256 "216f325a24ed8578e929b0f1b3fb2052165f3b04b0461818adaa51aa29c71f8a"
  end

  resource "pdf2image" do
    url "https://files.pythonhosted.org/packages/00/d8/b280f01045555dc257b8153c00dee3bc75830f91a744cd5f84ef3a0a64b1/pdf2image-1.17.0.tar.gz"
    sha256 "eaa959bc116b420dd7ec415fcae49b98100dda3dd18cd2fdfa86d09f112f6d57"
  end

  resource "pdfminer-six" do
    url "https://files.pythonhosted.org/packages/31/b1/a43e3bd872ded4deea4f8efc7aff1703fca8c5455d0c06e20506a06a44ff/pdfminer.six-20231228.tar.gz"
    sha256 "6004da3ad1a7a4d45930cb950393df89b068e73be365a6ff64a838d37bcb08c4"
  end

  resource "pypdf" do
    url "https://files.pythonhosted.org/packages/49/6c/4ffb864f1f41b7ef7bf8a397b16888cf191161a98d4c345fa32ec5aa1454/pypdf-4.1.0.tar.gz"
    sha256 "01c3257ec908676efd60a4537e525b89d48e0852bc92b4e0aa4cc646feda17cc"
  end

  resource "playwright" do
    url "https://files.pythonhosted.org/packages/8d/63/239ffc94f3856932ea8cf4bf4c2cebeda8442ccdcf2e685882ab666b244b/playwright-1.41.0-py3-none-macosx_11_0_arm64.whl"
    sha256 "9d34f472d174e55d8f12265e10d11ba21be99bf0661ccbf1f9b048312696d5e8"
  end

  def install
    # Set environment variables for building Pillow with system libraries
    ENV["JPEG_ROOT"] = Formula["jpeg"].opt_prefix
    ENV["FREETYPE_ROOT"] = Formula["freetype"].opt_prefix
    ENV["ZLIB_ROOT"] = Formula["zlib"].opt_prefix
    ENV["LCMS_ROOT"] = Formula["little-cms2"].opt_prefix
    ENV["WEBP_ROOT"] = Formula["webp"].opt_prefix
    ENV["TIFF_ROOT"] = Formula["libtiff"].opt_prefix
    ENV["PNG_ROOT"] = Formula["libpng"].opt_prefix

    # Set build flags
    ENV.append "CFLAGS", "-I#{Formula["freetype"].opt_include}/freetype2 -I#{Formula["jpeg"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["jpeg"].opt_lib}"

    # Create virtualenv and install dependencies
    venv = virtualenv_create(libexec, "python3.11")
    
    # Install all resources except playwright
    resources.each do |r|
      next if r.name == "playwright"
      r.stage do
        system libexec/"bin/python", "-m", "pip", "install", "."
      end
    end

    # Install playwright wheel file
    resource("playwright").stage do
      system libexec/"bin/python", "-m", "pip", "install", Dir["*.whl"].first
    end

    # Install the package itself
    system libexec/"bin/python", "-m", "pip", "install", "."

    # Install Playwright browsers
    ohai "Installing Playwright browsers..."
    system libexec/"bin/playwright", "install", "chromium"
  end

  def post_install
    venv_path = libexec/"bin/python"

    # Verify Python environment
    ohai "Verifying Python environment..."
    system venv_path, "-c", "import sys; assert sys.version_info >= (3, 11)"
    
    # Verify all key dependencies
    ohai "Verifying package installation..."
    %w[requests PIL ollama docx pptx openai pdf2image pdfminer pypdf playwright].each do |pkg|
      system venv_path, "-c", "import #{pkg}"
    end
    
    # Verify system dependencies
    ohai "Verifying system dependencies..."
    system "pkg-config", "--exists", "poppler-cpp"
    system "pkg-config", "--exists", "freetype2"
    
    # Check Playwright setup
    ohai "Checking Playwright installation..."
    system venv_path, "-m", "playwright", "install", "--help"

    # Check for LibreOffice
    libreoffice_path = "/Applications/LibreOffice.app/Contents/MacOS/soffice"
    if !File.exist?(libreoffice_path)
      opoo "Notice: LibreOffice is not installed"
      opoo "Some document processing features require LibreOffice"
      opoo "To install: brew install --cask libreoffice"
    end
  end

  def caveats
    warnings = []
    
    libreoffice_path = "/Applications/LibreOffice.app/Contents/MacOS/soffice"
    if !File.exist?(libreoffice_path)
      warnings << "LibreOffice is not installed. Some document processing features may be limited.\n" \
                 "To install: brew install --cask libreoffice"
    end

    <<~EOS
      PyVisionAI Installation Complete!

      Quick Start:
      -----------
      • Set up OpenAI API key (for cloud features):
        export OPENAI_API_KEY='your-api-key'
      
      • For local models (alternative to OpenAI):
        brew install ollama
        ollama pull llama2-vision

      • To use Playwright features, install browsers:
        playwright install chromium

      Documentation:
      -------------
      For detailed setup instructions, usage examples, and troubleshooting:
      https://github.com/roland/homebrew-pyvisionai#readme

      #{warnings.empty? ? "" : "\nWarnings:\n---------\n• #{warnings.join("\n• ")}"}

      Basic Usage:
      -----------
      describe-image -i path/to/image.jpg    # Describe an image
      file-extract -t pdf -s document.pdf    # Extract text from a PDF
    EOS
  end

  test do
    venv_path = libexec/"bin/python"
    
    # Basic command help tests
    system "#{bin}/file-extract", "--help"
    system "#{bin}/describe-image", "--help"
    
    # Verify Python version
    assert_match "3.11", shell_output("#{venv_path} -c 'import sys; print(f\"{sys.version_info.major}.{sys.version_info.minor}\")'")
    
    # Verify all dependencies
    %w[requests pillow ollama docx pptx openai pdf2image pdfminer pypdf playwright].each do |pkg|
      system venv_path, "-c", "import #{pkg}"
    end

    # Test environment variables
    ENV["OPENAI_API_KEY"] = "dummy_key_for_test"
    assert_match "OPENAI_API_KEY is set",
      shell_output("#{venv_path} -c 'import os; print(\"OPENAI_API_KEY\" in os.environ) if \"OPENAI_API_KEY\" in os.environ else \"not set\"'")
  end
end
