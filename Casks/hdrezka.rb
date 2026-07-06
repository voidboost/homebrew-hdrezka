cask "hdrezka" do
  version "1.0.42"
  sha256 "cfd902fdc4366bf01e0924b2eeb3b1c6e9d07d0920bb9a09b6abd60f43b94edc"

  url "https://voidboost.github.io/hdrezka-releases/HDrezka.dmg"
  name "HDrezka"
  desc "Unofficial macOS client for HDrezka"
  homepage "https://github.com/voidboost/hdrezka-swiftui"

  livecheck do
    url "https://voidboost.github.io/hdrezka-releases/appcast.xml"
    strategy :sparkle do |items|
      items.map(&:short_version)
    end
  end

  auto_updates true
  depends_on macos: :sequoia

  app "HDrezka.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/HDrezka.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/HDrezka",
    "~/Library/Caches/io.silentsea.hdrezka",
    "~/Library/Preferences/io.silentsea.hdrezka.plist",
    "~/Library/Saved Application State/io.silentsea.hdrezka.savedState",
  ]

  caveats <<~EOS
    Unofficial macOS client for HDrezka.

    This cask automatically removes the quarantine flag during install.

    If Gatekeeper blocks launch, run:

      xattr -dr com.apple.quarantine "/Applications/HDrezka.app"
  EOS
end
