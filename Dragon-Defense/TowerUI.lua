module(..., package.seeall)

function showRange(Tower, scale)
	if (Tower._rangedDisp) then 
		Tower._rangedDisp.isVisible = true
	else
		local rangedDisp = display.newCircle(Tower.x, Tower.y, Tower._range *scale)
		rangedDisp:setFillColor(255,255,255,12)
		Tower:insert(rangedDisp, true)
		Tower._rangedDisp = rangedDisp
	end
	
	return Tower

end

function hideRange(Tower)
	if (Tower._rangedDisp) then
		Tower._rangedDisp.isVisible = false
	
	end

end


function NewTower(params)
	local Tower  = display.newGroup()
	if params.image then
		local image = display.newImage( params.image )
		Tower:insert( image, true )
		Tower._image = params.image
	else
		Tower._image = nil
	end
	if params.range then
		Tower._range = params.range
	else
		Tower._range = 1
	end
	return Tower
end


