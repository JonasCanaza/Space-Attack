local player = {}

function player.load()
    player.x = 100
    player.y = 300
    player.width = 125
    player.height = 65
    player.speed = 750
    player.lives = 5
end

function player.update(deltaTime)
    local screenHeight = love.graphics.getHeight()

    if player.y < 0 then
        player.y = 0
    end

    if player.y + player.height > screenHeight then
        player.y = screenHeight - player.height
    end
end

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

function player.moveUp(deltaTime)
    player.y = player.y - player.speed * deltaTime
end

function player.moveDown(deltaTime)
    player.y = player.y + player.speed * deltaTime
end

return player