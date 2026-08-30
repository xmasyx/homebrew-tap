cask "nosleep" do
  version "1.3.0"
  sha256 "a792b96b66bd77c9fd7bc5d2aa85d6be59b887e256766d3f24a73fabf2efad9d"

  url "https://github.com/xmasyx/nosleep/releases/download/v#{version}/NoSleep-#{version}.zip"
  name "NoSleep"
  desc "Keeps the Mac awake until the work is done, even with the lid closed"
  homepage "https://github.com/xmasyx/nosleep"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask xmasyx/tap/nosleep
  # then, once: xattr -dr com.apple.quarantine /Applications/NoSleep.app (not notarized)
  depends_on macos: :sequoia
  depends_on arch: :arm64

  app "NoSleep.app"

  zap trash: [
    "~/Library/Application Support/NoSleep",
    "~/Library/Preferences/app.nosleep.mac.plist",
  ]
end
