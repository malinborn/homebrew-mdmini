cask "couplet" do
  version "2.0.1"

  # Universal build (Apple Silicon + Intel) — one file for both architectures,
  # so no `depends_on arch:` and no Hardware::CPU.arm? branch.
  url "https://github.com/malinborn/couplet/releases/download/v#{version}/couplet_#{version}_universal.dmg"
  sha256 "d9219fc50e4eb07c79d1c3724c6c5853a5a4ff51d91dc19a14ef2cb93a4efea3"

  name "couplet"
  desc "Markdown editor you and your AI agent work in together"
  homepage "https://couplet.pro"

  app "couplet.app"
  binary "#{appdir}/couplet.app/Contents/Resources/bin/couplet", target: "couplet"
  # Former name: execs `couplet`, so MCP registrations and scripts that call
  # `mdmini` keep working after the rename.
  binary "#{appdir}/couplet.app/Contents/Resources/bin/mdmini", target: "mdmini"
  binary "#{appdir}/couplet.app/Contents/Resources/bin/coup", target: "coup"

  # Remove quarantine for unsigned app (custom tap only — official cask doesn't allow this)
  # `postflight_steps` runs in Homebrew::InstallSteps::DSL — no `system_command`,
  # no Ruby `#{appdir}`. Use the `run` step with the literal `{{appdir}}` token,
  # which the step runner expands at install time.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/couplet.app"]
  end

  uninstall quit: "pro.couplet.app"

  zap trash: [
    "~/Library/Application Support/couplet",
    "~/Library/Application Support/pro.couplet.app",
    "~/Library/Caches/couplet",
    "~/Library/Caches/pro.couplet.app",
    "~/Library/Logs/couplet",
    "~/Library/Preferences/pro.couplet.app.plist",
    "~/Library/Saved Application State/pro.couplet.app.savedState",
    "~/Library/WebKit/pro.couplet.app",
    "/tmp/couplet-pending-files",
    "/tmp/couplet_cmd.sock",
    "/tmp/pro_couplet_app_si.sock",
    # Left behind by md-mini ≤1.3 (after migration it holds only a MOVED_TO note).
    "~/Library/Application Support/md-mini",
    "~/Library/Application Support/com.md-mini.app",
    "~/Library/Caches/com.md-mini.app",
    "~/Library/Preferences/com.md-mini.app.plist",
    "~/Library/WebKit/com.md-mini.app",
  ]
end
