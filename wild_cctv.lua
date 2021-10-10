--[[BU SCRİPT ESX_SECURİTYCAM SCRİPTİNDEN ALINTIDIR, %50'LİK BİR KISMI DEĞİŞTİRİLEREK FARKLI BİR İŞLEYİŞE SAHİP EDİLMİŞTİR.
TAMAMEN ÜCRETSİZ OLMASIYLA BİRLİKTE SİZ GÜZEL İNSANLAR İÇİN PAYLAŞTIK
BAZI KENDİNİ BİRŞEY SANAN ARKADAŞLAR SCRİPT İSMİNE KENDİ ADINI YAZIP BEN YAZDIM BU BENİM SCRİPTİM DİYEBİLİYOR
YAPMAYIN ARKADAŞLAR BUNUN ADINI DEĞİŞTİRİP BEN YAZDIM DİYİNCE ELİNE BİRŞEY GEÇMEYECEK
İNSANLAR SENİ DEVELOPER GİBİ GÖRMEYECEK KENDİNİ KÜÇÜK DÜŞÜRÜRSÜN GÜZEL DOSTUM :)
]]


local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["wild"]
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, 
}

local PlayerData = {}
local blockbuttons = false
local currentCameraIndex = 0
local currentCameraIndexIndex = 0
local createdCamera = 0
local kameraIsim = ""

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	PlayerData.job = job
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
end)


-- RegisterCommand("cctv", function()
-- 	--if IsPedSittingInAnyVehicle(PlayerPedId()) and vehicleType(GetVehiclePedIsUsing(PlayerPedId())) or (PlayerData.job and PlayerData.job.name == "police") then
-- 		kameraMenu()
-- 	--else	
-- -- 	--	exports['mythic_notify']:SendAlert('error', 'PD aracında değilsin veya polis değilsin.')
-- -- 	--end
-- -- end)
-- --..wild..
-- 	--if IsPedSittingInAnyVehicle(PlayerPedId()) and vehicleType(GetVehiclePedIsUsing(PlayerPedId())) or (PlayerData.job and PlayerData.job.name == "police") then
-- 		kameraMenu()
-- 	--else	
-- -- 	--	exports['mythic_notify']:SendAlert('error', 'PD aracında değilsin veya polis değilsin.')
-- -- 	--end
-- -- end)
-- 	--if IsPedSittingInAnyVehicle(PlayerPedId()) and vehicleType(GetVehiclePedIsUsing(PlayerPedId())) or (PlayerData.job and PlayerData.job.name == "police") then
-- 		kameraMenu()
-- 	--else	
-- -- 	--	exports['mythic_notify']:SendAlert('error', 'PD aracında değilsin veya polis değilsin.')
-- -- 	--end
-- -- end)

Citizen.CreateThread(function()
	while true do
		sleep = 2000
		local ped = PlayerPedId()
		local kordinat = GetEntityCoords(ped)
		local dist = GetDistanceBetweenCoords(kordinat, 442.806, -998.76, 34.9701, true)
		if dist < 3.0 then
			sleep = 5
		end
		if dist < 2.0 then
			DrawText3Ds(442.806, -998.76, 34.9701, '[~g~E~s~] CCTV\'ye Bağlan')
			if IsControlJustReleased(0, 46) then
				TriggerEvent("mythic_progbar:client:progress", {
					name = "ra1der_kamera_arıyor_amq",
					duration = 15000,
					label = "Veri Tabanına Bağlanılıyor",
					useWhileDead = false,
					canCancel = true,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = true,
						disableCombat = true,
					},
					animation = {
						animDict = "mp_fbi_heist",
						anim = "loop",
					},
					prop = {
						model = "",
					}
				}, function(status)
					if not status then
						-- Do Something If Event Wasn't Cancelled
					end
				end)
				Wait(15000)
                kameraMenu()
                FreezeEntityPosition(PlayerPedId(), true)
			end
		end
		Citizen.Wait(sleep)
	end
end)

function marketwldKameraMenu()
	local elements = {}
	for no, marketler in pairs(kameralar) do
		if no ~= "Motel" and no ~= "Mucevher" and no ~= "Hastane" and no ~= "Polis" and no ~= "KasabaMotel" and no ~= "Banka" then
			table.insert(elements, {label = no .. " Numaralı Market Kameraları",  menu = no})
		end
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "W-CCTV",
		align    = 'top-left',
		elements = elements
	}, function(data2, menu2)
		menu2.close()
		FreezeEntityPosition(PlayerPedId(), true)
		blockbuttons = true
		kameraIsim = data2.current.menu
		local firstCamx = kameralar[kameraIsim][1].x
		local firstCamy = kameralar[kameraIsim][1].y
		local firstCamz = kameralar[kameraIsim][1].z
		local firstCamr = kameralar[kameraIsim][1].r
		SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
		ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)

		currentCameraIndex = 1
		currentCameraIndexIndex = 1
		TriggerEvent('esx_securitycam:freeze', true)
		
	end, function(data2, menu2)
		menu2.close()
		FreezeEntityPosition(PlayerPedId(), false)
		blockbuttons = false
	end)
end

function kameraMenu()
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = "CCTV",
		align    = 'top-left',
		elements = {
			{label = 'Market CC TV', menu = 'Market'},
			{label = "Pacific Bank CC TV",  menu = 'Banka'},
			{label = "Paletobay Bank CC TV",  menu = 'Kasaba Motel'},
			{label = "Police Department CC TV", menu = 'Police'},
			{label = "State Department CC TV", menu = 'Trooper'},
			{label = "Sheriff Department CC TV", menu = 'Sheriff'},
			{label = 'Pillbox Hospital CC TV', menu = 'Pillbox'},
			{label = 'Vangelico CC TV', menu = 'Vangelico Shop'},
			{label = 'Pink Cage CC TV', menu = 'Motel'},			
		}
	}, function(data, menu)

		if data.current.menu == "market" then
			marketwldKameraMenu()
		else
			menu.close()
			blockbuttons = true
			kameraIsim = data.current.menu
			local firstCamx = kameralar[kameraIsim][1].x
			local firstCamy = kameralar[kameraIsim][1].y
			local firstCamz = kameralar[kameraIsim][1].z
			local firstCamr = kameralar[kameraIsim][1].r
			SetFocusArea(firstCamx, firstCamy, firstCamz, firstCamx, firstCamy, firstCamz)
			ChangeSecurityCamera(firstCamx, firstCamy, firstCamz, firstCamr)

			currentCameraIndex = 1
			currentCameraIndexIndex = 1
			TriggerEvent('esx_securitycam:freeze', true)
		end

	end, function(data, menu)
		menu.close()
        ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        blockbuttons = false
	end)
end

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if createdCamera ~= 0 then
			time = 1
			local instructions = CreateInstuctionScaleform("instructional_buttons")

			DrawScaleformMovieFullscreen(instructions, 255, 255, 255, 255, 0)
			SetTimecycleModifier("scanline_cam_cheap")
			SetTimecycleModifierStrength(2.0)

			-- CLOSE CAMERAS
			if IsControlJustPressed(0, Keys["BACKSPACE"]) then
				CloseSecurityrdrCamera()
				TriggerEvent('esx_securitycam:freeze', false)
			end

			-- GO BACK CAMERA
			if IsControlJustPressed(0, Keys["LEFT"]) then
				local newCamIndex

				if currentCameraIndexIndex == 1 then
					newCamIndex = #kameralar[kameraIsim]
				else
					newCamIndex = currentCameraIndexIndex - 1
				end

				local newCamx = kameralar[kameraIsim][newCamIndex].x
				local newCamy = kameralar[kameraIsim][newCamIndex].y
				local newCamz = kameralar[kameraIsim][newCamIndex].z
				local newCamr = kameralar[kameraIsim][newCamIndex].r

				SetFocusArea(newCamx, newCamy, newCamz, newCamx, newCamy, newCamz)

				ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
				currentCameraIndexIndex = newCamIndex
			end

			-- GO FORWARD CAMERA
			if IsControlJustPressed(0, Keys["RIGHT"]) then
				local newCamIndex
			
				if currentCameraIndexIndex == #kameralar[kameraIsim] then
					newCamIndex = 1
				else
					newCamIndex = currentCameraIndexIndex + 1
				end

				local newCamx = kameralar[kameraIsim][newCamIndex].x
				local newCamy = kameralar[kameraIsim][newCamIndex].y
				local newCamz = kameralar[kameraIsim][newCamIndex].z
				local newCamr = kameralar[kameraIsim][newCamIndex].r

				ChangeSecurityCamera(newCamx, newCamy, newCamz, newCamr)
				currentCameraIndexIndex = newCamIndex
			end

			if kameralar[kameraIsim][currentCameraIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end

			elseif kameralar[kameraIsim][currentCameraIndex].canRotate then
				local getCameraRot = GetCamRot(createdCamera, 2)

				-- ROTATE LEFT
				if IsControlPressed(1, Keys['N4']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z + 0.7, 2)
				end

				-- ROTATE RIGHT
				if IsControlPressed(1, Keys['N6']) then
					SetCamRot(createdCamera, getCameraRot.x, 0.0, getCameraRot.z - 0.7, 2)
				end
			end

		end
		Citizen.Wait(time)
	end
end)

function ChangeSecurityCamera(x, y, z, r)
	if createdCamera ~= 0 then
		DestroyCam(createdCamera, 0)
		createdCamera = 0
	end

	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(cam, x, y, z)
	SetCamRot(cam, r.x, r.y, r.z, 2)
	RenderScriptCams(1, 0, 0, 1, 1)

	createdCamera = cam
end

function CloseSecurityrdrCamera()
	blockbuttons = false
	DestroyCam(createdCamera, 0)
	RenderScriptCams(0, 0, 1, 1, 1)
	createdCamera = 0
	ClearTimecycleModifier("scanline_cam_cheap")
	SetFocusEntity(GetPlayerPed(PlayerId()))
	Citizen.Wait(50)
	kameraMenu()
end

function CreateInstuctionScaleform(scaleform)
	local scaleform = RequestScaleformMovie(scaleform)

	while not HasScaleformMovieLoaded(scaleform) do
		Citizen.Wait(10)
	end

	PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
	PushScaleformMovieFunctionParameterInt(200)
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["RIGHT"], true))
	InstructionButtonMessage("Sonraki kamera")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(1)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["LEFT"], true))
	InstructionButtonMessage("Önceki kamera")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
	PushScaleformMovieFunctionParameterInt(2)
	PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(0, Keys["BACKSPACE"], true))
	InstructionButtonMessage("Çık")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	PopScaleformMovieFunctionVoid()

	PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(0)
	PushScaleformMovieFunctionParameterInt(80)
	PopScaleformMovieFunctionVoid()

	return scaleform
end

function InstructionButtonMessage(text)
	BeginTextCommandScaleformString("STRING")
	AddTextComponentScaleform(text)
	EndTextCommandScaleformString()
end

RegisterNetEvent('esx_securitycam:freeze')
AddEventHandler('esx_securitycam:freeze', function(freeze)
	FreezeEntityPosition(PlayerPedId(), freeze)
end)

Citizen.CreateThread(function()
	while true do
		local time = 1000
		if blockbuttons then
			time = 1
			DisableControlAction(2, 24, true)
			DisableControlAction(2, 257, true)
			DisableControlAction(2, 25, true)
			DisableControlAction(2, 263, true)
			DisableControlAction(2, Keys['R'], true)
			DisableControlAction(2, Keys['SPACE'], true)
			DisableControlAction(2, Keys['Q'], true)
			DisableControlAction(2, Keys['TAB'], true)
			DisableControlAction(2, Keys['F'], true)
			DisableControlAction(2, Keys['F1'], true)
			DisableControlAction(2, Keys['F2'], true)
			DisableControlAction(2, Keys['F3'], true)
			DisableControlAction(2, Keys['F6'], true)
			DisableControlAction(2, Keys['F7'], true)
			DisableControlAction(2, Keys['F10'], true)
		end
		Citizen.Wait(time)
	end
end)

function DrawText3Dkamera(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

	local factor = (string.len(text)) / 330
	DrawRect(_x, _y + 0.0150, 0.0 + factor, 0.035, 41, 11, 41, 100)
end
function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x,y,z)
    if onScreen then
        local factor = #text / 325
        SetTextScale(0.27, 0.27)
        SetTextFont(11)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry('STRING')
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        DrawRect(_x, _y + 0.0120, 0.006 + factor, 0.024, 0, 0, 0, 155)
    end
end

function vehicleType(using)
	local cars = Config.Cars
	for i=1, #cars, 1 do
		if IsVehicleModel(using, GetHashKey(cars[i])) then
		return true
		end
	end
end

kameralar = {
	["Banka"] = {
		{x = 232.86, y = 221.46, z = 107.83, r = {x = -25.0, y = 0.0, z = -140.0}, canRotate = true},
		{x = 257.45, y = 210.07, z = 109.08, r = {x = -25.0, y = 0.0, z = 28.0}, canRotate = true},
		{x = 261.50, y = 218.08, z = 107.95, r = {x = -25.0, y = 0.0, z = -149.0}, canRotate = true},
		{x = 241.64, y = 233.83, z = 111.48, r = {x = -25.0, y = 0.0, z = 120.0}, canRotate = true},
		{x = 269.66, y = 223.67, z = 113.23, r = {x = -25.0, y = 0.0, z = 111.0}, canRotate = true},
		{x = 261.98, y = 217.92, z = 113.25, r = {x = -25.0, y = 0.0, z = -159.0}, canRotate = true},
		{ x = 258.44, y = 204.97, z = 113.25, r = {x = -25.0, y = 0.0, z = 10.0}, canRotate = true},
		{x = 235.53, y = 227.37, z = 113.23, r = {x = -25.0, y = 0.0, z = -160.0}, canRotate = true},
		{x = 254.72, y = 206.06, z = 113.28, r = {x = -25.0, y = 0.0, z = 44.0}, canRotate = true},
		{x = 269.89, y = 223.76, z = 106.48, r = {x = -25.0, y = 0.0, z = 112.0}, canRotate = true},
		{x = 252.27, y = 225.52, z = 103.99, r = {x = -25.0, y = 0.0, z = -74.0}, canRotate = true}
	},

	["KasabaMotel"] = {
		{x = -107.99, y = 6463.06, z = 33.35, r = {x = -25.0, y = 0.0, z = 6.0}, canRotate = true},
		{x = -103.14, y = 6467.86, z = 33.35, r = {x = -25.0, y = 0.0, z = 46.0}, canRotate = true},
		{x = -115.21, y = 6472.39, z = 33.35, r = {x = -25.0, y = 0.0, z = 206.0}, canRotate = true},
		{x = -112.64, y = 6464.64, z = 33.35, r = {x = -25.0, y = 0.0, z = 355.0}, canRotate = true},
		{x = -108.0, y = 6468.52, z = 33.35, r = {x = -25.0, y = 0.0, z = 259.0}, canRotate = true},
		{x = -107.19, y = 6476.16, z = 33.35, r = {x = -25.0, y = 0.0, z = 203.0}, canRotate = true},
		{x = -104.53, y = 6479.56, z = 33.35, r = {x = -25.0, y = 0.0, z = 175.0}, canRotate = true},
		{x = -103.42, y = 6451.33, z = 34.5, r = {x = -25.0, y = 0.0, z = 127.0}, canRotate = true},
	},

	["Polis"] = {
		{x = 433.8810, y = -988.291, z = 33.822, r = {x = -25.0, y = 0.0, z = 39.0}, canRotate = true},
		{x = 424.3083, y = -996.720, z = 33.381, r = {x = -25.0, y = 0.0, z = 156.0}, canRotate = true},
		{x = 458.8177, y = -1021.05, z = 37.413, r = {x = -25.0, y = 0.0, z = 89.0}, canRotate = true},
		{x = 489.4088, y = -1017.59, z = 32.751, r = {x = -25.0, y = 0.0, z = 126.0}, canRotate = true},
		{x = 426.9510, y = -972.836, z = 27.333, r = {x = -25.0, y = 0.0, z = 234.0}, canRotate = true},
		{x = 464.9103, y = -972.539, z = 28.341, r = {x = -25.0, y = 0.0, z = 193.0}, canRotate = true},
		{x = 477.0179, y = -1004.85, z = 28.152, r = {x = -25.0, y = 0.0, z = 225.0}, canRotate = true},
		{x = 449.3049, y = -972.898, z = 32.373, r = {x = -25.0, y = 0.0, z = 195.0}, canRotate = true},
		{x = 419.0173, y = -1024.90, z = 30.797, r = {x = -25.0, y = 0.0, z = 288.0}, canRotate = true},
		{x = 386.8959, y = -999.827, z = 55.304, r = {x = -25.0, y = 0.0, z = 273.0}, canRotate = true},
	},

	["State"] = {
		{x = -1090.93, y = -807.855, z = 21.330, r = {x = -25.0, y = 0.0, z = 97.0}, canRotate = true},
		{x = -1088.53, y = -826.211, z = 20.889, r = {x = -25.0, y = 0.0, z = 1.0}, canRotate = true},
		{x = -1090.23, y = -847.576, z = 14.778, r = {x = -25.0, y = 0.0, z = 350.0}, canRotate = true},
		{x = -1112.61, y = -836.048, z = 40.501, r = {x = -25.0, y = 0.0, z = 276.0}, canRotate = true},
		{x = -1116.65, y = -831.386, z = 40.312, r = {x = -25.0, y = 0.0, z = 339.0}, canRotate = true},
		{x = -1033.22, y = -850.371, z = 17.318, r = {x = -25.0, y = 0.0, z = 111.0}, canRotate = true},
	},

	["Sheriff"] = {
		{x = -435.278, y = 6011.176, z = 34.078, r = {x = -25.0, y = 0.0, z = 5.0}, canRotate = true},
		{x = -449.116, y = 6023.020, z = 33.133, r = {x = -25.0, y = 0.0, z = 187.0}, canRotate = true},
		{x = -430.469, y = 5992.520, z = 33.070, r = {x = -25.0, y = 0.0, z = 90.0}, canRotate = true},
		{x = -440.689, y = 5994.783, z = 34.204, r = {x = -25.0, y = 0.0, z = 94.0}, canRotate = true},
		{x = -431.489, y = 5989.478, z = 34.267, r = {x = -25.0, y = 0.0, z = 280.0}, canRotate = true},
		{x = -447.589, y = 6022.989, z = 34.267, r = {x = -25.0, y = 0.0, z = 333.0}, canRotate = true},
	},

	["Hastane"] = {
		{x = -818.156, y = -1222.13, z = 8.8670, r = {x = -20.0, y = 0.0, z = 190.0}, canRotate = true},
		{x = -804.196, y = -1249.38, z = 8.8648, r = {x = -25.0, y = 0.0, z = 14.0}, canRotate = true},
		{x = -810.212, y = -1212.59, z = 8.8648, r = {x = -25.0, y = 0.0, z = 180.0}, canRotate = true},
		{x = -809.348, y = -1220.15, z = 8.9908, r = {x = -25.0, y = 0.0, z = 212.0}, canRotate = true},
		{x = -782.665, y = -1222.37, z = 8.8018, r = {x = -25.0, y = 0.0, z = 124.0}, canRotate = true},
		{x = -774.851, y = -1241.81, z = 8.8018, r = {x = -25.0, y = 0.0, z = 64.0}, canRotate = true},
		{x = -803.165, y = -1249.84, z = 9.0538, r = {x = -25.0, y = 0.0, z = 290.0}, canRotate = true},
		{x = -821.352, y = -1224.80, z = 9.7258, r = {x = -25.0, y = 0.0, z = 49.0}, canRotate = true},
		{x = -863.976, y = -1225.57, z = 10.040, r = {x = -25.0, y = 0.0, z = 305.0}, canRotate = true},
		{x = -772.696, y = -1229.64, z = 48.638, r = {x = -25.0, y = 0.0, z = 100.0}, canRotate = true},
		{x = -802.192, y = -1171.68, z = 54.119, r = {x = -25.0, y = 0.0, z = 214.0}, canRotate = true},
	},

	["Mucevher"] = {
		{x = -627.34, y = -239.85, z = 39.85, r = {x = -25.0, y = 0.0, z = 345.0}, canRotate = true},
		{x = -620.25, y = -224.22, z = 39.85, r = {x = -25.0, y = 0.0, z = 153.0}, canRotate = true},
		{x = -622.46, y = -235.5, z = 39.85, r = {x = -25.0, y = 0.0, z = 343.0}, canRotate = true},
		{x = -627.78, y = -230.01, z = 39.85, r = {x = -25.0, y = 0.0, z = 160.0}, canRotate = true}
	},

	["Motel"] = {
		{x = 326.79, y = -194.97, z = 57.0, r = {x = -25.0, y = 0.0, z = 230.0}, canRotate = true},
		{x = 306.36, y = -216.39, z = 60.02, r = {x = -25.0, y = 0.0, z = 299.0}, canRotate = true},
		{x = 347.02, y = -199.04, z = 60.02, r = {x = -25.0, y = 0.0, z = 107.0}, canRotate = true},
		{x = 339.31, y = -240.46, z = 61.05, r = {x = -25.0, y = 0.0, z = 83.0}, canRotate = true},
	},

	["1"] = {
		{x = 373.27, y = 331.44, z = 105.57, r = {x = -25.0, y = 0.0, z = 208.0}, canRotate = true},
		{x = 380.63, y = 330.38, z = 105.57, r = {x = -25.0, y = 0.0, z = 55.0}, canRotate = true},
	},

	["2"] = {
		{x = 2552.09, y = 380.34, z = 110.62, r = {x = -25.0, y = 0.0, z = 322.0}, canRotate = true},
		{x = 2551.68, y = 388.01, z = 110.62, r = {x = -25.0, y = 0.0, z = 147.0}, canRotate = true},
	},

	["3"] = {
		{x = -3043.24, y = 582.42, z = 9.91, r = {x = -25.0, y = 0.0, z = 344.0}, canRotate = true},
		{x = -3046.66, y = 589.29, z = 9.91, r = {x = -25.0, y = 0.0, z = 168.0}, canRotate = true},
	},

	["4"] = {
		{x = -1483.5, y = -380.12, z = 42.6, r = {x = -25.0, y = 0.0, z = 85.0}, canRotate = true},
		{x = -1479.84, y = -372.09, z = 42.16, r = {x = -25.0, y = 0.0, z = 168.0}, canRotate = true},
	},

	["5"] = {
		{x = 1387.83, y = 3604.63, z = 36.98, r = {x = -25.0, y = 0.0, z = 265.0}, canRotate = true},
		{x = 1398.25, y = 3610.38, z = 36.98, r = {x = -25.0, y = 0.0, z = 50.0}, canRotate = true},
	},

	["6"] = {
		{x = -2965.79, y = 387.31, z = 17.04, r = {x = -25.0, y = 0.0, z = 46.0}, canRotate = true},
		{x = -2957.82, y = 389.9, z = 16.04, r = {x = -25.0, y = 0.0, z = 139.0}, canRotate = true},
	},

	["7"] = {
		{x = 2673.41, y = 3281.22, z = 57.24, r = {x = -25.0, y = 0.0, z = 303.0}, canRotate = true},
		{x = 2676.25, y = 3288.3, z = 57.24, r = {x = -25.0, y = 0.0, z = 109.0}, canRotate = true},
	},

	["8"] = {
		{x = -42.85, y = -1755.13, z = 31.44, r = {x = -25.0, y = 0.0, z = 100.0}, canRotate = true},
		{x = -41.37, y = -1749.37, z = 31.42, r = {x = -25.0, y = 0.0, z = 103.0}, canRotate = true},
	},

	["9"] = {
		{x = 1164.64, y = -318.63, z = 71.21, r = {x = -25.0, y = 0.0, z = 150.0}, canRotate = true},
		{x = 1161.57, y = -312.94, z = 71.21, r = {x = -25.0, y = 0.0, z = 176.0}, canRotate = true},
	},

	["10"] = {
		{x = -705.5, y = -909.72, z = 21.22, r = {x = -25.0, y = 0.0, z = 150.0}, canRotate = true},
		{x = -707.46, y = -903.42, z = 21.22, r = {x = -25.0, y = 0.0, z = 154.0}, canRotate = true},
	},

	["11"] = {
		{x = -1822.4, y = 797.64, z = 140.09, r = {x = -25.0, y = 0.0, z = 195.0}, canRotate = true},
		{x = -1827.99, y = 800.84, z = 138.15, r = {x = -25.0, y = 0.0, z = 195.0}, canRotate = true},
	},

	["12"] = {
		{x = 1701.11, y = 4920.02, z = 44.06, r = {x = -25.0, y = 0.0, z = 20.0}, canRotate = true},
		{x = 1707.21, y = 4918.19, z = 44.06, r = {x = -25.0, y = 0.0, z = 20.0}, canRotate = true},
	},

	["13"] = {
		{x = 1956.98, y = 3744.05, z = 34.34, r = {x = -25.0, y = 0.0, z = 262.0}, canRotate = true},
		{x = 1963.16, y = 3748.54, z = 34.34, r = {x = -25.0, y = 0.0, z = 80.0}, canRotate = true},
	},

	["14"] = {
		{x = 1132.96, y = -979.16, z = 48.42, r = {x = -25.0, y = 0.0, z = 224.0}, canRotate = true},
		{x = 1125.22, y = -983.36, z = 48.0, r = {x = -25.0, y = 0.0, z = 312.0}, canRotate = true},
	},

	["15"] = {
		{x = 23.64, y = -1342.25, z = 31.5, r = {x = -25.0, y = 0.0, z = 236.0}, canRotate = true},
		{x = 31.41, y = -1341.48, z = 31.5, r = {x = -25.0, y = 0.0, z = 48.0}, canRotate = true},
	},

	["16"] = {
		{x = 550.48, y = 2666.68, z = 44.16, r = {x = -25.0, y = 0.0, z = 67.0}, canRotate = true},
		{x = 542.92, y = 2664.67, z = 44.16, r = {x = -25.0, y = 0.0, z = 243.0}, canRotate = true},
	},

	["17"] = {
		{x = -3247.53, y = 1000.08, z = 14.83, r = {x = -25.0, y = 0.0, z = 305.0}, canRotate = true},
		{x = -3247.55, y = 1007.36, z = 14.83, r = {x = -25.0, y = 0.0, z = 138.0}, canRotate = true},
	},

	["18"] = {
		{x = 1169.3, y = 2711.34, z = 40.16, r = {x = -25.0, y = 0.0, z = 120.0}, canRotate = true},
		{x = 1166.57, y = 2719.52, z = 40.16, r = {x = -25.0, y = 0.0, z = 230.0}, canRotate = true},
	},

	["19"] = {
		{x = 1729.41, y = 6419.83, z = 37.04, r = {x = -25.0, y = 0.0, z = 213.0}, canRotate = true},
		{x = 1736.66, y = 6417.44, z = 37.04, r = {x = -25.0, y = 0.0, z = 19.0}, canRotate = true},
	},	
}
