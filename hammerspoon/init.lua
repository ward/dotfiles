-- https://github.com/scottwhudson/Lunette
-- Keybindings like Spectacle provided
hs.loadSpoon("Lunette")
spoon.Lunette:bindHotkeys()

amphetamine = require "amphetamine"

-- Doing it through standard Mac ways resulted in it not working in Finder.
-- Instead just making the binding here.
hs.hotkey.bind({"ctrl", "cmd"}, "T", function()
  local shell_command = "open -n -a /Applications/Alacritty.app"
  hs.execute(shell_command)
  hs.notify.new({title="Launching Alacritty"}):send()
end)

hs.hotkey.bind({}, "F19", function()
  -- Perhaps use hs.sound instead?
  local shell_command = "/usr/bin/afplay /Users/wardmuylaert/Library/Mobile\\ Documents/com~apple~QuickTimePlayerX/Documents/gezondheid.m4a"
  hs.execute(shell_command)
end)

hs.hotkey.bind({}, "F18", function()
  local shell_command = "open /Users/wardmuylaert/OneDrive\\ -\\ Vrije\\ Universiteit\\ Brussel/timetracking.tsv"
  hs.execute(shell_command)
end)

hs.hotkey.bind({}, "F17", function()
  local shell_command = "open /Users/wardmuylaert/OneDrive/todo.txt"
  hs.execute(shell_command)
end)

-- Intercept press on PLAY button
tap = hs.eventtap.new({hs.eventtap.event.types.NSSystemDefined}, function(event)
  local sys_key_event = event:systemKey()
  -- When I want to add Back/forward, they event keys are: REWIND and FAST
  if sys_key_event and sys_key_event.key == "PLAY" then
    -- Only if Quod Libet is running do we do something special
    if hs.application.get("io.github.quodlibet.quodlibet") then
      if sys_key_event.down then
        hs.execute("/Applications/QuodLibet.app/Contents/MacOS/quodlibet --play-pause")
        hs.alert.show("Toggled play-pause of Quod Libet.")
      end
      return true -- Eat event
    end
  end
  return false -- Propagate event
end)
tap:start()
