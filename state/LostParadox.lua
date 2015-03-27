local State = require "state.State"
local SpeechBubble = require "classes.ui.SpeechBubble"

local LostParadox = Class {}
LostParadox:include(State, LostParadox)


function LostParadox:enter()
    self.deathSprite = love.graphics.newImage("assets/gfx/death.png")

    self.speechUI = SpeechBubble()
    self.speechUI:addText("SORRY, WE DON'T\nALLOW THAT KIND\nOF TIME PARADOX", 245, 155, 128, 47)

    self.player.x = 7.5
    self.player.y = 10
    self.player:moveBy(0, -1)
end

function LostParadox:draw()
    self.speechUI:draw()

    love.graphics.setColor(255,255,255)
    love.graphics.draw(self.deathSprite, 200, 150)

    player:draw()

    self:drawTransition()
end

function LostParadox:update(dt)
    self:updateTransition(dt)
end


function LostParadox:setPlayer(player)
    self.player = player
end

function LostParadox:keyreleased(key, code)
    if(not self.speechUI:hasNext()) then
        self:transition(State.Menu, {r=0,g=0,b=0}, 1.5)
    end
end


return LostParadox
