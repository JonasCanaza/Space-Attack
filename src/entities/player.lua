local player = {}

local PLAYER_WIDTH = 125
local PLAYER_HEIGHT = 65
local PLAYER_DEFAULT_SPEED = 750
local PLAYER_DEFAULT_LIVES = 5

function player.load()
    local posY = SCREEN_HEIGHT / 2 - PLAYER_HEIGHT / 2

    player.x = 50
    player.y = posY
    player.width = PLAYER_WIDTH
    player.height = PLAYER_HEIGHT
    player.speed = PLAYER_DEFAULT_SPEED
    player.lives = PLAYER_DEFAULT_LIVES
end

function player.update(deltaTime)
    if player.y < 0 then
        player.y = 0
    end

    if player.y + player.height > SCREEN_HEIGHT then
        player.y = SCREEN_HEIGHT - player.height
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

function player.reset()
    local posY = SCREEN_HEIGHT / 2 - PLAYER_HEIGHT / 2

    player.y = posY
    player.lives = PLAYER_DEFAULT_LIVES
end

return player