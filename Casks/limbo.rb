cask "limbo" do
  # `Scripts/bump.sh limbo` rewrites these two lines from the latest GitHub
  # release, checksum computed from the downloaded asset.
  version "0.6.0"
  sha256 "a4b9e506a67158076753cd73ff8a1909fd48af1bd6def339ee49d8a5be153897"

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
