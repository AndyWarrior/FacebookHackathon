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
		speedX = 2,
		speedY = 2,
		size = 1,
		direction = 1,
		lastObject = -2,
		saveX = 0,
		saveY = 0,
		stop = false
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

function ball:stopBall()
	self.saveX = self.speedX
	self.saveY = self.speedY
	self.speedX = 0
	self.speedY = 0
	self.stop = true
end

function ball:resume()
	self.speedX = self.saveX
	self.speedY = self.saveY
	self.stop = false
end

function ball:getStatus()
	return self.stop
end

function ball:move()
	if self.direction == 1 then
		self.ball.x = self.ball.x + self.speedX
		self.ball.y = self.ball.y - self.speedY
	elseif self.direction == 2 then
		self.ball.x = self.ball.x - self.speedX
		self.ball.y = self.ball.y - self.speedY
	elseif self.direction == 3 then
		self.ball.x = self.ball.x - self.speedX
		self.ball.y = self.ball.y + self.speedY
	elseif self.direction == 4 then
		self.ball.x = self.ball.x + self.speedX
		self.ball.y = self.ball.y + self.speedY
	end
end

function ball:checkColision(objects,player,actives,hay,paper)
	if self.stop == false then
		if inside(self.ball,player) then
			self.lastObject = 0
			if self.direction == 3 then
				self.direction = 2
			elseif self.direction == 4 then
				self.direction = 1
			end
			self:changeSpeedX()
		end
		
		for i=1, #objects do
			if inside(self.ball,objects[i]) and self.lastObject ~= i and actives[i]~=0 then
				self.lastObject = i
				actives[i]=actives[i] - 1
				if actives[i] == 0 then
					objects[i].alpha = 0
				end
				if hay[i] == false then
					if self.direction == 1 then
						self.direction = 4
					elseif self.direction == 2 then
						self.direction = 3
					elseif self.direction == 3 then
						self.direction = 2
					elseif self.direction == 4 then
						self.direction = 1
					end
					self:changeSpeedX()
				end
			end
		end
		
		if self.ball.x - self.ball.width/2 < paper.x - paper.width/2 then
			self.lastObject = -1
			self:changeSpeedX()
			if self.direction == 2 then
				self.direction = 1
			elseif self.direction == 3 then
				self.direction = 4
			end
		elseif self.ball.x + self.ball.width/2 > paper.x + paper.width/2 then
			self.lastObject = -1
			self:changeSpeedX()
			if self.direction == 1 then
				self.direction = 2
			elseif self.direction == 4 then
				self.direction = 3
			end
		end
		
		if self.ball.y - self.ball.height/2 < paper.y - paper.height/2 then
			self.lastObject = -1
			self:changeSpeedX()
			if self.direction == 1 then
				self.direction = 4
			elseif self.direction == 2 then
				self.direction = 3
			end
		elseif self.ball.y + self.ball.height/2 > paper.y + paper.height/2 then
			self.ball.x = screenW/2 + leftX
			self.ball.y = bottomY - screenH/3
			self.lastObject = -1
			local dir = math.random(1,2)
			self.direction = dir
			self:stopBall()
			player.x = screenW/2 + leftX
			player.y = bottomY - screenH/4
			return true
		end
	end
	return false
end

function ball:changeSpeedX()
	local x = math.random(1,4)
	self.speedX = x
end

function inside(obj1, obj2)
        return obj1.contentBounds.xMin < obj2.contentBounds.xMax
                and obj1.contentBounds.xMax > obj2.contentBounds.xMin
                and obj1.contentBounds.yMin < obj2.contentBounds.yMax
                and obj1.contentBounds.yMax > obj2.contentBounds.yMin
end

return ball





