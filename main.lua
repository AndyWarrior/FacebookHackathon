-----------------------------------
--Coordinate values for positioning
-----------------------------------

local topY = display.screenOriginY --Numerical value for the top of the screen
local rightX = display.contentWidth - display.screenOriginX --Numerical value for the right of the screen
local bottomY = display.contentHeight - display.screenOriginY --Numerical value for the bottom of the screen
local leftX = display.screenOriginX --Numerical value for the left of the screen
local screenW = rightX - leftX --Numerical value for the width of the screen
local screenH = bottomY - topY --Numerical value for the height of the screen


objects = {}
newObjects = {}
newObjectsPointer = 1

--Function that creates a new Object when you click on it
function createObject(event)
	event.target.alpha = 1
	local targetName = event.target.name
	if (event.phase == "ended") then
		if(targetName == "object1") then
			newObjects[newObjectsPointer] = display.newImageRect("object1.png", 30, 30)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = "newObject"..1
			newObjectsPointer = newObjectsPointer + 1
		elseif (targetName == "object2") then
			newObjects[newObjectsPointer] = display.newImageRect("object2.png", 30, 30)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = "newObject"..2
			newObjectsPointer = newObjectsPointer + 1
		elseif (targetName == "object3") then
			newObjects[newObjectsPointer] = display.newImageRect("object3.png", 30, 30)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = "newObject"..3
			newObjectsPointer = newObjectsPointer + 1
		elseif (targetName == "object4") then
			newObjects[newObjectsPointer] = display.newImageRect("object4.png", 30, 30)
			newObjects[newObjectsPointer].x = screenW/2 + leftX
			newObjects[newObjectsPointer].y = screenH/2 + topY
			newObjects[newObjectsPointer].name = "newObject"..4
			newObjectsPointer = newObjectsPointer + 1
		end
	end
	
	if (event.phase == "began") then
		event.target.alpha = 0.5
	end
	
	
end


--Function that displays the objects in the bottom
for i=1, 4 do
	
	objects[i] = display.newImageRect("object"..i..".png", 30, 30)
	objects[i].x = leftX + (screenW/6 * i) + objects[i].width/2
	objects[i].y = bottomY - objects[i].height
	objects[i].name = "object"..i
	objects[i]:addEventListener("touch", createObject)
end

