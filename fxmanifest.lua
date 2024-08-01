fx_version "cerulean"

author "Tama Scripts - m_gnus"
version '1.0.0'

lua54 'yes'

game "gta5"

-- dependency "vrp" -- Only needed if you use vRP

client_script "client.lua"
server_scripts {
  "server.lua",
  -- "@vrp/lib/utils.lua" -- Only needed if you use vRP
}
shared_script "config.lua"

files {'html/index.html', 'html/**/*'}

this_is_a_map "yes"
