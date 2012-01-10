module(..., package.seeall)

local function changeDirection(direction, mapsetup, x, y)
	local newdirection = "south"
	print ("changeDirection")
	print(direction)
	
	if ((direction == "north")  or (direction == "south")) then
		
		if (mapsetup[y][x+1] == 0) then 
			newdirection = "west"
		elseif (mapsetup[y][x-1] == 0) then
			newdirection = "east"
		end
	elseif ((direction == "west") or (direction == "east")) then
		if (mapsetup[y+1][x] == 0) then
			newdirection = "south"
		elseif (mapsetup[y-1][x] == 0) then
			newdirection = "north"
		end
	end
	return newdirection
end


function moveMonster(Monster, mapsetup, maxX, maxY, sizeX, sizeY)
	mapsetup:_translateFunc(Monster.x,Monster.y)
	local mapsetupX =  math.floor((Monster.x / sizeX)+0.5)+1
	local mapsetupY =  math.floor((Monster.y / sizeY)+0.5)+1
	print ("X and Y pos")
	print (mapsetupX)
	print (mapsetupY)
	
	local newx = Monster.x
	local newy = Monster.y
	
	if(Monster._direction == "north") then -- north
		newy = newy - Monster._speed
	elseif (Monster._direction == "west") then
			newx = newx + Monster._speed
	elseif (Monster._direction == "south") then
			newy = newy + Monster._speed
	elseif (Monster._direction == "east") then
			newx = newx - Monster._speed
	end
	
	newmapsetupX = math.floor(newx / sizeX+0.5)+1
	newmapsetupY = math.floor(newy / sizeY+0.5)+1
	
	
	
	if ((newmapsetupX == mapsetupX) and (newmapsetupY == mapsetupY)) then
		Monster.x = newx
		Monster.y = newy
	elseif mapsetup[newmapsetupY][newmapsetupX] == 0 then
		print("New Square")
		Monster.x = newx
		Monster.y = newy
	else 
		Monster._direction = changeDirection(Monster._direction, mapsetup, mapsetupX, mapsetupY)  
	
	end
end

function NewMonster(params)
	local Monster = display.newGroup()
	if params.image then 
		local monsterImage = display.newImage(params.image)
		Monster:insert(monsterImage)
		Monster._imageName = params.image
	end
	if params.hp then
		Monster._hp = params.hp
		local healthbar = display.newRoundedRect(Monster.x, Monster.y -10, Monster.contentWidth -2, 8, 2)
		healthbar.strokeWidth =2
		healthbar:setFillColor(0,255,0)
		healthbar:setStrokeColor(180,180,180)
		Monster:insert(healthbar)
	end
	if params.direction then
		Monster._direction = params.direction
	end
	if params.speed then
		Monster._speed = params.speed
	end
	return Monster
end