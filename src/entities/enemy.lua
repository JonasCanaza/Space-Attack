local enemy = {}

local MAX_ENEMIES = 10
local enemies = {}
local ENEMY_WIDTH = 125
local ENEMY_HEIGHT = 65
local ENEMY_SPEED = 600

function enemy.create(x, y)
    return {
        x = x,
        y = y,
        width = ENEMY_WIDTH,
        height = ENEMY_HEIGHT,
        speed = ENEMY_SPEED,
        lives = 5,
        isActive = true
    }
end

function enemy.load()
    for i = 1, MAX_ENEMIES do
        enemies[i] = nil
    end

    enemies[1] = enemy.create(1200, 360)
end

function enemy.update(deltaTime)
    for i = 1, MAX_ENEMIES do
        if enemies[i] and enemies[i].isActive then
            enemies[i].x = enemies[i].x - enemies[i].speed * deltaTime

            if enemies[i].x + enemies[i].width < 0 then
                enemies[i].x = 1200
            end
        end
    end
end

function enemy.draw()
    for i = 1, MAX_ENEMIES do
        if enemies[i] and enemies[i].isActive then
            love.graphics.rectangle("fill", enemies[i].x, enemies[i].y, enemies[i].width, enemies[i].height)
        end
    end
end

function enemy.getAll()
    return enemies
end

return enemy