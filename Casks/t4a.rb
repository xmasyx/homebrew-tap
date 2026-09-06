cask "t4a" do
  # `Scripts/bump.sh t4a` rewrites these two lines from the latest GitHub
  # release, checksum computed from the downloaded asset.
  version "0.1.0"
  sha256 "a0123e5dd877579250d6b357b006eda0a856627bf98f25b9426bf9a78766f576"

  url "https://github.com/xmasyx/t4a/releases/download/v#{version}/T4A-#{version}.zip"
  name "T4A"
  desc "GPU-drawn terminal that treats agent sessions as objects"
  homepage "https://github.com/xmasyx/t4a"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask xmasyx/tap/t4a
  # then, once: xattr -dr com.apple.quarantine /Applications/T4A.app (not notarized)
  # Later updates go through the app's own "Check for updates" button, which
  # clears the flag itself.
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "T4A.app"

  zap trash: [
    "~/.cache/t4a",
    "~/.config/t4a",
  ]
end
