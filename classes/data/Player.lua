
local Direction = require "classes.data.Direction"

local Player = Class {}


function Player:init(sprite)
    self.sprite = sprite
    self.id = 1
    self.direction = Direction.South
end

function Player:setLocation(x, y)
    self.x = x
    self.y = y
end

function Player:getLocation()
    return {x = self.x, y = self.y}
end

function Player:getDirection()
    return self.direction
end

function Player:setTileSize(tileSize)
    self.tileSize = tileSize
end

function Player:draw()
    love.graphics.draw(self.sprite, (self.x-1) * self.tileSize, ((self.y - 2) * self.tileSize) + 10)
end

function Player:moveBy(xoff, yoff)
    self.x = self.x + xoff
    self.y = self.y + yoff
end

function Player:clone()
    local newPlayer = Player()
    newPlayer.sprite = self.sprite
    newPlayer.x = self.x
    newPlayer.y = self.y
    newPlayer.tileSize = self.tileSize
    newPlayer.id = self.id + 1
    return newPlayer
end


return Player