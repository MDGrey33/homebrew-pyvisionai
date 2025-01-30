class Pyvisionai < Formula
  desc "Extract and describe content from documents using Vision Language Models"
  homepage "https://github.com/MDGrey33/pyvisionai"
  url "https://github.com/MDGrey33/pyvisionai/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "[SHA256_HASH]"  # Will be updated with actual hash after first release
  license "Apache-2.0"

  depends_on "python@3.8"
  depends_on "libreoffice" => :cask
  depends_on "poppler"

  def install
    virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", "."
    system libexec/"bin/pip", "install", "playwright"
    system libexec/"bin/playwright", "install"
  end

  def caveats
    <<~EOS
      To use cloud-based image description (recommended), set your OpenAI API key:
        export OPENAI_API_KEY='your-api-key'

      For local image description (optional):
        brew install ollama
        ollama pull llama3.2-vision
    EOS
  end

  test do
    system "#{bin}/file-extract", "--help"
    system "#{bin}/describe-image", "--help"
  end
end
