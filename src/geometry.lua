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


function Vec2(x,y) 
    local v = {x=x or 0, y=y or 0} 
    setmetatable(v, {
        __add = function(v1,v2) return Vec2(v1.x+v2.x, v1.y+v2.y) end, 
        __sub = function(v1,v2) return Vec2(v1.x-v2.x, v1.y-v2.y) end,
        __mul = function(v1,v2) return Vec2(v1.x*v2.x, v1.y*v2.y) end,
        __tostring = function(v) return "("..v.x..","..v.y..")" end,
    })
    return v
end

function Rect(x,y,w,h) 
    return {
        x=x or 0, y=y or 0,
        w=w or 0, h=h or 0,
        getArea = function(self) return self.w * self.h end
    }
end 