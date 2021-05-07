client.set_event_callback("paint", function()

    local players = entity.get_players(true)

    for i = 1, #players do
        local player = players[i]
        local x,y,z = entity.hitbox_position(player,0)
        local x_world,y_world = renderer.world_to_screen(x,y,z)
        if not x_world or not y_world then return end
        renderer.circle(x_world,y_world,255,255,0,255,10,0,1) --emoji face
        renderer.rectangle(x_world - 10,y_world - 3,20,3,0,0,0,255) --center
        renderer.rectangle(x_world - 7,y_world,5,3,0,0,0,255) --left
        renderer.rectangle(x_world + 3,y_world,5,3,0,0,0,255) --right
        renderer.rectangle(x_world - 4,y_world + 5,8,3,0,0,0,255) --smile
    end
end)
