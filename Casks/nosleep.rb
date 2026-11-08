cask "nosleep" do
  version "1.3.3"
  sha256 "92f5956de732c299f4cb8840971ddc7ce14b2933fc069e2d6ac7854531cb7578"

  url "https://github.com/xmasyx/nosleep/releases/download/v#{version}/NoSleep-#{version}.zip"
  name "NoSleep"
  desc "Keeps the Mac awake until the work is done, even with the lid closed"
  homepage "https://github.com/xmasyx/nosleep"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew trust xmasyx/tap   (once per Mac: Homebrew loads a third-party tap only after you trust it)
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
