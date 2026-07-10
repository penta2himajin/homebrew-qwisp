class Qwisp < Formula
  desc "Fast, optionally-lossless local inference for Qwen3.6-35B-A3B (MoE) on Apple Silicon"
  homepage "https://github.com/penta2himajin/qwisp"
  url "https://github.com/penta2himajin/qwisp/releases/download/v0.1.3/qwisp-v0.1.3-macos-arm64.tar.gz"
  sha256 "a37bc8bca887e41f6973a103a10daf47658efa0839bd300a15f1b1802ebe46d5"
  license "Apache-2.0"
  version "0.1.3"

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
