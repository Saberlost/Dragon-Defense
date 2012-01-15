module(..., package.seeall)
local map = require("map")

local utilities = require("utilities")


function getMapCords(Monster)
	return Monster._mapcords
end

function setNewMapCords(Monster, mapcords)
	Monster._mapcords = mapcords
end

function setNewDirection(Monster, dir)
	Monster._direction = dir
end

function setGoalCords(Monster, mapcords)
	print("setGoalCords" .. mapcords.x .. "," .. mapcords.y) 
	Monster._mapgoalcords = mapcords
end

function getGoalCords(Monster)
	return Monster._mapgoalcords 
end

function setDistanceToGoal(Monster, distance)
	Monster._distance_to_goal = distance
end

function updateDistanceToGoal(Monster)
	Monster._distance_to_goal = Monster._distance_to_goal - Monster._speed
end 

function isGoalReached(Monster)
	return Monster._distance_to_goal <= 0
end


function towards(Monster, direction)
	local pos = {}
	pos.x = Monster._mapcords.x
	pos.y = Monster._mapcords.y
	if(direction == "north") then -- north
		pos.y = pos.y - Monster._speed
	elseif (direction == "west") then
		pos.x = pos.x + Monster._speed
	elseif (direction == "south") then
		pos.y = pos.y + Monster._speed
	elseif (direction == "east") then
		pos.x = pos.x - Monster._speed
	end
	return pos
end

function newPosition(Monster, newpos)
	Monster.x = newpos.x
	Monster.y = newpos.y
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

function printInfo(Monster)
	print ("Me Monster!!!!")
	print ("x,y" .. Monster.x .. "," .. Monster.y)
	print ("Mapcords x,y" .. Monster._mapcords.x .. "," .. Monster._mapcords.y)
	
end