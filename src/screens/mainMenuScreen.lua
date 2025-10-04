local mainMenuScreen = {}

local button = require("src.interface.button")
local exitPanel = require("src.panels.exitPanel")

-- BUTTON

local MAX_BUTTONS = 4
local buttons = {}
local buttonsNames = {
    "PLAY",
    "RULES",
    "CREDITS",
    "EXIT"
}
local screenID = {
    gameplay = 1,
    howToPlay = 2,
    credits = 3,
    exit = 4
}
local WIDTH_BUTTON = 300
local HEIGHT_BUTTON = 80
local SPACE_BETWEEN = 5

-- LOGO

local logo = {
    x = 0,
    y = 0,
    width = 600,
    height = 350
}

local function initLogoAndButtons()
    local totalHeight = logo.height + (MAX_BUTTONS * HEIGHT_BUTTON) + (MAX_BUTTONS - 1) * SPACE_BETWEEN
    local startY = SCREEN_HEIGHT / 2 - totalHeight / 2

    logo.x = SCREEN_WIDTH / 2 - logo.width / 2
    logo.y = startY

    local startButtonsY = logo.y + logo.height + SPACE_BETWEEN
    local menuX = SCREEN_WIDTH / 2 - WIDTH_BUTTON / 2

    for i = 1, MAX_BUTTONS do
        buttons[i] = button.create(menuX, startButtonsY + (i - 1) * (HEIGHT_BUTTON + SPACE_BETWEEN), WIDTH_BUTTON, HEIGHT_BUTTON, buttonsNames[i])
    end
end

local function updateAllButtons()
    for i = 1, MAX_BUTTONS do
        button.update(buttons[i])
    end

    if buttons[screenID.gameplay].clicked then
        currentScreen = screens.gameplay
    end

    if buttons[screenID.howToPlay].clicked then
        currentScreen = screens.howToPlay
    end

    if buttons[screenID.credits].clicked then
        currentScreen = screens.credits
    end

    if buttons[screenID.exit].clicked then
        exitPanel.show()
    end
end

function mainMenuScreen.load()
    initLogoAndButtons()
    exitPanel.load()
end

function mainMenuScreen.update(deltaTime)
    if not exitPanel.isActive() then
        updateAllButtons()
    end

    exitPanel.update()
end

function mainMenuScreen.draw()
    for i = 1, MAX_BUTTONS do
        button.draw(buttons[i])
    end

    love.graphics.rectangle("fill", logo.x, logo.y, logo.width, logo.height)

    exitPanel.draw()
end

function mainMenuScreen.keypressed(key)
    if key == "escape" then
        exitPanel.toggle()
    end
end

return mainMenuScreen