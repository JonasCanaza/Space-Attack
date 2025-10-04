local game = {}

-- LOAD GAME SCREENS

local mainMenuScreen = require("src.screens.mainMenuScreen")
local gameplayScreen = require("src.screens.gameplayScreen")
local howToPlayScreen = require("src.screens.howToPlayScreen")
local creditsScreen = require("src.screens.creditsScreen")

screens = {
    mainMenu = 1,
    gameplay = 2,
    howToPlay = 3,
    credits = 4
}

currentScreen = screens.mainMenu

function game.load()
    math.randomseed(os.time())
    math.random()
    love.graphics.setBlendMode("alpha")

    mainMenuScreen.load()
    gameplayScreen.load()
    howToPlayScreen.load()
    creditsScreen.load()
end

function game.update(deltaTime)
    if currentScreen == screens.mainMenu then

        mainMenuScreen.update(deltaTime)

    elseif currentScreen == screens.gameplay then

        gameplayScreen.update(deltaTime)

    elseif currentScreen == screens.howToPlay then

        howToPlayScreen.update(deltaTime)

    elseif currentScreen == screens.credits then

        creditsScreen.update(deltaTime)

    end
end

function game.draw()
    if currentScreen == screens.mainMenu then

        mainMenuScreen.draw()

    elseif currentScreen == screens.gameplay then

        gameplayScreen.draw()

    elseif currentScreen == screens.howToPlay then

        howToPlayScreen.draw()

    elseif currentScreen == screens.credits then

        creditsScreen.draw()

    end
end

function game.keypressed(key)
    if currentScreen == screens.mainMenu then

        mainMenuScreen.keypressed(key)

    elseif currentScreen == screens.gameplay then

        gameplayScreen.keypressed(key)

    elseif currentScreen == screens.howToPlay then

        howToPlayScreen.keypressed(key)

    elseif currentScreen == screens.credits then

        creditsScreen.keypressed(key)

    end
end

return game