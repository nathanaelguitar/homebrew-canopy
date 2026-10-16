# Rendered by packaging/render.py into Formula/canopy-code.rb of nathanaelguitar/homebrew-canopy.
class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  version "2026.10.13"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.13/canopy-code-2026.10.13-darwin-arm64.tar.gz"
    sha256 "2bc84453032e160929525000f4a8584a16a1bd98420aeee3689e689b94227ae8"
  end

  on_linux do
    on_arm do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.13/canopy-code-2026.10.13-linux-arm64.tar.gz"
      sha256 "7948a37d35898a158f6a5f1c8183acefddd5e7b6b10c225a4703e3fa712b953e"
    end
    on_intel do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.13/canopy-code-2026.10.13-linux-x64.tar.gz"
      sha256 "8495017ac7b8ffffc6897f54b45eb3cc82cac60db23e93642a19da4aed2d6352"
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
