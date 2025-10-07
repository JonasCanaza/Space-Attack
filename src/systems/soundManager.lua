local soundManager = {}

local sfx = {}
local music = {}

local currentMusic = nil

function soundManager.load()
    sfx.shot1 = love.audio.newSource("res/sound/player/shot01.wav", "static")
    sfx.shot2 = love.audio.newSource("res/sound/player/shot02.wav", "static")
    sfx.shot3 = love.audio.newSource("res/sound/player/shot03.wav", "static")

    sfx.hit1 = love.audio.newSource("res/sound/enemy/hit01.wav", "static")

    sfx.buttonHover = love.audio.newSource("res/sound/button/hover.wav", "static")
    sfx.buttonPressed = love.audio.newSource("res/sound/button/pressed.wav", "static")

    sfx.panelOn = love.audio.newSource("res/sound/panel/on.wav", "static")
    sfx.panelOff = love.audio.newSource("res/sound/panel/off.wav", "static")

    music.menu = love.audio.newSource("res/music/menu.ogg", "stream")
    music.gameplay = love.audio.newSource("res/music/gameplay.ogg", "stream")
end

function soundManager.playSFX(name)
    local sound = sfx[name]

    if sound then
        local clone = sound:clone()
        clone:play()
    end
end

function soundManager.playRandomSFX(baseName, variantCount)
    local randomIndex = love.math.random(1, variantCount)
    local soundName = baseName .. randomIndex
    soundManager.playSFX(soundName)
end

function soundManager.playMusic(name, loop)
    if currentMusic and currentMusic:isPlaying() then
        currentMusic:stop()
    end

    local track = music[name]

    if track then
        currentMusic = track
        track:setLooping(loop == true)
        track:play()
    end
end

function soundManager.pauseMusic()
    if currentMusic and currentMusic:isPlaying() then
        currentMusic:pause()
    end
end

function soundManager.resumeMusic()
    if currentMusic and not currentMusic:isPlaying() then
        currentMusic:play()
    end
end

function soundManager.stopMusic()
    if currentMusic then
        currentMusic:stop()
    end
end

return soundManager