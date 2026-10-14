cask "hdrezka" do
  version "1.0.56"
  sha256 "82fd29dc75f34f601e59778e24a4d2172a6db66488d365257cacd19566fe02fd"

  url "https://github.com/voidboost/hdrezka-swiftui/releases/download/#{version}/HDrezka.dmg"

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

  postflight_steps do
    run "/usr/bin/xattr",
      args: [
        "-dr",
        "com.apple.quarantine",
        "{{appdir}}/HDrezka.app",
      ]
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
