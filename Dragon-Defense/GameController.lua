
module(..., package.seeall)


local Map = require("map")
local MonsterIm = require("monster")
local Tower = require("towerui")
local utilities = require("utilities")

local map = nil
                  
local startbutton = nil

local squarepane = nil
                  
                  
local newtower = nil


GameController = {}
GameController.__index = GameController

function GameController:new()
	local obj = {_Monsters = {}, _numberofmonsters = 0, _vaveActive = false}
	setmetatable(obj, self)
	
	return obj
end

function GameController:setMap(map)
	self._map = map
end




function GameController:moveMonsterForward(monster)
	local mapgoalpos = MonsterIm.getGoalCords(monster)	
	local currentmappos = MonsterIm.getMapCords(monster)
	local newmapcords = MonsterIm.towards(monster, monster._direction)
	MonsterIm.setNewMapCords(monster, newmapcords)
	MonsterIm.updateDistanceToGoal(monster)
	if (MonsterIm.isGoalReached(monster)) then
		local tempmapcords = {}
		tempmapcords.x = math.floor(newmapcords.x+0.5)
		tempmapcords.y = math.floor(newmapcords.y+0.5)
		print ("newmapcords" .. tempmapcords.x .. "," .. tempmapcords.y)
		MonsterIm.setNewMapCords(monster, tempmapcords)
		local rest = math.max(math.abs(newmapcords.x - tempmapcords.x), math.abs(newmapcords.y - tempmapcords.y))
		local restp = rest / monster._speed 
		return restp
	end
	return 0
end

function GameController:updateMonsterGoalPos(monster)
	MonsterIm.printInfo(monster)
	local mapcords = MonsterIm.getMapCords(monster)
	local freepass = true
	local goalcords = {}
	local tempgoalcords = {}
	tempgoalcords.x = mapcords.x
	tempgoalcords.y = mapcords.y
	local length = 0
	while freepass do
		tempgoalcords = utilities.towards(tempgoalcords, monster._direction)
		if (self._map:roadAt(tempgoalcords) == false) then
			break
		end
		length = length +1
		goalcords.x = tempgoalcords.x 
		goalcords.y = tempgoalcords.y
	end
	print("updateMonsterGoalPos " .. monster._direction .. " cords " .. goalcords.x .. "," .. goalcords.y)
	MonsterIm.setGoalCords(monster, goalcords)
	MonsterIm.setDistanceToGoal(monster, length)
end


function GameController:updateMonsterDisplayCords(monster)
	local newDisplayCords = {}
	local mapcords = MonsterIm.getMapCords(monster)
	newDisplayCords.x = (mapcords.x -1) * self._map:getTileSize()
	newDisplayCords.y = (mapcords.y -1) * self._map:getTileSize()
	MonsterIm.newPosition(monster, newDisplayCords)
end

function GameController:moveMonster(event)
	local i = 0
	
	while i < self._numberofmonsters do
		local monster = self._Monsters[i]
		if (self:moveMonsterForward(monster)  > 0 )then 
			print("changeDirection")
			local mappos = MonsterIm.getMapCords(monster)

			local directions = {"north", "east", "south", "west"}
    		for i, k in ipairs(directions) do 
    			print ("ChangeDirection : " .. k)
    			if (self._map:roadAt(utilities.towards(mappos, k)) == true) then
    			
    				if (utilities.isOppositeDirection(monster._direction, k) == false ) then
    					MonsterIm.setNewDirection(monster,k)
    					self:updateMonsterGoalPos(monster)
    					break
    				end
    			end
    		end

		end
		
		self:updateMonsterDisplayCords(monster)
		i = i+1
		print(self)
		print("MoveMonsters "  .. " i is " .. i .. " and number of mosters are " .. self._numberofmonsters)
	end
end


function GameController:sendWave(event)
	print("GC Sencwave")
	if event.phase == "ended" then 
	                    
		local Monster = MonsterIm.NewMonster{image="Monster.png", hp = 10,0, direction="south", speed = 0.1}
		local startpos = self._map:getStartPosition()
		MonsterIm.setNewMapCords(Monster, startpos)
		self:updateMonsterGoalPos(Monster)
		
		self:updateMonsterDisplayCords(Monster)
		
		if self._vaveActive == false then
			print("vaveActive")
			timer.performWithDelay(60, utilities.bind(self, GameController.moveMonster), 0)
		end
		self._vaveActive = true
		self._Monsters[self._numberofmonsters] = Monster
		self._numberofmonsters = self._numberofmonsters+1

	end
end
