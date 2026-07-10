# homebrew-qwisp

Homebrew tap for [qwisp](https://github.com/penta2himajin/qwisp) — fast, optionally-lossless
local inference for Qwen3.6-35B-A3B (MoE) on Apple Silicon.

```bash
brew install penta2himajin/qwisp/qwisp
```

Apple Silicon only (arm64), macOS 14+. The model (~20 GB) is downloaded separately — see the
[qwisp README](https://github.com/penta2himajin/qwisp#readme).

```bash
brew services start qwisp   # resident OpenAI-compatible server on :8080
```
