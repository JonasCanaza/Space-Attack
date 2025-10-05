local projectile = {}

local MAX_PROJECTILES = 10
local bullets = {}
BULLET_WIDTH = 30
BULLET_HEIGHT = 20
local BULLET_SPEED = 1750

local bulletFrames = {}
local frameDuration = 0.1
local totalFrames = 0

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
        isActive = true,
        animFrame = 1,
        animTimer = 0
    }
end

function projectile.load()
    for i = 1, MAX_PROJECTILES do
        bullets[i] = nil
    end

    bulletFrames = {
        love.graphics.newImage("res/bullet/bullet01.png"),
        love.graphics.newImage("res/bullet/bullet02.png"),
        love.graphics.newImage("res/bullet/bullet03.png"),
        love.graphics.newImage("res/bullet/bullet04.png"),
        love.graphics.newImage("res/bullet/bullet05.png"),
        love.graphics.newImage("res/bullet/bullet06.png")
    }

    totalFrames = #bulletFrames
end

function projectile.update(deltaTime)
    for i = 1, MAX_PROJECTILES do
        if bullets[i] and bullets[i].isActive then
            bullets[i].prevX = bullets[i].x
            bullets[i].x = bullets[i].x + bullets[i].speed * deltaTime

            if bullets[i].x > SCREEN_WIDTH then
                bullets[i].isActive = false
            end

            bullets[i].animTimer = bullets[i].animTimer + deltaTime

            if bullets[i].animTimer >= frameDuration then
                bullets[i].animTimer = 0
                bullets[i].animFrame = bullets[i].animFrame + 1

                if bullets[i].animFrame > totalFrames then
                    bullets[i].animFrame = 1
                end
            end
        end
    end
end

function projectile.draw()
    for i = 1, MAX_PROJECTILES do
        if bullets[i] and bullets[i].isActive then
            local frame = bulletFrames[bullets[i].animFrame]
            local imgWidth = frame:getWidth()
            local imgHeight = frame:getHeight()
            local scaleX = bullets[i].width / imgWidth
            local scaleY = bullets[i].height / imgHeight

            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(frame, bullets[i].x, bullets[i].y, 0, scaleX, scaleY)
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

function projectile.resetAll()
    for i = 1, MAX_PROJECTILES do
        bullets[i] = nil
    end
end

return projectile