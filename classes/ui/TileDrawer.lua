
local Tiles = require "tiles"

local TileDrawer = Class {}

function TileDrawer:init()
    self.tiles = {}
    self.tileSize = 32

    for i, tile in ipairs(Tiles) do
        self.tiles[i] = love.graphics.newImage(tile)
    end
end

function TileDrawer:setLevel(level)
    self.level = level
end

function TileDrawer:draw()
    for i,row in ipairs(self.level.map) do
        for j,e in ipairs(row) do
            love.graphics.draw(self.tiles[e], (i-1) * self.tileSize, (j-1) * self.tileSize)
        end
    end
end

return TileDrawer