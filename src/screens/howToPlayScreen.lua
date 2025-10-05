local howToPlayScreen = {}

local button = require("src.interface.button")

local sceneButton = {}
local BUTTON_TEXT = "Back"
local WIDTH_BUTTON = 300
local HEIGHT_BUTTON = 80
local MARGIN_BUTTON = 10

local function initButton()
    local posX = SCREEN_WIDTH / 2 - WIDTH_BUTTON / 2
    local posY = SCREEN_HEIGHT - HEIGHT_BUTTON - MARGIN_BUTTON

    sceneButton = button.create(posX, posY, WIDTH_BUTTON, HEIGHT_BUTTON, BUTTON_TEXT)
end

function howToPlayScreen.load()
    initButton()
end

function howToPlayScreen.update(deltaTime)
    button.update(sceneButton)

    if sceneButton.clicked then
        currentScreen = screens.mainMenu
    end
end

function howToPlayScreen.draw()
    button.draw(sceneButton)
end

function howToPlayScreen.keypressed(key)
    if key == "escape" then
        currentScreen = screens.mainMenu
    end
end

return howToPlayScreen