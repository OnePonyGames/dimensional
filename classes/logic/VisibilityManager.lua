
local Vector = require "libs.hump.vector"

local VisibilityManager = Class {}

function VisibilityManager:init(game, timeManager, level)
    self.game = game
    self.level = level
    self.timeManager = timeManager
    self.timeManager:setVisibiltyManager(self)
    self.squares = {}
end

function VisibilityManager:check()
    for i, entity in pairs(self.timeManager:getEntities()) do
        for i, cmp in pairs(self.timeManager:getEntities()) do
            if(entity ~= cmp) then
                self.squares = {}

                local vect = Vector(entity.x - cmp.x, entity.y - cmp.y)
                local norm = vect:normalized()
                local vct = vect:normalized()
                local los = true

                while(vect:len() > vct:len()) do
                    local cx = math.floor(entity.x - vct.x)
                    local cy = math.floor(entity.y - vct.y)
                    table.insert(self.squares, Vector(cx, cy))

                    if(not self.level:isPassable(cx, cy)) then
                        los = false
                    end
                    vct = vct + norm
                end

                if(los) then
                    self.game:playerLostParadox(entity, cmp)
                end
            end
        end
    end
end

function VisibilityManager:draw()
    for i, vc in pairs(self.squares) do
        love.graphics.rectangle("line", (vc.x-1) * 32,(vc.y-1) * 32,  32, 32)
    end
end


return VisibilityManager

