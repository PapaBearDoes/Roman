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
romanConfig = {
  type = "group",
  name = me,
  args = {
    general = {
      order = 1,
      type = "group",
      name = L["GeneralSettings"],
      args = {
        separator1 = {
          type = "header",
          name = "This is a Header",
          order = 1,
        },
        testOption = {
          order = 2,
          type = "toggle",
          name = "TestToggle",
          get = function()
            return RomanDB.profile.options.general.testOption
          end,
          set = function(key, value)
            RomanDB.profile.options.general.testOption = value
          end,
        },
      },
    },
  },
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
