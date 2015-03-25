require "util.functions"

Debug = require "util.debugout"
Class = require "libs.hump.class"
Vector = require "libs.hump.vector"

local GameManager = require "classes.logic.GameManager"


function love.load()
    love.keyboard.setKeyRepeat(true)
    GameManager:init()
end




