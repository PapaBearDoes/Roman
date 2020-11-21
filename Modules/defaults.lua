--[[
                                      \\\\///
                                     /       \
                                   (| (.)(.) |)
     .---------------------------.OOOo--()--oOOO.---------------------------.
     |                                                                      |
     |  @file-author@'s Roman Addon for World of Warcraft
     ######################################################################## ]]
--   ## Let's init this file shall we?
-- Imports
local _G = _G
--Durrr = select(2, ...)
local me, ns = ...
local Roman = ns
local L = Roman:GetLocale()
local RomanDB = LibStub("LibMayronDB"):GetDatabaseByName("RomanDB")
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
-- Create DB defaults
romanDefaults.options = {
  general = {
    mmIcon = {
      minimapPos = 245,
      hide = false,
    },
  },
  phrases = {
    categories = {},
  },
}

-- Globals Table
romanDefaults.globals = {
  enableTasks = {},
}

--[[
     ########################################################################
     |  Last Editted By: @file-author@ - @file-date-iso@
     |  @file-revision@
     |                                                                      |
     '-------------------------.oooO----------------------------------------|
                              (    )     Oooo.
                              \  (     (    )
                               \__)     )  /
                                       (__/                                   ]]
