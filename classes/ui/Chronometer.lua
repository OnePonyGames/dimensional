

local Chronometer = Class {}


function Chronometer:init()
    self.isVisible = false
    self.time = 0
end

function Chronometer:setVisible(isVisible)
    self.isVisible = isVisible
end

function Chronometer:isVisible()
    return self.isVisible
end

function Chronometer:setTime(time)
    self.time = time
end

function Chronometer:getTime()
    return self.time
end

function Chronometer:draw()
    if(self.isVisible) then
        local txt = "" .. self.time
        love.graphics.print(txt, 400, 500)
    end
end

function Chronometer:inc()
    self.time = self.time + 1
end

function Chronometer:dec()
    self.time = self.time - 1
end


return Chronometer