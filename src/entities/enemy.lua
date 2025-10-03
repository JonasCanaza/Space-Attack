local enemy = {}

local MAX_ENEMIES = 10
local enemies = {}
ENEMY_WIDTH = 125
ENEMY_HEIGHT = 65
ENEMY_SPEED = 600

local hit1

for i = 1, MAX_ENEMIES do
    enemies[i] = nil
end

function enemy.create(x, y)
    return {
        x = x,
        y = y,
        width = ENEMY_WIDTH,
        height = ENEMY_HEIGHT,
        speed = ENEMY_SPEED,
        isActive = true
    }
end

function enemy.load()
    hit1 = love.audio.newSource("res/sound/enemy/hit01.wav", "static")

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

    for i = 1, MAX_ENEMIES do
        if bullets[i] and bullets[i].isActive then

            for j = 1, MAX_ENEMIES do
                if enemies[j] and enemies[j].isActive then
                    if checkCollisionRay(enemies[j], bullets[i].prevX, bullets[i].x, bullets[i].y, bullets[i].height) then
                        local clone = hit1:clone()
                        love.audio.play(clone)
                        print("HIT")
                        bullets[i].isActive = false
                        break
                    end
                end
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

-- function checkCollisionBetweenRectangles(recA, recB)
--     return recA.x < recB.x + recB.width and
--             recA.x + recA.width > recB.x and
--             recA.y < recB.y + recB.height and
--             recA.y + recA.height > recB.y
-- end

function checkCollisionRay(rec, x1, x2, y, height)
    return x2 >= rec.x and x1 <= rec.x + rec.width and
            y < rec.y + rec.height and y + height > rec.y
end

return enemy