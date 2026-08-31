cask "kalamos" do
  version "1.6.2"
  sha256 "bfed0d80bc31c65514b868bcde5344aaaccb5332db94c18a8bba92fbad20f796"

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
