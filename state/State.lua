
local State = Class {
    setManager = function(self, manager)
        self.manager = manager
    end,
    Menu = 1,
    Game = 2,
    Combat = 3,
}

return State