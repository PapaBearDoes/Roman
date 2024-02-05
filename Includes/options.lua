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
--OptionsTable
Roman.options = {
  type = "group",
  name = myName,
  args = {
    settings = {
      order = 1,
      type = "group",
      name = L["Settings"],
      childGroups = "tab",
      cmdInline = true,
      args = {
        generalSettings = {
          order = 1,
          type = "group",
          name = L["GeneralSettings"],
          cmdInline = true,
          args = {
            separator1 = {
              order = 1,
              type = "header",
              width = "full,",
              name = L["Options"],
            },
            generalChan = {
              order = 2,
              type = "toggle",
              width = "normal",
              name = L["General"] .. " " .. L["Channel"],
              desc = L["GeneralChanDesc"],
              get = function()
                return Roman.db.profile.messages.guildRecruit.channels.General
              end,
              set = function(key, value)
                Roman.db.profile.messages.guildRecruit.channels.General = value
                if not Roman.db.profile.messages.guildRecruit.channels.General then
                  Roman.db.profile.messages.guildRecruit.channels.General = value
                end
              end,
            },
            tradeChan = {
              order = 3,
              type = "toggle",
              width = "normal",
              name = L["Trade"] .. " " .. L["Channel"],
              desc = L["TradeChanDesc"],
              get = function()
                return Roman.db.profile.messages.guildRecruit.channels.Trade
              end,
              set = function(key, value)
                Roman.db.profile.messages.guildRecruit.channels.Trade = value
                if not Roman.db.profile.messages.guildRecruit.channels.Trade then
                  Roman.db.profile.messages.guildRecruit.channels.Trade = value
                end
              end,
            },
            LFGChan = {
              order = 4,
              type = "toggle",
              width = "double",
              name = L["LFG"] .. " " .. L["Channel"],
              desc = L["LFGChanDesc"],
              get = function()
                return Roman.db.profile.messages.guildRecruit.channels.LookingForGroup
              end,
              set = function(key, value)
                Roman.db.profile.messages.guildRecruit.channels.LookingForGroup = value
                if not Roman.db.profile.messages.guildRecruit.channels.LookingForGroup then
                  Roman.db.profile.messages.guildRecruit.channels.LookingForGroup = value
                end
              end,
            },
            useCustomMessage = {
              order = 5,
              type = "toggle",
              width = "double",
              name = L["UseCustomMessage"],
              desc = L["UseCustomMessageDesc"],
              get = function()
                return Roman.db.profile.messages.guildRecruit.useCustomMessage
              end,
              set = function(key, value)
                Roman.db.profile.messages.guildRecruit.useCustomMessage = value
                if not Roman.db.profile.messages.guildRecruit.useCustomMessage then
                  Roman.db.profile.messages.guildRecruit.useCustomMessage = value
                end
              end,
            },
            showMinimapButton = {
              order = 6,
              type = "toggle",
              width = "normal",
              name = L["ShowMinimapButton"],
              desc = L["ShowMinimapButtonDesc"],
              get = function()
                if Roman.db.profile.mmIcon.hide == true then
                  show = false
                else
                  show = true
                end
                return show
              end,
              set = function(key, value)
                if value == true then
                  Roman.db.profile.mmIcon.hide = false
                  RomanIcon:Show(myName .. "_mapIcon")
                else
                  Roman.db.profile.mmIcon.hide = true
                  RomanIcon:Hide(myName .. "_mapIcon")
                end
              end
            },
            separator2 = {
              order = 7,
              type = "header",
              width = "full",
              name = "",
            },
            lockoutTime = {
              order = 8,
              type = "range",
              width = "full",
              name = L["LockOutTimer"],
              desc = L["LockOutTimerDesc"],
              min = 15,
              max = 120,
              step = 5,
              get = function()
                return Roman.db.profile.messages.guildRecruit.time
              end,
              set = function(key, value)
                Roman.db.profile.messages.guildRecruit.time = value
                if not Roman.db.profile.messages.guildRecruit.time then
                  Roman.db.profile.messages.guildRecruit.time = value
                end
              end,
            },
            separator3 = {
              order = 9,
              type = "header",
              width = "full",
              name = L["ResetZoneBarkTimes"],
            },
            resetZoneBarkTimesDescription = {
              order = 10,
              type = "description",
              fontSize = "medium",
              name = L["ResetZoneBarkTimesDesc"],
            },
            resetZoneBarkTimes = {
              order = 11,
              type = "execute",
              name = L["ResetZoneBarkTimes"],
              func = function()
                if Roman.db.global.debug == true then
                  Roman:Print("SavedVariables Before Reset:")
                  for k, v in pairs(Roman.db.profile.messages.guildRecruit.zones) do
                    Roman:Print(k .. " => " .. v)
                  end
                end

                  Roman.db.profile.messages.guildRecruit.zones = {}

                  local genChanID, genChanName = GetChannelName(L["General"])
                  local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])
                  Roman.db.profile.messages.guildRecruit.zones[genChanName] = GetServerTime()
                  Roman.db.profile.messages.guildRecruit.zones["Trade - City"] = GetServerTime()
                  Roman.db.profile.messages.guildRecruit.zones[lfgChanName] = GetServerTime()
                  
                  if Roman.db.global.debug == false then
                    ReloadUI();
                  end

                if Roman.db.global.debug == true then
                  Roman:Print("SavedVariables After Reset:")
                  for k, v in pairs(Roman.db.profile.messages.guildRecruit.zones) do
                    Roman:Print(k .. " => " .. v)
                  end
                end
              end,
            },
          },
        },
        recruitmentMessage = {
          order = 2,
          type = "group",
          name = L["RecruitmentMessage"],
          cmdInline = true,
          args = {
            separator10 = {
              order = 1,
              type = "header",
              width = "full",
              name = L["RecruitmentMessage"],
            },
            defaultMessage = {
              order = 2,
              type = "description",
              width = "full",
              fontSize = "medium",
              name = function()
                local guildInfo = ClubFinderGetCurrentClubListingInfo(C_Club.GetGuildClubId())
                local guildLink = GetClubFinderLink(guildInfo.clubFinderGUID, guildInfo.name)
                local guildComment = guildInfo.comment
                guildComment = string.gsub(guildComment, "%s+", " ")
                msg = guildLink .. " " .. guildComment
                return msg 
              end,
            },
            separator11 = {
              order = 3,
              type = "header",
              width = "full",
              name = "",
            },
            customMessage = {
              order = 4,
              type = "input",
              width = "full",
              multiline = true,
              validate = function(i, str)
                if string.len(str) > 254 then
                  return L["CharLimit"] .. string.len(str)
                else
                  return true
                end
              end,
              hidden = function()
                if Roman.db.profile.messages.guildRecruit.useCustomMessage == true then
                  return false
                else
                  return true
                end
              end,
              name = L["CustomMessage"],
              get = function()
                local msg = Roman.db.profile.messages.guildRecruit.customMessage
                return msg
              end,
              set = function(key, value)
                Roman.db.profile.messages.guildRecruit.customMessage = value
                if not Roman.db.profile.messages.guildRecruit.customMessage then
                  Roman.db.profile.messages.guildRecruit.customMessage = value
                end
              end,
            },
          },
        },
      },
    },
  },
}
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