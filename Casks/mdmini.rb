cask "mdmini" do
  version "1.3.0"

  # Universal build (Apple Silicon + Intel) since 1.0.1 — one file for both
  # architectures, so no `depends_on arch:` and no Hardware::CPU.arm? branch.
  url "https://github.com/malinborn/mdmini/releases/download/v#{version}/md-mini_#{version}_universal.dmg"
  sha256 "6faac5a5565731fa75eb60fda28bd8d5f3b5627c57bbbd65fb00716e6ade11d4"

  name "mdmini"
  desc "Minimalist live-preview markdown editor for macOS"
  homepage "https://github.com/malinborn/mdmini"

  app "md-mini.app"
  binary "#{appdir}/md-mini.app/Contents/Resources/bin/mdmini", target: "mdmini"

  # Remove quarantine for unsigned app (custom tap only — official cask doesn't allow this)
  # `postflight_steps` runs in Homebrew::InstallSteps::DSL — no `system_command`,
  # no Ruby `#{appdir}`. Use the `run` step with the literal `{{appdir}}` token,
  # which the step runner expands at install time.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/md-mini.app"]
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
