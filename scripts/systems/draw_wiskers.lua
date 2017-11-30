return function(v, _)
        local sx = v.position.x
        local sy = v.position.y
        love.graphics.circle("line", v.position.x, v.position.y, 10)
        for l, w in ipairs(v.wiskers) do
            love.graphics.line(sx, sy, w.x + sx, sy + w.y)
        end

end