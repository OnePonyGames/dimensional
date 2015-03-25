local State = require "state.State"
local Timer = require "libs.hump.timer"

local LostParadox = Class {}
LostParadox:include(State, LostParadox)


function LostParadox:enter()
    Timer.add(5, function() self.manager:pushState(State.Menu) end)
end

function LostParadox:draw()
    love.graphics.setNewFont(14)
    love.graphics.print("Well seems like you caused a paradox...", 80, 50)
    love.graphics.print("The Universe doesn't allow for that and deleted you...", 30, 70)
end

function LostParadox:update(dt)
    Timer.update(dt)
end



return LostParadox
