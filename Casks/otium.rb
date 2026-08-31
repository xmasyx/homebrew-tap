cask "otium" do
  version "1.2.1"
  sha256 "f60a55416410015690022b2c924b10b4186f2e00fda6394ef45e56b162a919a8"

  url "https://github.com/xmasyx/otium/releases/download/v#{version}/Otium.zip"
  name "Otium"
  desc "Counts active time and locks the screen until you do an exercise"
  homepage "https://github.com/xmasyx/otium"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask xmasyx/tap/otium
  # then, once: xattr -dr com.apple.quarantine /Applications/Otium.app (not notarized)
  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Otium.app"

  zap trash: [
    "~/Library/Application Support/Otium",
    "~/Library/Preferences/app.otium.mac.plist",
  ]
end
