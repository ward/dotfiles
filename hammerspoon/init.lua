-- https://github.com/scottwhudson/Lunette
-- Keybindings like Spectacle provided
hs.loadSpoon("Lunette")
spoon.Lunette:bindHotkeys()

amphetamine = require "amphetamine"

-- Doing it through standard Mac ways resulted in it not working in Finder.
-- Instead just making the binding here.
hs.hotkey.bind({"ctrl", "cmd"}, "T", function()
  -- Downside: opens new instances instead of just windows
  -- local shell_command = "open -n -a /Applications/Alacritty.app"
  -- Downsides:
  -- 1. doesnt work if none open. (perhaps check if one is open?)
  -- 2. does not open focused, so might be behind other window. See
  --    hs.window.find and hs.window:focus() perhaps.
  -- local shell_command = "/usr/local/bin/alacritty msg create-window"
  local shell_command = "osascript -e 'tell application \"iTerm\" to create window with default profile'"
  hs.execute(shell_command)
  hs.notify.new({title="Launching iTerm"}):send()
end)

hs.hotkey.bind({}, "F19", function()
  -- Perhaps use hs.sound instead?
  local shell_command = "/usr/bin/afplay /Users/wardmuylaert/Library/Mobile\\ Documents/com~apple~QuickTimePlayerX/Documents/gezondheid.m4a"
  hs.execute(shell_command)
end)

-- hs.hotkey.bind({}, "F16", function()
--   if hs.spotify.isRunning() then
--     hs.spotify.playpause()
--     hs.spotify.displayCurrentTrack()
--   end
-- end)

function displayCurrentSpotifyTrack(stopping)
	-- There is hs.spotify.displayCurrentTrack, but I wanted to add some extra text
	-- Just copying their implementation with adjustments
	local artist = hs.spotify.getCurrentArtist() or "Unknown artist"
	local album  = hs.spotify.getCurrentAlbum() or "Unknown album"
	local track  = hs.spotify.getCurrentTrack() or "Unknown track"
	local playpausemsg = "Playing"
	if stopping then
		playpausemsg = "Pausing"
	end
	local msg = playpausemsg .. "\ntrack: " .. track .."\nalbum: ".. album .."\nartist: ".. artist
	local duration = 3
	hs.alert.show(msg, duration)
end

hs.hotkey.bind({"ctrl", "cmd"}, "P", function()
  if hs.spotify.isRunning() then
    local stopping = hs.spotify.isPlaying()
    hs.spotify.playpause()
    displayCurrentSpotifyTrack(stopping)
  end
end)

-- Intercept press on PLAY button
-- Don't think this is activated since installing USB Overdrive.
-- tap = hs.eventtap.new({hs.eventtap.event.types.NSSystemDefined}, function(event)
--   local sys_key_event = event:systemKey()
--   -- When I want to add Back/forward, they event keys are: REWIND and FAST
--   if sys_key_event and sys_key_event.key == "PLAY" then
--     -- local blab = hs.application.find(20488):bundleID()
--     -- hs.alert.show(blab)
--     -- Only if Quod Libet is running do we do something special
--     if hs.application.get("io.github.quodlibet.QuodLibet") then
--       if sys_key_event.down then
--         hs.execute("/Applications/QuodLibet.app/Contents/MacOS/quodlibet --play-pause")
--         hs.alert.show("Toggled play-pause of Quod Libet.")
--       end
--       return true -- Eat event
--     end
--   end
--   return false -- Propagate event
-- end)
-- tap:start()
