
local State = Class {
    setManager = function(self, manager)
        self.manager = manager
    end,
    Menu = 1,
    Game = 2,
    Won = 3,
    LostTime = 4,
    LostParadox = 5,
}

function State:initTransition()
    self.transitionState = nil
    self.transitionColor = nil
    self.transitionTime = nil
    self.transitionTimeLeft = nil
end

function State:transition(transitionState, color, time)
    if(self.transitionState == nil) then
        self.transitionState = transitionState
        self.transitionColor = color
        self.transitionTime = time
        self.transitionTimeLeft = time
    end
end

function State:drawTransition()
    if(self.transitionColor ~= nil) then
        local timeFraction = 1 - (self.transitionTimeLeft / self.transitionTime)
        local r,g,b,a = love.graphics.getColor()

        love.graphics.setColor(self.transitionColor.r, self.transitionColor.b, self.transitionColor.b, timeFraction * 255)

        love.graphics.rectangle("fill", 0,0, love.graphics.getWidth( ), love.graphics.getHeight())
        love.graphics.setColor(r, b, g, a)
    end
end

function State:updateTransition(dt)
    if(self.transitionTime ~= nil) then
        self.transitionTimeLeft = self.transitionTimeLeft - dt

        if(self.transitionTimeLeft <= 0) then
            local state = self.transitionState
            self:initTransition()

            self.manager:pushState(state)
        end
    end
end

return State