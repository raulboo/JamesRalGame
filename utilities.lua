-- @return table: A 2d vector with x and y components
function Vec2(x,y) 
    local v = {x=x or 0, y=y or 0} 
    setmetatable(v, {
        __add = function(v1,v2) return Vec2(v1.x+v2.x, v1.y+v2.y) end, 
        __sub = function(v1,v2) return Vec2(v1.x-v2.x, v1.y-v2.y) end,
        __mul = function(v1,v2)
			if type(v2)=="number" then return Vec2(v1.x*v2, v1.y*v2)     -- vector * number
			else 					   return Vec2(v1.x*v2.x, v1.y*v2.y) end -- vector * vector
		end,
        __tostring = function(v) return "("..v.x..","..v.y..")" end,
    })
    return v
end

-- Standard overlap algorithm for box-box.
-- pos1 and pos2 correspond to the CENTER of the box
function isBoxInBox(pos1, size1, pos2, size2)
	if ((pos2.x - size2.x/2 >= pos1.x + size1.x/2) or
		(pos2.x + size2.x/2 <= pos1.x - size1.x/2) or
		(pos2.y - size2.y/2 >= pos1.y + size1.y/2) or
		(pos2.y + size2.y/2 <= pos1.y - size1.y/2)) then
			return false 
	else return true end
end

-- Standard overlap algorithm for point-box.
-- box_pos corresponds to the CENTER of the box
function isPointInBox(point, box_pos, box_size)
	local left_x  = box_pos.x - box_size.x/2
	local right_x = box_pos.x + box_size.x/2
	local up_y    = box_pos.y - box_size.y/2
	local down_y = box_pos.y + box_size.y/2
	if (left_x < point.x) and (point.x < right_x) and (up_y < point.y) and (point.y < down_y) then
		return true
	end
	return false
end

-- deep clones a table
function clone(tbl) 
	local cp={}
	for k,v in pairs(tbl) do
		if type(v)=="table" then
			cp[k]=clone(v)
		else
			cp[k]=v
		end
	end
	return setmetatable(cp, getmetatable(tbl))
end

-- Basically applies the function "f" to all elements of the table
function tableMap(table, f)
	local new_table = {}
	for i,v in ipairs(table) do
		new_table[i] = f(v)
	end
	return new_table
end

function pickRandom(table)
	return table[math.random(#table)]
end

function round(n) 
	if (n % 1)>0.5 then 
		return math.ceil(n)
	else 
		return math.floor(n)
	end 
end

-- lazyest implementation ever
function mid(a,b,c)
	return math.max(math.min(a,b), math.min(b,c), math.min(a,c))
	--return (table.sort{a,b,c})[2]
end

-- Animation function
animation = {}
animation.frame = 0

function animationPlayer(entity, startFrame, EndFrame, frameSpeed)
	entity.sprite = startFrame + math.floor(animation.frame % (EndFrame - startFrame))
	animation.frame = animation.frame + frameSpeed
end