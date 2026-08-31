cask "nosleep" do
  version "1.3.1"
  sha256 "e6ae743b9e48cfdeaeaf7b7c625bfd07de4239c6d85d8109abf4a1da6c737b31"

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
