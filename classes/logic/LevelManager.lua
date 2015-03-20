
local Direction = require "classes.data.Direction"

local LevelManager = Class {}


function LevelManager:init(level)
    self.map = level.map
    self.actions = level.actions
    self.spawn = level.spawn
    self.dimensions = level.dimensions
    self.passable = level.passable
    self.script = level.script
end

function LevelManager:fireAction(location, direction)
    activatorLocation = self:getActivatorLocation(location, direction)

    for i, action in ipairs(self.actions) do
        if(action.location.x == activatorLocation.x and action.location.y == activatorLocation.y) then
            action:call(activatorLocation)
        end
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
    return self.passable[y][x] == 1
end

return LevelManager