local State = require "state.State"
local TileDrawer = require "classes.ui.TileDrawer"


local Game = Class {}
Game:include(State, Game)


function Game:setLevel(level)
    self.level = level

    self.drawer = TileDrawer()
    self.drawer:setLevel(level)
    self.player:setTileSize(self.drawer.tileSize)

    self.player:setLocation(level.spawn.x, level.spawn.y)
end

function Game:setPlayer(player)
    self.player = player
end

function Game:enter()
end

function Game:draw()
    self.drawer:draw()
    self.player:draw()
end

function Game:keypressed(key, code)
    if(key == "w") then
        self.player:moveUp()
    elseif (key == "s") then
        self.player:moveDown()
    elseif (key == "a") then
        self.player:moveLeft()
    elseif (key == "d") then
        self.player:moveRight()
    end
end

return Game