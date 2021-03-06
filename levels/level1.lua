
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
local temporalDisplacement = false


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
    checkDoorState()
end

function checkDoorState()
    if(isDoorOpen()) then
        level.map[1][8] = 25
        level.map[2][8] = 26
    else
        level.map[1][8] = 11
        level.map[2][8] = 12
    end
end

function getLeverState(location)
    for lever, stt in pairs(levers) do
        if(lever.x == location.x and lever.y == location.y) then
            return stt
        end
    end
    return false
end

function pullLever(location)
    if(not getLeverState(location)) then
        setLever(location, true, 14)
        src1 = love.audio.newSource("assets/sfx/clock.wav", "static")
        src1:play()
        Timer.add(2.3, function() resetLever(location) end)
    end
end

function pickupClock()
    temporalDisplacement = true
end

function resetLever(location)
    setLever(location, false, 13)
end

function isDoorOpen()
    for i, lever in pairs(levers) do
        if(lever == false) then
            return false
        end
    end
    return true
end

function Lvl1Script:isDoorOpen()
    return isDoorOpen()
end

function Lvl1Script:canUseTemporalDisplacement()
    return temporalDisplacement
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
    items = {
        {
            location = {x = 4, y = 12},
            img = "assets/gfx/clock.png",
            name = "a Temporal Displacer",
            description = "Press 'T' and use 'W' and 'S' to manipulate time, 'E' to confirm.",
            canpickup = true,
            visible = true,
            onpickup = pickupClock,
        },
        {
            location = {x = 12, y = 12},
            img = "assets/gfx/bomb.png",
            name = "a Bomb",
            description = "That doesn't look good!",
            canpickup = false,
            visible = true,
            onpickup = pickupClock,
        }
    },
    spawn = {
        x = 8,
        y = 3,
        t = 30,
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
    bgMusic = "assets/sfx/Marty_Gots_a_Plan.mp3",
}


return level