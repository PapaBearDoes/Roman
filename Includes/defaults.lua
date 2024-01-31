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
-- Create any required hidden frames
Roman.frame = CreateFrame("GameTooltip")
Roman.frame:SetOwner(WorldFrame, "ANCHOR_NONE")

-- Create DB defaults
Roman.dbDefaults = {
  global = {
    debug = true,
    message = {
      type = {
        [1] = "GuildRecruitment",
        [2] = "Trade",
        [3] = "LookingForGroup",
        [4] = "Dungeons",
        [5] = "Raid",
        [6] = "Battleground",
        [7] = "Guild",
      },
      channel = {
        [1] = "General",
        [2] = "Trade",
        [3] = "LocalDefense",
        [4] = "LookingForGroup",
        [5] = "Trade(Services)",
        [6] = "Instance",
        [7] = "Party",
        [8] = "Raid",
        [9] = "RaidWarning",
        [10] = "Say",
        [11] = "Yell",
        [12] = "Guild",
        [13] = "Officer",
      },
    },
  },
  profile = {
    messages = {
      guildRecruit = {
        time = 45,
        channels = {
          General = true,
          Trade = true,
          LookingForGroup = true,
        },
        zones = {},
        useCustomMessage = false,
        customMessage = "",
      },
    },
    mmIcon = {
      hide = false,
      minimapPos = 205,
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