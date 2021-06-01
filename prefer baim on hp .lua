local auto_hp = ui.new_slider("RAGE","Aimbot","auto min dmg to baim",0,100,50,true,"")
local scout_hp = ui.new_slider("RAGE","Aimbot","scout min dmg to baim",0,100,92,true,"")
local awp_hp = ui.new_slider("RAGE","Aimbot","awp min dmg to baim",0,100,85,true,"")
local has_restarted
local has_died

local function mingun(weapon,dmg)
    local localPlayer = entity.get_local_player()
    local weapons = entity.get_player_weapon(localPlayer)
    for i = 0,#weapon do
        if entity.get_classname(weapons) == weapon[i] then
            return dmg[i]
        end
    end
    return 0
end

client.set_event_callback("round_start",function()
    has_restarted = true
end)

client.set_event_callback("player_death",function(e)
    if client.userid_to_entindex(e.userid) == localPlayer then
        has_died = true
    end
end)

client.set_event_callback("run_command",function()

    local localPlayer = entity.get_local_player()
    local player = entity.get_players(true)
    local weapon = entity.get_player_weapon(localPlayer)
    for i = 1, #player do
        local players = player[i]

        local hp = entity.get_prop(players,"m_iHealth")
        local armour_value = entity.get_prop(players,"m_ArmorValue")

        if has_restarted == true then
            plist.set(players,"Override prefer body aim","-")
            has_restarted = false
        end

        if hp <= mingun({"CWeaponSSG08","CWeaponAWP","CWeaponG3SG1","CWeaponSCAR20"},{ui.get(scout_hp),ui.get(awp_hp),ui.get(auto_hp),ui.get(auto_hp)}) then
            plist.set(players,"Override prefer body aim","On")
        elseif armour_value == 0 then
            plist.set(players,"Override prefer body aim","On")
        elseif armour_value >= 1 and hp > mingun({"CWeaponSSG08","CWeaponAWP","CWeaponG3SG1","CWeaponSCAR20"},{ui.get(scout_hp),ui.get(awp_hp),ui.get(auto_hp),ui.get(auto_hp)}) then
            plist.set(players,"Override prefer body aim","-")
        end
        
    end

end)

client.set_event_callback("setup_command",function()

    if has_restarted == true or has_died == true then
        for i=1, globals.maxplayers() do
         plist.set(i,"Override prefer body aim","-") 
        end

        if has_restarted == true then 
            has_restarted = false
        end

        if has_died == true then 
            has_died = false
        end
     end

end)

client.set_event_callback("paint",function() 

    local x,y = client.screen_size()
    local player = entity.get_players(true)
    local y_value = 0
    renderer.text(x * 0.05, y / 2 + y_value,255,255,255,255,nil,0,"Prefer baim on:")
    y_value = y_value + 15

    for i = 1, #player do
        local players = player[i]

        if plist.get(players,"Override prefer body aim") == "On" then
            local player_name = entity.get_player_name(players)
            renderer.text(x * 0.05, y / 2 + y_value,255,255,255,255,nil,0,player_name)
            y_value = y_value + 15
        end
    end
end)
