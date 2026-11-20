cask "caprine" do
  version "2.63.3"
  sha256 arm:   "7daa4d576e2345fda152ddbf4e86ca1019cf3d113ac6f92547689ec840b0389e",
         intel: "43a8d8865a0b3bdfbab9a2dc2ab0577007b2e88b5047fee26776ffcedefcb18c"

  on_arm do
    url "https://github.com/bankjaneo/caprine/releases/download/v#{version}/Caprine-#{version}-arm64.dmg"
  end
  on_intel do
    url "https://github.com/bankjaneo/caprine/releases/download/v#{version}/Caprine-#{version}.dmg"
  end

  name "Caprine"
  desc "Elegant Facebook Messenger desktop app"
  homepage "https://github.com/bankjaneo/caprine"

  livecheck do
    url "https://api.github.com/repos/bankjaneo/caprine/releases/latest"
    strategy :json do |json|
      json["tag_name"]&.delete_prefix("v")
    end
  end

  # Updates are owned by brew; the in-app updater is disabled for unsigned builds.
  auto_updates false
  depends_on :macos

  app "Caprine.app"

  # The app is not notarized yet (no Apple Developer certificate), so remove the
  # quarantine xattr that Homebrew applies; otherwise macOS reports the app as
  # "damaged". Remove this once builds are signed and notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Caprine.app"],
        writable_paths: ["{{appdir}}/Caprine.app"]
  end

  zap trash: [
    "~/Library/Application Support/Caprine",
    "~/Library/Caches/com.sindresorhus.Caprine",
    "~/Library/Caches/com.sindresorhus.Caprine.ShipIt",
    "~/Library/Preferences/com.sindresorhus.Caprine.plist",
    "~/Library/Saved Application State/com.sindresorhus.Caprine.savedState",
    "~/Library/WebKit/com.sindresorhus.Caprine",
  ]
end
