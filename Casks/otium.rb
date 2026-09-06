cask "otium" do
  version "1.3.0"
  sha256 "a8c2b97ede28c18d59079b17b5c8c28a32d4b927b7394a27ae61da0b8b701f9f"

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
