local creditsScreen = {}

function creditsScreen.load()

end

function creditsScreen.update(deltaTime, game)

end

function creditsScreen.draw()
    love.graphics.print("CREDITS", 400, 300)
end

function creditsScreen.keypressed(key)
    if key == "escape" then
        currentScreen = Screens.mainMenu
    end
end

return creditsScreen