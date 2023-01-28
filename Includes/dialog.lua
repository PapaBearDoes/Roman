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
  RomanDialog:Register("GuildRecruitAnnounce", {
    text = "",
--    width = 600,
    buttons = {
      {
        text = "Announce!",
        on_click = function(self, button, down)
          local msg = Roman:MakeGuildRecruitMessage()
          local msgLen = string.len(msg[1]) + string.len(msg[2])
          if Roman.db.global.debug == true then
            Roman:Print("Message Length: " .. msgLen)
          end

          if Roman.db.profile.messages.guildRecruit.channels.General == true then
            if GetChannelName((GetChannelName("Trade - City"))) < 1 then
              if Roman:CheckZoneTime() == true then
                local genZone = GetZoneText()
                genChanID, genChanName = GetChannelName((GetChannelName("General - " .. genZone)))
                if genChanName ~= nil then
                  if msgLen > 254 then
                    RomanCTL:SendChatMessage("BULK", "roman", msg[2], "CHANNEL", nil, 6) --chanID)
                    RomanCTL:SendChatMessage("BULK", "roman", msg[1], "CHANNEL", nil, 6) --chanID)
                  else
                    RomanCTL:SendChatMessage("BULK", "roman", msg[1] .. " " .. msg[2], "CHANNEL", nil, 6) --chanID)
                  end
                  Roman.db.profile.messages.guildRecruit.zones[genZone] = GetServerTime()
                end
              end
            end
          end
          
          if Roman.db.profile.messages.guildRecruit.channels.Trade == true then
            if Roman:CheckTradeTime() == true then
              tradeChanID, tradeChanName = GetChannelName((GetChannelName("Trade - City")))
              if tradeChanName ~= nil then
                if msgLen > 254 then
                  RomanCTL:SendChatMessage("BULK", "roman", msg[2], "CHANNEL", nil, 6) --chanID)
                  RomanCTL:SendChatMessage("BULK", "roman", msg[1], "CHANNEL", nil, 6) --chanID)
                else
                  RomanCTL:SendChatMessage("BULK", "roman", msg[1] .. " " .. msg[2], "CHANNEL", nil, 6) --chanID)
                end
                local genZone = GetZoneText()
                Roman.db.profile.messages.guildRecruit.zones[genZone] = GetServerTime()
                Roman.db.profile.messages.guildRecruit.zones["Trade"] = GetServerTime()
              end
            end
          end

          if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
            if Roman:CheckLFGTime() == true then
              lfgChanID, lfgChanName = GetChannelName((GetChannelName("LookingForGroup")))
              if lfgChanName ~= nil then
                if msgLen > 254 then
                  RomanCTL:SendChatMessage("BULK", "roman", msg[2], "CHANNEL", nil, 6) --chanID)
                  RomanCTL:SendChatMessage("BULK", "roman", msg[1], "CHANNEL", nil, 6) --chanID)
                else
                  RomanCTL:SendChatMessage("BULK", "roman", msg[1] .. " " .. msg[2], "CHANNEL", nil, 6) --chanID)
                end
                Roman.db.profile.messages.guildRecruit.zones["LFG"] = GetServerTime()
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
    show_while_dead = false,
    on_show = function(self, data)
      Roman:Print("Roman On Show")
      local genChanName, tradeChanName, lfgChanName

      if Roman.db.profile.messages.guildRecruit.channels.General == true then
        if Roman:CheckZoneTime() == true then
          local genZone = GetZoneText()
          genChanID, genChanName = GetChannelName((GetChannelName("General - " .. genZone)))
          if genChanName ~= nil then
            if GetChannelName((GetChannelName("Trade - City"))) < 1 then
              genChanName = Roman:Colorize(genChanName, "rare") .. "\n"
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

      if Roman.db.profile.messages.guildRecruit.channels.Trade == true then
        if Roman:CheckTradeTime() == true then
          tradeChanID, tradeChanName = GetChannelName((GetChannelName("Trade - City")))
          if tradeChanName ~= nil then
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

      if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
        if Roman:CheckLFGTime() == true then
          lfgChanID, lfgChanName = GetChannelName((GetChannelName("LookingForGroup")))
          if lfgChanName ~= nil then
            lfgChanName = Roman:Colorize(lfgChanName, "rare") .. "\n"
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
      end
      
      local text = "Guild recruitment announcement can now be sent.\n\n" 
       .. "We will be announcing in the following channels:\n\n"
       .. "%s"
       .. "%s"
       .. "%s"
       if Roman.db.global.debug == true then
         Roman:Print("PopUp Text: " .. text)
       end
      
      self.text:SetFormattedText(text, genChanName, tradeChanName, lfgChanName)
    end,
    on_hide = function(self)
      Roman:Print("Roman On Hide")
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
      Roman.announceTimer = Roman:ScheduleTimer("RunAnnouncement", nextRun)
    end,
  })
end

function Roman:PopUp()
  RomanDialog:Spawn("GuildRecruitAnnounce")
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