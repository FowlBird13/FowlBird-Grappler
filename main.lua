-- Grappler by FowlBird

mods["LuaENVY-ENVY"].auto()
mods["ReturnsAPI-ReturnsAPI"].auto{
    namespace = "grappler",
    mp = true
}

PATH = _ENV["!plugins_mod_folder_path"]

-- ========== Main ==========

local initialize = function()
    hotload = true
    require("./grappler")
end

Initialize.add(initialize)

-- ** Uncomment the two lines below to re-call initialize() on hotload **
if hotload then initialize() end
