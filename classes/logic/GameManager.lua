local Gamestate = require "libs.hump.gamestate"

local State = require "state.State"
local MenuState = require "state.Menu"
local GameState = require "state.Game"
local WonState = require "state.Won"
local LostTimeState = require "state.LostTime"
local LostParadoxState = require "state.LostParadox"

local GameManager = Class {}

function GameManager:init()
    self.states = {}
    self.states[State.Menu] = MenuState()
    self.states[State.Game] = GameState()
    self.states[State.Won] = WonState()
    self.states[State.LostTime] = LostTimeState()
    self.states[State.LostParadox] = LostParadoxState()

    for i, state in ipairs(self.states) do
        state:setManager(self)
    end

    Gamestate.registerEvents()
    Gamestate.switch(self.states[State.Menu])
end

function GameManager:pushState(state)
    Gamestate.push(self.states[state])
end

function GameManager:getState(state)
    return self.states[state]
end

return GameManager

