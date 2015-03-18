

local Player = Class {}


function Player:init(sprite)
    self.sprite = sprite
    self.id = 1
end

function Player:setLocation(x, y)
    self.x = x
    self.y = y
end

function Player:setTileSize(tileSize)
    self.tileSize = tileSize
end

function Player:draw()
    love.graphics.draw(self.sprite, (self.x-1) * self.tileSize, (self.y-1) * self.tileSize)
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