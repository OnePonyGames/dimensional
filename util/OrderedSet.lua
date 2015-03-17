

local Class = require "libs.hump.class"


local OrderedSet = Class{}


function OrderedSet:init()
    self.order = {}
    self.elements = {}

    self.index = 1
    self.count = 0
end

function OrderedSet:add(element)
    if(not self.elements[element]) then
        self.elements[element] = self.index
        self.order[self.index] = element
        self.index = self.index + 1
        self.count = self.count + 1
    end
end

function OrderedSet:remove(element)
    local index = self.elements[element]
    if(index ~= nil) then
        self.elements[element] = nil
        self.order[index] = nil
        self.count = self.count - 1
    end
end

function OrderedSet:contains(element)
    return self.elements[element]~=nil
end

function OrderedSet:pairs()
    local i = 0
    local j = 0
    local n = self.count
    return function()
        i = i + 1
        j = j + 1
        if (j == self.index) then
            return nil
        else
            while(self.order[j] == nil) do
                j = j + 1
            end
            return i, self.order[j]
        end
    end
end



return OrderedSet

