local button = {}

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

function button.create(x, y, width, height, text)
    return {
        x = x,
        y = y,
        width = width or DEFAULT_WIDTH,
        height = height or DEFAULT_HEIGTH,
        text = text or DEFAULT_NAME,
        state = ButtonState.Normal,
        clicked = false
    }
end

function button.load(btn)

end

function button.update(btn)
    btn.clicked = false

    if isMouseOverButton(btn) then
        if love.mouse.isDown(1) then
            btn.state = ButtonState.Pressed
        else
            if btn.state == ButtonState.Pressed then
                btn.clicked = true
            end

            btn.state = ButtonState.Hover
        end
    else
        btn.state = ButtonState.Normal
    end
end

function button.draw(btn)
    -- COLOR PER STATE
    if btn.state == ButtonState.Normal then

        love.graphics.setColor(1, 0, 0)

    elseif btn.state == ButtonState.Hover then

        love.graphics.setColor(0, 0, 1)

    elseif btn.state == ButtonState.Pressed then

        love.graphics.setColor(0, 1, 0)

    end

    -- PRINT BUTTON

    love.graphics.rectangle("fill", btn.x, btn.y, btn.width, btn.height)

    love.graphics.setFont(font)
    love.graphics.setColor(1, 1, 1)
    
    local textHeight = font:getHeight(btn.text)
    local textY = btn.y + (btn.height / 2) - (textHeight / 2)
    
    love.graphics.printf(btn.text, btn.x, textY, btn.width, "center")
end

function isMouseOverButton(btn)
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()

    return mouseX > btn.x and
    mouseX < btn.x + btn.width and
    mouseY > btn.y and
    mouseY < btn.y + btn.height
end

return button