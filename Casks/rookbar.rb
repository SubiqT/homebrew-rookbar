cask "rookbar" do
  version "0.1.0"
  sha256 "b2adfe7213edc7bc9fe1f888ad02e462a1d5d928581fb576aae2533660982a06"

  url "https://github.com/SubiqT/rookbar/releases/download/v#{version}/rookbar-#{version}-macos.zip"
  name "rookbar"
  desc "Native status bar for the yabai window manager"
  homepage "https://github.com/SubiqT/rookbar"

  depends_on macos: :sonoma

  app "rookbar.app"
  binary "#{appdir}/rookbar.app/Contents/MacOS/rookbar"

  # A postflight block rather than postflight_steps: the steps sandbox blocks `launchctl bootstrap`.
  postflight do
    # The app is ad-hoc signed, not notarised, so launchd would otherwise refuse the quarantined binary.
    system_command "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "#{appdir}/rookbar.app"]
    # Writes ~/Library/LaunchAgents/com.rookbar.plist and (re)starts the agent, which relaunches after crashes.
    system_command "#{appdir}/rookbar.app/Contents/MacOS/rookbar", args: ["--enable-service"]
  end

  uninstall launchctl: "com.rookbar"

  zap trash: [
    "~/Library/Application Support/rookbar",
    "~/Library/Logs/rookbar.log",
    "~/Library/Preferences/com.rookbar.plist",
  ]

  caveats <<~EOS
    rookbar needs yabai, and room at the top of the screen for the 32pt bar:
      yabai -m config external_bar all:32:0

    Clicking a space to focus it needs yabai's scripting addition.
  EOS
end
