local State = require "state.State"
local TileDrawer = require "classes.ui.TileDrawer"
local Chronometer = require "classes.ui.Chronometer"
local Timer = require "libs.hump.timer"

local VisibilityManager = require "classes.logic.VisibilityManager"
local TimeManager = require "classes.logic.TimeManager"


local Game = Class {}
Game:include(State, Game)


function Game:setLevel(levelMngr)
    self.gameEnded = false
    self.level = levelMngr
    self.level:setGame(self)

    self.drawer = TileDrawer()
    self.chronometer = Chronometer()

    self.drawer:setLevel(levelMngr)
    self.player:setTileSize(self.drawer.tileSize)

    self.timeManager = TimeManager(self.level)
    VisibilityManager(self, self.timeManager, self.level)

    self.timeManager:setPlayer(self.player, levelMngr.spawn.x, levelMngr.spawn.y)
end

function Game:setPlayer(player)
    self.player = player
end

function Game:draw()
    self.drawer:draw()
    self.timeManager:draw()
    --Debug.draw()

    self:drawTransition()
end

function Game:update(dt)
    self:updateTransition(dt)

    self.timeManager:update(dt)
    self.drawer:update(dt)

    --Debug.update(dt)

    if(self.chronometer:isVisible()) then
        self.timeManager:setOffset(self.chronometer:getTime())
    end

    if(self.timeManager:isRunning() or self.gameEnded) then
        Timer.update(dt)
    end

    if(self.timeManager:getTime() <= 0 ) then
        self:playerLostTime()
    end

end

function Game:keyreleased(key, code)
    if(self.timeManager:isRunning()) then
        if(self.level:canUseTemporalDisplacement() or true) then
            if(key == "t") then
                self.timeManager:stop()

                self.chronometer:setTime(0)
                self.chronometer:setVisible(true)
            end
        end
        if(key == "e") then
            self.timeManager:activate(self.player)
        end
    elseif(key == "return" or key == "e") then
        self.chronometer:setVisible(false)
        local timeOffset = self.chronometer:getTime()

        self.timeManager:timeShift(self.player, timeOffset)
        self.timeManager:setOffset(0)
        self.timeManager:resume()
    elseif(key == "escape" or key == "t") then
        self.chronometer:setVisible(false)
        self.timeManager:setOffset(0)
        self.timeManager:resume()
    end
    if(key == "escape") then
        love.event.quit()
    end
end

function Game:keypressed(key, isrepeat)
    if(self.timeManager:isRunning() and self.player:isStanding()) then
        if(key == "w") then
            if(self.level:isPassable(self.player.x, self.player.y - 1)) then
                self.timeManager:moveUp(self.player)
            end
        elseif (key == "s") then
            if(self.level:isPassable(self.player.x, self.player.y + 1)) then
                self.timeManager:moveDown(self.player)
            end
        elseif (key == "a") then
            if(self.level:isPassable(self.player.x - 1, self.player.y)) then
                self.timeManager:moveLeft(self.player)
            end
        elseif (key == "d") then
            if(self.level:isPassable(self.player.x + 1, self.player.y)) then
                self.timeManager:moveRight(self.player)
            end
        end
    elseif(key == "w") then
        self.chronometer:inc()
    elseif(key == "s") then
        self.chronometer:dec()
    end
end

function Game:playerWon()
    self.manager:pushState(State.Won)
end

function Game:playerLostParadox(entity1, entity2)
    if(not self.gameEnded) then
        self.timeManager:stop()
        self.gameEnded = true

        self.drawer:addExclamationMark(entity1)
        self.drawer:addExclamationMark(entity2)

        Timer.add(1, function() self:transition(State.LostParadox, {r=0, g=0, b=0}, 1.2) end)
    end
end

function Game:playerLostTime()
    if(not self.gameEnded) then
        self.timeManager:stop()
        self.gameEnded = true

        self:transition(State.LostTime, {r=255, g=255, b=255}, 1.8)
    end
end

function Game:displayMessage(msg)
    self.drawer:displayMessage(msg)
end

return Game