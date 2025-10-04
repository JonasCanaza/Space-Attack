local exitPanel = {}

local button = require("src.interface.button")

local MAX_BUTTONS = 2
local buttons = {}
local buttonsNames = {
    "RESUME",
    "EXIT"
}
local buttonID = {
    resume = 1,
    exit = 2
}
local WIDTH_BUTTON = 300
local HEIGHT_BUTTON = 80

local imageMessage = {
    x = 0,
    y = 0,
    width = 700,
    height = 300
}

local isActive = false

local function initButtons()
    local menuX = SCREEN_WIDTH / 2 - WIDTH_BUTTON / 2
    local spaceBetween = HEIGHT_BUTTON + 5

    local startButtonsY = imageMessage.y + imageMessage.height

    for i = 1, MAX_BUTTONS do
        buttons[i] = button.create(menuX, startButtonsY + spaceBetween * (i - 1), WIDTH_BUTTON, HEIGHT_BUTTON, buttonsNames[i])
    end
end

local function updateAllButtons()
    for i = 1, MAX_BUTTONS do
        button.update(buttons[i])
    end

    if buttons[buttonID.resume].clicked then
        isActive = false
    end

    if buttons[buttonID.exit].clicked then
        love.window.close()
    end
end

function exitPanel.load()
    imageMessage.x = SCREEN_WIDTH / 2 - imageMessage.width / 2
    imageMessage.y = SCREEN_HEIGHT / 2 - (imageMessage.height + (MAX_BUTTONS * HEIGHT_BUTTON + (MAX_BUTTONS - 1) * 10)) / 2

    initButtons()
end

function exitPanel.update()
    if not isActive then
        return
    end

    updateAllButtons()
end

function exitPanel.draw()
    if not isActive then
        return
    end

    love.graphics.setColor(0.0, 0.0, 0.0, 0.8)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1, 1, 1)

    love.graphics.rectangle("fill", imageMessage.x, imageMessage.y, imageMessage.width, imageMessage.height)

    for i = 1, MAX_BUTTONS do
        button.draw(buttons[i])
    end
end

function exitPanel.show()
    isActive = true
end

function exitPanel.hide()
    isActive = false
end

function exitPanel.toggle()
    isActive = not isActive
end

function exitPanel.isActive()
    return isActive
end

return exitPanel