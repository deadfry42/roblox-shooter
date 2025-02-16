--[[ data.luau
store basic client data (because roblox was acting weird with all of it in one script)

> last edited: 16th feb 2025
> author(s): deadfry42
> the code below licensed under GPLv3.
]]


local data = {
    ["States"] = {
        ["mouseUnlockable"] = true,
        ["mainMenuOpen"] = false,
        ["cameraToPart"] = false,
        ["lobbyCamera"] = false,
        ["canReset"] = true,
        ["currentEmote"] = false,
        ["canChooseEmote"] = true,
    },
    ["Binds"] = {}
}

return data