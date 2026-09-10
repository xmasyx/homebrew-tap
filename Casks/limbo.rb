cask "limbo" do
  # `Scripts/bump.sh limbo` rewrites these two lines from the latest GitHub
  # release, checksum computed from the downloaded asset.
  version "0.6.1"
  sha256 "62ada43075a25c646b24d6609a5e98aa924393a081120c627e2d65257bb13b5e"

  url "https://github.com/xmasyx/limbo/releases/download/v#{version}/Limbo.zip"
  name "Limbo"
  desc "Clipboard, shelf and converter that live in the notch of your Mac"
  homepage "https://github.com/xmasyx/limbo"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask xmasyx/tap/limbo
  # then, once: xattr -dr com.apple.quarantine /Applications/Limbo.app
  # Later updates go through the app's own "Verifica aggiornamenti" button in
  # Settings, which clears the flag itself.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Limbo.app"

  # What you copied and what you shelved live outside the bundle and survive an
  # upgrade; `brew zap` is the one command meant to take them away.
  zap trash: [
    "~/Library/Application Support/Limbo",
    "~/Library/Preferences/app.limbo.mac.plist",
  ]
end
