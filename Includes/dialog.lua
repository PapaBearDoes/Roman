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

function Roman:CreateDialogs()
  RomanDialog:Register("GuildRecruitBark", {
    text = "",
    buttons = {
      {
        text = "Bark!",
        on_click = function(self, button, down)
          local msg = Roman:MakeGuildRecruitMessage()
          local msgLen = string.len(msg[1]) + string.len(msg[2])
          local genChanID, genChanName = GetChannelName(L["General"])
          local tradeChanID, tradeChanName = GetChannelName(L["TradeChanName"])
          local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])
          if Roman.db.global.debug == true then
            Roman:Print("Message Length: " .. msgLen)
          end

          if Roman.db.profile.messages.guildRecruit.channels.General == true then
            if Roman.db.profile.messages.guildRecruit.channels.Trade == false or GetChannelName(GetChannelName(tradeChanName)) < 1 then
              if Roman:CheckZoneTime() == true then
                if genChanName ~= nil then
                  if msgLen > 254 then
                    RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[2], "CHANNEL", nil, genChanID) --chanID)
                    RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[1], "CHANNEL", nil, genChanID) --chanID)
                  else
                    RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[1] .. " " .. msg[2], "CHANNEL", nil, genChanID) --chanID)
                  end

                  Roman:SendBarkTimer(Roman:Serialize(genChanName .. "," .. GetServerTime()))
                end
              end
            end
          end
          
          if Roman.db.profile.messages.guildRecruit.channels.Trade == true then
            if Roman:CheckTradeTime() == true then
              if tradeChanName ~= nil then
                if GetChannelName(GetChannelName(tradeChanName)) > 0 then
                  if msgLen > 254 then
                    RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[2], "CHANNEL", nil, tradeChanID) --chanID)
                    RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[1], "CHANNEL", nil, tradeChanID) --chanID)
                  else
                    RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[1] .. " " .. msg[2], "CHANNEL", nil, tradeChanID) --chanID)
                  end
                end

                Roman:SendBarkTimer(Roman:Serialize(tradeChanName .. "," .. GetServerTime()))
              end
            end
          end

          if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
            if Roman:CheckLFGTime() == true then
              if lfgChanName ~= nil then
                if msgLen > 254 then
                  RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[2], "CHANNEL", nil, lfgChanID) --chanID)
                  RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[1], "CHANNEL", nil, lfgChanID) --chanID)
                else
                  RomanCTL:SendChatMessage("BULK", "Roman-GuildBark", msg[1] .. " " .. msg[2], "CHANNEL", nil, lfgChanID) --chanID)
                end

                Roman:SendBarkTimer(Roman:Serialize(lfgChanName .. "," .. GetServerTime()))
              end
            end
          end
        end
      },
      {
        text = "Cancel",
        on_click = function(self, button, down)
        end
      },
    },
    hide_on_escape = true,
    show_while_dead = true,
    on_show = function(self, data)
      if Roman.db.global.debug == true then
        Roman:Print("Roman On_Show")
      end

      local genChanID, genChanName = GetChannelName(L["General"])
      local tradeChanID, tradeChanName = GetChannelName(L["TradeChanName"])
      local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])

      if Roman.db.profile.messages.guildRecruit.channels.General == true then
        if Roman:CheckZoneTime() == true then
          if Roman.db.global.debug == true then
            Roman:Print("General Channel Name (OnShow): " .. genChanName)
          end
          if genChanName ~= nil then
            if Roman.db.profile.messages.guildRecruit.channels.Trade == false or GetChannelName(GetChannelName(tradeChanName)) < 1 then
              genChanName = Roman:Colorize(genChanName, "uncommon") .. "\n"
            else
              genChanName = ""
            end
          else
            genChanName = ""
          end
        else
          genChanName = ""
        end
      else
        genChanName = ""
      end

      if Roman.db.profile.messages.guildRecruit.channels.Trade == true and GetChannelName(GetChannelName(tradeChanName)) > 0 then
        if Roman:CheckTradeTime() == true then
          if tradeChanName ~= nil then
            if GetChannelName(GetChannelName(tradeChanName)) > 0 then
              tradeChanName = Roman:Colorize(tradeChanName, "rare") .. "\n"
            else
              tradeChanName = ""
            end
          else
            tradeChanName = ""
          end
        else
          tradeChanName = ""
        end
      else
        tradeChanName = ""
      end

      if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
        if Roman:CheckLFGTime() == true then
          if lfgChanName ~= nil then
            lfgChanName = Roman:Colorize(lfgChanName, "epic") .. "\n"
          else
            lfgChanName = ""
          end
        else
          lfgChanName = ""
        end
      else
        lfgChanName = ""
      end

      if Roman.db.global.debug == true then
        Roman:Print("genChanName: " .. genChanName)
        Roman:Print("tradeChanName: " .. tradeChanName)
        Roman:Print("lfgChanName: " .. lfgChanName)

        local text = L["BarkCanBeSent"] .. ".\n"
        .. L["WeWillBarkInChannels"] .. ":\n\n"
        .. genChanName
        .. tradeChanName
        .. lfgChanName
        Roman:Print("PopUp Text: " .. text)
        self.text:SetFormattedText(text, genChanName, tradeChanName, lfgChanName)
      end
    end,
    on_hide = function(self)
      if Roman.db.global.debug == true then
        Roman:Print("Roman On Hide")
      end
      --Add the new lockout Time
      local nextRun = (10 + (60 * Roman.db.profile.messages.guildRecruit.time))
      Roman:Print("NextRun at approximately " .. date("%H:%M:%S", (nextRun + GetServerTime())))
      local checkTimer = Roman:TimeLeft(Roman.announceTimer)
      if checkTimer ~= nil and checkTimer > 0 then
        if Roman.db.global.debug == true then
          Roman:Print("Timer Active, resetting.")
        end
        Roman:CancelTimer(Roman.announceTimer)
      else
        if Roman.db.global.debug == true then
          Roman:Print("Timer Not Active, moving on ...")
        end
      end
      Roman.announceTimer = Roman:ScheduleTimer("Bark", nextRun)
    end,
  })
end

function Roman:PopUp()
  RomanDialog:Spawn("GuildRecruitBark")
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