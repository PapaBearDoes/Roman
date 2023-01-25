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
    recruit = {
      order = 1,
      type = "group",
      name = L["GuildRecruitment"],
      cmdInline = true,
      args = {
        separator1 = {
          order = 1,
          type = "header",
          name = L["GuildRecruitment"],
        },
        useGuildFinder = {
          order = 2,
          type = "toggle",
          name = L["UseGuildFinder"],
          desc = L["UseGuildFinderDesc"],
          get = function()
            return Roman.db.profile.messages.guildRecruit.useGuildFinder
          end,
          set = function(key, value)
            Roman.db.profile.messages.guildRecruit.useGuildFinder = value
            if not Roman.db.profile.messages.guildRecruit.useGuildFinder then
              Roman.db.profile.messages.guildRecruit.useGuildFinder = value
            end
          end,
        },
      },
    },
--[[    trade = {
      order = 2,
      type = "group",
      name = L["Trade"],
      cmdInline = true,
      args = {
        separator1 = {
          order = 1,
          type = "header",
          name = L["Trade"],
        },
        doThing = {
          order = 2,
          type = "toggle",
          name = L["DoThing"],
          desc = L["DoThingDesc"],
          get = function()
            return Roman.db.profile.doThing
          end,
          set = function(key, value)
            Roman.db.profile.doThing = value
            if not Roman.db.profile.doThjing then
              Roman.db.profile.doThing = value
            end
          end,
        },
      },
    },
    LFG = {
      order = 3,
      type = "group",
      name = L["LFG"],
      cmdInline = true,
      args = {
        separator1 = {
          order = 1,
          type = "header",
          name = L["LFG"],
        },
        doThing = {
          order = 2,
          type = "toggle",
          name = L["DoThing"],
          desc = L["DoThingDesc"],
          get = function()
            return Roman.db.profile.doThing
          end,
          set = function(key, value)
            Roman.db.profile.doThing = value
            if not Roman.db.profile.doThjing then
              Roman.db.profile.doThing = value
            end
          end,
        },
      },
    },]]
    settings = {
      order = 4,
      type = "group",
      name = L["GeneralSettings"],
      cmdInline = true,
      args = {
        separator1 = {
          order = 1,
          type = "header",
          name = L["Options"],
        },
        --[[doThing = {
          order = 2,
          type = "toggle",
          name = L["DoThing"],
          desc = L["DoThingDesc"],
          get = function()
            return Roman.db.profile.doThing
          end,
          set = function(key, value)
            Roman.db.profile.doThing = value
            if not Roman.db.profile.doThjing then
              Roman.db.profile.doThing = value
            end
          end,
        },]]
        showMinimapButton = {
          order = 5,
          type = "toggle",
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