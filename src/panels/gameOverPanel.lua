local gameOverPanel = {}

local button = require("src.interface.button")

local MAX_BUTTONS = 3
local buttons = {}
local BUTTONS_NAMES = {
    "Continue",
    "Restart",
    "Exit"
}
local BUTTON_ID = {
    continue = 1,
    restart = 2,
    exit = 3
}
local WIDTH_BUTTON = 300
local HEIGHT_BUTTON = 80
local BUTTON_SPACING = 5

local imageMessage = {
    x = 0,
    y = 0,
    width = 700,
    height = 300,
    texture = nil
}

local isActive = false
local lastAction = nil

local function initMessage()
    imageMessage.x = SCREEN_WIDTH / 2 - imageMessage.width / 2
    imageMessage.y = SCREEN_HEIGHT / 2 - (imageMessage.height + (MAX_BUTTONS * HEIGHT_BUTTON + (MAX_BUTTONS - 1) * BUTTON_SPACING)) / 2
end

local function initButtons()
    local menuX = SCREEN_WIDTH / 2 - WIDTH_BUTTON / 2
    local startButtonsY = imageMessage.y + imageMessage.height

    for i = 1, MAX_BUTTONS do
        buttons[i] = button.create(menuX, startButtonsY + (HEIGHT_BUTTON + BUTTON_SPACING) * (i - 1), WIDTH_BUTTON, HEIGHT_BUTTON, BUTTONS_NAMES[i])
    end
end

local function updateAllButtons()
    if not isActive then
        return
    end

    for i = 1, MAX_BUTTONS do
        button.update(buttons[i])
    end

    if buttons[BUTTON_ID.continue].clicked then
        isActive = false
        lastAction = "continue"
    end

    if buttons[BUTTON_ID.restart].clicked then
        isActive = false
        lastAction = "restart"
    end

    if buttons[BUTTON_ID.exit].clicked then
        isActive = false
        lastAction = "exit"
    end
end

function gameOverPanel.load()
    initMessage()
    initButtons()

    imageMessage.texture = love.graphics.newImage("res/ui/gameOverPanelMessage.png")
end

function gameOverPanel.update()
    updateAllButtons()
end

function gameOverPanel.draw()
    if not isActive then
        return
    end

    love.graphics.setColor(0.0, 0.0, 0.0, 0.75)
    love.graphics.rectangle("fill", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
    love.graphics.setColor(1, 1, 1)

    love.graphics.draw(imageMessage.texture, imageMessage.x, imageMessage.y)

    for i = 1, MAX_BUTTONS do
        button.draw(buttons[i])
    end
end

function gameOverPanel.show()
    isActive = true
end

function gameOverPanel.hide()
    isActive = false
end

function gameOverPanel.toggle()
    isActive = not isActive
end

function gameOverPanel.isActive()
    return isActive
end

function gameOverPanel.getLastAction()
    return lastAction
end

function gameOverPanel.clearAction()
    lastAction = nil
end

return gameOverPanel