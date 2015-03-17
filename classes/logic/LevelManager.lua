


local LevelManager = Class {}


function LevelManager:init(level)
    self.map = level.map
    self.actions = level.actions
    self.spawn = level.spawn
    self.dimensions = level.dimensions
end

return LevelManager