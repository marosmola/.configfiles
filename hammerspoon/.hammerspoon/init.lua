stackline = require "stackline"
stackline:init()

-- Only show stackline indicators when the current space is in stack layout.
-- Clear all indicators when in BSP or float mode.
local function isStackLayout()
  local handle = io.popen("/opt/homebrew/bin/yabai -m query --spaces --json")
  local json = handle:read("*a")
  handle:close()
  for _, s in ipairs(hs.json.decode(json)) do
    if s["has-focus"] then
      return s.type == "stack"
    end
  end
  return false
end

local function clearAllIndicators()
  pcall(function()
    stackline.manager:eachStack(function(stack)
      stack:deleteAllIndicators()
    end)
  end)
end

local lastStackState = nil

local function updateStacklineVisibility()
  local stackMode = isStackLayout()
  if lastStackState == nil then
    -- First run: clear if in BSP, no-op if in stack
    if not stackMode then
      clearAllIndicators()
    end
  elseif stackMode ~= lastStackState then
    -- Layout changed
    if not stackMode then
      clearAllIndicators()
    end
  end
  lastStackState = stackMode
end

-- Check on init
updateStacklineVisibility()

-- Poll every 1 second to catch space/layout changes
hs.timer.new(1.0, function()
  updateStacklineVisibility()
end):start()
