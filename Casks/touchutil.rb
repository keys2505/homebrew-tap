cask "touchutil" do
  version "1.1.0"
  sha256 "7a611060296498e4262163e29408cc7981b476295218eacd5a7a2b2694671a15"

  url "https://github.com/keys2505/touchutil/releases/download/v#{version}/touchutil-#{version}.zip"
  name "touchutil"
  desc "Map an external USB touchscreen to its display on macOS"
  homepage "https://github.com/keys2505/touchutil"

  app "touchutil.app"
  binary "#{appdir}/touchutil.app/Contents/MacOS/touchutil"

  postflight do
    plist_path = "#{Dir.home}/Library/LaunchAgents/com.touchutil.agent.plist"
    system_command "/bin/launchctl",
      args: ["bootstrap", "gui/#{Process.uid}", plist_path],
      sudo: false
  end

  uninstall launchctl: "com.touchutil.agent",
            delete:    "#{Dir.home}/Library/LaunchAgents/com.touchutil.agent.plist"

  zap trash: "#{Dir.home}/.config/touchutil"
end
