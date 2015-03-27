local State = require "state.State"
local SpeechBubble = require "classes.ui.SpeechBubble"

local LostTime = Class {}
LostTime:include(State, LostTime)


function LostTime:enter()
    self.deathSprite = love.graphics.newImage("assets/gfx/death.png")

    self.speechUI = SpeechBubble()
    self.speechUI:addText("WELL...\nIT IS TIME.", 245, 155, 68, 33)

    self.player.x = 7.5
    self.player.y = 10
    self.player:moveBy(0, -1)
end

function LostTime:draw()
    self.speechUI:draw()

    love.graphics.setColor(255,255,255)
    love.graphics.draw(self.deathSprite, 200, 150)

    player:draw()

    self:drawTransition()
end

function LostTime:update(dt)
    self:updateTransition(dt)
end

function LostTime:keyreleased(key, code)
    if(key == "return" or key == "e") then
        self:transition(State.Menu, {r=0,g=0,b=0}, 1.5)
    end
end

function LostTime:setPlayer(player)
    self.player = player
end

return LostTime
