cask "otium" do
  version "1.1.0"
  sha256 "40a6f80f311f520a935479558c2fb98117e4f671ca2465e153219403277f18e3"

  url "https://github.com/xmasyx/otium/releases/download/v#{version}/Otium.zip"
  name "Otium"
  desc "Counts active time and locks the screen until you do an exercise"
  homepage "https://github.com/xmasyx/otium"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask --no-quarantine xmasyx/tap/otium
  # or right-click → Open the first time.
  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "Otium.app"

  zap trash: [
    "~/Library/Application Support/Otium",
    "~/Library/Preferences/app.otium.mac.plist",
  ]
end
