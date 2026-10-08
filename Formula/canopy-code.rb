class CanopyCode < Formula
  desc "Terminal coding agent with remote control from the CanopyChat app"
  homepage "https://canopychat.app"
  url "https://github.com/nathanaelguitar/canopy-code/releases/download/v2026.10.7/canopy-code-2026.10.7-darwin-arm64.tar.gz"
  version "2026.10.7"
  sha256 "81202a29a4b1d6131a2687f925b315654dcaee83ecdc0fa98f5a12774bf8dd6a"
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
