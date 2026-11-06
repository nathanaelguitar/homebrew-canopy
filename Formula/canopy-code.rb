# Rendered by packaging/render.py into Formula/canopy-code.rb of nathanaelguitar/homebrew-canopy.
class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  version "2026.11.05"
  license "Apache-2.0"

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.11.05/canopy-code-2026.11.05-darwin-arm64.tar.gz"
    sha256 "55018d6960db69114b813a8b2f2bdc7dd089176afebb10d6e7f5977a594bc94c"
  end

  on_linux do
    on_arm do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.11.05/canopy-code-2026.11.05-linux-arm64.tar.gz"
      sha256 "a72cc51ae6a781d78e4ff35d47a199094580a87aebb93d1a50982e70c0d885ad"
    end
    on_intel do
      url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.11.05/canopy-code-2026.11.05-linux-x64.tar.gz"
      sha256 "700b3c67b81280ef3bc9a7dd5b3794ff66476ce97491e15e14e91c3b988a4bbf"
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
