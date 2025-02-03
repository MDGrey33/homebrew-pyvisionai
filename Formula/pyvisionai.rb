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
    url "https://files.pythonhosted.org/packages/9d/be/10918a2eac4ae9f02f6cfe6414b7a155ccd8f7f9d4380d62fd5b955065c3/requests-2.31.0.tar.gz"
    sha256 "942c5a758f98d790eaed1a29cb6eefc7ffb0d1cf7af05c3d2791656dbd6ad1e1"
  end

  resource "pillow" do
    url "https://files.pythonhosted.org/packages/f8/3e/32cbd0129a28686621434cbf17bb64bf1458bfb838f1f668262fefce145c/pillow-10.2.0.tar.gz"
    sha256 "e87f0b2c78157e12d7686b27d63c070fd65d994e8ddae6f328e0dcf4a0cd007e"
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

  resource "virtualenv" do
    url "https://files.pythonhosted.org/packages/a7/ca/f23dcb02e161a9bba141b1c08aa50e8da6ea25e6d780528f1d385a3efe25/virtualenv-20.29.1.tar.gz"
    sha256 "b8b8970138d32fb606192cb97f6cd4bb644fa486be9308fb9b63f81091b5dc35"
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
    ENV.append "CPPFLAGS", "-I#{Formula["freetype"].opt_include}/freetype2"
    ENV.append "CPPFLAGS", "-I#{Formula["jpeg"].opt_include}"
    ENV.append "LDFLAGS", "-L#{Formula["jpeg"].opt_lib}"

    virtualenv_install_with_resources
    
    # Install Playwright and browsers
    system libexec/"bin/pip", "install", "playwright==1.41.0"
    system libexec/"bin/python", "-m", "playwright", "install"
  end

  def caveats
    warnings = []
    
    warnings << "LibreOffice is not installed. Some document processing features may be limited.\n" \
               "To install: brew install --cask libreoffice" unless which("libreoffice")

    <<~EOS
      PyVisionAI Installation Complete!

      Quick Start:
      -----------
      • Set up OpenAI API key (for cloud features):
        export OPENAI_API_KEY='your-api-key'
      
      • For local models (alternative to OpenAI):
        brew install ollama
        ollama pull llama2-vision

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

  def post_install
    # Verify Python environment
    ohai "Verifying Python environment..."
    system "#{bin}/python3", "-c", "import sys; assert sys.version_info >= (3, 11)"
    
    # Verify key dependencies
    ohai "Verifying package installation..."
    %w[requests PIL playwright docx pptx openai].each do |pkg|
      system "#{bin}/python3", "-c", "import #{pkg}"
    end

    # Check for LibreOffice
    unless which("libreoffice")
      opoo "Notice: LibreOffice is not installed"
      opoo "Some document processing features require LibreOffice"
      opoo "To install: brew install --cask libreoffice"
    end
  end

  test do
    # Basic command help tests
    system "#{bin}/file-extract", "--help"
    system "#{bin}/describe-image", "--help"
    
    # Verify Python version
    assert_match "3.11",
      shell_output("#{bin}/python3 -c 'import sys; print(f\"{sys.version_info.major}.{sys.version_info.minor}\")'")
    
    # Verify key dependencies
    %w[requests PIL playwright docx pptx openai].each do |pkg|
      system "#{bin}/python3", "-c", "import #{pkg}"
    end

    # Test environment variables
    ENV["OPENAI_API_KEY"] = "dummy_key_for_test"
    assert_match "OPENAI_API_KEY is set",
      shell_output("#{bin}/python3 -c 'import os; print(\"OPENAI_API_KEY is set\" if \"OPENAI_API_KEY\" in os.environ else \"not set\")'")
  end
end
