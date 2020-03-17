//HALF-LIFE 2 BETA HUD
//Script made by DyaMetR
//Font by DyaMetR
//Textures brought by Matsilagi
//Version 1.4.4

surface.CreateFont( "Hl2BHd", {
font = "HL2BetaHUD",
size = 36,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = true,
outline = false
})

surface.CreateFont( "Hl2BHdC", {
font = "HL2BetaHUD",
size = 36,
weight = 500,
blursize = 5,
scanlines = 5,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = true,
outline = false
})

surface.CreateFont( "Hl2BHuA", {
font = "HL2BetaHUD",
size = 18,
weight = 500,
blursize = 0,
scanlines = 0,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = true,
outline = false
})

surface.CreateFont( "Hl2BHdAC", {
font = "HL2BetaHUD",
size = 18,
weight = 500,
blursize = 5,
scanlines = 5,
antialias = true,
underline = false,
italic = false,
strikeout = false,
symbol = false,
rotary = false,
shadow = false,
additive = true,
outline = false
})

-- Health Buff Vars
local hpbuff = 0
local hptime = 0
local hplast = 100
local apbuff = 0
local aptime = 0
local aplast = 0
local hptime2 = 0
local am1buff = 0
local am1time = 0
local am1last = 0
local am2buff = 0
local am2time = 0
local am2last = 0

--CVARS!!!
local enabled = CreateClientConVar( "hl2bhud_enabled", 1, true, false )

function hl2betahud()
if enabled:GetInt() == 1 then
local client = LocalPlayer()
if(client:GetActiveWeapon() == NULL or client:GetActiveWeapon() == "Camera") then return end
--
--Textures
local hevtx = surface.GetTextureID ("hl2betahud/hev")
local hptx = surface.GetTextureID ("hl2betahud/health")
local ammotx = surface.GetTextureID ("hl2betahud/ammo")
local dztx = surface.GetTextureID ("hl2betahud/num_dual")
local sztx = surface.GetTextureID ("hl2betahud/num_off")
--
--Health
surface.SetTexture( hptx )
surface.SetDrawColor( 255 ,220, 0 ,255 )
surface.DrawTexturedRect(53,ScrH()-73,58,11)
if client:Health() > 20 then
surface.SetTexture( dztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(72,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(50,ScrH()-60,19,34)
else
surface.SetTexture( dztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(72,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(50,ScrH()-60,19,34)
end
if client:Health() > 20 then
draw.SimpleText(client:Health(), "Hl2BHd", 114, ScrH()-38, Color(255 ,220, 0 ,255), 2, 1)
elseif client:Health() < 0 then
draw.SimpleText("0", "Hl2BHd", 114, ScrH()-38, Color(200, 0, 0, 255), 2, 1)
else
draw.SimpleText(client:Health(), "Hl2BHd", 114, ScrH()-38, Color(200, 0, 0, 255), 2, 1)
end
--
-- Health Buff
local hp = client:Health()
if hplast ~= hp then
hpbuff = hpbuff + ( hp - hplast )
hptime = CurTime() + 2
hptime2 = CurTime() + 2
hplast = hp
end

if hptime > CurTime() then
if hpbuff < 0 then
draw.SimpleText(client:Health(), "Hl2BHdC", 114, ScrH()-38, Color( 255, 255, 0, math.Clamp( ( hptime - CurTime() ) * 130, 0, 255 ) ), 2, 1)
end
if hpbuff > 0 then
draw.SimpleText(client:Health(), "Hl2BHdC", 114, ScrH()-38, Color( 255, 255, 0, math.Clamp( ( hptime - CurTime() ) * 130, 0, 255 ) ), 2, 1)
end
else
hpbuff = 0
end

if hpbuff == 0 then
if client:Health() <= 20 then
if hptime2 > CurTime() then
draw.SimpleText(client:Health(), "Hl2BHdC", 114, ScrH()-38, Color( 255, 0, 0, math.Clamp( ( hptime2 - CurTime() ) * 130, 0, 255 ) ), 2, 1)
else
hptime2 = CurTime() + 1
end
else
end
else
end
--
--
--ARMOR
surface.SetTexture( hevtx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(155,ScrH()-73,31,11)
surface.SetTexture( dztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(178,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(153,ScrH()-60,19,34)
draw.SimpleText(client:Armor(), "Hl2BHd", 221, ScrH()-38, Color(255, 220, 0, 255), 2, 1)
-- Armor Buff
local ap = client:Armor()
if aplast ~= ap then
apbuff = apbuff + ( ap - aplast )
aptime = CurTime() + 2
aplast = ap
end

if aptime > CurTime() then
if apbuff < 0 then
draw.SimpleText(client:Armor(), "Hl2BHdC", 221, ScrH()-38, Color( 255, 255, 0, math.Clamp( ( aptime - CurTime() ) * 130, 0, 255 ) ) , 2, 1)
end
if apbuff > 0 then
draw.SimpleText(client:Armor(), "Hl2BHdC", 221, ScrH()-38, Color( 255, 255, 0, math.Clamp( ( aptime - CurTime() ) * 130, 0, 255 ) ) , 2, 1)
end
else
apbuff = 0
end
--
--AMMO
if client:GetActiveWeapon():Clip1() != -1 then
if client:GetActiveWeapon():GetPrintName() != "#HL2_GravityGun" then
--Ammo Primary
surface.SetTexture( ammotx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+13,ScrH()-73,43,12)

if client:GetActiveWeapon():Clip1() == 0 then
surface.SetTexture( dztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+35,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+12,ScrH()-60,19,34)
--
surface.SetTexture( dztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.2+17,ScrH()-60,19,18)
surface.SetTexture( sztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.2+3,ScrH()-60,13,18)
draw.SimpleText(client:GetActiveWeapon():Clip1(), "Hl2BHd", ScrW()/1.3+78, ScrH()-38, Color(180, 0, 0, 255), 2, 1)
else
surface.SetTexture( dztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+35,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+12,ScrH()-60,19,34)
--
surface.SetTexture( dztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.2+16,ScrH()-60,22,18)
surface.SetTexture( sztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.2+5,ScrH()-60,10,18)
draw.SimpleText(client:GetActiveWeapon():Clip1(), "Hl2BHd", ScrW()/1.3+78, ScrH()-38, Color(255, 220, 0, 255), 2, 1)
end
--AMMOBUFF
local am1 = client:GetActiveWeapon():Clip1()
if am1last ~= am1 then
am1buff = am1buff + ( am1 - am1last )
am1time = CurTime() + 2
am1last = am1
end

if am1time > CurTime() then
if am1buff < 0 then
draw.SimpleText(client:GetActiveWeapon():Clip1(), "Hl2BHdC", ScrW()/1.3+78, ScrH()-38, Color( 255, 255, 0, math.Clamp( ( am1time - CurTime() ) * 130, 0, 255 ) ) , 2, 1)
end
if am1buff > 0 then
draw.SimpleText(client:GetActiveWeapon():Clip1(), "Hl2BHdC", ScrW()/1.3+78, ScrH()-38, Color( 255, 255, 0, math.Clamp( ( am1time - CurTime() ) * 130, 0, 255 ) ) , 2, 1)
end
else
am1buff = 0
end
--Ammo Extra
if client:GetActiveWeapon():Clip1() == 0 then
draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "Hl2BHuA", ScrW()/1.2+37, ScrH()-49, Color(180, 0, 0, 255), 2, 1)
else
draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "Hl2BHuA", ScrW()/1.2+37, ScrH()-49, Color(255, 220, 0, 255), 2, 1)
end
else
end
elseif client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) > 0 then
if client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()) > 0 then
surface.SetTexture( ammotx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+13,ScrH()-73,43,12)
surface.SetTexture( dztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+35,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+12,ScrH()-60,19,34)
draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "Hl2BHd", ScrW()/1.3+78, ScrH()-38, Color(255, 220, 0, 255), 2, 1)
else
surface.SetTexture( ammotx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+13,ScrH()-73,43,12)
surface.SetTexture( dztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+35,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 180, 0, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.3+12,ScrH()-60,19,34)
draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetPrimaryAmmoType()), "Hl2BHd", ScrW()/1.3+78, ScrH()-38, Color(255, 220, 0, 255), 2, 1)
end
else
end
--Ammo secondary
if client:GetActiveWeapon():GetSecondaryAmmoType() > -1 then
surface.SetTexture( dztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.1+16,ScrH()-60,41,35)
surface.SetTexture( sztx )
surface.SetDrawColor( 255, 220, 0, 255 )
surface.DrawTexturedRect(ScrW()/1.1-9,ScrH()-60,19,34)
draw.SimpleText(client:GetAmmoCount(client:GetActiveWeapon():GetSecondaryAmmoType()), "Hl2BHd", ScrW()/1.05+3, ScrH()-38, Color(255, 220, 0, 255), 2, 1)
else
end
--
end
end
hook.Add("HUDPaint", "hl2betahud", hl2betahud)

local tohide = { -- This is a table where the keys are the HUD items to hide
["CHudHealth"] = true,
["CHudBattery"] = true,
["CHudAmmo"] = true,
["CHudSecondaryAmmo"] = true
}
local function HUDShouldDraw(name)
	if (tohide[name] and enabled:GetInt() > 0) then return false end;
end
hook.Add("HUDShouldDraw", "hl2bhudhide", HUDShouldDraw)

local function TheMenu( Panel )
	Panel:ClearControls()
	//Do menu things here
	Panel:AddControl( "Label" , { Text = "Half-Life 2: Missing Information HUD Settings", Description = "The options of the Half-Life 2: Missing Information HUD"} )
	Panel:AddControl( "CheckBox", {
		Label = "Toggle HUD",
		Command = "hl2bhud_enabled",
		}
	)
end

local function createthemenu()
	spawnmenu.AddToolMenuOption( "Options", "DyaMetR", "Hl2BHUD", "Missing Information HUD", "", "", TheMenu )
end
hook.Add( "PopulateToolMenu", "hl2bmenu", createthemenu )
