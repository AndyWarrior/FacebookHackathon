display.setStatusBar( display.HiddenStatusBar ) --Hide status bar from the beginning
system.setIdleTimer( false ) -- turn off device sleeping

-----------------------------------
--Coordinate values for positioning
-----------------------------------

local Ball = require("ball")

local topY = display.screenOriginY --Numerical value for the top of the screen
local rightX = display.contentWidth - display.screenOriginX --Numerical value for the right of the screen
local bottomY = display.contentHeight - display.screenOriginY --Numerical value for the bottom of the screen
local leftX = display.screenOriginX --Numerical value for the left of the screen
local screenW = rightX - leftX --Numerical value for the width of the screen
local screenH = bottomY - topY --Numerical value for the height of the screen


objects = {}
newObjects = {}
actives = {}
saveActives = {}
hay = {}
newObjectsPointer = 1

local function moveObject( event )
	local t = event.target
	local name = event.target.name
	if actives[name] ~= 0 then
		-- Print info about the event. For actual production code, you should
		-- not call this function because it wastes CPU resources.

		local phase = event.phase
		if "began" == phase then
			-- Make target the top-most object
			local parent = t.parent
			parent:insert( t )
			display.getCurrentStage():setFocus( t )

			-- Spurious events can be sent to the target, e.g. the user presses 
			-- elsewhere on the screen and then moves the finger over the target.
			-- To prevent this, we add this flag. Only when it's true will "move"
			-- events be sent to the target.
			t.isFocus = true

			-- Store initial position
			t.x0 = event.x - t.x
			if(name ~= "player") then
				t.y0 = event.y - t.y
			end
		elseif t.isFocus then
			if "moved" == phase then
				-- Make object move (we subtract t.x0,t.y0 so that moves are
				-- relative to initial grab point, rather than object "snapping").
				t.x = event.x - t.x0
				if t.x - event.target.width/2 < paper.x - paper.width/2 then
					t.x = paper.x - paper.width/2 + event.target.width/2
				elseif t.x + event.target.width/2 > paper.x + paper.width/2 then
					t.x = paper.x + paper.width/2 - event.target.width/2
				end
				if(name ~= "player") then
					t.y = event.y - t.y0
					if t.y - event.target.height/2 < paper.y - paper.height/2 then
						t.y = paper.y - paper.height/2 + event.target.height/2
					elseif t.y + event.target.height/2 > paper.y + paper.height/2 then
						t.y = paper.y + paper.height/2 - event.target.height/2
					end
				end
			elseif "ended" == phase or "cancelled" == phase then
				display.getCurrentStage():setFocus( nil )
				t.isFocus = false
			end
		end
	end

	-- Important to return true. This tells the system that the event
	-- should not be propagated to listeners of any objects underneath.
	return true
end

local function checkPlayerColision()
	if player.x - player.width/2 < paper.x - paper.width/2 then
		player.x = paper.x - paper.width/2 + player.width/2
	elseif player.x + player.width/2 > paper.x + paper.width/2 then
		player.x = paper.x + paper.width/2 - player.width/2
	end
	
end

local function rotateObject (event)
	local t = event.target
	
	t:rotate(-45)
end

--Function that creates a new Object when you click on it
function createObject(event)
	event.target.alpha = 1
	local targetName = event.target.name
	if (event.phase == "ended") then
		if(targetName == "object1") then
			newObjects[newObjectsPointer] = display.newImageRect("object1.png", 35, 20)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = newObjectsPointer
			newObjects[newObjectsPointer]:addEventListener("touch", moveObject)
			newObjects[newObjectsPointer]:addEventListener("tap", rotateObject)
			actives[newObjectsPointer] = 1
			saveActives[newObjectsPointer] = 1
			hay[newObjectsPointer] = true
			newObjectsPointer = newObjectsPointer + 1
		elseif (targetName == "object2") then
			newObjects[newObjectsPointer] = display.newImageRect("object2.png", 35, 20)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = newObjectsPointer
			newObjects[newObjectsPointer]:addEventListener("touch", moveObject)
			newObjects[newObjectsPointer]:addEventListener("tap", rotateObject)
			actives[newObjectsPointer] = 1
			saveActives[newObjectsPointer] = 1
			hay[newObjectsPointer] = false
			newObjectsPointer = newObjectsPointer + 1
		elseif (targetName == "object3") then
			newObjects[newObjectsPointer] = display.newImageRect("object3.png", 35, 20)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = newObjectsPointer
			newObjects[newObjectsPointer]:addEventListener("touch", moveObject)
			newObjects[newObjectsPointer]:addEventListener("tap", rotateObject)
			actives[newObjectsPointer] = 3
			saveActives[newObjectsPointer] = 3
			hay[newObjectsPointer] = false
			newObjectsPointer = newObjectsPointer + 1
		elseif (targetName == "object4") then
			newObjects[newObjectsPointer] = display.newImageRect("object4.png", 35, 20)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = newObjectsPointer
			newObjects[newObjectsPointer]:addEventListener("touch", moveObject)
			newObjects[newObjectsPointer]:addEventListener("tap", rotateObject)
			actives[newObjectsPointer] = 999
			saveActives[newObjectsPointer] = 999
			hay[newObjectsPointer] = false
			newObjectsPointer = newObjectsPointer + 1
		end
	end
	
	if (event.phase == "began") then
		event.target.alpha = 0.5
	end
	
	
end

function pauseGame(event)
	event.target.alpha = 1
	
	if (event.phase == "ended") then
		if ball:getStatus() == false then
			ball:stopBall()
		else ball:resume()
		end
	end
	
	if (event.phase == "began") then
		event.target.alpha = 0.5
	end
end


--Function that displays the objects in the bottom
function startGame()
	background = display.newImageRect("background.png",screenW,screenH)
	background.x = screenW/2 + leftX
	background.y = screenH/2 + topY
	
	paper = display.newImageRect("paper.png",395,255)
	paper.x = 55 + leftX + paper.width/2
	paper.y = 30 + topY + paper.height/2
	
	for i=1, 4 do
		
		objects[i] = display.newImageRect("object"..i..".png", 35, 20)
		objects[i].x = leftX + (screenW/6 * i) + objects[i].width/2
		objects[i].y = bottomY - objects[i].height
		objects[i].name = "object"..i
		objects[i]:addEventListener("touch", createObject)
	end
	
	player = display.newImageRect("player.png", 80, 20)
	player.x = screenW/2 + leftX
	player.y = bottomY - screenH/4
	player.name = "player"
	player:addEventListener("touch", moveObject)
	
	ball = Ball.new()
	ball:stopBall()
	
	playButton = display.newImageRect("playButton.png",60,60)
	playButton.x = leftX + playButton.width/2
	playButton.y = bottomY - playButton.height/2
	playButton:addEventListener("touch", pauseGame)
	
end

function endGame()
	for i=1, #actives do
		actives[i] = saveActives[i]
		newObjects[i].alpha = 1
	end
end

function updateGame(event)
	ball:move()
	checkPlayerColision()
	local endgame = ball:checkColision(newObjects,player,actives,hay,paper)
	
	if endgame == true then
		endGame()
	end
	

end

startGame()
Runtime:addEventListener( "enterFrame", updateGame )