
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
    self.items = level.items
    self.bgMusic = level.bgMusic
end

function LevelManager:setGame(game)
    self.game = game
end

function LevelManager:fireAction(location, direction)
    activatorLocation = self:getActivatorLocation(location, direction)

    for i, action in ipairs(self.actions) do
        if(action.location.x == activatorLocation.x and action.location.y == activatorLocation.y) then
            action.call(activatorLocation)
        end
    end
end

function LevelManager:entityMoved(entity)
    self:checkWinCondition(entity:getLocation())

    for i = #self.items, 1, -1 do
        item = self.items[i]
        if(item.location.x == entity.x and item.location.y == entity.y and item.visible) then
            self.game:displayMessage("You found: ".. item.name)
            if(item.description ~= "") then
                self.game:displayMessage(item.description)
            end
            if(item.canpickup) then
                item.onpickup()
                item.visible = false
            end
        end
    end
end

function LevelManager:checkWinCondition(location)
    if(location.x == self.goal.x and location.y == self.goal.y) then
        self.game:playerWon()
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
    if(x < 1 or y < 1) then
        return false
    end
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

function LevelManager:canUseTemporalDisplacement()
    return self.script:canUseTemporalDisplacement()
end

return LevelManager