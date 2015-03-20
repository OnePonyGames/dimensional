-- local Script = require "scripts.Script"


local Script = Class {}
-- Script:include(Script, Script)

function Script:isDoorOpen()
    return false
end

function Script:reset()
    -- do nothing
end

function Script:canUseTemporalDisplacement()
    return true
end


return Script

