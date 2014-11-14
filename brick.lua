local topY = display.screenOriginY --Numerical value for the top of the screen
local rightX = display.contentWidth - display.screenOriginX --Numerical value for the right of the screen
local bottomY = display.contentHeight - display.screenOriginY --Numerical value for the bottom of the screen
local leftX = display.screenOriginX --Numerical value for the left of the screen
local screenW = rightX - leftX --Numerical value for the width of the screen
local screenH = bottomY - topY --Numerical value for the height of the screen

local brick = {}
local brick_mt = { __index = brick}

-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------


-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function brick.new(x,y,index)	-- constructor
	local newBrick = {
		brick = display.newImageRect("object"..index..".png", 35, 20),
		}
		newBrick.brick.x = x
		newBrick.brick.y = y
	return setmetatable(newBrick, brick_mt)
end

function brick:getImage()
	return brick
end


return brick





