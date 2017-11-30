local clickOn = {}

clickOn.clickArea = function (x,y,w,h)
    return function(event)
        if not (event.x and event.y) then
            return false
        end
        return (event.x > x and event.y > y and event.x < x+w and event.y < y+h)
    end
 end
return clickOn