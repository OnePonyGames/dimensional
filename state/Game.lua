local State = require "state.State"
local TileDrawer = require "classes.ui.TileDrawer"
local Chronometer = require "classes.ui.Chronometer"

local TimeManager = require "classes.logic.TimeManager"


local Game = Class {}
Game:include(State, Game)


function Game:setLevel(level)
    self.level = level

    self.drawer = TileDrawer()
    self.chronometer = Chronometer()

    self.drawer:setLevel(level)
    self.player:setTileSize(self.drawer.tileSize)

    self.timeManager = TimeManager()
    self.timeManager:setPlayer(self.player, level.spawn.x, level.spawn.y)
end

function Game:setPlayer(player)
    self.player = player
end

function Game:enter()
end

function Game:draw()
    self.drawer:draw()
    self.timeManager:draw()
    self.chronometer:draw()
end

function Game:update(dt)
    self.timeManager:update(dt)
end

function Game:keyreleased(key, code)
    if(self.timeManager:isRunning()) then
        if(key == "t") then
            self.timeManager:stop()

            self.chronometer:setTime(0)
            self.chronometer:setVisible(true)
        end
    elseif(key == "return") then
        self.chronometer:setVisible(false)
        local timeOffset = self.chronometer:getTime()

        self.timeManager:timeShift(self.player, timeOffset)
        self.timeManager:resume()
    end
end

function Game:keypressed(key, isrepeat)
    if(self.timeManager:isRunning()) then
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

return Game