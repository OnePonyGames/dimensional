
local Tiles = require "tiles"

local TileDrawer = Class {}

function TileDrawer:init()
    self.tiles = {}
    self.itemImg = {}
    self.tileSize = 32

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
        love.graphics.draw(self.itemImg[i], (item.location.x - 1) * self.tileSize, (item.location.y - 1) * self.tileSize)
    end
end

return TileDrawer