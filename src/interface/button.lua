local button = {}

local soundManager = require("src.systems.soundManager")

local textSize = 40
local font = love.graphics.newFont(textSize)
local ButtonState = {
    Normal = 1,
    Hover = 2,
    Pressed = 3
}
local DEFAULT_WIDTH = 100
local DEFAULT_HEIGTH = 50
local DEFAULT_NAME = "NO NAME"

-- TEXTURES

local normalButtonTex
local hoverButtonTex
local pressedButtonTex

local font

local function isMouseOverButton(btn)
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    return mouseX > btn.x and
    mouseX < btn.x + btn.width and
    mouseY > btn.y and
    mouseY < btn.y + btn.height
end

function button.create(x, y, width, height, text)
    return {
        x = x,
        y = y,
        width = width or DEFAULT_WIDTH,
        height = height or DEFAULT_HEIGTH,
        text = text or DEFAULT_NAME,
        state = ButtonState.Normal,
        clicked = false,
        hoveredOnce = false
    }
end

function button.load()
    normalButtonTex = love.graphics.newImage("res/ui/normalButton.png")
    hoverButtonTex = love.graphics.newImage("res/ui/hoverButton.png")
    pressedButtonTex = love.graphics.newImage("res/ui/pressedButton.png")

    font = love.graphics.newFont("res/font/Black-Regular.ttf", 48)
end

function button.update(btn)
    btn.clicked = false

    if isMouseOverButton(btn) then
        if love.mouse.isDown(1) then
            btn.state = ButtonState.Pressed
        else
            if btn.state == ButtonState.Pressed then
                soundManager.playSFX("buttonPressed")
                btn.clicked = true
            end

            btn.state = ButtonState.Hover

            if not btn.hoveredOnce then
                soundManager.playSFX("buttonHover")
                btn.hoveredOnce = true
            end
        end
    else
        btn.state = ButtonState.Normal
        btn.hoveredOnce = false
    end
end

function button.draw(btn)
    local texture

    -- COLOR PER STATE
    if btn.state == ButtonState.Normal then

        texture = normalButtonTex

    elseif btn.state == ButtonState.Hover then

        texture = hoverButtonTex

    elseif btn.state == ButtonState.Pressed then

        texture = pressedButtonTex

    end

    -- PRINT BUTTON

    local imgWidth = texture:getWidth()
    local imgHeight = texture:getHeight()
    local scaleX = btn.width / imgWidth
    local scaleY = btn.height / imgHeight
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(texture, btn.x, btn.y, 0, scaleX, scaleY)

    love.graphics.setFont(font)
    
    local textHeight = font:getHeight(btn.text)
    local textY = btn.y + (btn.height / 2) - (textHeight / 2)
    
    love.graphics.printf(btn.text, btn.x, textY, btn.width, "center")
end

return button