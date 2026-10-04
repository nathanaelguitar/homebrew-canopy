class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.3/canopy-code-2026.10.3-darwin-arm64.tar.gz"
  version "2026.10.3"
  sha256 "a615e91eacb7434b409ea1744a2f2f059cdb2f27c74bbd92701afa1bc6f54707"
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

      Remote control from the CanopyChat app needs a Canopy account:
        https://canopychat.app/signup
    EOS
  end

  test do
    assert_match "Canopy Code", shell_output("#{bin}/canopy --version")
  end
end
