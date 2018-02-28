require('move_space')

hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 3
hs.grid.GRIDHEIGHT = 3

hs.window.animationDuration = 0
-- hotkey mash
local mash   = {"alt", "ctrl"}
local halfWidth = hs.grid.GRIDWIDTH / 2


-- Reload automatically
function reloadConfig(files)
  doReload = false
  for _,file in pairs(files) do
      if file:sub(-4) == ".lua" then
          doReload = true
      end
  end
  if doReload then
      hs.reload()
  end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")


hs.hotkey.bind(mash, 'down', hs.grid.show)

hs.hotkey.bind(mash, 'up', function()
  hs.grid.adjustWindow(function(cell)
    cell.x = 0
    cell.y = 0
    cell.w = hs.grid.GRIDWIDTH
    cell.h = hs.grid.GRIDHEIGHT
  end)
end)

hs.hotkey.bind(mash, 'left', function()
  hs.grid.adjustWindow(function(cell)
    cell.x = 0
    cell.y = 0
    cell.w = halfWidth
    cell.h = hs.grid.GRIDHEIGHT
  end)
end)

hs.hotkey.bind(mash, 'right', function()
  hs.grid.adjustWindow(function(cell)
    cell.x = halfWidth
    cell.y = 0
    cell.w = halfWidth
    cell.h = hs.grid.GRIDHEIGHT
  end)
end)

-- multi monitor
hs.hotkey.bind(mash, 'N', hs.grid.pushWindowNextScreen)
hs.hotkey.bind(mash, 'P', hs.grid.pushWindowPrevScreen)

-- move windows

-- Window Hints
hs.hotkey.bind(mash, '.', hs.hints.windowHints)


-- Restart Hajo
if false then
  hs.timer.doEvery(60 * 10, function()
    hajo = hs.application.find("Hajo")
    if hajo then
      hajo:kill()
    end
    hs.timer.doAfter(1, function()
      hs.application.open("Hajo Headphone Enhancer")
    end)
  end)
end

-- Restart Alacritty
hs.hotkey.bind(mash, 'A', function()
  alacritty = hs.application.find("Alacritty")
  if alacritty then
    alacritty:kill9()
  end
  hs.timer.doAfter(1, function()
    hs.application.open("/Applications/Alacritty.app")
    hs.timer.doAfter(1, function()
      alacritty = hs.application.find("Alacritty")
      hs.grid.maximizeWindow(alacritty:focusedWindow())
    end)
  end)
end)

-- Hammer soon autofill
delay = 1
hs.hotkey.bind(mash, '7', function()
  hs.timer.doAfter(delay, function()
    hs.execute('/Users/uri/dev/python/autogui/env/bin/python3 /Users/uri/dev/python/autogui/recurly_autogui.py')
  end)
end)
hs.hotkey.bind(mash, 'pad7', function()
  hs.timer.doAfter(delay, function()
    hs.execute('/Users/uri/dev/python/autogui/env/bin/python3 /Users/uri/dev/python/autogui/recurly_autogui.py')
  end)
end)
hs.hotkey.bind(mash, 'pad8', function()
  hs.timer.doAfter(delay, function()
    hs.execute('env RECURLY_ALT_START=1 /Users/uri/dev/python/autogui/env/bin/python3 /Users/uri/dev/python/autogui/recurly_autogui.py')
  end)
end)
