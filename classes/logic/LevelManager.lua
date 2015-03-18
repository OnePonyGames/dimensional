


local LevelManager = Class {}


function LevelManager:init(level)
    self.map = level.map
    self.actions = level.actions
    self.spawn = level.spawn
    self.dimensions = level.dimensions
    self.passable = level.passable
end

function LevelManager:isPassable(x, y)
    return self.passable[y][x] == 1
end

return LevelManager