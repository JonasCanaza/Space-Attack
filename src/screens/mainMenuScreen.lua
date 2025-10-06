local mainMenuScreen = {}

local button = require("src.interface.button")
local exitPanel = require("src.panels.exitPanel")

-- BUTTON

local MAX_BUTTONS = 4
local buttons = {}
local BUTTONS_TEXTS = {
    "Play",
    "Rules",
    "Credits",
    "Exit"
}
local SCREEN_ID = {
    gameplay = 1,
    howToPlay = 2,
    credits = 3,
    exit = 4
}
local WIDTH_BUTTON = 300
local HEIGHT_BUTTON = 80
local BUTTON_SPACING = 5

-- LOGO

local logo = {
    x = 0,
    y = 0,
    width = 700,
    height = 325,
    texture = nil
}

-- BACKGROUND

local background = {
    x = 0,
    y = 0,
    width = SCREEN_WIDTH,
    height = SCREEN_HEIGHT,
    texture = nil
}

local function initLogoAndButtons()
    local totalHeight = logo.height + (MAX_BUTTONS * HEIGHT_BUTTON) + (MAX_BUTTONS - 1) * BUTTON_SPACING
    local startY = SCREEN_HEIGHT / 2 - totalHeight / 2

    logo.x = SCREEN_WIDTH / 2 - logo.width / 2
    logo.y = startY

    local startButtonsY = logo.y + logo.height + BUTTON_SPACING
    local menuX = SCREEN_WIDTH / 2 - WIDTH_BUTTON / 2

    for i = 1, MAX_BUTTONS do
        buttons[i] = button.create(menuX, startButtonsY + (i - 1) * (HEIGHT_BUTTON + BUTTON_SPACING), WIDTH_BUTTON, HEIGHT_BUTTON, BUTTONS_TEXTS[i])
    end
end

local function updateAllButtons()
    for i = 1, MAX_BUTTONS do
        button.update(buttons[i])
    end

    if buttons[SCREEN_ID.gameplay].clicked then
        currentScreen = screens.gameplay
    end

    if buttons[SCREEN_ID.howToPlay].clicked then
        currentScreen = screens.howToPlay
    end

    if buttons[SCREEN_ID.credits].clicked then
        currentScreen = screens.credits
    end

    if buttons[SCREEN_ID.exit].clicked then
        exitPanel.show()
    end
end

function mainMenuScreen.load()
    initLogoAndButtons()
    exitPanel.load()
    button.load()

    logo.texture = love.graphics.newImage("res/ui/logo.png")
    background.texture = love.graphics.newImage("res/ui/mainMenu.png")
end

function mainMenuScreen.update(deltaTime)
    if not exitPanel.isActive() then
        updateAllButtons()
    end

    exitPanel.update()
end

function mainMenuScreen.draw()
    local imgWidth = background.texture:getWidth()
    local imgHeight = background.texture:getHeight()
    local scaleX = background.width / imgWidth
    local scaleY = background.height / imgHeight

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(background.texture, background.x, background.y, 0, scaleX, scaleY)

    for i = 1, MAX_BUTTONS do
        button.draw(buttons[i])
    end

    love.graphics.draw(logo.texture, logo.x, logo.y)

    exitPanel.draw()
end

function mainMenuScreen.keypressed(key)
    if key == "escape" then
        exitPanel.toggle()
    end
end

return mainMenuScreen