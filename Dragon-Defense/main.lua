local towerui = require("TowerUI")
local ui = require("ui")
local monsterui = require("Monster")


--local mapbackground = display.newImageRect("Map.png", 640,480)
local mapbackground = display.newImage("MapWithGrass.png",0,0,true)
print (mapbackground.x)
print (mapbackground.y)
--mapbackground:rotate(90)
--mapbackground.x = 320
--mapbackground.y = 480
--mapbackground.rotation = 90


local mapsetup =   {{1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
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
local mapMaxX = 9
local mapMaxY = 7
                  
local gameplanmaxX = display.contentWidth * (4/5)
local gameplanmaxY = display.contentHeight * (2/3)

local scaleX = gameplanmaxX / mapMaxX
local scaleY = gameplanmaxY / mapMaxY
local startbutton

local squarepane = nil
                  
                  
local AllTowers = {}
local nroftowers = 0                  
print "hej"
print (mapsetup[2][2])
local newtower = nil
local vaveActive = false

local Monsters = {}
local numberofmonsters = 0

local function moveMonster(event)
	print "Monster should move"
	local i = 0
	while i < numberofmonsters do
		local doDamage = monsterui.moveMonster(Monsters[i], mapsetup, 30, 20, 32, 32)
	
		--Monsters[i].y = Monsters[i].y+4
		i = i+1
	end
	
end


local function sendWave(event)
	if event.phase == "ended" then 
	                    
		Monster = monsterui.NewMonster{image="Monster.png", hp = 10,0, direction="south", speed = 4}
		Monster.x = 3*32
		Monster.y = 32
		if vaveActive == false then
			timer.performWithDelay(60, moveMonster, 0)
		end
		vaveActive = true
		Monsters[numberofmonsters] = Monster
		numberofmonsters = numberofmonsters+1
		
		
		
	end
end



local function moveNewTower(event)
	print ("Hej")
	if (event.target == newtower) then 

		if (newtower == nil) then
		else
			newtower.x = event.x
			newtower.y = event.y
		end
		if (event.phase == "ended") then
			local mapsetupX =  math.floor(event.x / 32)+1
			local mapsetupY =  math.floor(event.y / 32)+1
			print ("X and Y pos")
			print (mapsetupX)
			print (mapsetupY)
			print (newtower)
			if mapsetup[mapsetupY][mapsetupX] == 1 then
				towerui.hideRange(newtower)
				mapsetup[mapsetupY][mapsetupX] = newtower
				
			else
				print ("Not allowed to place tower")
				print (newtower)
				local parent = newtower.parent
				print (parent)
				parent:remove(newtower)
			end
			newtower = nil
 		end
 	end
	
end

local function buildNewTower(event)
	print (event)
	print (event.target)
	print (event.target._image)
	print (event.target._range)
	if event.phase == "moved" then
		if (newtower == nil) then
			newtower = towerui.NewTower{image = event.target._image, range = event.target._range}
			newtower = towerui.showRange(newtower, scaleX)
			newtower:addEventListener("touch", moveNewTower)
		end
		newtower.x = event.x
		newtower.y = event.y
	
	elseif event == "ended" then
		newtower = nil
	end
	

end

local function drawsquares()
	local i = 0
	local j = 0
	squarepane = display.newGroup()
	while (i < 30) do
		j = 0
		while(j < 20) do
			local square = display.newRect(i*	32, j* 32, 32, 32)
			square:setFillColor(0,0,0,0)
			square.strokeWidth = 2
			square:setStrokeColor(0, 0, 0,100)
			squarepane:insert(square)
			j= j+ 1
		end
		i = i +1
	end

end


local function gfxToMapCords(self, x, y)
	print ("gfxToMap")
	print (x)
	print(y)
end

mapsetup._translateFunc = gfxToMapCords

local ArrowTower =towerui.NewTower{image = "ArrowTower.png", range = 2.5}
ArrowTower.y =  50
ArrowTower.x = display.contentWidth -50
ArrowTower:addEventListener("touch", buildNewTower)

local CannonTower = towerui.NewTower{image = "CannonTower.png", range = 2.1}
CannonTower.y = 100
CannonTower.x = display.contentWidth - 50
CannonTower:addEventListener("touch", buildNewTower)


startbutton = ui.newButton{default = "startbuttonRed.png", over = "startbuttonRedOver.png", id = "startbutton", text= "Sent Next Wave", size = 40, emboss = true}
startbutton.x = display.contentWidth / 2
startbutton.y = display.contentHeight - display.contentHeight /8
startbutton:addEventListener("touch", sendWave)
startbutton:scale(0.4, 0.4)
startbutton.x = 800
startbutton.y = 600
drawsquares()
