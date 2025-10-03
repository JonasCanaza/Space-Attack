local game = require("game")

function love.load()
    game.load()
end

function love.update(deltaTime)
    game.update(deltaTime)
end

function love.draw()
    game.draw()
end

function love.keypressed(key)
    game.keypressed(key)
end