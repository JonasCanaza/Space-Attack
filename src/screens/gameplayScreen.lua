local gameplayScreen = {}

local player = require("src.entities.player")
local projectiles = require("src.entities.projectile")
local enemies = require("src.entities.enemy")
local collision = require("src.utils.collision")
local pausePanel = require("src.panels.pausePanel")

-- SOUND

local shot1

local isPlaying = true

local function handleBulletEnemyCollisions()
    local allBullets = projectiles.getAll()
    local allEnemies = enemies.getAll()

    for i = 1, #allBullets do
        if allBullets[i] and allBullets[i].isActive then
            for j = 1, #allEnemies do
                if allEnemies[j] and allEnemies[j].isActive then
                    if collision.rayIntersectsRectangle(allEnemies[j], allBullets[i].prevX, allBullets[i].x, allBullets[i].y, allBullets[i].height) then
                        allEnemies[j].lives = allEnemies[j].lives - 1
                        allBullets[i].isActive = false
                        
                        if allEnemies[j].lives <= 0 then
                            allEnemies[j].isActive = false
                        end

                        return
                    end
                end
            end
        end
    end
end

local function handlePlayerEnemyCollisions()
    local allEnemies = enemies.getAll()

    for i = 1, #allEnemies do
        if collision.rectanglesOverlap(player, allEnemies[i]) and allEnemies[i].isActive then
            player.lives = player.lives - 1
            allEnemies[i].isActive = false
        end
    end
end

function gameplayScreen.load()
    player.load()
    projectiles.load()
    enemies.load()

    pausePanel.load()

    shot1 = love.audio.newSource("res/sound/shot01.wav", "static")
end

function gameplayScreen.update(deltaTime)
    if not pausePanel.isActive() then
        if love.keyboard.isDown("w") then
            player.moveUp(deltaTime)
        end

        if love.keyboard.isDown("s") then
            player.moveDown(deltaTime)
        end

        player.update(deltaTime)
        projectiles.update(deltaTime)
        enemies.update(deltaTime)

        handleBulletEnemyCollisions()
        handlePlayerEnemyCollisions()
    end

    pausePanel.update()
end

function gameplayScreen.draw()
    player.draw()
    projectiles.draw()
    enemies.draw()

    pausePanel.draw()
end

function gameplayScreen.keypressed(key)
    if key == "escape" then
        pausePanel.toggle()
    end

    if key == "space" then
        local success = projectiles.spawn(player.x + player.width, player.y + player.height / 2 - BULLET_HEIGHT / 2)

        if success then
            local clone = shot1:clone()
            love.audio.play(clone)
        end
    end
end

return gameplayScreen