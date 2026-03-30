cask "mdmini" do
  version "0.1.0"

  url "https://github.com/malinborn/mdmini/releases/download/v#{version}/md-mini_#{version}_aarch64.dmg"
  sha256 "6905a475112795ecc3cca1a964a58f85f4974d0f5bac9814795e91754fba8812"

  name "mdmini"
  desc "Minimalist live-preview markdown editor for macOS"
  homepage "https://github.com/malinborn/mdmini"

  depends_on arch: :arm64

  app "md-mini.app"
  binary "#{appdir}/md-mini.app/Contents/Resources/bin/mdmini", target: "mdmini"

  uninstall quit: "com.md-mini.app"

  zap trash: [
    "~/Library/Application Support/com.md-mini.app",
    "~/Library/Caches/com.md-mini.app",
    "~/Library/Preferences/com.md-mini.app.plist",
    "/tmp/md-mini-pending-files",
    "/tmp/com_md_mini_app_si.sock",
  ]
end
