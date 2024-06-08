function verctor2d(x, y)
    local t = {}
    t.x = x or 0
    t.y = y or 0
    return t
end

function rect(x, y, width, height)
    local t = {}
    t.position = verctor2d(x or 0, y or 0)
    t.width    = width or 0
    t.height   = height or 0

    function t.getArea()
        return width * height
    end
    return t
end