local howToPlayScreen = {}

local button = require("src.interface.button")

local sceneButton = {}
local BUTTON_TEXT = "Back"
local WIDTH_BUTTON = 300
local HEIGHT_BUTTON = 80
local MARGIN_BUTTON = 20

-- BACKGROUND

local background = {
    x = 0,
    y = 0,
    width = SCREEN_WIDTH,
    height = SCREEN_HEIGHT,
    texture = nil
}

-- TEXT

local text = {
    x = 0,
    y = 0,
    width = SCREEN_WIDTH,
    height = SCREEN_HEIGHT,
    texture = nil
}

local function initButton()
    local posX = SCREEN_WIDTH / 2 - WIDTH_BUTTON / 2
    local posY = SCREEN_HEIGHT - HEIGHT_BUTTON - MARGIN_BUTTON

    sceneButton = button.create(posX, posY, WIDTH_BUTTON, HEIGHT_BUTTON, BUTTON_TEXT)
end

function howToPlayScreen.load()
    initButton()

    background.texture = love.graphics.newImage("res/background/rules.png")
    text.texture = love.graphics.newImage("res/ui/rulesText.png")
end

function howToPlayScreen.update(deltaTime)
    button.update(sceneButton)

    if sceneButton.clicked then
        currentScreen = screens.mainMenu
    end
end

function howToPlayScreen.draw()
    local imgWidthBackground = background.texture:getWidth()
    local imgHeightBackground = background.texture:getHeight()
    local scaleBackgroundX = background.width / imgWidthBackground
    local scaleBackgroundY = background.height / imgHeightBackground
    local imgWidthText = text.texture:getWidth()
    local imgHeightText = text.texture:getHeight()
    local scaleTextX = text.width / imgWidthText
    local scaleTextY = text.height / imgHeightText

    love.graphics.draw(background.texture, background.x, background.y, 0, scaleBackgroundX, scaleBackgroundY)
    love.graphics.draw(text.texture, text.x, text.y, 0, scaleTextX, scaleTextY)

    button.draw(sceneButton)
end

function howToPlayScreen.keypressed(key)
    if key == "escape" then
        currentScreen = screens.mainMenu
    end
end

return howToPlayScreen