local clicktext = ""
local tx = 20
local ty = 10

local totaldt = 0

local msgs = {}

Debug = {}


function Debug.draw()
    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(0, 255, 0, 255)

    local texts = {}
    table.insert(texts, "FPS: " .. love.timer.getFPS())

    local mpos = "m: " .. love.mouse.getX() .. ", " .. love.mouse.getY()
    table.insert(texts, mpos)

    if (mousetext ~= "") then
        table.insert(texts, clicktext)
    end

    for i, text in ipairs(texts) do
        love.graphics.print(text, tx, (12 * i))
    end

    for i, msg in ipairs(msgs) do
        love.graphics.print(msg[1], tx, ty - (12 * i))
    end

    love.graphics.setColor(r, g, b, a)
end

function Debug.update(dt)
    totaldt = totaldt + dt

    if (totaldt > 1) then
        totaldt = totaldt - 1

        for i = #msgs, 1, -1 do
            local msg = msgs[i]
            if (msg[2] == 1) then
                table.remove(msgs, i)
            else
                msg[2] = msg[2] - 1
            end
        end
    end
end

function love.mousereleased(mx, my, b)
    clicktext = "cl: " .. mx .. ", " .. my .. " b: " .. b
end

function printr(t, indent, done)
    done = done or {}
    indent = indent or ''
    local nextIndent -- Storage for next indentation value
    for key, value in pairs(t) do
        if type(value) == "table" and not done[value] then
            nextIndent = nextIndent or
                    (indent .. string.rep(' ', string.len(tostring(key)) + 2))
            -- Shortcut conditional allocation
            done[value] = true
            print(indent .. "[" .. tostring(key) .. "] => Table {");
            print(nextIndent .. "{");
            printr(value, nextIndent .. string.rep(' ', 2), done)
            print(nextIndent .. "}");
        else
            print(indent .. "[" .. tostring(key) .. "] => " .. tostring(value) .. "")
        end
    end
end

function Debug.log(text)
    print("Logging: " .. text)
    table.insert(msgs, { text, 5 })
end

return Debug