--[[ Helper
	by Nato Boram
	
	Official Topic Link : 
	Official Download Link : 
]]

local VERSION = "0.0.1"

function OnLoad()
	-- DownloadFile("", SCRIPT_PATH..GetCurrentEnv().FILE_NAME, function() end)
	PrintChat(">> PointBlank "..VERSION.." Loaded")
	SendChat("/l")
end

function OnUnload()
end

---------- On Buff ----------
function OnApplyBuff(source, target, buff)
	if not source or not target or not buff then return end
	-- if source.isMe then PrintChat("+ "..source.charName.." | "..target.charName.." | "..buff.name) end
end

function OnRemoveBuff(unit, buff)
	if not unit or not buff then return end
	-- if unit.isMe then PrintChat("- "..unit.charName.." | "..buff.name) end
end

function OnUpdateBuff(unit, buff, stacks)
	if not unit or not buff then return end
	-- if unit.isMe then PrintChat("� "..unit.charName.." | "..buff.name.." | ") end
end

---------- On Spell ----------
function OnProcessSpell(object, spellProc)
	if not object or not spellproc or myHero.dead or not ValidTarget(object) then return end
	
	-- if myHero:GetDistance(object) <= 1200 then PrintChat("Object : "..object.charName..", spellProc : "..spellProc.name) end
	
	-- Ultimate Projectiles
	if (false
	or spellProc.name == "EnchantedCrystalArrow"
	or spellProc.name == "BrandWildfire"
	or spellProc.name == "BraumPulseLine"
	or spellProc.name == "CaitlynAceintheHole"
	or spellProc.name == "MissileBarrage"
	or spellProc.name == "DravenRCast"
	or spellProc.name == "EzrealTrueshotBarrage"
	or spellProc.name == "GravesChargeShot"
	or spellProc.name == "IreliaTranscendentBlades"
	or spellProc.name == "JinxR"
	or spellProc.name == "KatarinaR"
	or spellProc.name == "LucianR"
	or spellProc.name == "MissFortuneBulletTime"
	or spellProc.name == "NamiR"
	or spellProc.name == "RivenWindslashMissileCenter"
	or spellProc.name == "SonaR"
	or spellProc.name == "SwainMetamorphism"
	or spellProc.name == "ShadowAssault"
	or spellProc.name == "TristanaR"
	or spellProc.name == "VarusR"
	or spellProc.name == "VeigarPrimordialBurst"
	or spellProc.name == "ZiggsR"
	or spellProc.name == "AzirR"
	or spellProc.name == "FizzMarinerDoom"
	or false)
	then
		OnUltimateProjectile(object, spellProc)
	end
	
	-- Ultimate Channels
	if (false
	or spellProc.name == "CaitlynAceintheHole"
	or spellProc.name == "DariusExecute"
	or spellProc.name == "Crowstorm"
	or spellProc.name == "GalioIdolOfDurand"
	or spellProc.name == "SowTheWind"
	or (spellProc.name == "KarthusFallenOne" and not object.dead) -- ???
	or spellProc.name == "KatarinaR"
	or spellProc.name == "AlZaharNetherGrasp"
	or spellProc.name == "MissFortuneBulletTime"
	or spellProc.name == "AbsoluteZero"
	or spellProc.name == "PantheonR"
	or spellProc.name == "TwistedFateR" -- ???
	or spellProc.name == "UrgotSwap2" -- ???
	or spellProc.name == "InfiniteDuress"
	or spellProc.name == "ShenR"
	or spellProc.name == "LucianR"
	or spellProc.name == "SionR"
	or spellProc.name == "EzrealTrueshotBarrage"
	or spellProc.name == "LuxMaliceCannon" -- ???
	or spellProc.name == "XerathLocusPulse" -- ???
	or false)
	then
		OnUltimateChannel(object, spellProc)
	end
	
	-- Channels
	if (false
	or spellProc.name == "Drain"
	or spellProc.name == "GragasW"
	or spellProc.name == "Meditate"
	or spellProc.name == "PantheonE"
	or spellProc.name == "CaitlynEntrapment" -- ???
	or spellProc.name == "ZacE"
	or spellProc.name == "VarusQ"
	or spellProc.name == "ViQ"
	or spellProc.name == "XerathArcanopulse2"
	or false)
	then
		OnChannel(object, spellProc)
	end
	
end

---------- Objects ----------
function OnCreateObj(object)
end

---------- Custom Callbacks ----------
function OnUltimateProjectile(object, spellProc)
	if myHero.charName == "Nocturne" and myHero:CanUseSpell(SPELL_2) == READY then
		CastSpell(SPELL_2)
	elseif myHero.charName == "Sivir" and myHero:CanUseSpell(SPELL_3) == READY then
		CastSpell(SPELL_3)
	elseif (myHero.charName == "Yasuo" or myHero.charName == "Fiora") and myHero:CanUseSpell(SPELL_2) == READY then
		CastSpell(SPELL_2, object.x, object.z)
	elseif myHero.charName == "Braum" and myHero:CanUseSpell(SPELL_3) == READY then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Morgana" and myHero:CanUseSpell(SPELL_3) == READY then
		CastSpell(SPELL_3, GetLowestAlly())
	end
end

function OnUltimateChannel(object, spellProc)
	if myHero.charName == "Amumu" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 550 then
		CastSpell(SPELL_4)
	elseif myHero.charName == "Ashe" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 2800 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Azir" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 250 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Bard" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 3400 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Blitzcrank" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 600 then
		CastSpell(SPELL_4)
	elseif myHero.charName == "Braum" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1250 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Cassiopeia" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 825 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Fizz" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1275 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Galio" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 600 then
		CastSpell(SPELL_4)
	elseif myHero.charName == "Gragas" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1150 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Hecarim" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1000 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Janna" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 875 then
		CastSpell(SPELL_4)
	elseif myHero.charName == "LeeSin" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 375 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Leona" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1200 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Lissandra" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 550 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Lulu" and myHero:CanUseSpell(SPELL_4) == READY and SelectWildGrowthAlly(object) ~= nil then
		CastSpell(SPELL_4, SelectWildGrowthAlly(object))
	elseif myHero.charName == "Malphite" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1000 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Malzahar" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 700 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Nami" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 2750 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Nautilus" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 825 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Orianna" and myHero:CanUseSpell(SPELL_1) == READY and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 825 then
		CastSpell(SPELL_1, object.x, object.z)
		CastSpell(SPELL_4)
	elseif myHero.charName == "Sejuani" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1175 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Shyvana" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1000 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Sion" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1200 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Skarner" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 350 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Sona" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1000 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Tristana" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 670 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Urgot" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 850 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Varus" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 1075 then
		CastSpell(SPELL_4, object.x, object.z)
	elseif myHero.charName == "Vi" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 800 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "Warwick" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 700 then
		CastSpell(SPELL_4, object)
	elseif myHero.charName == "MonkeyKing" and myHero:CanUseSpell(SPELL_3) == READY and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 625 then
		CastSpell(SPELL_3, object)
		CastSpell(SPELL_4)
	elseif myHero.charName == "XinZhao" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 600 then
		if myHero:CanUseSpell(SPELL_3) == READY then CastSpell(SPELL_3, object) end
		CastSpell(SPELL_4)
	elseif myHero.charName == "Zac" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 300 then
		CastSpell(SPELL_4)
	elseif myHero.charName == "Zyra" and myHero:CanUseSpell(SPELL_4) == READY and myHero:GetDistance(object) < 700 then
		CastSpell(SPELL_4, object.x, object.z)
	else OnChannel(object, spellProc)
	end
end

function OnChannel(object, spellProc)
	if myHero.charName == "Aatrox" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 650 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Ahri" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 975 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Alistar" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 365 then
		CastSpell(SPELL_1)
	elseif myHero.charName == "Alistar" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 650 then
		CastSpell(SPELL_2, object)
	elseif myHero.charName == "Amumu" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 1100 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Anivia" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 1000 then
		CastSpell(SPELL_2, object.x, object.z)
	elseif myHero.charName == "Bard" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 950 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Blitzcrank" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_3)
	elseif myHero.charName == "Blitzcrank" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 925 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "ChoGath" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 300 then
		CastSpell(SPELL_2, object.x, object.z)
	elseif myHero.charName == "ChoGath" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 950 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Darius" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 550 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Diana" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 350 then
		CastSpell(SPELL_3)
	elseif myHero.charName == "Draven" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 1050 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Fiddlesticks" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 575 then
		CastSpell(SPELL_1, object)
	elseif myHero.charName == "Fiddlesticks" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 750 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "Garen" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_1)
	elseif myHero.charName == "Gragas" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 600 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Hecarim" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_3)
	elseif myHero.charName == "Heimerdinger" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 925 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Irelia" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 425 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "JarvanIV" and myHero:CanUseSpell(SPELL_1) == READY and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 770 then
		CastSpell(SPELL_3, object.x, object.z)
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Jinx" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 900 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Leona" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_1)
	elseif myHero.charName == "Lulu" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 650 then
		CastSpell(SPELL_2, object)
	elseif myHero.charName == "Malzahar" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 900 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Maokai" and myHero:CanUseSpell(SPELL_1) == READY and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 525 then
		CastSpell(SPELL_2, object)
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Nami" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 875 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Nautilus" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 1100 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Pantheon" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 600 then
		CastSpell(SPELL_2, object)
	elseif myHero.charName == "Poppy" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 525 then
		CastSpell(SPELL_2, object)
	elseif myHero.charName == "Quinn" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 675 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "Rammus" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 225 then
		myHero:Attack(object)
		CastSpell(SPELL_1)
	elseif myHero.charName == "Rammus" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 325 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "Renekton" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_2)
	elseif myHero.charName == "Riven" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 125 then
		CastSpell(SPELL_2)
	elseif myHero.charName == "Ryze" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 600 then
		CastSpell(SPELL_2, object)
	elseif myHero.charName == "Sejuani" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 650 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Shen" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 600 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Singed" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "Skarner" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 1000 then
		myHero:Attack(object)
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Soraka" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 925 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Swain" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 900 then
		CastSpell(SPELL_2, object.x, object.z)
	elseif myHero.charName == "Syndra" and myHero:CanUseSpell(SPELL_1) == READY and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 700 then
		CastSpell(SPELL_1, object.x, object.z)
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Taric" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 625 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "Thresh" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 400 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Trundle" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 1000 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Udyr" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_3)
	elseif myHero.charName == "Vayne" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 550 then
		CastSpell(SPELL_3, object)
	elseif myHero.charName == "VelKoz" and myHero:CanUseSpell(SPELL_2) == READY and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 850 then
		CastSpell(SPELL_2, object.x, object.z)
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "Vi" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 250 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Viktor" and myHero:CanUseSpell(SPELL_2) == READY and myHero:GetDistance(object) < 700 then
		CastSpell(SPELL_2, object.x, object.z)
	elseif myHero.charName == "Volibear" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < myHero.range * 2 then
		myHero:Attack(object)
		CastSpell(SPELL_1)
	elseif myHero.charName == "Xerath" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 1050 then
		CastSpell(SPELL_3, object.x, object.z)
	elseif myHero.charName == "XinZhao" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 600 then
		myHero:Attack(object)
		CastSpell(SPELL_1)
		if myHero:CanUseSpell(SPELL_3) == READY then CastSpell(SPELL_3, object) end
	elseif myHero.charName == "Yasuo" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 900 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Zilean" and myHero:CanUseSpell(SPELL_1) == READY and myHero:GetDistance(object) < 900 then
		CastSpell(SPELL_1, object.x, object.z)
	elseif myHero.charName == "Zyra" and myHero:CanUseSpell(SPELL_3) == READY and myHero:GetDistance(object) < 1100 then
		if myHero:CanUseSpell(SPELL_1) == READY then CastSpell(SPELL_1, object.x, object.z) end
		CastSpell(SPELL_3, object.x, object.z)
	end
end

---------- Custom Functions ----------
function GetLowestAlly(Range)
	local target = nil
	for i=1, heroManager.iCount do
		local temp = heroManager:getHero(i)
		if not temp.dead and temp.health > 1 and myHero.team == temp.team and temp.visible and myHero:GetDistance(temp) < Range then
			if target == nil or temp.health < target.health then
				target = temp
			end
		end
	end
	return target
end

function SelectWildGrowthAlly(object)
	local target = nil
	for i=1, heroManager.iCount do
		local temp = heroManager:getHero(i)
		if not temp.dead and temp.health > 1 and myHero.team == temp.team and temp.visible and myHero:GetDistance(temp) < 900 and object:GetDistance(temp) < 150 then
			if target == nil or temp.health < target.health then
				target = temp
			end
		end
	end
	return target
end