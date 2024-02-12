--[[
                                      \\\\///
                                     /       \
                                   (| (.)(.) |)
     .---------------------------.OOOo--()--oOOO.---------------------------.
     |                                                                      |
     |  PapaBearDoes's Roman Addon for World of Warcraft                 |
     |  @project-version@
     ######################################################################## ]]
--   ## Let's init this file shall we?
-- Imports
local _G = _G
local myName, addon = ...
local Roman = addon
local L = Roman:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
function Roman:ReceiveBarkTimers(prefix, str, distro)
  local timer, barkTimer
  if Roman.db.global.debug == true then
    Roman:Print("Comms Received: ")
    Roman:Print(str)
  end
  
  _, barkTimer = Roman:Deserialize(str)
  if Roman.db.global.debug == true then
    Roman:Print("Deserialized Bark Timer: " .. barkTimer)
  end
  
  timer = Roman:CommaSplitter(barkTimer)
  if Roman.db.global.debug == true then
    for k, v in pairs (timer) do
      Roman:Print(k .. " => " .. v)
    end
  end
  
  if Roman.db.global.debug == true then
    Roman:Print("Zone: " .. timer[1])
    Roman:Print("Time: " .. timer[2])
  end

  Roman.db.profile.messages.guildRecruit.zones[timer[1]] = timer[2]
  
  if Roman.db.global.debug == true then
    Roman:Print(timer[1] .. " Saved Time: " .. Roman.db.profile.messages.guildRecruit.zones[timer[1]])
  end
end

function Roman:SendBarkTimer(str)
  if Roman.db.global.debug == true then
    Roman:Print("Comms To Send: ")
    Roman:Print(str)
  end
  
  Roman:SendCommMessage("Roman-BarkTimers", str, "GUILD")
end
--[[
     ########################################################################
     |  Last Editted By: @file-author@ - @file-date-iso@
     |  @file-hash@
     |                                                                      |
     '-------------------------.oooO----------------------------------------|
                              (    )     Oooo.
                              \  (     (    )
                               \__)     )  /
                                       (__/                                   ]]