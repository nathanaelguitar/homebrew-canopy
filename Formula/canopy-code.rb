# Rendered by packaging/render.py into Formula/canopy-code.rb of nathanaelguitar/homebrew-canopy.
class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  version "2026.10.21"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.21/canopy-code-2026.10.21-darwin-arm64.tar.gz"
    sha256 "b27e85f5a220a0450140cdad0da9e13ddd46819071890c3b4d1f1b577ee88318"
  end

  on_linux do
    on_arm do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.21/canopy-code-2026.10.21-linux-arm64.tar.gz"
      sha256 "1530018ccdc62cee7815074000bb0304a15bc3f08abeadf990dba78b3af0a4e9"
    end
    on_intel do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.21/canopy-code-2026.10.21-linux-x64.tar.gz"
      sha256 "b773f86464362d7ea8455b35d7d2c15a04f30b4a5612c6e4ce332cbf132cf78e"
    end
  end

  def install
    # The archive's layout goes to libexec as is, so canopy finds its helpers beside its real
    # binary (and the gateway its Web Shell in ../share, the Linux sandbox its bubblewrap in
    # ../codex-resources). Only the commands people run go on the PATH, as small exec wrappers.
    # The helpers stay off it: `codex-code-mode-host` has the same name as the one OpenAI's
    # `codex` cask puts in the same bin directory, which kept `brew link` from linking canopy.
    libexec.install "bin", "share"
    libexec.install "codex-resources" if OS.linux?
    bin.write_exec_script %w[canopy canopy-gateway canopy-channels].map { |name| libexec/"bin"/name }
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
    assert_predicate libexec/"bin/codex-code-mode-host", :executable?
    refute_predicate bin/"codex-code-mode-host", :exist?
  end
end
