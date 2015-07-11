--[[ Helper 1.2.1
		by Nato Boram
		
	Summary
		Callbacks
			OnLoad
			OnTick
			OnDraw
		Core
			Drink
		Calculations
			Select Lowest Target
			Range Library
			Maximum Range
			Critical Strike
			On Hit Effects
			One Combo
		Functions
			Harass
			Kill Secure
	
	If you have any comments, suggestions or feedback, please post them in the topic.
	If you have Riot Decode, please have a look at the Range Library.
		
	Official Topic Link : http://forum.botoflegends.com/topic/55691-/
	Official Download Link : http://pastebin.com/download.php?i=cLjSuk2p
	Special thanks to Script Status : http://scriptstatus.net/
]]

assert(load(Base64Decode("G0x1YVIAAQQEBAgAGZMNChoKAAAAAAAAAAAAAQIKAAAABgBAAEFAAAAdQAABBkBAAGUAAAAKQACBBkBAAGVAAAAKQICBHwCAAAQAAAAEBgAAAGNsYXNzAAQNAAAAU2NyaXB0U3RhdHVzAAQHAAAAX19pbml0AAQLAAAAU2VuZFVwZGF0ZQACAAAAAgAAAAgAAAACAAotAAAAhkBAAMaAQAAGwUAABwFBAkFBAQAdgQABRsFAAEcBwQKBgQEAXYEAAYbBQACHAUEDwcEBAJ2BAAHGwUAAxwHBAwECAgDdgQABBsJAAAcCQQRBQgIAHYIAARYBAgLdAAABnYAAAAqAAIAKQACFhgBDAMHAAgCdgAABCoCAhQqAw4aGAEQAx8BCAMfAwwHdAIAAnYAAAAqAgIeMQEQAAYEEAJ1AgAGGwEQA5QAAAJ1AAAEfAIAAFAAAAAQFAAAAaHdpZAAEDQAAAEJhc2U2NEVuY29kZQAECQAAAHRvc3RyaW5nAAQDAAAAb3MABAcAAABnZXRlbnYABBUAAABQUk9DRVNTT1JfSURFTlRJRklFUgAECQAAAFVTRVJOQU1FAAQNAAAAQ09NUFVURVJOQU1FAAQQAAAAUFJPQ0VTU09SX0xFVkVMAAQTAAAAUFJPQ0VTU09SX1JFVklTSU9OAAQEAAAAS2V5AAQHAAAAc29ja2V0AAQIAAAAcmVxdWlyZQAECgAAAGdhbWVTdGF0ZQAABAQAAAB0Y3AABAcAAABhc3NlcnQABAsAAABTZW5kVXBkYXRlAAMAAAAAAADwPwQUAAAAQWRkQnVnc3BsYXRDYWxsYmFjawABAAAACAAAAAgAAAAAAAMFAAAABQAAAAwAQACBQAAAHUCAAR8AgAACAAAABAsAAABTZW5kVXBkYXRlAAMAAAAAAAAAQAAAAAABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAUAAAAIAAAACAAAAAgAAAAIAAAACAAAAAAAAAABAAAABQAAAHNlbGYAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAtAAAAAwAAAAMAAAAEAAAABAAAAAQAAAAEAAAABAAAAAQAAAAEAAAABAAAAAUAAAAFAAAABQAAAAUAAAAFAAAABQAAAAUAAAAFAAAABgAAAAYAAAAGAAAABgAAAAUAAAADAAAAAwAAAAYAAAAGAAAABgAAAAYAAAAGAAAABgAAAAYAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAHAAAABwAAAAcAAAAIAAAACAAAAAgAAAAIAAAAAgAAAAUAAABzZWxmAAAAAAAtAAAAAgAAAGEAAAAAAC0AAAABAAAABQAAAF9FTlYACQAAAA4AAAACAA0XAAAAhwBAAIxAQAEBgQAAQcEAAJ1AAAKHAEAAjABBAQFBAQBHgUEAgcEBAMcBQgABwgEAQAKAAIHCAQDGQkIAx4LCBQHDAgAWAQMCnUCAAYcAQACMAEMBnUAAAR8AgAANAAAABAQAAAB0Y3AABAgAAABjb25uZWN0AAQRAAAAc2NyaXB0c3RhdHVzLm5ldAADAAAAAAAAVEAEBQAAAHNlbmQABAsAAABHRVQgL3N5bmMtAAQEAAAAS2V5AAQCAAAALQAEBQAAAGh3aWQABAcAAABteUhlcm8ABAkAAABjaGFyTmFtZQAEJgAAACBIVFRQLzEuMA0KSG9zdDogc2NyaXB0c3RhdHVzLm5ldA0KDQoABAYAAABjbG9zZQAAAAAAAQAAAAAAEAAAAEBvYmZ1c2NhdGVkLmx1YQAXAAAACgAAAAoAAAAKAAAACgAAAAoAAAALAAAACwAAAAsAAAALAAAADAAAAAwAAAANAAAADQAAAA0AAAAOAAAADgAAAA4AAAAOAAAACwAAAA4AAAAOAAAADgAAAA4AAAACAAAABQAAAHNlbGYAAAAAABcAAAACAAAAYQAAAAAAFwAAAAEAAAAFAAAAX0VOVgABAAAAAQAQAAAAQG9iZnVzY2F0ZWQubHVhAAoAAAABAAAAAQAAAAEAAAACAAAACAAAAAIAAAAJAAAADgAAAAkAAAAOAAAAAAAAAAEAAAAFAAAAX0VOVgA="), nil, "bt", _ENV))() ScriptStatus("WJMKPIQQORK") 

local SAFE = 7
------------------------------ OnLoad ------------------------------
function OnLoad() -- On Load	
	Helper = scriptConfig("Helper", "Helper")
	Helper:addParam("AutoPotions", "Auto Potions", SCRIPT_PARAM_ONOFF, true)
	Helper:addParam("KS", "Kill Secure", SCRIPT_PARAM_ONOFF, true)
	Helper:addParam("Harass", "Harass", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey("M"))
	Helper:addParam("DrawRange", "Draw Range", SCRIPT_PARAM_ONOFF, true)
	Helper:addParam("DrawTargets", "Draw Targets", SCRIPT_PARAM_ONOFF, true)
	Helper:addParam("Debug", "Debug", SCRIPT_PARAM_ONOFF, false)
	Helper:addParam("SafeMode", "Safe Mode", SCRIPT_PARAM_ONOFF, true)
	
	PrintChat("Helper loaded.")
end
------------------------------ OnTick Callback ------------------------------
function OnTick()
	if not myHero.dead and GetTickCount() % SAFE == 0 and Helper.AutoPotions then
		Drink() -- Auto Potions
	end
	if not myHero.dead and Helper.KS and (Helper.SafeMode == false or GetTickCount() % SAFE == 0) then
		Kill(SelectTarget(MaxRange())) -- Auto Combo
	end
	if not myHero.dead and Helper.Harass and (Helper.SafeMode == false or GetTickCount() % SAFE == 0) then
		Harass() -- Harass
	end
end
------------------------------ OnDraw Callback ------------------------------
function OnDraw()
	if Helper.DrawRange and not myHero.dead then
		DrawCircle3D(myHero.x, myHero.y, myHero.z, MaxRange(), 1, ARGB(255, 0, 255, 0))
	end
	
	if Helper.DrawTargets then
		for i=1, heroManager.iCount do
			local temp = heroManager:getHero(i)
			if not temp.dead and myHero.team ~= temp.team and temp.visible and ValidTarget(temp) and OneCombo(temp) ~= nil then
				if temp.health < OneCombo(temp)*1 then -- 3
					DrawCircle3D(temp.x, temp.y, temp.z, 50, 6, ARGB(155,255,0,0), 16)
				end
				if temp.health < OneCombo(temp)*2 then -- 2
					DrawCircle3D(temp.x, temp.y, temp.z, 30, 6, ARGB(155,255,0,0), 16)
				end
				if temp.health < OneCombo(temp)*3 then -- 1
					DrawCircle3D(temp.x, temp.y, temp.z, 10, 6, ARGB(155,255,0,0), 16)
				end
			end
		end
	end
end
------------------------------ Drink ------------------------------
function Drink() -- Auto Potions
	-- Crystalline Flash
	if GetInventoryHaveItem(2041, GetMyHero()) then
		-- Conditions
		if myHero:CanUseSpell(GetInventorySlotItem(2041)) == READY and (myHero.health / myHero.maxHealth < myHero:getItem(GetInventorySlotItem(2041)).stacks / 4 or myHero.mana / myHero.maxMana < myHero:getItem(GetInventorySlotItem(2041)).stacks / 4) and (myHero.maxHealth - myHero.health > 120 and myHero.maxMana - myHero.mana > 60) or (myHero.mana < 100 or myHero.health < 100) then
			-- Cast
			CastSpell(GetInventorySlotItem(2041))
			if Helper.Debug then PrintChat("Crystalline Flask") end
		end
	end
	-- Health Potions
	if GetInventoryHaveItem(2003, GetMyHero()) then
		-- Conditions
		if myHero:CanUseSpell(GetInventorySlotItem(2003)) == READY and myHero.health / myHero.maxHealth < myHero:getItem(GetInventorySlotItem(2003)).stacks / 6 and myHero.maxHealth - myHero.health > 150 then
			-- Cast
			CastSpell(GetInventorySlotItem(2003))
			if Helper.Debug then PrintChat("Health Potion") end
		end
	end
	-- Mana Potions
	if GetInventoryHaveItem(2004, GetMyHero()) then
		-- Conditions
		if myHero:CanUseSpell(GetInventorySlotItem(2004)) == READY and myHero.mana / myHero.maxMana < myHero:getItem(GetInventorySlotItem(2004)).stacks / 6 and myHero.maxMana - myHero.mana > 100 or myHero.mana < 100 then
			-- Cast
			CastSpell(GetInventorySlotItem(2004))
			if Helper.Debug then PrintChat("Mana Potion") end
		end
	end
end
------------------------------ Select Lowest Target in Range ------------------------------
function SelectTarget(Range)
	local target = nil
	for i=1, heroManager.iCount do
		local temp = heroManager:getHero(i)
		if not temp.dead and temp.health > 1 and myHero.team ~= temp.team and temp.visible and ValidTarget(temp) and myHero:GetDistance(temp) < Range then
			if target == nil then
				target = temp
			elseif (temp.health < target.health) then
				target = temp
			end
		end
	end
	return target
end
------------------------------ Maximum Range for Kill Secure ------------------------------
function MaxRange()
	local RANGE = 0
	
	if myHero.canAttack then RANGE = math.max(RANGE, myHero.range) end
	if myHero.CanAttack then RANGE = math.max(RANGE, Range("P")) end

	if myHero:CanUseSpell(SPELL_1) == READY
		then RANGE = math.max(RANGE, Range("Q")) end
	
	if myHero:CanUseSpell(SPELL_2) == READY
		and myHero.charName ~= "Akali"
		and myHero.charName ~= "Kalista"
		and myHero.charName ~= "MasterYi"
		then RANGE = math.max(RANGE, Range("W")) end
	
	if myHero:CanUseSpell(SPELL_3) == READY
		and myHero.charName ~= "Ashe"
		and myHero.charName ~= "Sivir"
		then RANGE = math.max(RANGE, Range("E")) end
	
	if myHero:CanUseSpell(SPELL_4) == READY
		and myHero.charName ~= "Ashe"
		and myHero.charName ~= "Caitlyn"
		and myHero.charName ~= "Draven"
		and myHero.charName ~= "Ezreal"
		and myHero.charName ~= "Gangplank"
		and myHero.charName ~= "Jinx"
		and myHero.charName ~= "Karthus"
		and myHero.charName ~= "KogMaw"
		and myHero.charName ~= "Lucian"
		and myHero.charName ~= "Lux"
		and myHero.charName ~= "Nami"
		and myHero.charName ~= "Pantheon"
		and myHero.charName ~= "Sivir"
		then RANGE = math.max(RANGE, Range("R")) end
	
	return RANGE
end
------------------------------ Range Library ------------------------------
function Range(Spell) -- Yes, it is incomplete. I don't even use some of these values.
	
	-- When BoL's bugs are fixed, which is never.
	local test
	if Spell == "Q" then test = myHero:GetSpellData(SPELL_1).range
	elseif Spell == "W" then test = myHero:GetSpellData(SPELL_2).range
	elseif Spell == "E" then test = myHero:GetSpellData(SPELL_3).range
	elseif Spell == "R" then test = myHero:GetSpellData(SPELL_4).range
	end
	if test ~= nil and test ~= 0 and test <= 1200 then return test end

	-- Backup Library
	if myHero.charName == nil then return 0
	-- Aatrox
	elseif myHero.charName == "Aatrox" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 650 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 1000 end
		if Spell == "R" then return 550 end
	-- Ahri
	elseif myHero.charName == "Ahri" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 880 end
		if Spell == "W" then return 550 end
		if Spell == "E" then return 975 end
		if Spell == "R" then return 450 end
	-- Akali
	elseif myHero.charName == "Akali" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 700 end
		if Spell == "E" then return 325 end
		if Spell == "R" then return 700 end
	-- Alistar
	elseif myHero.charName == "Alistar" then
		if Spell == "P" then return 300 end
		if Spell == "Q" then return 365 end
		if Spell == "W" then return 650 end
		if Spell == "E" then return 575 end
		if Spell == "R" then return 0 end
	-- Amumu
	elseif myHero.charName == "Amumu" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 1100 end
		if Spell == "W" then return 300 end
		if Spell == "E" then return 350 end
		if Spell == "R" then return 550 end
	-- Anivia
	elseif myHero.charName == "Anivia" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1100 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 650 end
		if Spell == "R" then return 615 end
	-- Annie
	elseif myHero.charName == "Annie" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 625 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 625 end
		if Spell == "R" then return 600 end
	-- Ashe
	elseif myHero.charName == "Ashe" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 1200 end
		if Spell == "E" then return 1000 end
		if Spell == "R" then return 0 end
	-- Azir
	elseif myHero.charName == "Azir" then
		if Spell == "P" then return 400 end
		if Spell == "Q" then return 875 end
		if Spell == "W" then return 450 end
		if Spell == "E" then return 0 end
		if Spell == "R" then return 250 end
	-- Blitzcrank
	elseif myHero.charName == "Blitzcrank" then
		if Spell == "P" then return 450 end
		if Spell == "Q" then return 925 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return myHero.range end
		if Spell == "R" then return 600 end
	-- Brand
	elseif myHero.charName == "Brand" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 900 end
		if Spell == "W" then return 900 end
		if Spell == "E" then return 625 end
		if Spell == "R" then return 750 end
	-- Braum
	elseif myHero.charName == "Braum" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1000 end
		if Spell == "W" then return 625 end
		if Spell == "E" then return 0 end
		if Spell == "R" then return 1250 end
	-- Caitlyn
	elseif myHero.charName == "Caitlyn" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 1300 end
		if Spell == "W" then return 800 end
		if Spell == "E" then return 950 end
		if Spell == "R" then return 1500 + 500 * myHero:GetSpellData(SPELL_4).level end
	-- Cassiopeia
	elseif myHero.charName == "Cassiopeia" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 850 end
		if Spell == "W" then return 850 end
		if Spell == "E" then return 700 end
		if Spell == "R" then return 825 end
	-- Cho'Gath
	elseif myHero.charName == "ChoGath" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 950 end
		if Spell == "W" then return 700 end
		if Spell == "E" then return 500 end
		if Spell == "R" then return 175 end
	-- Corki
	elseif myHero.charName == "Corki" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 825 end
		if Spell == "W" then return 800 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 1225 end
	-- Darius
	elseif myHero.charName == "Darius" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 425 end
		if Spell == "W" then return 145 end
		if Spell == "E" then return 550 end
		if Spell == "R" then return 460 end
	-- Diana
	elseif myHero.charName == "Diana" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 830 end
		if Spell == "W" then return 200 end
		if Spell == "E" then return 350 end
		if Spell == "R" then return 825 end
	-- Dr. Mundo
	elseif myHero.charName == "DrMundo" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1000 end
		if Spell == "W" then return 162.5 end
		if Spell == "E" then return myHero.range end
		if Spell == "R" then return 0 end
	-- Draven
	elseif myHero.charName == "Draven" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 1050 end
		if Spell == "R" then return 0 end
	-- Elise
	-- Evelynn
	elseif myHero.charName == "Evelynn" then
		if Spell == "P" then return 700 end
		if Spell == "Q" then return 500 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 225 end
		if Spell == "R" then return 650 end
	-- Ezreal
	elseif myHero.charName == "Ezreal" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1150 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 475 end
		if Spell == "R" then return 0 end
	-- Fiddlesticks
	elseif myHero.charName == "Fiddlesticks" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 575 end
		if Spell == "W" then return 575 end
		if Spell == "E" then return 750 end
		if Spell == "R" then return 800 end
	-- Fiora
	elseif myHero.charName == "Fiora" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 0 end
		if Spell == "R" then return 400 end
	-- Fizz
	elseif myHero.charName == "Fizz" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 550 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 400 end
		if Spell == "R" then return 1275 end
	-- Galio
	elseif myHero.charName == "Galio" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 940 end
		if Spell == "W" then return 800 end
		if Spell == "E" then return 1180 end
		if Spell == "R" then return 600 end
	-- Gangplank
	elseif myHero.charName == "Gangplank" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 625 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 1300 end
		if Spell == "R" then return 1900 end
	-- Garen
	elseif myHero.charName == "Garen" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 165 end
		if Spell == "R" then return 400 end
	-- Gnar
	elseif myHero.charName == "Gnar" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1100 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 475 end
		if Spell == "R" then return 590 end
	-- Gragas
	elseif myHero.charName == "Gragas" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 850 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 1150 end
	-- Graves
	elseif myHero.charName == "Graves" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 950 end
		if Spell == "W" then return 950 end
		if Spell == "E" then return 425 end
		if Spell == "R" then return 1000 end
	-- Hecarim
	elseif myHero.charName == "Hecarim" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 350 end
		if Spell == "W" then return 525 end
		if Spell == "E" then return (myHero.range + 150) end
		if Spell == "R" then return 1000 end
	-- Heimerdinger
	elseif myHero.charName == "Heimerdinger" then
		if Spell == "P" then return 1000 end
		if Spell == "Q" then return 450 end
		if Spell == "W" then return 1100 end
		if Spell == "E" then return 925 end
		if Spell == "R" then return 0 end
	-- Irelia
	elseif myHero.charName == "Irelia" then
		if Spell == "P" then return 1200 end
		if Spell == "Q" then return 650 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 425 end
		if Spell == "R" then return 1000 end
	-- Janna
	elseif myHero.charName == "Janna" then
		if Spell == "P" then return 1250 end
		if Spell == "Q" then return ((1100 + 1700) / 2) end
		if Spell == "W" then return 600 end
		if Spell == "E" then return 800 end
		if Spell == "R" then return 725 end
	-- JarvanIV
	elseif myHero.charName == "JarvanIV" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 770 end
		if Spell == "W" then return 300 end
		if Spell == "E" then return 830 end
		if Spell == "R" then return 650 end
	-- Jax
	elseif myHero.charName == "Jax" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 700 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 187.5 end
		if Spell == "R" then return 0 end
	-- Jayce
	-- Jinx
	elseif myHero.charName == "Jinx" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 1500 end
		if Spell == "E" then return 900 end
		if Spell == "R" then return 0 end
	-- Kalista : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Kalista" then
		if Spell == "P" then return 0 end		-- Unknown
		if Spell == "Q" then return 1200 end
		if Spell == "W" then return 5000 end
		if Spell == "E" then return 0 end		-- Unknown
		if Spell == "R" then return 1200 end
	-- Karma
	elseif myHero.charName == "Karma" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 950 end
		if Spell == "W" and myHero:CanUseSpell(SPELL_2) == READY then return 675 end
		if Spell == "W" and myHero:CanUseSpell(SPELL_2) == COOLDOWN then return 1000 end
		if Spell == "E" then return 800 end
		if Spell == "R" then return 0 end
	-- Karthus
	elseif myHero.charName == "Karthus" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 875 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 475 end
		if Spell == "R" then return 0 end
	-- Kassadin
	elseif myHero.charName == "Kassadin" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 650 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 700 end
		if Spell == "R" then return 450 end
	-- Katarina
	elseif myHero.charName == "Katarina" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 675 end
		if Spell == "W" then return 375 end
		if Spell == "E" then return 700 end
		if Spell == "R" then return 550 end
	-- Kayle
	elseif myHero.charName == "Kayle" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 650 end
		if Spell == "W" then return 900 end
		if Spell == "E" then return myHero.range end
		if Spell == "R" then return 900 end
	-- Kennen
	elseif myHero.charName == "Kennen" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1050 end
		if Spell == "W" then return 800 end
		if Spell == "E" then return 0 end
		if Spell == "R" then return 550 end
	-- Kha'Zix
	elseif myHero.charName == "KhaZix" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 325 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 0 end
	-- Kog'Maw : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "KogMaw" then
		if Spell == "P" then return 0 end -- Unknown
		if Spell == "Q" then return 1000 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 1280 end
		if Spell == "R" then return 1200 end
	-- LeBlanc
	elseif myHero.charName == "LeBlanc" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 700 end
		if Spell == "W" then return 600 end
		if Spell == "E" and myHero:CanUseSpell(SPELL_3) == READY then return 1000 end
		if Spell == "E" and myHero:CanUseSpell(SPELL_3) == COOLDOWN then return 950 end
		if Spell == "R" then return 0 end
	-- Lee Sin
	elseif myHero.charName == "LeeSin" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 1100 end
		if Spell == "W" then return 700 end
		if Spell == "E" then return 350 end
		if Spell == "R" then return 375 end
	-- Leona
	elseif myHero.charName == "Leona" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 275 end
		if Spell == "E" then return 875 end
		if Spell == "R" then return 1200 end
	-- Lissandra
	elseif myHero.charName == "Lissandra" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 725 end
		if Spell == "W" then return 450 end
		if Spell == "E" then return 1050 end
		if Spell == "R" then return 550 end
	-- Lucian
	elseif myHero.charName == "Lucian" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 500 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 425 end
		if Spell == "R" then return 1400 end
	-- Lulu
	elseif myHero.charName == "Leona" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 925 end
		if Spell == "W" then return 650 end
		if Spell == "E" then return 650 end
		if Spell == "R" then return 900 end
	-- Lux
	elseif myHero.charName == "Lux" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1175 end
		if Spell == "W" then return 1075 end
		if Spell == "E" then return 1100 end
		if Spell == "R" then return 3340 end
	-- Malphite
	elseif myHero.charName == "Malphite" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 625 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 200 end
		if Spell == "R" then return 1000 end
	-- Malzahar
	elseif myHero.charName == "Malzahar" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 900 end
		if Spell == "W" then return 800 end
		if Spell == "E" then return 650 end
		if Spell == "R" then return 700 end
	-- Maokai : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Maokai" then
		if Spell == "P" then return 0 end	-- Estimated
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 525 end
		if Spell == "E" then return 1100 end
		if Spell == "R" then return 475 end
	-- Master Yi
	elseif myHero.charName == "MasterYi" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return myHero.range end
		if Spell == "R" then return 0 end
	-- Miss Fortune
	elseif myHero.charName == "MissFortune" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 650 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 800 end
		if Spell == "R" then return 1400 end
	-- Mordekaiser
	elseif myHero.charName == "Mordekaiser" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 250 end
		if Spell == "E" then return 700 end
		if Spell == "R" then return 850 end
	-- Morgana
	elseif myHero.charName == "Morgana" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 1175 end
		if Spell == "W" then return 900 end
		if Spell == "E" then return 750 end
		if Spell == "R" and myHero:CanUseSpell(SPELL_4) == READY then return 600 end
		if Spell == "R" and myHero:CanUseSpell(SPELL_4) == COOLDOWN then return 1050 end
	-- Nami
	elseif myHero.charName == "Nami" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 875 end
		if Spell == "W" then return 725 end
		if Spell == "E" then return 800 end
		if Spell == "R" then return 2750 end
	-- Nasus
	elseif myHero.charName == "Nasus" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 600 end
		if Spell == "E" then return 650 end
		if Spell == "R" then return 850 end
	-- Nautilus
	elseif myHero.charName == "Nautilus" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 1100 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 825 end
	-- Nidalee
	-- Nocturne
	elseif myHero.charName == "Nocturne" then
		if Spell == "P" then return myHero.range end	-- Estimated
		if Spell == "Q" then return 1200 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 425 end
		if Spell == "R" then return 1250 + 750 * myHero:GetSpellData(SPELL_4).level end
	-- Nunu
	elseif myHero.charName == "Nunu" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 125 end
		if Spell == "W" then return 700 end
		if Spell == "E" then return 550 end
		if Spell == "R" then return 650 end
	-- Olaf
	elseif myHero.charName == "Olaf" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 1000 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 325 end
		if Spell == "R" then return 0 end
	-- Orianna
	elseif myHero.charName == "Orianna" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 825 end
		if Spell == "W" then return 250 end
		if Spell == "E" then return 1100 end
		if Spell == "R" then return 400 end
	-- Pantheon
	elseif myHero.charName == "Pantheon" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 600 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 5500 end
	-- Poppy
	elseif myHero.charName == "Poppy" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 525 end
		if Spell == "R" then return 900 end
	-- Quinn
	-- Rammus : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Rammus" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 200 end -- Estimated
		if Spell == "W" then return 0 end
		if Spell == "E" then return 325 end
		if Spell == "R" then return 300 end
	-- Rek'Sai : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	-- Renekton : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Renekton" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 225 end -- Estimated
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 450 end
		if Spell == "R" then return 175 end
	-- Rengar
	elseif myHero.charName == "Rengar" then
		if Spell == "P" then return 0 end	-- Unknown but idc
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 500 end
		if Spell == "E" then return 1000 end
		if Spell == "R" then return 1250 end
	-- Riven
	elseif myHero.charName == "Riven" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 260 end
		if Spell == "W" then return 125 end
		if Spell == "E" then return 325 end
		if Spell == "R" then return 900 end
	-- Rumble
	elseif myHero.charName == "Rumble" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 850 end
		if Spell == "R" then return 1700 end
	-- Ryze
	elseif myHero.charName == "Ryze" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 900 end
		if Spell == "W" then return 600 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 200 end
	-- Sejuani
	elseif myHero.charName == "Sejuani" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 650 end
		if Spell == "W" then return 350 end
		if Spell == "E" then return 1000 end
		if Spell == "R" then return 1175 end
	-- Shaco
	elseif myHero.charName == "Shaco" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 400 end
		if Spell == "W" then return 425 end
		if Spell == "E" then return 625 end
		if Spell == "R" then return 0 end
	-- Shen
	elseif myHero.charName == "Shen" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 475 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 600 end
		if Spell == "R" then return 0 end
	-- Shyvana
	elseif myHero.charName == "Shyvana" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 162.5 end
		if Spell == "E" then return 925 end
		if Spell == "R" then return 1000 end
	-- Singed
	elseif myHero.charName == "Singed" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 0 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 125 end
		if Spell == "R" then return 0 end
	-- Sion : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Sion" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 550 end
		if Spell == "E" then return 1500 end -- Estimated
		if Spell == "R" then return 0 end -- I need the collision box of this spell.
	-- Sivir
	elseif myHero.charName == "Sivir" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 1250 end
		if Spell == "W" then return myHero.range end
		if Spell == "E" then return 0 end
		if Spell == "R" then return 1000 end
	-- Skarner
	elseif myHero.charName == "Skarner" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 350 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 1000 end
		if Spell == "R" then return 350 end
	-- Sona
	elseif myHero.charName == "Sona" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 850 end
		if Spell == "W" then return 1000 end
		if Spell == "E" then return 350 end
		if Spell == "R" then return 1000 end
	-- Soraka
	elseif myHero.charName == "Soraka" then
		if Spell == "P" then return 2500 end
		if Spell == "Q" then return 970 end
		if Spell == "W" then return 550 end
		if Spell == "E" then return 925 end
		if Spell == "R" then return 0 end
	-- Swain : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Swain" then
		if Spell == "P" then return 0 end -- Gay
		if Spell == "Q" then return 625 end
		if Spell == "W" then return 900 end
		if Spell == "E" then return 625 end
		if Spell == "R" then return 700 end -- Estimated
	-- Syndra : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Syndra" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 800 end
		if Spell == "W" then return 925 end -- TODO : Passive
		if Spell == "E" then return 700 end
		if Spell == "675" then return 0 end -- TODO : Passive
	-- Talon
	elseif myHero.charName == "Talon" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 600 end
		if Spell == "E" then return 700 end
		if Spell == "R" then return 500 end
	-- Taric
	elseif myHero.charName == "Taric" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 750 end
		if Spell == "W" then return 200 end
		if Spell == "E" then return 626 end
		if Spell == "R" and myHero:CanUseSpell(SPELL_4) == READY then return 200 end
		if Spell == "R" and myHero:CanUseSpell(SPELL_4) == COOLDOWN then return 500 end
	-- Teemo
	elseif myHero.charName == "Teemo" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 580 end
		if Spell == "W" then return 0 end
		if Spell == "E" then return 0 end
		if Spell == "R" then return 230 end
	-- Thresh
	-- Tristana
	-- Trundle
	-- Tryndamere
	-- Twisted Fate
	-- Twitch
	-- Udyr
	-- Urgot
	-- Varus
	-- Vayne
	-- Veigar
	-- Vel'Koz
	-- Vi
	-- Viktor
	-- Vladimir
	elseif myHero.charName == "Vladimir" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 600 end
		if Spell == "W" then return 150 end
		if Spell == "E" then return 610 end
		if Spell == "R" then return 700 end
	-- Volibear
	elseif myHero.charName == "Volibear" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return myHero.range end
		if Spell == "W" then return 400 end
		if Spell == "E" then return 425 end
		if Spell == "R" then return 300 end
	-- Warwick
	elseif myHero.charName == "Warwick" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 400 end
		if Spell == "W" then return 1250 end
		if Spell == "E" then return 700 + 800 * myHero:GetSpellData(SPELL_3).level end
		if Spell == "R" then return 700 end
	-- Wukong : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "MonkeyKing" then
		if Spell == "P" then return 1200 end	-- Estimated
		if Spell == "Q" then return 300 end
		if Spell == "W" then return 175 end
		if Spell == "E" then return 625 end
		if Spell == "R" then return 162.5 end
	-- Xerath
	elseif myHero.charName == "Xerath" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 750 end
		if Spell == "W" then return 1100 end
		if Spell == "E" then return 1050 end
		if Spell == "R" then return 2000 + 1200 * myHero:GetSpellData(SPELL_4).level end
	-- Xin Zhao
	-- Yasuo
	elseif myHero.charName == "Yasuo" then
		if Spell == "P" then return 0 end
		if Spell == "Q" and myHero:CanUseSpell(SPELL_3) == COOLDOWN then return 375
		else return 475 end
		if Spell == "W" then return 400 end
		if Spell == "E" then return 475 end
		if Spell == "R" then return 1200 end
	-- Yorick
	-- Zac : If someone has Riot Decode, please write the values in the League of Legends Wiki.
	elseif myHero.charName == "Zac" then
		if Spell == "P" then return 0 end
		if Spell == "Q" then return 550 end
		if Spell == "W" then return 350 end
		if Spell == "E" then return 300 end -- Unknown
		if Spell == "R" then return 400 end -- Unknown
	-- Zed
	elseif myHero.charName == "Zed" then
		if Spell == "P" then return myHero.range end
		if Spell == "Q" then return 900 end
		if Spell == "W" then return 550 end
		if Spell == "E" then return 290 end
		if Spell == "R" then return 625 end
	-- Ziggs
	-- Zilean
	-- Zyra
	end
	return 0
end
------------------------------ Critical Strike ------------------------------
function CanCrit(damage)
	return (damage * myHero.critChance * myHero.critDmg)
end
------------------------------ On Hit Effects ------------------------------
function OnHit(target)
	local DAMAGE = 0
	if GetInventoryHaveItem(3153, GetMyHero()) then DAMAGE = DAMAGE + getDmg("RUINEDKING", target, myHero, 1) end
	if GetInventoryHaveItem(3115, GetMyHero()) then DAMAGE = DAMAGE + getDmg("NTOOTH", target, myHero) end
	if GetInventoryHaveItem(3078, GetMyHero()) then DAMAGE = DAMAGE + getDmg("TRINITY", target, myHero) end
	if GetInventoryHaveItem(3091, GetMyHero()) then DAMAGE = DAMAGE + getDmg("WITSEND", target, myHero) end
	if GetInventoryHaveItem(3025, GetMyHero()) then DAMAGE = DAMAGE + getDmg("ICEBORN", target, myHero) end
	if GetInventoryHaveItem(3100, GetMyHero()) then DAMAGE = DAMAGE + getDmg("LICHBANE", target, myHero) end
	if GetInventoryHaveItem(3057, GetMyHero()) then DAMAGE = DAMAGE + getDmg("SHEEN", target, myHero) end
	if GetInventoryHaveItem(3087, GetMyHero()) then DAMAGE = DAMAGE + getDmg("STATIKK", target, myHero) end
	return DAMAGE
end
------------------------------ OneCombo ------------------------------
function OneCombo(target)
	local DAMAGE = 0
	
	-- Items
	if GetInventoryHaveItem(3077, GetMyHero()) then 
		if myHero:CanUseSpell(GetInventorySlotItem(3077)) == READY then DAMAGE = DAMAGE + getDmg("TIAMAT", target, myHero) end
	end
	if GetInventoryHaveItem(3074, GetMyHero()) then
		if myHero:CanUseSpell(GetInventorySlotItem(3074)) == READY then DAMAGE = DAMAGE + getDmg("HYDRA", target, myHero) end
	end
	
	-- Champion
	if myHero.charName == nil then
		return 0
		
	elseif myHero.charName == "Akali" then -- QER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 3)
		else DAMAGE = DAMAGE + getDmg("Q", target, myHero, 1) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Annie" then -- QW
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Ashe" then -- W
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Brand" then -- E
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Darius" then -- QWER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 3) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + (getDmg("AD", target, myHero) + OnHit(target) + getDmg("W", target, myHero)) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Fizz" then -- QW
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) + OnHit(target) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero, 1) + etDmg("W", target, myHero, 2) + etDmg("W", target, myHero, 3) end
		return DAMAGE
		
	elseif myHero.charName == "Gangplank" then -- QR
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) + getDmg("P", target, myHero) + OnHit(target) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) * 7 end
		return DAMAGE
		
	elseif myHero.charName == "Garen" then -- R
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Katarina" then -- QWER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 3)
		else DAMAGE = DAMAGE + getDmg("Q", target, myHero, 2) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Kayle" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Lissandra" then -- QW
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		return DAMAGE
	
	elseif myHero.charName == "Malzahar" then -- QWER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
	
	elseif myHero.charName == "MasterYi" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "MissFortune" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 1) + OnHit(target) end
		return DAMAGE

	elseif myHero.charName == "Mordekaiser" then -- QER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 3) + OnHit(target) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE		
	
	elseif myHero.charName == "Pantheon" then -- QWE
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Sivir" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		return DAMAGE

	elseif myHero.charName == "Swain" then -- QWER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 3) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero, 3) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero) end
		return DAMAGE
	
	elseif myHero.charName == "Talon" then -- QWER
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero, 3) end
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero, 3) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("R", target, myHero, 3) end
		return DAMAGE
	
	elseif myHero.charName == "Teemo" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Vladimir" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		if myHero:CanUseSpell(SPELL_4) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Volibear" then -- W
		if myHero:CanUseSpell(SPELL_2) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Warwick" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "MonkeyKing" then -- QE
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) + getDmg("AD", target, myHero) + OnHit(target) end
		if myHero:CanUseSpell(SPELL_3) == READY then DAMAGE = DAMAGE + getDmg("E", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Xerath" then -- W
		if myHero:CanUseSpell(SPELL_W) == READY then DAMAGE = DAMAGE + getDmg("W", target, myHero) end
		return DAMAGE
		
	elseif myHero.charName == "Yasuo" then -- Q
		if myHero:CanUseSpell(SPELL_1) == READY then DAMAGE = DAMAGE + getDmg("Q", target, myHero) + OnHit(target) end
		return DAMAGE
		
	end
end
------------------------------ Harass ------------------------------
function Harass() -- For Manaless Champions

	if myHero.isStealthed then return end

	-- Items
	-- Tiamat
	if GetInventoryHaveItem(3077, GetMyHero()) and SelectTarget(myHero.range * 2) ~= nil then
		if myHero:CanUseSpell(GetInventorySlotItem(3077)) == READY then
			CastSpell(GetInventorySlotItem(3077))
			if Helper.Debug then PrintChat("Tiamat") end
		end
	end
	-- Ravenous Hydra
	if GetInventoryHaveItem(3074, GetMyHero()) and SelectTarget(myHero.range * 2) ~= nil then
		if myHero:CanUseSpell(GetInventorySlotItem(3074)) == READY then
			CastSpell(GetInventorySlotItem(3074))
			if Helper.Debug then PrintChat("Ravenous Hydra") end
		end
	end
	-- Bilgewater Cutlass
	if GetInventoryHaveItem(3144, GetMyHero()) and SelectTarget(450) ~= nil then
		if myHero:CanUseSpell(GetInventorySlotItem(3144)) == READY then
			CastSpell(GetInventorySlotItem(3144), SelectTarget(450))
			if Helper.Debug then PrintChat("Bilgewater Cutlass") end
		end
	end
	-- Hextech Gunblade
	if GetInventoryHaveItem(3146, GetMyHero()) and SelectTarget(700) ~= nil then
		if myHero:CanUseSpell(GetInventorySlotItem(3146)) == READY then
			CastSpell(GetInventorySlotItem(3146), SelectTarget(700))
			if Helper.Debug then PrintChat("Hextech Gunblade") end
		end
	end
	-- Blade of the Ruined King
	if GetInventoryHaveItem(3153, GetMyHero()) and SelectTarget(450) ~= nil then
		if myHero:CanUseSpell(GetInventorySlotItem(3153)) == READY then
			CastSpell(GetInventorySlotItem(3153), SelectTarget(450))
			if Helper.Debug then PrintChat("Blade of the Ruined King") end
		end
	end
	
	-- Champions
	if myHero.charName == nil then
	-- Ahri
	elseif myHero.charName == "Ahri" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2)
			if Helper.Debug then PrintChat("Fox-Fire") end
		end
	-- Akali
	elseif myHero.charName == "Akali" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Mark of the Assassin") end
		elseif myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3)
			if Helper.Debug then PrintChat("Crescent Slash") end
		end
	-- Diana
	elseif myHero.charName == "Diana" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2)
			if Helper.Debug then PrintChat("Pale Cascade") end
		elseif myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil and myHero:CanUseSpell(SPELL_4) == COOLDOWN then
			CastSpell(SPELL_3)
			if Helper.Debug then PrintChat("Moonfall") end
		end
	-- Gangplank
	elseif myHero.charName == "Gangplank" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Parrrley") end
		end
	-- Hecarim
	elseif myHero.charName == "Hecarim" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1)
			if Helper.Debug then PrintChat("Rampage") end
		end
	-- Katarina
	elseif myHero.charName == "Katarina" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Bouncing Blade") end
		elseif myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2)
			if Helper.Debug then PrintChat("Sinister Steel") end
		end
	-- Kha'Zix
	elseif myHero.charName == "KhaZix" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Taste Their Fear") end
		end
	-- Lissandra
	elseif myHero.charName == "Lissandra" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")).x, SelectTarget(Range("Q")).z)
			if Helper.Debug then PrintChat("Ice Shard") end
		end
	-- Maokai
	elseif myHero.charName == "Maokai" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(100) ~= nil then
			CastSpell(SPELL_1, SelectTarget(100).x, SelectTarget(100).z)
			if Helper.Debug then PrintChat("Arcane Smash") end
		end
	-- Master Yi
	elseif myHero.charName == "MasterYi" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Alpha Strike") end
		elseif myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3)
			if Helper.Debug then PrintChat("Wuju Style") end
		elseif myHero.canAttack and SelectTarget(Range("Q")) ~= nil and GetTickCount() % SAFE == 0 then
			myHero:Attack(SelectTarget(Range("Q")))
		end
	-- Mordekaiser
	elseif myHero.charName == "Mordekaiser" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1)
			if Helper.Debug then PrintChat("Mace of Spades") end
		elseif myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2, myHero)
			if Helper.Debug then PrintChat("Creeping Death") end
		elseif myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3, SelectTarget(Range("E")).x, SelectTarget(Range("E")).z)
			if Helper.Debug then PrintChat("Siphon of Destruction") end
		end
	-- Rengar
	elseif myHero.charName == "Rengar" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2)
			if Helper.Debug then PrintChat("Battle Roar") end
		end
	-- Riven
	elseif myHero.charName == "Riven" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2, SelectTarget(Range("W")))
			if Helper.Debug then PrintChat("Ki Burst") end
		end
	-- Ryze
	elseif myHero.charName == "Ryze" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2, SelectTarget(Range("W")))
			if Helper.Debug then PrintChat("Rune Prison") end
		elseif myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3, SelectTarget(Range("E")))
			if Helper.Debug then PrintChat("Spell Flux") end
		end
	-- Shen
	elseif myHero.charName == "Shen" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Vorpal Blade") end
		end
	-- Sivir
	elseif myHero.charName == "Sivir" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil and myHero.mana / myHero.maxMana > myHero.health / myHero.maxHealth then
			CastSpell(SPELL_2)
			if Helper.Debug then PrintChat("Ricochet") end
		end
	-- Skarner
	elseif myHero.charName == "Skarner" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1)
			if Helper.Debug then PrintChat("Crystal Slash") end
		end
	-- Sona
	elseif myHero.charName == "Sona" then
		if myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1)
			myHero:Attack(SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Hymn of Valor") end
		end
	-- Swain
	elseif myHero.charName == "Swain" then
		if myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3, SelectTarget(Range("E")))
			if Helper.Debug then PrintChat("Torment") end
		elseif myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Decrepify") end
		elseif myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil and not myHero:CanUseSpell(SPELL_1) == READY then
			CastSpell(SPELL_2, SelectTarget(Range("W")).x, SelectTarget(Range("W")).z)
			if Helper.Debug then PrintChat("Nevermove") end
		end
	-- Talon
	elseif myHero.charName == "Talon" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2, SelectTarget(Range("W")).x, SelectTarget(Range("W")).z)
			if Helper.Debug then PrintChat("Rake") end
		elseif myHero:CanUseSpell(SPELL_1) == READY and SelectTarget() ~= nil then
			CastSpell(SPELL_1)
			myHero:Attack(SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Noxian Diplomacy") end
		end
	-- Teemo
	elseif myHero.charName == "Teemo" then
		if myHero:CanUseSpell(SPELL_4) == READY and SelectTarget(Range("R")) ~= nil then
			CastSpell(SPELL_4, SelectTarget(Range("R")).x, SelectTarget(Range("R")).z)
			if Helper.Debug then PrintChat("Noxious Trap") end
		end
	-- Vladimir
	elseif myHero.charName == "Vladimir" then
		if myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3)
			if Helper.Debug then PrintChat("Tides of Blood") end
		elseif myHero:CanUseSpell(SPELL_1) == READY and SelectTarget(Range("Q")) ~= nil then
			CastSpell(SPELL_1, SelectTarget(Range("Q")))
			if Helper.Debug then PrintChat("Transfusion") end
		end
	-- Yasuo
	elseif myHero.charName == "Yasuo" then
		local target = SelectTarget(Range("Q"))
		if myHero:CanUseSpell(SPELL_1) == READY and target ~= nil then
			CastSpell(SPELL_1, target.x, target.z)
			if Helper.Debug then PrintChat("Steel Tempest") end
		end
	-- Zac
	elseif myHero.charName == "Zac" then
		if myHero:CanUseSpell(SPELL_2) == READY and SelectTarget(Range("W")) ~= nil then
			CastSpell(SPELL_2)
			if Helper.Debug then PrintChat("Unstable Matter") end
		end
	-- Zed
	elseif myHero.charName == "Zed" then
		if myHero:CanUseSpell(SPELL_3) == READY and SelectTarget(Range("E")) ~= nil then
			CastSpell(SPELL_3)
			if Helper.Debug then PrintChat("Shadow Slash") end
		end
	end
end
------------------------------ Kill ------------------------------
function Kill(target)
	if target ~= nil and OneCombo(target) ~= nil then
		
		if myHero.charName == nil then
		-- Akali
		elseif myHero.charName == "Akali" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				myHero:Attack(target)
				if Helper.Debug then PrintChat("Mark of the Assassin") end
			elseif myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3)
				if Helper.Debug then PrintChat("Crescent Slash") end
			elseif myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4, target)
				myHero:Attack(target)
				if Helper.Debug then PrintChat("Shadow Dance") end
			end
		-- Annie
		elseif myHero.charName == "Annie" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2, target.x, target.z)
				if Helper.Debug then PrintChat("Incinerate") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Disintegrate") end
			elseif myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4, target.x, target.z)
				if Helper.Debug then PrintChat("Tibbers") end
			end
		-- Ashe
		elseif myHero.charName == "Ashe" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2, target.x, target.z)
				if Helper.Debug then PrintChat("Volley") end
			end
		-- Brand
		elseif myHero.charName == "Brand" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Conflagration") end
			end
		-- Darius
		elseif myHero.charName == "Darius" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1)
				if Helper.Debug then PrintChat("Decimate") end
			elseif myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target.x, target.z)
				if Helper.Debug then PrintChat("Apprehend") end
			elseif myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2)
				myHero:Attack(target)
				if Helper.Debug then PrintChat("Crippling Strike") end
			elseif myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4)
				if Helper.Debug then PrintChat("Noxian Guillotine") end
			end
		--Fizz
		elseif myHero.charName == "Fizz" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_2)
				if Helper.Debug then PrintChat("Seastone Trident") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Urchin Strike") end
			end
		-- Gangplank
		elseif myHero.charName == "Gangplank" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Parrrley") end
			elseif myHero:CanUseSpell(SPELL_4) == READY then
				CastSpell(SPELL_4, target.x, target.z)
				if Helper.Debug then PrintChat("Cannon Barrage") end
			end
		-- Garen
		elseif myHero.charName == "Garen" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4, target)
				if Helper.Debug then PrintChat("Demacian Justice") end
			end
		-- Katarina
		elseif myHero.charName == "Katarina" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Bouncing Blade") end
			elseif myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Shunpo") end
			elseif myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2)
				if Helper.Debug then PrintChat("Sinister Steel") end
			elseif myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4)
				if Helper.Debug then PrintChat("Death Lotus") end
			end
		-- Kayle
		elseif myHero.charName == "Kayle" and OneCombo(target) > target.health then
				if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
					CastSpell(SPELL_1, target)
					if Helper.Debug then PrintChat("Reckoning") end
				end
		-- Lissandra
		elseif myHero.charName == "Lissandra" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2)
				if Helper.Debug then PrintChat("Ring of Frost") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target.x, target.z)
				if Helper.Debug then PrintChat("Ice Shard") end
			end
		-- Malzahar
		elseif myHero.charName == "Malzahar" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Malefic Visions") end
			elseif myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2, target.x, target.z)
				if Helper.Debug then PrintChat("Null Zone") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target.x, target.z)
				if Helper.Debug then PrintChat("Call of the Void") end
			elseif myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4, target)
				if Helper.Debug then PrintChat("Nether Grasp") end
			end
		-- Master Yi
		elseif myHero.charName == "MasterYi" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				myHero:Attack(target)
				if Helper.Debug then PrintChat("Alpha Strike") end
			end
		-- Miss Fortune
		elseif myHero.charName == "MissFortune" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Double Up") end
			end
		-- Mordekaiser
		elseif myHero.charName == "Mordekaiser" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4, target)
				if Helper.Debug then PrintChat("Children of the Grave") end
			end
		-- Pantheon
		elseif myHero.charName == "Pantheon" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Spear Shot") end
			elseif myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2, target)
				if Helper.Debug then PrintChat("Aegis of Zeonia") end
			elseif myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Heartseeker Strike") end
			end
		-- Sivir
		elseif myHero.charName == "Sivir" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target.x, target.z)
				if Helper.Debug then PrintChat("Boomerang Blade") end
			end
		-- Swain
		elseif myHero.charName == "Swain" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Torment") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Decrepify") end
			elseif myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") and myHero:CanUseSpell(SPELL_1) == COOLDOWN then
				CastSpell(SPELL_2, target.x, target.z)
				if Helper.Debug then PrintChat("Nevermove") end
			end
		-- Talon
		elseif myHero.charName == "Talon" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Cutthroat") end
			elseif myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4)
				if Helper.Debug then PrintChat("Shadow Assault") end
			elseif myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(target) < Range("W") then
				CastSpell(SPELL_2, target.x, target.z)
				if Helper.Debug then PrintChat("Rake") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1)
				myHero:Attack(target)
				if Helper.Debug then PrintChat("Noxian Diplomacy") end
			end
		-- Teemo
		elseif myHero.charName == "Teemo" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Blinding Dart") end
			end
		-- Vladimir
		elseif myHero.charName == "Vladimir" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(target) < Range("R") then
				CastSpell(SPELL_4, target.x, target.z)
				if Helper.Debug then PrintChat("Hemoplague") end
			elseif myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3)
				if Helper.Debug then PrintChat("Tides of Blood") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1, target)
				if Helper.Debug then PrintChat("Transfusion") end
			end
		-- Volibear
		elseif myHero.charName == "Volibear" and OneCombo(target) > target.health and myHero:CanUseSpell(SPELL_2) == READY then
			CastSpell(SPELL_2, target)
			if Helper.Debug then PrintChat("Frenzy") end
		-- Warwick
		elseif myHero.charName == "Warwick" and OneCombo(target) > target.health and myHero:CanUseSpell(SPELL_1) == READY then
			CastSpell(SPELL_1, target)
			if Helper.Debug then PrintChat("Hungering Strike") end
		-- Wukong
		elseif myHero.charName == "MonkeyKing" and OneCombo(target) > target.health then
			if myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(target) < Range("E") then
				CastSpell(SPELL_3, target)
				if Helper.Debug then PrintChat("Nimbus Strike") end
			elseif myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(target) < Range("Q") then
				CastSpell(SPELL_1)
				myHero:Attack(target)
				if Helper.Debug then PrintChat("Crushing Blow") end
			end
		-- Xerath
		elseif myHero.charName == "Xerath" and OneCombo(target) > target.health and myHero:CanUseSpell(SPELL_2) == READY then
			CastSpell(SPELL_2, target.x, target.z)
			if Helper.Debug then PrintChat("Eye of Destruction") end
		-- Yasuo
		elseif myHero.charName == "Yasuo" and OneCombo(target) > target.health and myHero:CanUseSpell(SPELL_1) == READY then
			CastSpell(SPELL_1, target.x, target.z)
			if Helper.Debug then PrintChat("Steel Tempest") end
		end
	end
end