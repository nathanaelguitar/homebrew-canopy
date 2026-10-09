class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.9/canopy-code-2026.10.9-darwin-arm64.tar.gz"
  version "2026.10.9"
  sha256 "f583140908596fb7cf00947c4c7e5746f93065d703c8e01ca95d968bc50db5ea"
  license "Apache-2.0"

  depends_on arch: :arm64
  depends_on :macos

  def install
    bin.install "bin/canopy", "bin/canopy-gateway", "bin/canopy-channels", "bin/codex-code-mode-host"
    (share/"canopy").install "share/canopy/web-shell"
  end

  def caveats
    <<~EOS
      Start with:
        canopy

      Sign in to a model provider inside Canopy with /auth:
        - ChatGPT: "Sign in with ChatGPT" (Plus/Pro/Business plans)
        - Claude: "Sign in with Anthropic" uses your Claude subscription through
          Claude Code, which must be installed first:
            brew install --cask claude-code
          (or: npm install -g @anthropic-ai/claude-code)
        - Or any API key / OpenAI-compatible endpoint.

      Remote control from the CanopyChat app needs a Canopy account:
        https://canopychat.app/signup
    EOS
  end

  test do
    assert_match "Canopy Code", shell_output("#{bin}/canopy --version")
  end
end
