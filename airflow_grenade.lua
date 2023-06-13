local lua_information = 
{
    description = "Airflow grenade timer",
    coder = "kayron (REAL)",
    version = "ZG0gbWluaSM2NTc2IHRvIHdpbiBzdGFybGlnaHQgcHJpdmF0ZSB2ZXJzaW9u"
}
local base64 = require("gamesense/base64") or error("Failed to load base64 | https://gamesense.pub/forums/viewtopic.php?id=21619")

local a,b,e,f,g,h,j,kz,l,m,lz = ui.reference,ui.new_multiselect,ui.get,renderer.world_to_screen,entity.get_prop,entity.get_local_player(),entity.get_all,renderer.circle_outline,renderer.text,entity.get_origin,math.min

local vector = require("vector")
local images = require("gamesense/images") or error("Failed to load images | https://gamesense.pub/forums/viewtopic.php?id=22917")


local az = 
{
    a("VISUALS", "Other ESP", "Grenade proximity warning"),
    { a("VISUALS", "Other ESP", "Grenades") },
    b("VISUALS", "Other ESP", "Smoke grenades", {"Text","Icon","Timer"}),
   b("VISUALS", "Other ESP", "Fire grenades", {"Text","Icon","Timer"}),
}

local function c(a, b, t)
    return a + (b - a) * t
end

local function d(tbl, val)
    for i=1,#tbl do
        if tbl[i] == val then
            return true
        end
    end
    return false
end


local z = 30
local t = false

local function peint()

    if math.ceil(z) == 30 then
        t = true
    elseif math.ceil(z) == 16 then
        t = false
    end

    local i = globals.frametime()
    z = c(z,t and 15 or 30,i * 3)

    for k,v in ipairs(j("CSmokeGrenadeProjectile")) do
       
        local pz = vector(m(v))
        local w,h = f(pz.x, pz.y, pz.z)

        if w == nil then break end

        local q = g(v, "m_nSmokeEffectTickBegin", k)
        local x = nil
        local cz = { e(az[2][2]) }
        if g(v, "m_bDidSmokeEffect", k) == 1 then
            local p = 18.2 -- Number of ticks the smoke lasts for
            local n = globals.tickcount()
            local o = globals.tickinterval()
            
            x = (n - q) * o / p
            x = lz(x, 1) 

            if d(e(az[3]),"Timer") then
                kz(w, h, 12, 12, 12, 255, 8, 0, 1, 4)
                kz(w, h, cz[1],cz[2],cz[3],255, 7, 0,1 - x, 2)
            end

            
            if d(e(az[3]),"Icon") then
                local weapon_icon = images.get_weapon_icon("weapon_smokegrenade")
                weapon_icon:draw(w - 6,h - 15 - math.ceil(z),10,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 4,h - 15 - math.ceil(z),10,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 5,h - 14 - math.ceil(z),10,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 5,h - 16 - math.ceil(z),10,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 5,h - 15 - math.ceil(z),10,20,cz[1],cz[2],cz[3],255,true,nil)
            end

            
            if not e(az[2][1]) and d(e(az[3]),"Text") then
                l(w - 1,h + 15,cz[1],cz[2],cz[3],cz[4],"c-",nil,"SMOKE")
            end
        end
    end

    local xz = cvar.mp_friendlyfire

    for k,v in ipairs(j("CInferno")) do

        if xz:get_int() == 0 and g(v, "m_iTeamNum", k) == g(h, "m_iTeamNum") then break end

        local pz = vector(m(v))

        if e(az[1]) then
            if pz:dist(vector(m(h))) < 440 then 
                break 
            end
        end

        local w,h = f(pz.x, pz.y, pz.z)    
        if w == nil then break end

        local q = g(v, "m_nFireEffectTickBegin", k)
        local x = nil
        local cz = { e(az[2][2]) }
        if g(v, "m_bFireIsBurning", k) == 1 then
            local p = 7.2 -- Number of ticks the molotov lasts for
            local n = globals.tickcount()
            local o = globals.tickinterval()
            
            x = (n - q) * o / p
            x = lz(x, 1)

            if d(e(az[4]),"Timer") then
                kz(w, h, 12, 12, 12, 255, 8, 0, 1, 4)
                kz(w, h, cz[1],cz[2],cz[3],255, 7, 0,1 - x, 2)
            end

            
            if d(e(az[4]),"Icon") then
                local weapon_icon = images.get_weapon_icon("weapon_molotov")
                weapon_icon:draw(w - 7,h - 15 - math.ceil(z),15,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 5,h - 15 - math.ceil(z),15,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 6,h - 14 - math.ceil(z),15,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 6,h - 16 - math.ceil(z),15,20,0,0,0,255,true,nil)
                weapon_icon:draw(w - 6,h - 15 - math.ceil(z),15,20,cz[1],cz[2],cz[3],255,true,nil)
            end

            
            if not e(az[2][1]) and d(e(az[4]),"Text") then
                l(w - 1,h + 15,cz[1],cz[2],cz[3],cz[4],"c-",nil,"FIRE")
            end
            
        end
    end
end

client.set_event_callback("paint", peint)
