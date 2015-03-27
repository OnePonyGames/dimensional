

local SpeechBubble = Class {}

function SpeechBubble:init()
    self.messages = {}
end

function SpeechBubble:addText(txt, x, y, w, h)
    table.insert(self.messages, {msg = txt, x=x, y=y, w=w, h=h})
end

function SpeechBubble:draw()
    if(#self.messages > 0) then
        love.graphics.setNewFont(12)

        local lx = self.messages[1].x
        local ly = self.messages[1].y
        local rx = self.messages[1].x + self.messages[1].w
        local ty = self.messages[1].y - self.messages[1].h

        love.graphics.setColor(255,255,255)
        love.graphics.rectangle("fill", lx, ty, rx-lx,ly-ty)

        love.graphics.setColor(246,246,246)
        love.graphics.line(lx, ty-1, rx, ty-1)  -- upper line
        love.graphics.line(lx, ly+1, rx, ly+1)  -- lower line
        love.graphics.line(lx-1, ty, lx-1, ly)  -- left line
        love.graphics.line(rx+1, ty, rx+1, ly)  -- right line

        love.graphics.setColor(0,0,0)
        love.graphics.print(self.messages[1].msg, lx + 4, ty + 4)

        if(#self.messages > 1) then

        end
    end
end

function SpeechBubble:hasNext()
    return (#self.messages > 1)
end

function SpeechBubble:nextText()
    if(#self.messages > 0) then
        table.remove(self.messages, 1)
    end

    return (#self.messages > 0)
end


return SpeechBubble