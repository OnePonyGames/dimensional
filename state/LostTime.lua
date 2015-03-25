local State = require "state.State"
local Timer = require "libs.hump.timer"

local LostTime = Class {}
LostTime:include(State, LostTime)


function LostTime:enter()
    Timer.add(5, function() self.manager:pushState(State.Menu) end)
end

function LostTime:draw()
    love.graphics.setNewFont(14)
    love.graphics.print("Your time ran out and you died in an horrible explosion!", 60, 50)
end

function LostTime:update(dt)
    Timer.update(dt)
end



return LostTime
