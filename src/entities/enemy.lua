local enemy = {}

local MAX_ENEMIES = 10
local enemies = {}
local ENEMY_WIDTH = 125
local ENEMY_HEIGHT = 65
local MIN_ENEMY_SPEED = 600
local MAX_ENEMY_SPEED = 900
local ENEMY_LIVES = 3

local enemyTex

-- SPAWN CONTROL
local spawnTimer = 0
local MIN_TIMER_COOLDOWN = 1.5
local MAX_TIMER_COOLDOWN = 2.25
local spawnDelay = math.random(MIN_TIMER_COOLDOWN, MAX_TIMER_COOLDOWN)

local function spawnEnemy()
    for i = 1, MAX_ENEMIES do
        if enemies[i] == nil or enemies[i].isActive == false then
            local posX = SCREEN_WIDTH
            local posY = math.random(0, SCREEN_HEIGHT - ENEMY_HEIGHT)
            local speedRandom = math.random(MIN_ENEMY_SPEED, MAX_ENEMY_SPEED)

            enemies[i] = enemy.create(posX, posY, speedRandom)
            return
        end
    end
end

function enemy.create(x, y, speed)
    return {
        x = x,
        y = y,
        width = ENEMY_WIDTH,
        height = ENEMY_HEIGHT,
        speed = speed,
        lives = ENEMY_LIVES,
        isActive = true
    }
end

function enemy.load()
    for i = 1, MAX_ENEMIES do
        enemies[i] = nil
    end

    enemyTex = love.graphics.newImage("res/characters/enemy.png")
end

function enemy.update(deltaTime)
    for i = 1, MAX_ENEMIES do
        if enemies[i] and enemies[i].isActive then
            enemies[i].x = enemies[i].x - enemies[i].speed * deltaTime

            if enemies[i].x + enemies[i].width < 0 then
                enemies[i].x = SCREEN_WIDTH
            end
        end
    end

    spawnTimer = spawnTimer + deltaTime
    if spawnTimer >= spawnDelay then
        spawnEnemy()
        spawnTimer = 0
        spawnDelay = math.random(MIN_TIMER_COOLDOWN, MAX_TIMER_COOLDOWN)
    end
end

function enemy.draw()
    for i = 1, MAX_ENEMIES do
        if enemies[i] and enemies[i].isActive then
            local imgWidth = enemyTex:getWidth()
            local imgHeight = enemyTex:getHeight()
            local scaleX = enemies[i].width / imgWidth
            local scaleY = enemies[i].height / imgHeight

            love.graphics.setColor(1, 1, 1)
            love.graphics.draw(enemyTex, enemies[i].x, enemies[i].y, 0, scaleX, scaleY)
        end
    end
end

function enemy.getAll()
    return enemies
end

function enemy.resetAll()
    for i = 1, MAX_ENEMIES do
        enemies[i] = nil
    end

    spawnTimer = 0
end

return enemy