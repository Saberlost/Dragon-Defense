local towerui = require("TowerUI")
local ui = require("ui")
local monsterui = require("Monster")


--local mapbackground = display.newImageRect("Map.png", 640,480)
local mapbackground = display.newImage("Map.png",0,0, true)

local gameplanmaxX = display.contentWidth * (2/3)
local gameplanmaxY = display.contentHeight * (2/3)

local scaleX = gameplanmaxX / 9
local scaleY = gameplanmaxY / 7
local startbutton

--mapbackground.rotation = 90


local mapsetup =  {{1,0,1,1,1,1,1,1,1}, 
                  { 1,0,1,1,0,0,0,0,1},
                  { 1,0,1,1,0,1,0,0,1},
                  { 1,0,0,0,0,1,1,0,1},
                  { 1,1,1,1,1,1,1,0,1},
                  { 1,1,1,1,1,1,1,0,1},
                  { 1,1,1,1,1,1,1,2,1}}
                  
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
		Monsters[i].y = Monsters[i].y+4
		i = i+1
	end
	
end


local function sendWave(event)
	if event.phase == "ended" then 
	                    
		Monster = monsterui.NewMonster{image="Monster.png", hp = 100}
		Monster.x = scaleX*2
		Monster.y = 100
		if vaveActive == false then
			timer.performWithDelay(30, moveMonster, 0)
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
			local mapsetupX =  math.floor(event.x / scaleX +0.5)
			local mapsetupY =  math.floor(event.y / scaleY +0.5)
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


