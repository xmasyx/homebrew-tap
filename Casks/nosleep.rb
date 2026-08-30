cask "nosleep" do
  version "1.2.0"
  sha256 "345bb36bcbd8e86fb83de049a4406964a4f6ae56f48ac00baa38c5f0a5c78d76"

  url "https://github.com/xmasyx/nosleep/releases/download/v#{version}/NoSleep-#{version}.zip"
  name "NoSleep"
  desc "Keeps the Mac awake until the work is done, even with the lid closed"
  homepage "https://github.com/xmasyx/nosleep"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask --no-quarantine xmasyx/tap/nosleep
  # or right-click → Open the first time.
  depends_on macos: ">= :sequoia"
  depends_on arch: :arm64

  app "NoSleep.app"

  zap trash: [
    "~/Library/Application Support/NoSleep",
    "~/Library/Preferences/app.nosleep.mac.plist",
  ]
end
