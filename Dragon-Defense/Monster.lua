module(..., package.seeall)

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
		--local healthleft = display.newRoundedRect(healthbar.x-2, healthbar.y-2, healthbar.contentWidth-2, healthbar.contentHeight-2, 12)
		--healthleft.strokeWidth = 0
		--healthleft:setFillColor(0, 255,0)
		Monster:insert(healthbar)
		--Monster:insert(healthleft)
	end
	return Monster
end