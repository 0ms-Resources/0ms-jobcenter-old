Config = {}

Config.Strings = {
  ["turn_on"] = "Turn on jobcenter pc",
  ["ui"] = {
    ["jobcenter"] = "Jobcenter",
    ["jobcenter_description"] = "Here you can choose what you want to work as!",
    ["choose_job"] = "Choose Job"
  },
  ["too_far_away"] = {
    ["title"] = "Too Far Away!",
    ["description"] = "You are too far away from the jobcenter."
  },
  ["invalid_job"] = {
    ["title"] = "Invalid Job",
    ["description"] = "This job does not exist. Try contacting an administrator."
  },
  ["new_job"] = {
    ["title"] = "New Job",
    ["description"] = "Congrats on your new job as {job}!"
  },
  ["cheater?"] = {
    ["title"] = "Cheating?",
    ["description"] = "The only way you are seeing this is if you found a bug or are trying to abuse the script!"
  }
}

Config.ScreenWidth = 1500 -- Amount of pixels on the x-axis. This also changes the zoom.

Config.Background = "https://img.goodfon.com/wallpaper/big/d/42/zelionyi-fon-linux-mint-linux-mint.webp" -- PC Background

Config.AppLocation = {
  x = 1,
  y = 1
}

Config.Jobs = {
  ["police"] = {
    label = 'Police',
    description = "This is a description of the police job.\nYou can use \\n to make new line!"
  },
  ["ambulance"] = {
    label = 'Ambulance',
    description = "Example description of the ambulance job.\nYou can add more jobs in the config!"
  }
}

Config.DrawText = true -- Overrides the Config.Target function
Config.DrawTextCoords = vec3(-263.7847, -965.6575, 31.5260) -- Only used if Config.DrawText is true
Config.OpenKeybind = "E" -- Only used if Config.DrawText is true

Config.Target = function(onSelect)
  -- exports["ox_target"]:addBoxZone({
  --   coords = Config.Coords,
  --   size = vec3(2, 2, 2),
  --   drawSprite = true,
  --   options = {{
  --     name = "tama-jobcenter:pc",
  --     icon = "fa-solid fa-suitcase",
  --     label = Config.Strings["turn_on"],
  --     onSelect = onSelect
  --   }}
  -- })

  -- exports["qb-target"]:AddBoxZone("tama-jobcenter:pc", Config.Coords, 2.0, 2.0, {
  --   name = "tama-jobcenter:pc",
  --   minZ = Config.Coords.z - 1,
  --   maxZ = Config.Coords.z + 1
  -- }, {
  --   options = {{
  --     icon = "fa-solid fa-suitcase",
  --     label = Config.Strings["turn_on"],
  --     action = onSelect
  --   }},
  --   distance = 2.0
  -- })

end

Config.DoesJobExist = function(job, grade) -- This function only runs server-side
  if not IsDuplicityVersion() then
    return
  end

  -- For ESX:
  -- local ESX = exports["es_extended"]:getSharedObject()
  -- return ESX.DoesJobExist(job, grade)

  -- For QBCore:
  -- local QBCore = exports["qb-core"]:GetCoreObject()
  -- return QBCore.Shared.Jobs[job]

  -- There is no way for checking if a job exists in vRP so just return true

  return true
end

Config.Notify = function(title, description, type, src) -- This function only runs server-side
  if not IsDuplicityVersion() then
    return
  end

  -- For ESX:
  -- TriggerClientEvent('esx:showNotification', src, description, type)

  -- For QBCore:
  -- local QBCore = exports["qb-core"]:GetCoreObject()
  -- QBCore.Functions.Notify(src, description, type)

  -- For Ox Lib:
  -- lib.notify({
  --    title = title,
  --    description = description,
  --    type = type
  -- })

  -- vRP has no server-sided notify system. You will need to add another notify system if you have one here.

  -- TriggerClientEvent("chatMessage", src, description)
end

Config.SetJob = function(src, job, grade) -- This function only runs server-side
  if not IsDuplicityVersion() then
    return
  end

  -- For ESX:
  -- local ESX = exports["es_extended"]:getSharedObject()
  -- local xPlayer = ESX.GetPlayerFromId(src)
  -- xPlayer.setJob(job, grade)

  -- For QBCore:
  -- local QBCore = exports["qb-core"]:GetCoreObject()
  -- local Player = QBCore.Functions.GetPlayer(src)
  -- Player.Functions.SetJob(job, grade)

  -- For vRP:
  -- local Proxy = module("vrp", "lib/Proxy")
  -- local vRP = Proxy.getInterface("vRP")
  -- local user_id = vRP.getUserId({src})
  -- vRP.addUserGroup({user_id, job})

end

Config.Coords = vec3(-263.7847, -965.6575, 31.5260) -- Location of the pc. Only edit this if you have moved the location of the pc in the ymap!
