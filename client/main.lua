--====================================================================================
-- #Authors: Jonathan D @ Gannon, Stanyslas Bres "Gramatiik"
--====================================================================================

local keyOpen = 289 -- "F2" by default
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local isPhoneOpenable = true

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustPressed(1, keyOpen) and not IsPedSwimming(GetPlayerPed(-1)) and isPhoneOpenable then
      setPhoneEnabled(true)
    end
    if DeadCheck() then
      setPhoneEnabled(false)
    end
  end
end)

function DeadCheck()
  local dead = IsEntityDead(GetPlayerPed(-1))
  if dead ~= isDead then
    isDead = dead
    SendNUIMessage({event = 'updateDead', isDead = isDead})
  end

  return dead
end

--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent("gcPhone:myPhoneNumber")
AddEventHandler("gcPhone:myPhoneNumber", function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({ type = 'updateYyPhoneNumber', phoneNumber = myPhoneNumber })
end)

RegisterNetEvent("gcPhone:contactList")
AddEventHandler("gcPhone:contactList", function(_contacts)
  Citizen.Trace('contactList')
  SendNUIMessage({ type = 'updateContacts', contacts = _contacts })
  contacts = _contacts
end)

RegisterNetEvent("gcPhone:allMessage")
AddEventHandler("gcPhone:allMessage", function(_messages)
  Citizen.Trace('allMessage')
  SendNUIMessage({ type = 'updateMessages', messages = _messages })
  messages = _messages
end)

RegisterNetEvent("gcPhone:receiveMessage")
AddEventHandler("gcPhone:receiveMessage", function(message)
  table.insert(messages, message)
  SendNUIMessage({ type = 'updateMessages', messages = messages })
  Citizen.Trace('sendMessage: ' .. json.encode(messages))
  if message.owner == 0 then
    SetNotificationTextEntry("STRING")
    AddTextComponentString('~o~Nouveau message')
    DrawNotification(false, false)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
    Citizen.Wait(300)
    PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
  end
end)

--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('gcPhone:sendMessage', num, message)
end

function deleteMessage(msgId)
  Citizen.Trace('deleteMessage' .. msgId)
  TriggerServerEvent('gcPhone:deleteMessage', msgId)
  for k, v in ipairs(messages) do
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('gcPhone:deleteMessageNumber', num)
end

function deleteAllMessage()
  TriggerServerEvent('gcPhone:deleteAllMessage')
end

function setReadMessageNumber(num)
  TriggerServerEvent('gcPhone:setReadMessageNumber', num)
  for k, v in ipairs(messages) do
    if v.transmitter == num then
      v.isRead = true
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcPhone:requestAllContact')
end

--====================================================================================
--  Gestion des evenements NUI
--====================================================================================
RegisterNUICallback('log', function(data, cb)
  Citizen.Trace('NUI Log | ' .. json.encode(data))
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)

RegisterNUICallback('blur', function(data, cb)
  cb()
end)

--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  Citizen.Trace('call getMessages | ' .. json.encode(messages))
  cb(json.encode(messages))
end)

RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(GetPlayerPed(-1))
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('gcPhone:sendMessage', data.phoneNumber, data.message)
end)

RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)

RegisterNUICallback('deleteMessageNumber', function (data, cb)
Citizen.Trace('deleteMessageNumber' .. data.number)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)

RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)

--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb)
  Citizen.Trace('addContact: ' .. json.encode(data))
  TriggerServerEvent('gcPhone:addContact', data.name, data.phone_number)
end)

RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('gcPhone:updateContact', data.id, data.name, data.phone_number)
end)

RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('gcPhone:deleteContact', data.id)
end)

RegisterNUICallback('getContacts', function(_, cb)
  cb(json.encode(contacts))
end)

RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)
RegisterNUICallback('callEvent', function(data, cb)
  if data.data ~= nil then
    TriggerEvent(data.eventName, {type = data.data})
  else
    TriggerEvent(data.eventName)
  end
  cb()
end)

RegisterNUICallback('deleteALL', function(_, cb)
  TriggerServerEvent('gcPhone:deleteALL')
  cb()
end)

function setPhoneEnabled(state)
  SetNuiFocus(state, state)
  SendNUIMessage({
    type = "toggleUI",
    enable = state
  })
  if state then
    ePhoneInAnim()
  else
    ePhoneOutAnim()
  end
end

RegisterNUICallback('closePhone', function(_, cb)
  isPhoneOpenable = false
  setPhoneEnabled(false)
  Citizen.Wait(500)
  isPhoneOpenable = true
  cb('ok')
end)

-- Just For reload
TriggerServerEvent('gcPhone:allUpdate')
