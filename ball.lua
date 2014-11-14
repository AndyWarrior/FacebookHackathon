local topY = display.screenOriginY --Numerical value for the top of the screen
local rightX = display.contentWidth - display.screenOriginX --Numerical value for the right of the screen
local bottomY = display.contentHeight - display.screenOriginY --Numerical value for the bottom of the screen
local leftX = display.screenOriginX --Numerical value for the left of the screen
local screenW = rightX - leftX --Numerical value for the width of the screen
local screenH = bottomY - topY --Numerical value for the height of the screen

local ball = {}
local ball_mt = { __index = ball}

-------------------------------------------------
-- PRIVATE FUNCTIONS
-------------------------------------------------


-------------------------------------------------
-- PUBLIC FUNCTIONS
-------------------------------------------------

function ball.new()	-- constructor
	local newBall = {
		ball = display.newImageRect("ball.png", 20, 20),
		speed = 3,
		size = 1,
		direction = 1,
		lastObject = -2
		}
		newBall.ball.x = screenW/2 + leftX
		newBall.ball.y = bottomY - screenH/3
	return setmetatable(newBall, ball_mt)
end


function ball:setSpeed(s)
	self.speed = s
end

function ball:setSize(s)
	self.size = s
end

function ball:move()
	if self.direction == 1 then
		self.ball.x = self.ball.x + 1
		self.ball.y = self.ball.y - 1
	elseif self.direction == 2 then
		self.ball.x = self.ball.x - 1
		self.ball.y = self.ball.y - 1
	elseif self.direction == 3 then
		self.ball.x = self.ball.x - 1
		self.ball.y = self.ball.y + 1
	elseif self.direction == 4 then
		self.ball.x = self.ball.x + 1
		self.ball.y = self.ball.y + 1
	end
end

function ball:checkColision(objects,player,actives)
	if inside(self.ball,player) then
		self.lastObject = 0
		if self.direction == 3 then
			self.direction = 2
		elseif self.direction == 4 then
			self.direction = 1
		end
	end
	
	for i=1, #objects do
		if inside(self.ball,objects[i]) and self.lastObject ~= i and actives[i]~=0 then
			self.lastObject = i
			actives[i]=actives[i] - 1
			if actives[i] == 0 then
				objects[i].alpha = 0
			end
			if self.direction == 1 then
				self.direction = 4
			elseif self.direction == 2 then
				self.direction = 3
			elseif self.direction == 3 then
				self.direction = 2
			elseif self.direction == 4 then
				self.direction = 1
			end
		end
	end
	
	if self.ball.x - self.ball.width/2 < leftX then
		self.lastObject = -1
		if self.direction == 2 then
			self.direction = 1
		elseif self.direction == 3 then
			self.direction = 4
		end
	elseif self.ball.x + self.ball.width/2 > rightX then
		self.lastObject = -1
		if self.direction == 1 then
			self.direction = 2
		elseif self.direction == 4 then
			self.direction = 3
		end
	end
	
	if self.ball.y - self.ball.height/2 < topY then
		self.lastObject = -1
		if self.direction == 1 then
			self.direction = 4
		elseif self.direction == 2 then
			self.direction = 3
		end
	elseif self.ball.y + self.ball.height/2 > bottomY then
		self.lastObject = -1
		if self.direction == 3 then
			self.direction = 2
		elseif self.direction == 4 then
			self.direction = 1
		end
	end
end

function inside(obj1, obj2)
        return obj1.contentBounds.xMin < obj2.contentBounds.xMax
                and obj1.contentBounds.xMax > obj2.contentBounds.xMin
                and obj1.contentBounds.yMin < obj2.contentBounds.yMax
                and obj1.contentBounds.yMax > obj2.contentBounds.yMin
end

return ball





