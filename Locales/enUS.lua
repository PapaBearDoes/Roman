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
local myName, addon = ...
local L = LibStub("AceLocale-3.0"):NewLocale(myName, "enUS", true)
local L = L or {}
-- End Imports
--[[ ######################################################################## ]]
--[[
L["Phrase"] = "Translation"
L["Phrase"] = true
L["SubNameSpace"] = {
  L["Phrase"] = "Translation"
  L["Phrase"] = true
}
]]
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
-- enUS Localization
--@localization(locale="enUS", format="lua_additive_table", same-key-is-true=true, handle-subnamespaces="subtable")@
L["GeneralSettings"] = "General Settings"
L["GuildRecruitment"] = "Guild Recruitment"
L["Trade"] = true
L["LFG"] = "Looking For Group"
L["Profiles"] = true
L["Options"] = true
L["Default"] = true
L["ShowMinimapButton"] = "Show Minimap Button"
L["ShowMinimapButtonDesc"] = "Show Minimap Button Description"
L["Version"] = true
L["RightClick"] = "Right Click"
L["RightClickToolTip"] = "Right Click Tooltip"
L["MessageBarkerForWoW"] = "Message Barker for WoW"

L["DoThing"] = "Do The Thing"
L["DoThingDesc"] = "Do The Thing Description"
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