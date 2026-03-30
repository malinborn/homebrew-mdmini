cask "mdmini" do
  version "0.1.0"

  url "https://github.com/malinborn/mdmini/releases/download/v#{version}/mdmini_#{version}_aarch64.dmg"
  sha256 "32e3a42658c87324f9006d617b8decc533f673c1bd65e98a956bf9f534a11e4a"

  name "mdmini"
  desc "Minimalist live-preview markdown editor for macOS"
  homepage "https://github.com/malinborn/mdmini"

  depends_on arch: :arm64

  app "md-mini.app"

  postflight do
    script = <<~EOS
      #!/usr/bin/env bash
      APP="/Applications/md-mini.app"
      BIN="$APP/Contents/MacOS/md-mini"
      SOCK="/tmp/com_md_mini_app_si.sock"
      PENDING="/tmp/md-mini-pending-files"
      args=()
      for arg in "$@"; do
        if [[ "$arg" != -* && "$arg" != /* ]]; then
          arg="$(cd "$(dirname "$arg")" 2>/dev/null && pwd)/$(basename "$arg")"
        fi
        args+=("$arg")
      done
      if [ -S "$SOCK" ]; then
        "$BIN" "${args[@]}" 2>/dev/null
      else
        [ ${#args[@]} -gt 0 ] && printf '%s\\n' "${args[@]}" > "$PENDING"
        open "$APP"
      fi
    EOS
    File.write("/usr/local/bin/mdmini", script)
    FileUtils.chmod(0755, "/usr/local/bin/mdmini")
  end

  uninstall quit: "com.md-mini.app"

  zap trash: [
    "~/Library/Application Support/com.md-mini.app",
    "~/Library/Caches/com.md-mini.app",
    "~/Library/Preferences/com.md-mini.app.plist",
    "/tmp/md-mini-pending-files",
    "/tmp/com_md_mini_app_si.sock",
  ],
  delete: "/usr/local/bin/mdmini"
end
