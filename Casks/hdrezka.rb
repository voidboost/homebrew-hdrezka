cask "hdrezka" do
  version "1.0.59"
  sha256 "e84a7d40b9af6899a1c548ae41933522dec702f360cd51bdbd2e9999d581728e"

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
