RegisterNetEvent('tama-jobcenter:givejob:server', function(job)
  local src = source

  local playerCoords = GetEntityCoords(GetPlayerPed(src))

  if #(playerCoords - Config.Coords) > 10 then
    Config.Notify(Config.Strings["too_far_away"]["title"], Config.Strings["too_far_away"]["description"], "error", src)
    return
  end

  if not Config.Jobs[job] then
    Config.Notify(Config.Strings["cheater?"]["title"], Config.Strings["cheater?"]["description"], "error", src)
    return
  end

  if not Config.DoesJobExist(job, 0) then
    Config.Notify(Config.Strings["invalid_job"]["title"], Config.Strings["invalid_job"]["description"], "error", src)
    print("^1Job \"" .. job .. "\" does not exist.^0")
    return
  end

  Config.SetJob(src, job, 0)
  Config.Notify(Config.Strings["new_job"]["title"],
      Config.Strings["new_job"]["description"]:gsub("{job}", Config.Jobs[job].label), "success", src)
end)
