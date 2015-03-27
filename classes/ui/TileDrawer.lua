
local Tiles = require "tiles"
local Vector = require "libs.hump.vector"

local TileDrawer = Class {}

function TileDrawer:init()
    self.exclamationsMarks = {}
    self.messages = {}

    self.tiles = {}
    self.itemImg = {}
    self.tileSize = 32
    self.totaldt = 0

    for i, tile in ipairs(Tiles) do
        self.tiles[i] = love.graphics.newImage(tile)
    end
end

function TileDrawer:setLevel(level)
    self.level = level

    for i, item in ipairs(self.level.items) do
        self.itemImg[i] = love.graphics.newImage(item.img)
    end
end

function TileDrawer:draw()
    for i,row in ipairs(self.level.map) do
        for j,e in ipairs(row) do
            love.graphics.draw(self.tiles[e], (j-1) * self.tileSize, (i-1) * self.tileSize)
        end
    end

    for i, item in ipairs(self.level.items) do
        if(item.visible) then
            love.graphics.draw(self.itemImg[i], (item.location.x - 1) * self.tileSize, (item.location.y - 1) * self.tileSize)
        end
    end

    for i, position in ipairs(self.exclamationsMarks) do
        love.graphics.draw(self.tiles[27], (position.x - 1) * self.tileSize, (position.y - 1) * self.tileSize)
    end

    love.graphics.setNewFont(12)
    for i = #self.messages, 1, -1 do
        local msg = self.messages[i]
        love.graphics.print(msg[1], 10, 475 + (13 * i))
    end
end

function TileDrawer:update(dt)
    self.totaldt = self.totaldt + dt
    if (self.totaldt > 1) then
        self.totaldt = self.totaldt - 1

        for i = #self.messages, 1, -1 do
            local msg = self.messages[i]
            if (msg[2] == 1) then
                table.remove(self.messages, i)
            else
                msg[2] = msg[2] - 1
            end
        end
    end
end

function TileDrawer:addExclamationMark(entity)
    table.insert(self.exclamationsMarks, Vector(entity.x, entity.y-1))
end

function TileDrawer:displayMessage(msg)
    table.insert(self.messages, {msg, 7.5})
end

return TileDrawer