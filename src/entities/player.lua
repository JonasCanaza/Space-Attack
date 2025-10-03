local player = {
    x = 100,
    y = 300,
    width = 125,
    height = 65,
    speed = 750
}



function player.load()

end

function player.update(deltaTime)
    if love.keyboard.isDown("w") then
        player.y = player.y - player.speed * deltaTime
    end

    if love.keyboard.isDown("s") then
        player.y = player.y + player.speed * deltaTime
    end

    -- LIMIT

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    if player.x < 0 then
        player.x = 0
    end

    if player.y < 0 then
        player.y = 0
    end

    if player.x + player.width > screenWidth then
        player.x = screenWidth - player.width
    end

    if player.y + player.height > screenHeight then
        player.y = screenHeight - player.height
    end
end

function player.draw()
    love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
end

return player