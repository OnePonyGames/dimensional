
local Stack = require "util.Stack"
local Timer = require "libs.hump.timer"


local TimeManager = Class {
    Spawn = "spawn",
    Remove = "remove",
    Move = "move",
    Activate = "activate",
}


function TimeManager:init(level)
    self.level = level

    self.offset = 0
    self.timeLeft = 30
    self.lastAction = self.timeLeft + 1
    self.timedActions = Stack:Create()
    self.pastActions = Stack:Create()
    self.entities = {}
    self.running = true
    self.animations = {}
end

function TimeManager:timeShift(entity, timeOffset)
    local newEntity = entity:clone()

    for i, action in pairs(self.timedActions._et) do
        if(action.e == entity) then
            action.e = newEntity
        end
    end
    for i, action in pairs(self.pastActions._et) do
        if(action.e == entity) then
            action.e = newEntity
        end
    end

    self:addAction(newEntity, TimeManager.Remove)
    self.timeLeft = self.timeLeft + timeOffset
    self.lastAction = 999
    self:playFromTheBeginning()
    self.lastAction = self.timeLeft + 0.1

    self:addAction(entity, TimeManager.Spawn, entity.x, entity.y)
end

function TimeManager:playFromTheBeginning()
    self.level:reset()
    self.entities = {}
    self.timedActions:push(self.pastActions:pop(self.pastActions:getn()))

    self:runActions()
end

function TimeManager:addAction(entity, action, x, y, time)
    x = x or 0
    y = y or 0
    time = time or self.timeLeft

    local newAction = {action = action, e = entity, x = x, y = y, time = time}
    self.timedActions:push(newAction)

    return newAction
end

function TimeManager:setPlayer(entity, x, y)
    self:addAction(entity, TimeManager.Spawn, x, y)

    entity:setLocation(x, y)
end

function TimeManager:setVisibiltyManager(vsbl)
    self.visibility = vsbl
end

function TimeManager:resolveAction(action)
    if(action.action == TimeManager.Spawn) then
        self.entities[action.e] = action.e
        action.e.x = action.x
        action.e.y = action.y
        action.e:warpIn()
    elseif(action.action == TimeManager.Remove) then
        table.insert(self.animations,{animation = action.e.animations.warpOut, x = action.e:getDrawX(), y=action.e:getDrawY()})
        self.entities[action.e] = nil
    elseif(action.action == TimeManager.Move) then
        action.e:moveBy(action.x, action.y)
        self.level:entityMoved(action.e)
    elseif(action.action == TimeManager.Activate) then
        self.level:fireAction(action.e:getLocation(), action.e:getDirection())
    end

    self.visibility:check()
end

function TimeManager:runActions()
    if(self.timedActions:getn() > 0) then
        local action = self.timedActions:pop()
        while(action ~= nil and action.time >= self.timeLeft and action.time < self.lastAction) do
            self:resolveAction(action)

            self.pastActions:push(action)
            action = self.timedActions:pop()
        end
        self.timedActions:push(action)
    end
end

function TimeManager:update(dt)
    if(self:isRunning()) then
        self:runActions()

        self.lastAction = self.timeLeft
        self.timeLeft = self.timeLeft - dt

        for i, entity in pairs(self.entities) do
            entity:update(dt)
        end
    end

    for i = #self.animations, 1, -1 do
        anim = self.animations[i]
        anim.animation:update(dt)

        if(anim.animation:isFinished()) then
            table.remove(self.animations, i)
        end
    end

    Timer.update(dt)
end

function TimeManager:draw()
    local txt = "" .. (self:getTime() + self.offset)
    if(not self.running) then
        love.graphics.setColor(180, 50, 50)
    end

    love.graphics.setNewFont(20)
    love.graphics.print(txt, 435, 495)

    love.graphics.setColor(255, 255, 255)
    for i, entity in pairs(self.entities) do
        entity:draw()
    end

    for i, anim in ipairs(self.animations) do
        anim.animation:draw(anim.x, anim.y)
    end

    --self.visibility:draw() check Line of Sight
end

function TimeManager:getEntities()
    return self.entities
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

function TimeManager:setOffset(offset)
    self.offset = offset
end

return TimeManager