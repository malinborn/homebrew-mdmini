cask "mdmini" do
  version "1.0.1"

  # Universal build (Apple Silicon + Intel) since 1.0.1 — one file for both
  # architectures, so no `depends_on arch:` and no Hardware::CPU.arm? branch.
  url "https://github.com/malinborn/mdmini/releases/download/v#{version}/md-mini_#{version}_universal.dmg"
  sha256 "26670aa2e99e3b193582927478fce55d05238dd41c74adbcb8c47c74a3fe7425"

  name "mdmini"
  desc "Minimalist live-preview markdown editor for macOS"
  homepage "https://github.com/malinborn/mdmini"

  app "md-mini.app"
  binary "#{appdir}/md-mini.app/Contents/Resources/bin/mdmini", target: "mdmini"

  # Remove quarantine for unsigned app (custom tap only — official cask doesn't allow this)
  postflight do
    system_command "/usr/bin/xattr",
      args: ["-dr", "com.apple.quarantine", "#{appdir}/md-mini.app"]
  end

  uninstall quit: "com.md-mini.app"

  zap trash: [
    "~/Library/Application Support/md-mini",
    "~/Library/Application Support/com.md-mini.app",
    "~/Library/Caches/com.md-mini.app",
    "~/Library/Preferences/com.md-mini.app.plist",
    "/tmp/md-mini-pending-files",
    "/tmp/com_md_mini_app_si.sock",
  ]
end
