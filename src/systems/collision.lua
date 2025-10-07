local collision = {}

function collision.rectanglesOverlap(rectA, rectB)
    return rectA.x < rectB.x + rectB.width and
            rectB.x < rectA.x + rectA.width and
            rectA.y < rectB.y + rectB.height and
            rectB.y < rectA.y + rectA.height
end

function collision.rayIntersectsRectangle(targetRect, startX, endX, rayY, rayHeight)
    return endX >= targetRect.x and
            startX <= targetRect.x + targetRect.width and
            rayY < targetRect.y + targetRect.height and
            rayY + rayHeight > targetRect.y
end

return collision