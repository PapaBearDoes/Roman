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
      name = L["GeneralSettings"],
      cmdInline = true,
      args = {
        separator1 = {
          order = 1,
          type = "header",
          width = "full,",
          name = L["Options"],
        },
        tradeChan = {
          order = 2,
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
          order = 3,
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
        showMinimapButton = {
          order = 4,
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
          order = 5,
          type = "header",
          width = "full",
          name = "",
        },
        lockoutTime = {
          order = 6,
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
          order = 7,
          type = "header",
          width = "full",
          name = "Recruitment Message",
        },
        recruitmentMessage = {
          order = 8,
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