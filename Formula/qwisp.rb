class Qwisp < Formula
  desc "Fast, optionally-lossless local inference for Qwen3.6-35B-A3B (MoE) on Apple Silicon"
  homepage "https://github.com/penta2himajin/qwisp"
  url "https://github.com/penta2himajin/qwisp/releases/download/v0.1.0/qwisp-v0.1.0-macos-arm64.tar.gz"
  sha256 "f9065ad6157d0e54e9a991f2574fde2005644b99945532262dbc70c806df5505"
  license "Apache-2.0"
  version "0.1.0"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  # Prebuilt: qwisp needs Xcode 26 / Swift 6.3 to build, so we ship a signed binary +
  # the SwiftPM resource bundles it loads at runtime (MLX's default.metallib, etc.).
  def install
    libexec.install Dir["*"]
    bin.install_symlink libexec/"qwisp"
  end

  service do
    run [opt_bin/"qwisp", "serve"]
    keep_alive true
    log_path var/"log/qwisp.log"
    error_log_path var/"log/qwisp.log"
  end

  test do
    # GPU-free, model-free gate — exits non-zero on failure.
    system bin/"qwisp", "configtest"
  end
end
