cask "hdrezka" do
  version "1.0.62"
  sha256 "3b9452f1cb473d591e95fb1a66cede76cc17b0c0bf2dd5b5b81fff70df411c6d"

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
