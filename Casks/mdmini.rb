cask "mdmini" do
  version "0.1.5"

  url "https://github.com/malinborn/mdmini/releases/download/v#{version}/md-mini_#{version}_aarch64.dmg"
  sha256 "e817254070836821b0d3ae493f6f7cc1f9ea76af1d0d3b6915703b7da34a7bd9"

  name "mdmini"
  desc "Minimalist live-preview markdown editor for macOS"
  homepage "https://github.com/malinborn/mdmini"

  depends_on arch: :arm64

  app "md-mini.app"
  binary "#{appdir}/md-mini.app/Contents/Resources/bin/mdmini", target: "mdmini"

  # Remove quarantine for unsigned app (custom tap only — official cask doesn't allow this)
  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/md-mini.app"]
  end

  uninstall quit: "com.md-mini.app"

  zap trash: [
    "~/Library/Application Support/com.md-mini.app",
    "~/Library/Caches/com.md-mini.app",
    "~/Library/Preferences/com.md-mini.app.plist",
    "/tmp/md-mini-pending-files",
    "/tmp/com_md_mini_app_si.sock",
  ]
end
