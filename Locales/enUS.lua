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
local me, ns = ...
local lang = GetLocale()
local l = LibStub("AceLocale-3.0")
local L = l:NewLocale(me, "enUS", true, true)
if not L then return end
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!

--@localization(locale="enUS", format="lua_additive_table")@

--@do-not-package@
L["ErrorDB"] = "Error: Database not loaded correctly. Exit WoW and delete Durrrability.lua found in your SavedVariables folder"
L["AddonName"] = "Roman"
L["Profiles"] = "Profiles"
L["RightClick"] = "Right-Click"
L["RightToolTip"] = "to open the options menu."
L["LeftClick"] = "Left-Click"
L["LeftToolTip"] = "to do something."
L["GeneralSettings"] = "General Settings"
--@end-do-not-package@

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
