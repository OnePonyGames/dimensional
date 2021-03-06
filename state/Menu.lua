local State = require "state.State"

local LevelLoader = require "classes.data.LevelLoader"
local Player = require "classes.data.Player"

local Menu = Class {}
Menu:include(State, Menu)

function Menu:init()
    self.lvlLoader = LevelLoader()
end

function Menu:draw()
    love.graphics.setColor(255,255,255)

    love.graphics.setNewFont( 26 )
    love.graphics.print("Dimensional", 155, 100)
    love.graphics.setNewFont( 12 )
    love.graphics.print("Press Enter to continue,", 160, 150)
    love.graphics.print("and Escape to quit", 175, 162)
    love.graphics.setNewFont( 11 )
    love.graphics.print("Move with W, A, S, D and interact with E", 125, 214)
end

function Menu:keyreleased(key, code)
    if key == "return" or key == "kpenter" then
        lvl = self.lvlLoader:loadLevel1()

        sprites = {
            standing = love.graphics.newImage("assets/gfx/player.png"),
            left = love.graphics.newImage("assets/gfx/player_left.png"),
            right = love.graphics.newImage("assets/gfx/player_right.png"),
            up = love.graphics.newImage("assets/gfx/player_up.png"),
            down = love.graphics.newImage("assets/gfx/player_down.png"),
            warpIn = love.graphics.newImage("assets/gfx/warp_in.png"),
            warpOut = love.graphics.newImage("assets/gfx/warp_out.png"),
        }

        player = Player(sprites)

        self.manager:getState(State.LostParadox):setPlayer(player)
        self.manager:getState(State.LostTime):setPlayer(player)
        self.manager:getState(State.Game):setPlayer(player)
        self.manager:getState(State.Game):setLevel(lvl)
        self.manager:pushState(State.Game)
    end
    if key == "escape" then
        love.event.quit()
    end
end



return Menu
