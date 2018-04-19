-- @author https://github.com/EmmanuelVlad/ephone

local inAnim = "cellphone_text_in"
local outAnim = "cellphone_text_out"
local callAnim = "cellphone_call_listen_base"

local phoneProp = 0
local phoneModel = "prop_npc_phone_02"

--------------------------------------------------------------------------------
--
--								ANIMATIONS
--
--------------------------------------------------------------------------------

-- plays the entering animation (draws the phone)
function ePhoneInAnim()
	if IsPlayerDead(PlayerId()) then
		return
	end
	local bone = GetPedBoneIndex(GetPlayerPed(-1), 28422)
	local dict = "cellphone@"
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		dict = dict .. "in_car@ds"
	end

	loadAnimDict(dict)

	TaskPlayAnim(GetPlayerPed(-1), dict, inAnim, 4.0, -1, -1, 50, 0, false, false, false)
	Citizen.Wait(157)
	phoneProp = newPhoneProp()
	AttachEntityToEntity(phoneProp, GetPlayerPed(-1), bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
end

-- Plays the out animation (puts back the phone in pocket)
function ePhoneOutAnim()
	if IsPlayerDead(PlayerId()) then
		return
	end
	local dict = "cellphone@"
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		dict = dict .. "in_car@ds"
	end

	loadAnimDict(dict)

	StopAnimTask(GetPlayerPed(-1), dict, inAnim, 1.0)
	TaskPlayAnim(GetPlayerPed(-1), dict, outAnim, 5.0, 1, -1, 50, 0, false, false, false)
	Citizen.Wait(1000)

	StopAnimTask(GetPlayerPed(-1), dict, outAnim, 1.0)

	-- Workaround to delete entity...
	Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(phoneProp))
end

--------------------------------------------------------------------------------
--
--								HELPERS
--
--------------------------------------------------------------------------------

-- Waits until the requested anim dictionary is loaded
function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end

function newPhoneProp()
	RequestModel(phoneModel)
	while not HasModelLoaded(phoneModel) do
		Citizen.Wait(1)
	end
	local phoneEntity = CreateObject(phoneModel, 1.0, 1.0, 1.0, 1, 1, 0)
	SetEntityAsMissionEntity(phoneEntity)
	return phoneEntity
end
