
local State = Class {
    setManager = function(self, manager)
        self.manager = manager
    end,
    Menu = 1,
    Game = 2,
    Won = 3,
    LostTime = 4,
    LostParadox = 5,
}

return State