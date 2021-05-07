client.exec('clear')
client.color_log(255, 255, 255, '\n')
client.color_log(255, 255, 255, '[--------------[      mini resolver     ]--------------]')
client.color_log(255, 100, 0, '                    made by mini#6510                     ')
client.color_log(255, 255, 255, '[------------------------------------------------------]')
client.color_log(255, 255, 255, '\n')

local localPlayer = entity.get_local_player()
local has_restarted
local has_died

client.set_event_callback("round_start",function()
    has_restarted = true
end)

client.set_event_callback("player_death",function(e)
    if client.userid_to_entindex(e.userid) == localPlayer then
        has_died = true
    end
end)

client.set_event_callback("aim_fire", function(e)

    plist.set(e.target,"Force body yaw",true)
    local random_value = client.random_int(-60,60)
    plist.set(e.target,"Force body yaw value",random_value)

end)

client.set_event_callback("setup_command",function()

    if has_restarted == true or has_died == true then
        for i=1, globals.maxplayers() do
         plist.set(i,"Force body yaw value",0) 
         plist.set(i,"Force body yaw",false)
        end

        if has_restarted == true then 
            has_restarted = false
        end

        if has_died == true then 
            has_died = false
        end
     end

end)
