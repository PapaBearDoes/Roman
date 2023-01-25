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
local RomanDialog = LibStub("LibDialog-1.0")
local RomanCTL = ChatThrottleLib

function Roman:MakeButtons()
  if Roman.db.profile.messages.guildRecruit.channels.General == true then
    --Get Channel ID by Name
    local genChanID, genChanName = GetChannelName((GetChannelName("General - " .. GetZoneText())))
    
    if genChanName ~= nil then
      if Roman.db.global.debug == true then
        Roman:Print("Channel Name: " .. genChanName)
        Roman:Print("Channel ID: " .. genChanID)
      end
      buttonGeneral = {
        text = genChanName,
        on_click = function(self, button, down)
          local msg = Roman:MakeGuildRecruitMessage()

          --Do announce
          local msgLen = string.len(msg[1]) + string.len(msg[2])
          if Roman.db.global.debug == true then
            Roman:Print("Message Length: " .. msgLen)
          end
          if msgLen > 254 then
            RomanCTL:SendChatMessage("BULK", "roman", msg[2], "CHANNEL", nil, 6) --chanID)
            RomanCTL:SendChatMessage("BULK", "roman", msg[1], "CHANNEL", nil, 6) --chanID)
          else
            RomanCTL:SendChatMessage("NORMAL", "roman", msg[1] .. " " .. msg[2], "CHANNEL", nil, 6) --chanID)
          end

          --Add the new lockout Time
          --Roman.db.profile.messages.guildRecruit.zones[zone] = GetServerTime()
        end
      }
    else
      buttonGeneral = nil
    end
  else
    buttonGeneral = nil
  end
  if Roman.db.profile.messages.guildRecruit.channels.Trade == true then
    --Get Channel ID by Name
    local tradeChanID, tradeChanName = GetChannelName((GetChannelName("Trade - City")))
    
    if tradeChanName ~= nil then
      if Roman.db.global.debug == true then
        Roman:Print("Channel Name: " .. tradeChanName)
        Roman:Print("Channel ID: " .. tradeChanID)
      end
      buttonTrade = {
        text = tradeChanName,
        on_click = function(self, button, down)
        end
      }
    else
      buttonTrade = nil
    end
  else
    buttonTrade = nil
  end
  if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
    --Get Channel ID by Name
    local lfgChanID, lfgChanName = GetChannelName((GetChannelName("LookingForGroup")))
    
    if lfgChanName ~= nil then
      if Roman.db.global.debug == true then
        Roman:Print("Channel Name: " .. lfgChanName)
        Roman:Print("Channel ID: " .. lfgChanID)
      end
      buttonLFG = {
        text = lfgChanName,
        on_click = function(self, button, down)
        end
      }
    else
      buttonLFG = nil
    end
  else
    buttonLFG = nil
  end
  
  local button = {
    buttonGeneral,
    buttonTrade,
    buttonLFG,
  }
  
  Roman:Print("Step 1:")
  DevTools_Dump(button)

  return buttonGeneral, buttonTrade, buttonLFG
end

function Roman:CreateDialogs()
end

function Roman:PopUp()
  --Do LibDialog PopUp Button here
  local buttonGeneral, buttonTrade, buttonLFG = Roman:MakeButtons()
  local buttonTable = {
    text = "Guild recruitment announcement can now be sent to this zone.\n\nClick the channels you wish to announce to:",
    buttons = {},
    hide_on_escape = true,
    show_while_dead = false,
    on_show = function(self, data)
      self.buttons = {
        buttonGeneral,
        buttonTrade,
        buttonLFG,
      }
    end,
    on_hide = function(self, data)
      buttonGeneral = nil,
      buttonTrade = nil,
      buttonLFG = nil,
    end,
  }
  Roman:Print("Step 2:")
  DevTools_Dump(buttonTable)
  RomanDialog:Spawn(buttonTable)
  --OnClick, fire the announcement(s), then close the window
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