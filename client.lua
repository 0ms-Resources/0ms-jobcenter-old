local pcOn = false
local duiObj
local camera
local buttonPressed = false

-- Screen resolution. Aspect ratio is 4:3
local screenWidth = Config.ScreenWidth or 1500
local screenHeight = math.floor(screenWidth / 4 * 3)
local dist = 0

CreateThread(function()
  if Config.DrawText then
    local wait = 10
    local ped = PlayerPedId()

    while true do
      dist = #(GetEntityCoords(ped) - Config.Coords)

      if not pcOn then
        if dist >= 25 then
          wait = 500
        elseif dist > 2 then
          wait = 50
        else
          DrawText3D(('~INPUT_%X~'):format(joaat("openjobcenter") & 0xFFFFFFFF) .. Config.Strings["turn_on"],
              Config.Coords)
        end
      else
        wait = 250
      end

      Wait(wait)
      wait = 10
    end
  else
    Config.Target(function()
      TurnOnPc()
      SetCamToObject()
      pcLoop()
    end)
  end
end)

RegisterCommand("openjobcenter", function()
  if dist <= 2 then
    TurnOnPc()
    SetCamToObject()
    pcLoop()
  end
end)

RegisterKeyMapping("openjobcenter", "Opens the jobcenter", "keyboard", Config.OpenKeybind or "E")

function DrawText3D(text, coords)
  AddTextEntry('Jobcenter', text)
  SetFloatingHelpTextWorldPosition(1, coords)
  SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
  BeginTextCommandDisplayHelp('Jobcenter')
  EndTextCommandDisplayHelp(2, false, false, -1)
end

RegisterNUICallback("selectJob", function(data, cb)
  TriggerServerEvent("tama-jobcenter:givejob:server", data.job)
  cb("ok")
end)

RegisterNUICallback("fetchJobs", function(_, cb)
  cb(Config.Jobs)
end)

RegisterNUICallback("fetchConfig", function(_, cb)
  cb({
    background = Config.Background,
    strings = Config.Strings,
    appLocation = Config.AppLocation
  })
end)

function TurnOnPc()
  local model = joaat("prop_monitor_w_large")
  RequestModel(model)

  while not HasModelLoaded(model) do
    Wait(0)
  end

  local txd = CreateRuntimeTxd("jobcenter_monitor_txd")
  duiObj = CreateDui("nui://tama-jobcenter/html/index.html", screenWidth, screenHeight)

  while not IsDuiAvailable(duiObj) do
    Wait(0)
  end

  local dui = GetDuiHandle(duiObj)
  CreateRuntimeTextureFromDuiHandle(txd, "jobcenter_monitor_txn", dui)
  AddReplaceTexture("prop_monitor_w_large", "script_rt_tvscreen", "jobcenter_monitor_txd", "jobcenter_monitor_txn")

  SetModelAsNoLongerNeeded(model)
end

function pcLoop()
  pcOn = true
  while pcOn do
    Wait(0)
    DisableAllControlActions(0)
    DisableAllControlActions(1)
    DisableAllControlActions(2)

    local cursorX, cursorY = GetDisabledControlNormal(0, 239), GetDisabledControlNormal(0, 240)
    local duiX, duiY = math.floor(cursorX * screenWidth + 0.5), math.floor(cursorY * screenHeight + 0.5)

    SendDuiMouseMove(duiObj, duiX, duiY)
    if IsDisabledControlJustPressed(0, 24) then
      SendDuiMouseDown(duiObj, "left")
    end
    if IsDisabledControlJustReleased(0, 24) then
      SendDuiMouseUp(duiObj, "left")
    end
  end
end

function SetCamToObject()
  local model = joaat("prop_monitor_w_large")

  local object = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 2.5, model, false, false, false)

  if not DoesEntityExist(object) then
    return
  end

  camera = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

  local forwardVector = GetEntityForwardVector(object)

  AttachCamToEntity(camera, object, 0.0, -0.5, 0.4, true)
  PointCamAtEntity(camera, object, 0.0, 0.0, 0.4, true)
  RenderScriptCams(true, true, 1000, 1, 0)
  SetCamActive(camera, true)

  DisplayRadar(false)
end

RegisterNetEvent("onResourceStop", function(res)
  if res ~= GetCurrentResourceName() then
    return
  end

  RemoveReplaceTexture("prop_monitor_w_large", "script_rt_tvscreen")

  if duiObj and IsDuiAvailable(duiObj) then
    DestroyDui(duiObj)
  end

  if camera then
    DestroyCam(camera)
  end

  DisplayRadar(true)
end)

function close()
  pcOn = false

  RemoveReplaceTexture("prop_monitor_w_large", "script_rt_tvscreen")

  RenderScriptCams(false, true, 1000, true, true)
  if duiObj and IsDuiAvailable(duiObj) then
    DestroyDui(duiObj)
  end

  if camera then
    DestroyCam(camera)
  end

  DisplayRadar(true)
end

RegisterNUICallback("close", function(_, cb)
  close()
end)
