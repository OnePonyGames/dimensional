

local Chronometer = Class {}


function Chronometer:init()
    self.visible = false
    self.time = 0
end

function Chronometer:setVisible(isVisible)
    self.visible = isVisible
end

function Chronometer:isVisible()
    return self.visible
end

function Chronometer:setTime(time)
    self.time = time
end

function Chronometer:getTime()
    return self.time
end

function Chronometer:inc()
    self.time = self.time + 1
end

function Chronometer:dec()
    self.time = self.time - 1
end


return Chronometer