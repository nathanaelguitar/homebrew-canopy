class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.8/canopy-code-2026.10.8-darwin-arm64.tar.gz"
  version "2026.10.8"
  sha256 "7ea521779ee74aa6c5859095c4914d2f436ddb2d07b2988777f1ecbc2c9c8877"
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
