
module(..., package.seeall)

local oppositeDirections = { south = "north", north = "south",  east = "west", west = "east"}

function gfxtrans(pos, offset, totalsize, scale)
	local mapcord =  math.floor((pos / scale))+1
	return mapcord
end


function isOppositeDirection(direction1, direction2)
	print (direction1 .. " opp " .. oppositeDirections[direction1] .. " and dir2 " .. direction2)
	
	return oppositeDirections[direction1] == direction2
end

function bind(obj, func)
	
	return function(...)
		return func(obj, unpack(arg))
	end	
end


function towards(obj, direction)
	local pos = {}
	pos.x = obj.x
	pos.y = obj.y
	if(direction == "north") then -- north
		pos.y = pos.y - 1
	elseif (direction == "west") then
		pos.x = pos.x + 1
	elseif (direction == "south") then
		pos.y = pos.y + 1
	elseif (direction == "east") then
		pos.x = pos.x - 1
	end
	return pos
	
end

