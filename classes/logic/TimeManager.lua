


local TimeManager = Class {
    Spawn = "spawn",
    Remove = "remove",
    Move = "move",
}


function TimeManager:init(level)
    self.level = level

    self.timeLeft = 30
    self.lastAction = self.timeLeft + 1
    self.timedActions = {}
    self.entities = {}
    self.running = true
end

function TimeManager:timeShift(entity, timeOffset)
    local newEntity = entity:clone()

    for i, actions in pairs(self.timedActions) do
        for j, action in ipairs(actions) do
            if(action.e == entity) then
                action.e = newEntity
            end
        end
    end

    self:addAction(newEntity, TimeManager.Remove)
    self.timeLeft = self.timeLeft + timeOffset
    self.lastAction = self.timeLeft
    self:addAction(entity, TimeManager.Spawn, entity.x, entity.y)

    self:playFromTheBeginning()
end

function TimeManager:playFromTheBeginning()
    self.level:reset()
    self.entities = {}

    for time, actions in pairs(self.timedActions) do
        if(time >= self.timeLeft) then
            for i, action in ipairs(actions) do
                self:resolveAction(action)
            end
        end
    end
end

function TimeManager:addAction(entity, action, x, y, time)
    x = x or 0
    y = y or 0
    time = time or self.timeLeft

    if(self.timedActions[time] == nil) then
        self.timedActions[time] = {}
    end

    local newAction = {action = action, e = entity, x = x, y = y}
    table.insert(self.timedActions[time], newAction)

    return newAction
end

function TimeManager:setPlayer(entity, x, y)
    self:addAction(entity, TimeManager.Spawn, x, y)

    entity:setLocation(x, y)
end

function TimeManager:resolveAction(action)
    if(action.action == TimeManager.Spawn) then
        self.entities[action.e] = action.e
        action.e.x = action.x
        action.e.y = action.y
    elseif(action.action == TimeManager.Remove) then
        self.entities[action.e] = nil
    elseif(action.action == TimeManager.Move) then
        action.e:moveBy(action.x, action.y)
        self.level:entityMoved(action.e)
    elseif(action.action == TimeManager.Activate) then
        self.level:fireAction(action.e:getLocation(), action.e:getDirection())
    end
end

function TimeManager:update(dt)
    if(self:isRunning()) then
        for time, actions in pairs(self.timedActions) do
            if(self.timeLeft <= time and self.lastAction > time) then
                for i, action in ipairs(actions) do
                    self:resolveAction(action)
                end
            end
        end

        self.lastAction = self.timeLeft
        self.timeLeft = self.timeLeft - dt

        for i, entity in pairs(self.entities) do
            entity:update(dt)
        end
    end
end

function TimeManager:draw()
    local txt = "" .. self:getTime()
    love.graphics.print(txt, 400, 20)

    for i, entity in pairs(self.entities) do
        entity:draw()
    end
end

function TimeManager:activate(entity)
    self:addAction(entity, TimeManager.Activate)
end

function TimeManager:moveUp(entity)
    self:addAction(entity, TimeManager.Move, 0, -1)
end

function TimeManager:moveDown(entity)
    self:addAction(entity, TimeManager.Move, 0, 1)
end

function TimeManager:moveLeft(entity)
    self:addAction(entity, TimeManager.Move, -1, 0)
end

function TimeManager:moveRight(entity)
    self:addAction(entity, TimeManager.Move, 1, 0)
end

function TimeManager:isRunning()
    return self.running
end

function TimeManager:stop()
    self.running = false
end

function TimeManager:resume()
    self.running = true
end

function TimeManager:getTime()
    return math.floor(self.timeLeft)
end

return TimeManager