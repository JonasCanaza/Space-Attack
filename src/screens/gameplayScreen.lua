local gameplayScreen = {}

local player = require("src/entities/player")
local projectiles = require("src/entities/projectile")
local enemies = require("src/entities/enemy")

-- SOUND

local shot1

local isPlaying = true

function gameplayScreen.load()
    player.load()
    projectiles.load()
    enemies.load()

    shot1 = love.audio.newSource("res/sound/shot01.wav", "static")
end

function gameplayScreen.update(deltaTime)
    player.update(deltaTime)
    projectiles.update(deltaTime)
    enemies.update(deltaTime)
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