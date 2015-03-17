

local Player = Class {}


function Player:init(sprite)
    self.sprite = sprite
end

function Player:setLocation(x, y)
    self.x = x
    self.y = y
end

function Player:setTileSize(tileSize)
    self.tileSize = tileSize
end

function Player:draw()
    love.graphics.draw(self.sprite, self.x * self.tileSize, self.y * self.tileSize)
end

function Player:moveUp()
    self.y = self.y - 1
end

function Player:moveDown()
    self.y = self.y + 1
end

function Player:moveLeft()
    self.x = self.x - 1
end

function Player:moveRight()
    self.x = self.x + 1
end


return Player