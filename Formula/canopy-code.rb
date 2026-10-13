# Rendered by packaging/render.py into Formula/canopy-code.rb of nathanaelguitar/homebrew-canopy.
class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  version "2026.10.10"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.10/canopy-code-2026.10.10-darwin-arm64.tar.gz"
    sha256 "8cba169cb7c127a7fedf56daa443bffef63d81456948d47b63131fe27302509f"
  end

  on_linux do
    on_arm do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.10/canopy-code-2026.10.10-linux-arm64.tar.gz"
      sha256 "31272b09e52ea0b7424106065614970c76ddceb011e61ba6b60b3ae68f1db8cf"
    end
    on_intel do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.10/canopy-code-2026.10.10-linux-x64.tar.gz"
      sha256 "3fbb46d8b81b5a9db9d15aba71ce7312929f921243b26fa03eeecbe0a82645f8"
    end
  end

  def install
    bin.install "bin/canopy", "bin/canopy-gateway", "bin/canopy-channels", "bin/codex-code-mode-host"
    # macOS: the on-device voice helper for hold-Space dictation (/voice setup).
    bin.install "bin/canopy-voice-mac" if OS.mac?
    (share/"canopy").install "share/canopy/web-shell"
    # Linux: the sandbox's bubblewrap, used when the system has no `bwrap`. canopy finds it at
    # <prefix>/codex-resources/bwrap; it stays off the PATH.
    prefix.install "codex-resources" if OS.linux?
  end

  def caveats
    <<~EOS
      Start with:
        canopy

      Sign in to a model provider inside Canopy with /auth:
        - ChatGPT: "Sign in with ChatGPT" (Plus/Pro/Business plans)
        - Claude: "Sign in with Anthropic" uses your Claude subscription through
          Claude Code, which must be installed first:
            brew install --cask claude-code   (macOS)
            npm install -g @anthropic-ai/claude-code
        - Or any API key / OpenAI-compatible endpoint.

      Voice (macOS): run /voice setup, then hold Space to talk (on-device).

      Remote control from the CanopyChat app needs a Canopy account:
        https://canopychat.app/signup
    EOS
  end

  test do
    assert_match "Canopy Code", shell_output("#{bin}/canopy --version")
  end
end
