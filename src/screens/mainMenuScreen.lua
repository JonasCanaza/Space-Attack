local mainMenuScreen = {}

local button = require("src/interface/button")
local buttons = {}
local ScreenID = {
    gameplay = 1,
    howToPlay = 2,
    credits = 3,
    exit = 4
}

function mainMenuScreen.load()
    table.insert(buttons, button.create(100, 100, 250, 75, "PLAY"))
    table.insert(buttons, button.create(100, 180, 250, 75, "RULES"))
    table.insert(buttons, button.create(100, 260, 250, 75, "CREDITS"))
    table.insert(buttons, button.create(100, 340, 250, 75, "EXIT"))
end

function mainMenuScreen.update(deltaTime)
    -- UPDATE BUTTONS
    button.update(buttons[ScreenID.gameplay])
    button.update(buttons[ScreenID.howToPlay])
    button.update(buttons[ScreenID.credits])
    button.update(buttons[ScreenID.exit])

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
    -- DRAW BUTTONS
    button.draw(buttons[ScreenID.gameplay])
    button.draw(buttons[ScreenID.howToPlay])
    button.draw(buttons[ScreenID.credits])
    button.draw(buttons[ScreenID.exit])
end

function mainMenuScreen.keypressed(key)
    if key == "escape" then
        print("EXIT")
    end
end

return mainMenuScreen