local projectile = {}

local MAX_PROJECTILES = 10
local bullets = {}
local BULLET_WIDTH = 30
BULLET_HEIGHT = 20
local BULLET_SPEED = 2500

-- START BULLETS
for i = 1, MAX_PROJECTILES do
    bullets[i] = nil
end

function projectile.create(x, y)
    return {
        x = x,
        y = y,
        prevX = x,
        width = BULLET_WIDTH,
        height = BULLET_HEIGHT,
        speed = BULLET_SPEED,
        isActive = true
    }
end

function projectile.load()
    for i = 1, MAX_PROJECTILES do
        bullets[i] = nil
    end
end

function projectile.update(deltaTime)
    local screenWidth = love.graphics.getWidth()

    for i = 1, MAX_PROJECTILES do
        if bullets[i] and bullets[i].isActive then
            bullets[i].prevX = bullets[i].x
            bullets[i].x = bullets[i].x + bullets[i].speed * deltaTime

            if bullets[i].x > screenWidth then
                bullets[i].isActive = false
            end
        end
    end
end

function projectile.draw()
    for i = 1, MAX_PROJECTILES do
        if bullets[i] and bullets[i].isActive then
            love.graphics.rectangle("fill", bullets[i].x, bullets[i].y, bullets[i].width, bullets[i].height)
        end
    end
end

function projectile.spawn(x, y)
    for i = 1, MAX_PROJECTILES do
        if bullets[i] == nil or bullets[i].isActive == false then
            bullets[i] = projectile.create(x, y)
            return true
        end
    end

    return false
end

function projectile.getAll()
    return bullets
end

return projectile