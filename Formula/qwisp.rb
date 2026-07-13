class Qwisp < Formula
  desc "Fast, optionally-lossless local inference for Qwen3.6-35B-A3B (MoE) on Apple Silicon"
  homepage "https://github.com/penta2himajin/qwisp"
  url "https://github.com/penta2himajin/qwisp/releases/download/v0.3.3/qwisp-v0.3.3-macos-arm64.tar.gz"
  sha256 "29c955e681b9bc55dddaf988e3237ab3e54e9daa22eeff99024d5610b5fc599b"
  license "Apache-2.0"
  version "0.3.3"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  # Prebuilt: qwisp needs Xcode 26 / Swift 6.3 to build, so we ship a signed binary +
  # the SwiftPM resource bundles it loads at runtime (MLX's default.metallib, etc.).
  def install
    libexec.install Dir["*"]
    # exec wrapper (NOT a symlink): argv0 must be the real libexec path so MLX finds
    # mlx-swift_Cmlx.bundle/…/default.metallib colocated with the executable.
    bin.write_exec_script libexec/"qwisp"
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
