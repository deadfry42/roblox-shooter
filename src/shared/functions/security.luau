--[[ security.luau
security related functions for use in shared

> last edited: 14th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]

local data = {}

data.CreateUUID = function(length : number)
    local ValidCharacters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
    local String = ``
    for i = 1, 5 do
        String = String..ValidCharacters[math.random(1,#ValidCharacters)]
    end
    return String
end

return data