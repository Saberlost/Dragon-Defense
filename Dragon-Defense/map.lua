-- All initMap 

module(..., package.seeall)

local utilities = require("utilities")

Map = {}
Map.__index = Map

function Map:new(width, height, tilesize)
	local obj = {_width = width, _height = height, _tilesize = tilesize, _graphics = display.newGroup()}
	setmetatable(obj, self)
	
	return obj
end

function Map:getStartPosition()
	local i = 1 
	while i < self._width do
		local j = 1
		while j < self._height do 
		
			if (self._mapsetup[j][i] == 'S') then
				local pos = {}
				pos.x = i
				pos.y = j
				return pos
			end
			j = j+1
		end
		i = i+1
	end
	local pos = {}
	pos.x = 1
	pos.y = 1
	return pos

end

function Map:getTileSize()
	return self._tilesize
end


function Map:addBackground(background)
	self._background = background
	print (background)
	local bg = display.newImage(background)
	self._graphics:insert(bg)
	
end

function Map:addMapsetup(mapsetup)
	self._mapsetup = mapsetup
end

function Map:translateToMapCords(object)
	
	local x = utilities.gfxtrans(object.x, 0, self._width * self._tilesize, self._tilesize)	
	local y = utilities.gfxtrans(object.y, 0, self._height * self._tilesize, self._tilesize)
	local mapcords = {}
	mapcords.x = x
	mapcords.y = y
	return mapcords
	
end

function Map:roadAt(object)
	local isroad = false
--	local mapcords = self:translateToMapCords(object)
--	if (self._mapsetup[mapcords.y] and self._mapsetup[mapcords.y][mapcords.x] == 0) then
	if (self._mapsetup[object.y] and self._mapsetup[object.y][object.x] == 0) then
		isroad = true
	end
	return isroad

end

function Map:canPlaceTowerAt(object)
	local isfree = false
	local mapcords = self:translateToMapCords(object)
	print ("canPlaceTowerAt")
	print (mapcords.x)
	print (mapcords.y)
	if (self._mapsetup[mapcords.y] and self._mapsetup[mapcords.y][mapcords.x] == 1) then
		isfree = true
	end
	return isfree
end

function Map:placeTowerAt(tower)
	local isfree = self:canPlaceTowerAt(tower)
	if isfree  == true then 
		local mapcords = self:translateToMapCords(tower)
		self._mapsetup[mapcords.y][mapcords.x] = tower
	end
	return isfree
end

function Map:isSameTile(object1, object2)
	local mapcords1 = self:translateToMapCords(object1)
	local mapcords2 = self:translateToMapCords(object2)
	
	
	if ((mapcords1.x == mapcords2.x) and (mapcords1.y == mapcords2.y)) then
		return true
	end
	return false
end


local function initMap(params)
	local gamemap = Map:new(params.width, params.height, params.tilesize)
	if (params.background) then
		gamemap:addBackground(params.background)
	end
	
	if (params.mapsetup) then
		gamemap:addMapsetup(params.mapsetup)
	end
	
	print (gamemap)
	return gamemap
end

function initMap1()

	local mapbackground1 = 'MapWithGrass.png' 
	local mapsetup ={{1,1,1,'S',1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
					{1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,1,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,1,1},
					{1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1},
					{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
					{1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}}

	local newmap = initMap{background = mapbackground1, mapsetup =  mapsetup, width = 30, height = 20, tilesize = 32}	
	return newmap
	
end


function test()
	print ("test")
end