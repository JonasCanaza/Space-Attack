local mainMenuScreen = {}

local button = require("src/interface/button")

-- BUTTON

local MAX_BUTTONS = 4
local buttons = {}
local buttonsNames = {
    "PLAY",
    "RULES",
    "CREDITS",
    "EXIT"
}
local ScreenID = {  
    gameplay = 1,
    howToPlay = 2,
    credits = 3,
    exit = 4
}
local BUTTON_WIDTH = 250
local BUTTON_HEIGTH = 75

-- LOGO

local logo = {
    x = 0,
    y = 0,
    width = 600,
    height = 300
}

local function initLogo()
    local screenWidth = love.graphics.getWidth()
    local marginTop = 25

    logo.x = logo.x + screenWidth / 2 - logo.width / 2
    logo.y = marginTop
end

local function initButtons()
    local screenWidth = love.graphics.getWidth()
    local menuX = screenWidth / 2 - 250 / 2
    local spaceBetween = 80
    local startButtonsY = 270

    for i = 1, MAX_BUTTONS do
        table.insert(buttons, button.create(menuX,  startButtonsY + spaceBetween * i, BUTTON_WIDTH, BUTTON_HEIGTH, buttonsNames[i]))
    end
end

function mainMenuScreen.load()
    initLogo()
    initButtons()
end

function mainMenuScreen.update(deltaTime)
    for i = 1, MAX_BUTTONS do
        button.update(buttons[i])
    end

    if buttons[ScreenID.gameplay].clicked then
        currentScreen = Screens.gameplay
    end

    if buttons[ScreenID.howToPlay].clicked then
        currentScreen = Screens.howToPlay
    end

    if buttons[ScreenID.credits].clicked then
        currentScreen = Screens.credits
    end

    if buttons[ScreenID.exit].clicked then
        love.window.close()
    end
end

function mainMenuScreen.draw()
    for i = 1, MAX_BUTTONS do
        button.draw(buttons[i])
    end

    love.graphics.rectangle("fill", logo.x, logo.y, logo.width, logo.height)
end

function mainMenuScreen.keypressed(key)
    if key == "escape" then 
        print("EXIT")
    end
end

return mainMenuScreen