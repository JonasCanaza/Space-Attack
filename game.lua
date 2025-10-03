local game = {}

-- LOAD GAME SCREENS

local mainMenuScreen = require("src/screens/mainMenuScreen")
local gameplayScreen = require("src/screens/gameplayScreen")
local howToPlayScreen = require("src/screens/howToPlayScreen")
local creditsScreen = require("src/screens/creditsScreen")

Screens = {
    mainMenu = 1,
    gameplay = 2,
    howToPlay = 3,
    credits = 4
}

currentScreen = Screens.gameplay

function game.load()
    mainMenuScreen.load()
    gameplayScreen.load()
    howToPlayScreen.load()
    creditsScreen.load()
end

function game.update(deltaTime)
    if currentScreen == Screens.mainMenu then

        mainMenuScreen.update(deltaTime)

    elseif currentScreen == Screens.gameplay then

        gameplayScreen.update(deltaTime)

    elseif currentScreen == Screens.howToPlay then

        howToPlayScreen.update(deltaTime)

    elseif currentScreen == Screens.credits then

        creditsScreen.update(deltaTime)

    end
end

function game.draw()
    if currentScreen == Screens.mainMenu then

        mainMenuScreen.draw()

    elseif currentScreen == Screens.gameplay then

        gameplayScreen.draw()

    elseif currentScreen == Screens.howToPlay then

        howToPlayScreen.draw()

    elseif currentScreen == Screens.credits then

        creditsScreen.draw()

    end
end

function game.keypressed(key)
    if currentScreen == Screens.mainMenu then

        mainMenuScreen.keypressed(key)

    elseif currentScreen == Screens.gameplay then

        gameplayScreen.keypressed(key)

    elseif currentScreen == Screens.howToPlay then

        howToPlayScreen.keypressed(key)

    elseif currentScreen == Screens.credits then

        creditsScreen.keypressed(key)

    end
end

return game