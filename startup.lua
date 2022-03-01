if pcall(function() shell.setDir("/disk") end)
then
    shell.setDir("/")
    shell.run("delete /updateProgs.lua")
    shell.run("cp /disk/updateProgs.lua /")
    shell.run("updateProgs.lua")
end
