local gameplayScreen = {}

local player = require("src/entities/player")
local projectiles = require("src/entities/projectile")
local enemies = require("src/entities/enemy")
local collision = require("src/utils/collision")

-- SOUND

local shot1

local isPlaying = true

local function handleBulletEnemyCollisions()
    local allBullets = projectiles.getAll()
    local allEnemies = enemies.getAll()

    for bulletIndex = 1, #allBullets do
        local currentBullet = allBullets[bulletIndex]

        if currentBullet and currentBullet.isActive then
            for enemyIndex = 1, #allEnemies do
                local currentEnemy = allEnemies[enemyIndex]

                if currentEnemy and currentEnemy.isActive then
                    if collision.rayIntersectsRectangle(currentEnemy, currentBullet.prevX, currentBullet.x, currentBullet.y, currentBullet.height) then
                        currentEnemy.lives = currentEnemy.lives - 1
                        currentBullet.isActive = false
                        print(currentEnemy.lives)
                        break
                    end
                end
            end
        end
    end
end

local function handlePlayerEnemyCollisions()
    local allEnemies = enemies.getAll()

    for enemyIndex = 1, #allEnemies do
        if collision.rectanglesOverlap(player, allEnemies[enemyIndex]) then
            print("PUM!!")
        end
    end
end

function gameplayScreen.load()
    player.load()
    projectiles.load()
    enemies.load()

    shot1 = love.audio.newSource("res/sound/shot01.wav", "static")
end

function gameplayScreen.update(deltaTime)
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

function gameplayScreen.draw()
    player.draw()
    projectiles.draw()
    enemies.draw()
end

function gameplayScreen.keypressed(key)
    if key == "escape" then
        currentScreen = Screens.mainMenu
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