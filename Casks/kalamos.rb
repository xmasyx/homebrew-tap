cask "kalamos" do
  version "1.5.0"
  sha256 "9174d92e9065bd235f6ca7f95b041412ef0862fbc2b7cccbbdd2c0f9fdce5f1e"

  url "https://github.com/xmasyx/kalamos/releases/download/v#{version}/Kalamos.zip"
  name "Kalamos"
  desc "Local dictation for macOS: WhisperKit transcription, MLX cleanup, nothing leaves the Mac"
  homepage "https://github.com/xmasyx/kalamos"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Signed with the project's own certificate, not notarized: install with
  #   brew install --cask xmasyx/tap/kalamos
  # then, once: xattr -dr com.apple.quarantine /Applications/Kalamos.app (not notarized)
  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Kalamos.app"

  # The downloaded speech and language models live outside the bundle and survive upgrades;
  # `brew zap` is the one command meant to take them away.
  zap trash: [
    "~/Library/Application Support/Kalamos",
    "~/Library/Preferences/app.kalamos.mac.plist",
  ]
end
