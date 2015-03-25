
local Direction = require "classes.data.Direction"
local Animation = require "libs.anal.anal"

local Player = Class {}

local movementSpeed = 0.075


function Player:init(sprites)
    self.id = 1
    self.direction = Direction.South
    self.sprites = sprites
    self.animations = {
        down = newAnimation(sprites.down, 32, 64, 0, 1),
        up = newAnimation(sprites.up, 32, 64, 0, 1),
        left = newAnimation(sprites.left, 32, 64, 0, 1),
        right = newAnimation(sprites.right, 32, 64, 0, 1),
        upWalk = newAnimation(sprites.up, 32, 64, movementSpeed, 0),
        downWalk = newAnimation(sprites.down, 32, 64, movementSpeed, 0),
        leftWalk = newAnimation(sprites.left, 32, 64, movementSpeed, 0),
        rightWalk = newAnimation(sprites.right, 32, 64, movementSpeed, 0),
    }
    self.animation = self.animations.down
    self.standing = true

    for i, anim in pairs(self.animations) do
        anim:setMode("once")
    end
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
    local off = self.animation:getCurrentFrame() / (self.animation:getSize() )
    if(self:isStanding()) then
        off = 1
    end
    off = (1 - off) * self.tileSize

    local xoff = 0
    local yoff = 0

    if(self.direction == Direction.North) then
        yoff = -off
    elseif(self.direction == Direction.South) then
        yoff = off
    elseif(self.direction == Direction.East) then
        xoff = off
    elseif(self.direction == Direction.West) then
        xoff = -off
    end

    self.animation:draw((self.x-1) * self.tileSize - xoff, ((self.y - 2) * self.tileSize) - yoff)
end

function Player:isStanding()
    return self.standing
end

function Player:moveBy(xoff, yoff)
    self.x = self.x + xoff
    self.y = self.y + yoff
    self.standing = false

    if(xoff > 0) then
        self.animation = self.animations.rightWalk
        self.direction = Direction.East
    elseif(xoff < 0) then
        self.animation = self.animations.leftWalk
        self.direction = Direction.West
    elseif(yoff > 0) then
        self.animation = self.animations.downWalk
        self.direction = Direction.South
    elseif(yoff < 0) then
        self.animation = self.animations.upWalk
        self.direction = Direction.North
    end
    self.animation:reset()
end

function Player:update(dt)
    self.animation:update(dt)

    if(self.animation:getCurrentFrame() == self.animation:getSize() and not self.standing) then
        if(self.direction == Direction.North) then
            self.animation = self.animations.up
        elseif(self.direction == Direction.South) then
            self.animation = self.animations.down
        elseif(self.direction == Direction.East) then
            self.animation = self.animations.right
        elseif(self.direction == Direction.West) then
            self.animation = self.animations.left
        end

        self.standing = true
    end
end

function Player:clone()
    local newPlayer = Player(self.sprites)
    newPlayer.x = self.x
    newPlayer.y = self.y
    newPlayer.tileSize = self.tileSize
    newPlayer.id = self.id + 1
    newPlayer.direction = self.direction
    newPlayer.animation = self.animations
    newPlayer.standing = self.standing

    return newPlayer
end


return Player