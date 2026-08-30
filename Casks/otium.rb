cask "otium" do
  version "1.2.0"
  sha256 "62260641dd870f19ba30e209692071a6c52830faf9f9098a325b96650f1ea91d"

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
