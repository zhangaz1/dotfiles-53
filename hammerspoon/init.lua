local Audio = require 'audio'
local Grid = require 'grid'
local Music = require 'itunes'

-- Enable dual-mapping of Ctrl to Escape
-- I used to use karabiner for this but it isn't supported on OS X Sierra
-- See this link for more discussion, context, and workarounds:
-- https://github.com/tekezo/Karabiner-Elements/issues/8
require 'ctrl_escape'

-- Remap some chorded Ctrl bindings for ergonomics:
require 'ctrl_remaps'

-- WIP pomodoro app
local Pomo = require 'pomodoro'
hs.hotkey.bind({}, 'F16', Pomo.startNew)
hs.hotkey.bind({}, 'F17', Pomo.togglePaused)
hs.hotkey.bind({}, 'F19', Pomo.showLatest)

-- For more crazy remapping shenanigans and ideas, see this file:
-- https://github.com/wincent/wincent/blob/master/roles/dotfiles/files/.hammerspoon/eventtap.lua

-- Reload automatically on config changes
hs.pathwatcher.new(os.getenv('HOME') .. '/.hammerspoon/', hs.reload):start()
hs.alert('Hammerspoon is locked and loaded', 1)

hs.window.animationDuration = 0     -- Disable window animations (janky for iTerm)

local mash = {'ctrl', 'alt', 'cmd'}

-- Hammerspoon repl:
hs.hotkey.bind(mash, 'C', hs.openConsole)
hs.hotkey.bind(mash, 'R', hs.reload)

-- Window management
hs.hotkey.bind(mash, 'K', Grid.fullscreen)
hs.hotkey.bind(mash, 'H', Grid.leftchunk)
hs.hotkey.bind(mash, 'L', Grid.rightchunk)
hs.hotkey.bind(mash, 'J', Grid.pushwindow)

hs.hotkey.bind(mash, 'N', Grid.topleft)
hs.hotkey.bind(mash, 'M', Grid.bottomleft)
hs.hotkey.bind(mash, ',', Grid.topright)
hs.hotkey.bind(mash, '.', Grid.bottomright)
hs.hotkey.bind(mash, 'P', Grid.rightpeek)


-- iTunes control
hs.hotkey.bind(mash, 'UP', hs.itunes.play)
hs.hotkey.bind(mash, 'DOWN', hs.itunes.pause)
hs.hotkey.bind(mash, 'LEFT', hs.itunes.previous)
hs.hotkey.bind(mash, 'RIGHT', hs.itunes.next)
hs.hotkey.bind(mash, '/', hs.itunes.displayCurrentTrack)
hs.hotkey.bind(mash, 'S', Music.toggleShuffle)

-- Slack-specific app launcher (since I keep it "peeked" to the side by default)
function showSlack()
  local appName = 'Slack'
  local app = hs.application.find(appName)
  hs.application.launchOrFocus(appName)

  if (app and hs.application.isRunning(app)) then
    Grid.topleft()
  end
end

-- Launch/focus specific apps with one keystroke.
-- Note: to get {^1,^2,^3} to work, you might need to change some conflicting
-- Mission Control keyboard shortcuts in SysPrefs > Keyboard > Shortcuts
hs.hotkey.bind({'ctrl'}, '1', function() hs.application.launchOrFocus('Google Chrome') end)
hs.hotkey.bind({'ctrl'}, '2', function() hs.application.launchOrFocus('iTerm2') end)
hs.hotkey.bind({'ctrl'}, '3', showSlack)
hs.hotkey.bind({'ctrl'}, '4', function() hs.application.launchOrFocus('Finder') end)

hs.hotkey.bind({'ctrl'}, '0', function() hs.application.launchOrFocus('iTunes') end)


-- Audio volume control
hs.hotkey.bind({}, 'F13', Audio.toggleMute)
hs.hotkey.bind({}, 'F14', Audio.decVolume)
hs.hotkey.bind({}, 'F15', Audio.incVolume)
