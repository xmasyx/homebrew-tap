cask "kalamos" do
  version "1.7.0"
  sha256 "b38982cb014cf7b967a76d0986d2255009915195d294aae65d014b984b91ee91"

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
