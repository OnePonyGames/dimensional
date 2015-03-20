
local Script = require "classes.logic.Script"
local Timer = require "libs.hump.timer"


local Lvl1Script = Class {}
Lvl1Script:include(Script, Lvl1Script)

-- locations of interest
local lever1 = {x = 4, y = 4}
local lever2 = {x = 12, y = 4 }

-- level map initialization
local level = {}

-- variables used in call functions
local levers = {}


function Lvl1Script:init()
    levers[lever1] = false
    levers[lever2] = false
end

function Lvl1Script:reset()
    setLever(lever1, false, 13)
    setLever(lever2, false, 13)
end

-- script call functions
function setLever(location, state, spriteId)
    for lever, stt in pairs(levers) do
        if(lever.x == location.x and lever.y == location.y) then
            levers[lever] = state
            level.map[location.y][location.x] = spriteId
        end
    end
end

function pullLever(location)
    setLever(location, true, 14)
    Timer.add(2, function() resetLever(location) end)
end

function resetLever(location)
    setLever(location, false, 13)
end

function Lvl1Script:isDoorOpen()
    for i, lever in pairs(levers) do
        if(lever == false) then
            return false
        end
    end
    return true
end


-- level map and scripts
level = {
    map = {
        {  7,  4,  4,  4, 15,  4, 2, 11, 2,  4, 15,  4,  2,  4,  6},
        {  7,  3,  3,  3, 15,  5, 3, 12, 5,  3, 15,  3,  3,  3,  6},
        {  7,  1,  1,  1, 15,  1, 1,  1, 1,  1, 15,  1,  1,  1,  6},
        {  7,  1,  1, 13, 15,  1, 1,  1, 1,  1, 15, 13,  1,  1,  6},
        {  7,  1, 21, 19, 18,  1, 1,  1, 1,  1, 17, 19, 20,  1,  6},
        {  7,  1,  4,  4,  4,  1, 1,  1, 1,  1,  4,  4,  4,  1,  6},
        {  7,  1,  5,  5,  5,  1, 1,  1, 1,  1,  5,  5,  5,  1,  6},
        {  7,  1,  1,  1,  1,  1, 1,  1, 1,  1,  1,  1,  1,  1,  6},
        { 22, 19, 19, 19, 19, 24, 1,  1, 1, 23, 19, 19, 19, 19, 22},
        {  7,  4,  2,  4,  4, 15, 1,  1, 1, 15,  2,  4,  2,  2,  6},
        {  7,  5,  5,  3,  5, 16, 1,  1, 1, 16,  5,  3,  3,  5,  6},
        {  7,  1,  1,  1,  1,  2, 1,  1, 1,  4,  1,  1,  1,  1,  6},
        {  7,  1,  1,  1,  1,  3, 1,  1, 1,  3,  1,  1,  1,  1,  6},
        {  7,  1,  1,  1,  1,  1, 1,  1, 1,  1,  1,  1,  1,  1,  6},
        { 10,  8,  8,  8,  8,  8, 8,  8, 8,  8,  8,  8,  8,  8,  9},
    },
    actions = {
        {
            location = lever1,
            call = pullLever,
        },
        {
            location = lever2,
            call = pullLever,
        },
    },
    spawn = {
        x = 8,
        y = 3
    },
    goal = {
        x = 8,
        y = 2,
    },
    dimensions = {
        w = 25,
        h = 18
    },
    passable = {
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
        { 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0},
        { 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0},
        { 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0},
        { 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0},
        { 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0},
        { 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0},
        { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
        { 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0},
        { 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0},
        { 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0},
        { 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0},
        { 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0},
        { 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
        { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    },
    script = Lvl1Script(),
}


return level