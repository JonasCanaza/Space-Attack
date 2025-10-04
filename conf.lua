require("src.globals")

function love.conf(t)
    t.console = true

    t.window.width = SCREEN_WIDTH
    t.window.height = SCREEN_HEIGHT
    t.window.title = "Space Attack"
    t.window.icon = "res/icon.png"
end