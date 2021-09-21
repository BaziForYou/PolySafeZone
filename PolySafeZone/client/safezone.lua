local job = ""
local grade = 0

if UseESX then
	Citizen.CreateThread(function()
		local ESX = nil -- dont need make this global it just for get job one time
		while ESX == nil do
			TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
			Citizen.Wait(10)
		end

		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(100)
		end

		job = ESX.GetPlayerData().job.name
		grade = ESX.GetPlayerData().job.grade
	end)

	RegisterNetEvent("esx:setJob")
	AddEventHandler("esx:setJob",function(NewJob)
		job = NewJob.name
		grade = NewJob.grade
	end)
end

local AllCreatedZones = {}

Citizen.CreateThread(function()
	for k,v in pairs(AllZones) do
		local TempZone = nil
		local TempTable = {}
		for k2,v2 in ipairs(v.Zones) do
			TempZone = PolyZone:Create(v2.Coords, {
				name = k .. "_" .. k2,
				minZ = v2.minZ,
				maxZ = v2.maxZ,
				debugPoly = v.Debug,
				debugGrid = v.Debug,
			})
			table.insert(TempTable,TempZone)
		end
		if #TempTable > 1 then
			TempZone = ComboZone:Create(TempTable, {name= k .. "_combo"})
			
			TempZone:onPlayerInOut(function(isPointInside, point, zone)
			  EnteredZone(isPointInside,k)
			end, CheckLoopTime)
		else
			TempZone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point, zone)
			  EnteredZone(isPointInside,k)
			end, CheckLoopTime)
		end
	end
end)

local IsLoopStarted = false
local IsPlayerCanAttackInSafeZone = nil
local UnarmedHash = `WEAPON_UNARMED`
local WhatIsLastLoop = ""

function EnteredZone(isPointInside,Name)
	local InZone,Name = InZone,Name
	if isPointInside and WhatIsLastLoop ~= Name then
		Citizen.CreateThread(function()
			WhatIsLastLoop = Name
			IsLoopStarted = true
			Notify('success', 'Enter')
			while WhatIsLastLoop == Name do
				if not WhiteListedJobs[job] or not WhiteListedJobs[job][Name] or not (WhiteListedJobs[job][Name] <= grade) then -- check player can attack in safezone or not
					local player = PlayerPedId() -- PlayerPedId is optimizer than GetPlayerPed
					SetCurrentPedWeapon(player, UnarmedHash,true) -- Cant carry weapon
					DisablePlayerFiring(player,true)  -- Disables firing all together
					DisableControlAction(0, 140, true) -- R
					DisableControlAction(0, 25, true) -- RIGHT MOUSE BUTTON Aim
					IsPlayerCanAttackInSafeZone = false
					Citizen.Wait(5)
				else
					IsPlayerCanAttackInSafeZone = true
					Citizen.Wait(500) -- i put this if player changed his job inside the zone like setjob or off or on duty
				end
			end
			IsPlayerCanAttackInSafeZone = nil
			Notify('error', 'Exit')
		end)
	else
		WhatIsLastLoop = ""
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
		return
	end
	for i = 1, #AllCreatedZones do
		AllCreatedZones[i]:destroy() -- if restart script destroy old zones
	end
end)

-- Exports --
InSafeZone = function()
    return IsLoopStarted
end

exports("InSafeZone", InSafeZone)

SafeZoneName = function()
    return WhatIsLastLoop
end

exports("SafeZoneName", SafeZoneName)

CanAttackInSafeZone = function()
    return IsPlayerCanAttackInSafeZone
end

exports("CanAttackInSafeZone", CanAttackInSafeZone)

SetJobAndGrade = function(NewJob,NewGrade)
	job = NewJob
	grade = NewGrade
end

exports("SetJobAndGrade", SetJobAndGrade)