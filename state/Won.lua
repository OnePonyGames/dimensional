local State = require "state.State"
local Timer = require "libs.hump.timer"

local Won = Class {}
Won:include(State, Won)


function Won:enter()
    Timer.add(5, function() self.manager:pushState(State.Menu) end)
end

function Won:draw()
    love.graphics.setNewFont(14)
    love.graphics.print("You managed to get out in time. Contragulations!", 60, 50)
end

function Won:update(dt)
    Timer.update(dt)
end



return Won
