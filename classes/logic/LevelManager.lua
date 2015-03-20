
local Direction = require "classes.data.Direction"

local LevelManager = Class {}


function LevelManager:init(level)
    self.map = level.map
    self.actions = level.actions
    self.spawn = level.spawn
    self.dimensions = level.dimensions
    self.passable = level.passable
    self.script = level.script
    self.goal = level.goal
end

function LevelManager:fireAction(location, direction)
    activatorLocation = self:getActivatorLocation(location, direction)

    for i, action in ipairs(self.actions) do
        if(action.location.x == activatorLocation.x and action.location.y == activatorLocation.y) then
            action.call(activatorLocation)
        end
    end
end

function LevelManager:checkWinCondition(location)
    if(location.x == self.goal.x and location.y == self.goal.y) then
        Debug.log("YOU WON!")
    end
end

function LevelManager:getActivatorLocation(location, direction)
    xoff = 0
    yoff = 0

    if(direction == Direction.North) then
        yoff = -1
    elseif(direction == Direction.South) then
        yoff = 1
    elseif(direction == Direction.East) then
        xoff = 1
    elseif(direction == Direction.West) then
        xoff = -1
    end

    return {x = location.x + xoff, y = location.y + yoff}
end

function LevelManager:isPassable(x, y)
    if(self.passable[y][x] == 1) then
        return true
    elseif(self.passable[y][x] == 2) then
        return self.script.isDoorOpen()
    end
    return false
end

function LevelManager:reset()
    self.script:reset()
end

return LevelManager