require("src.globals")

function love.conf(t)
    t.console = false

    t.window.width = SCREEN_WIDTH
    t.window.height = SCREEN_HEIGHT
    t.window.title = "Space Attack"
    t.window.icon = "res/game.png"
end