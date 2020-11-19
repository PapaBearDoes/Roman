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
local RomanDB = LibStub("LibMayronDB"):GetDatabaseByName("RomanDB")
local L = Roman:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
RomanDB.options = {
  type = "group",
  name = "Roman",
  args = {
    general = {
      order = 1,
      type = "group",
      name = L["GeneralSettings"],
      cmdInline = true,
      args = {
        separator1 = {
          type = "header",
          name = "",
          order = 1,
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
