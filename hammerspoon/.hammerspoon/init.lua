local resizeFraction = 0.07
local moveSpeedHorizontally = 0.10
local moveSpeedVertically = 0.10

local function getPadding(win)
    local screen = win:screen()
    local name = screen:name()
    if name:lower():find("built%-in") then
        return 20
    end
    return 35
end

local function getPaddingTop(win)
    local screen = win:screen()
    local name = screen:name()
    if name:lower():find("built%-in") then
        return 25
    end
    return 75
end

-- Move right
hs.hotkey.bind({ "alt", "shift" }, "Right", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    local padding = getPadding(win)

    f.x = math.min(max.x + max.w - padding - f.w,
                   f.x + (max.w * moveSpeedHorizontally))
    win:setFrame(f)
end)

-- Move left
hs.hotkey.bind({ "alt", "shift" }, "Left", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    local padding = getPadding(win)

    f.x = math.max(max.x + padding,
                   f.x - (max.w * moveSpeedHorizontally))
    win:setFrame(f)
end)

-- Move down
hs.hotkey.bind({ "alt", "shift" }, "Down", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    local padding = getPadding(win)

    f.y = math.min(max.y + max.h - padding - f.h,
                   f.y + (max.h * moveSpeedVertically))
    win:setFrame(f)
end)

-- Move up
hs.hotkey.bind({ "alt", "shift" }, "Up", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    local padding = getPaddingTop(win)

    f.y = math.max(max.y + padding,
                   f.y - (max.h * moveSpeedVertically))
    win:setFrame(f)
end)

-- Shrink width
hs.hotkey.bind({ "alt", "shift" }, "U", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    f.w = math.max(50, f.w - (max.w * resizeFraction))
    win:setFrame(f)
end)

-- Grow width
hs.hotkey.bind({ "alt", "shift" }, "P", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    local padding = getPadding(win)
    f.w = math.min(max.x + max.w - padding - f.x,
                   f.w + (max.w * resizeFraction))
    win:setFrame(f)
end)

-- Shrink height
hs.hotkey.bind({ "alt", "shift" }, "O", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    f.h = math.max(50, f.h - (max.h * resizeFraction))
    win:setFrame(f)
end)

-- Grow height
hs.hotkey.bind({ "alt", "shift" }, "I", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local f = win:frame()
    local max = win:screen():frame()
    local padding = getPadding(win)
    f.h = math.min(max.y + max.h - padding - f.y,
                   f.h + (max.h * resizeFraction))
    win:setFrame(f)
end)

-- Center and resize nicely
hs.hotkey.bind({ "alt", "shift" }, "C", function()
    local win = hs.window.focusedWindow()
    if not win then return end
    local max = win:screen():frame()
    local padding = getPadding(win)
    local newW = (max.w - 2 * padding) * 0.7
    local newH = (max.h - 2 * padding) * 0.8
    local newX = max.x + padding + ((max.w - 2 * padding) - newW) / 2
    local newY = max.y + padding + ((max.h - 2 * padding) - newH) / 2
    win:setFrame(hs.geometry.rect(newX, newY, newW, newH))
end)

