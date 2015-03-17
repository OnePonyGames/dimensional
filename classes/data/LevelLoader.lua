
local LevelManager = require "classes.logic.LevelManager"


local LevelLoader = Class {}


function LevelLoader:loadLevel1()
    return LevelManager(love.filesystem.load("levels/level1.lua")())
end


return LevelLoader