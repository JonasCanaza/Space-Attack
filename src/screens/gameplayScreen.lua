local gameplayScreen = {}

local player = require("src.entities.player")
local projectiles = require("src.entities.projectile")
local enemies = require("src.entities.enemy")
local collision = require("src.systems.collision")
local pausePanel = require("src.panels.pausePanel")
local gameOverPanel = require("src.panels.gameOverPanel")
local soundManager = require("src.systems.soundManager")

-- BACKGROUND

local background = {
    layers = {
        { image = nil, speed = 300,  x = 0 },
        { image = nil, speed = 525, x = 0 },
        { image = nil, speed = 800, x = 0 }
    },
    y = 0,
    width = SCREEN_WIDTH,
    height = SCREEN_HEIGHT
}

local isPlaying = true

local function updateBackground(deltaTime)
    for i = 1, #background.layers do
        local layer = background.layers[i]
        layer.x = layer.x - layer.speed * deltaTime

        if layer.x <= -background.width then
            layer.x = 0
        end
    end
end

local function drawBackground()
    for i = 1, #background.layers do
        local layer = background.layers[i]
        local img = layer.image
        local imgWidth = img:getWidth()
        local imgHeight = img:getHeight()
        local scaleX = background.width / imgWidth
        local scaleY = background.height / imgHeight

        love.graphics.draw(img, layer.x, background.y, 0, scaleX, scaleY)
        love.graphics.draw(img, layer.x + background.width, background.y, 0, scaleX, scaleY)
    end
end

local function thePlayerHasLives()
    if player.lives <= 0 then
        gameOverPanel.show()
        return false
    end

    return true
end

local function handleBulletEnemyCollisions()
    local allBullets = projectiles.getAll()
    local allEnemies = enemies.getAll()

    for i = 1, #allBullets do
        if allBullets[i] and allBullets[i].isActive then
            for j = 1, #allEnemies do
                if allEnemies[j] and allEnemies[j].isActive then
                    if collision.rayIntersectsRectangle(allEnemies[j], allBullets[i].prevX, allBullets[i].x, allBullets[i].y, allBullets[i].height) then
                        soundManager.playSFX("hit1")
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
            soundManager.playSFX("hit1")
            player.lives = player.lives - 1
            allEnemies[i].isActive = false

            isPlaying = thePlayerHasLives()

            if not isPlaying then
                soundManager.pauseMusic()
            end
        end
    end
end

local function updatePausePanelAction()
    local action = pausePanel.getLastAction()

    if action == "resume" then
        soundManager.resumeMusic()

        pausePanel.clearAction()
        isPlaying = true
    elseif action == "restart" then
        soundManager.stopMusic()
        soundManager.playMusic("gameplay", true)

        gameplayScreen.reset()
        pausePanel.clearAction()
        isPlaying = true
    elseif action == "exit" then
        soundManager.playMusic("menu", true)

        pausePanel.clearAction()
        isPlaying = true
        currentScreen = screens.mainMenu
    end
end

local function updateGameOverPanelAction()
    local action = gameOverPanel.getLastAction()

    if action == "continue" then
        soundManager.resumeMusic()

        gameplayScreen.continue()
        gameOverPanel.clearAction()
        isPlaying = true
    elseif action == "restart" then
        soundManager.stopMusic()
        soundManager.playMusic("gameplay", true)

        gameplayScreen.reset()
        gameOverPanel.clearAction()
        isPlaying = true
    elseif action == "exit" then
        soundManager.stopMusic()
        soundManager.playMusic("menu", true)

        gameplayScreen.reset()
        gameOverPanel.clearAction()
        isPlaying = true
        currentScreen = screens.mainMenu
    end
end

function gameplayScreen.load()
    player.load()
    projectiles.load()
    enemies.load()

    pausePanel.load()
    gameOverPanel.load()

    background.layers[1].image = love.graphics.newImage("res/ui/gameplay01.png")
    background.layers[2].image = love.graphics.newImage("res/ui/gameplay02.png")
    background.layers[3].image = love.graphics.newImage("res/ui/gameplay03.png")

    soundManager.load()
end

function gameplayScreen.update(deltaTime)
    if not pausePanel.isActive() and not gameOverPanel.isActive() then
        updateBackground(deltaTime)

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
    updatePausePanelAction()
    gameOverPanel.update()
    updateGameOverPanelAction()
end

function gameplayScreen.draw()
    drawBackground()

    player.draw()
    projectiles.draw()
    enemies.draw()

    pausePanel.draw()
    gameOverPanel.draw()
end

function gameplayScreen.keypressed(key)
    if not isPlaying then
        return
    end

    if key == "escape" and not gameOverPanel.isActive() then
        pausePanel.toggle()

        if pausePanel.isActive() then
            soundManager.playSFX("panelOn")
            soundManager.pauseMusic()
        else
            soundManager.playSFX("panelOff")
            soundManager.resumeMusic()
        end
    end

    if not pausePanel.isActive() and not gameOverPanel.isActive() then
        if key == "space" then
            local success = projectiles.spawn(player.x + player.width - BULLET_WIDTH, player.y + player.height / 2 - BULLET_HEIGHT / 2)

            if success then
                soundManager.playRandomSFX("shot", 3)
            end
        end
    end
end

function gameplayScreen.reset()
    player.reset()
    projectiles.resetAll()
    enemies.resetAll()
end

function gameplayScreen.continue()
    player.resetLives()
    projectiles.resetAll()
    enemies.resetAll()
end

return gameplayScreen