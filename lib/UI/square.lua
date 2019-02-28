--
-- Created by IntelliJ IDEA.
-- User: nander
-- Date: 28/02/2019
-- Time: 11:26
-- To change this template use File | Settings | File Templates.
--


return function(x,y,w,h, onClick)
    local hovers = false
    return {
        onHover = function(xx,yy)
            hovers = xx>x and xx < x + w and yy > y and yy < y + h
        end,
        draw = function()
            if hovers then love.graphics.setColor(1,0,0) else love.graphics.setColor(0,1,0) end
            love.graphics.rectangle("fill", x,y,w,h)
            love.graphics.setColor(1,1,1)
        end,
        mousePressed = function()
            if hovers then onClick("CLICKEDF")
            end
        end
    }
end