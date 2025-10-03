local howToPlayScreen = {}

function howToPlayScreen.load()

end

function howToPlayScreen.update(deltaTime)

end

function howToPlayScreen.draw()
    love.graphics.print("HOW TO PLAY", 400, 300)
end

function howToPlayScreen.keypressed(key)
    if key == "escape" then
        currentScreen = Screens.mainMenu
    end
end

return howToPlayScreen