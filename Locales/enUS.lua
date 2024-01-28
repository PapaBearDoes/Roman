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
L["BarkCanBeSent"] = "Guild recruitment bark can now be sent"
L["BarkPossibleAtApproximately"] = "bark possible at approximately"
L["CustomMessage"] = "Custom Recruitment Message (Limit 500 Chars) (Not Yet Implemented)"
L["Channel"] = true
L["Default"] = true
L["General"] = true
L["GeneralSettings"] = "General Settings"
L["GuildRecruitment"] = "Guild Recruitment"
L["LeftClick"] = "Left Click"
L["LeftClickToolTip"] = "Left Click Tooltip"
L["LFG"] = "Looking For Group"
L["LFGChanDesc"] = "Shall we bark in the Looking For Group channel? (You must be joined: '/join LookingForGroup')"
L["LockOutTimer"] = "Lock Out Time (Minutes)"
L["LockOutTimerDesc"] = "How long in between barks for each location?"
L["Next"] = true
L["Options"] = true
L["Profiles"] = true
L["RecruitmentMessage"] = "Recruitment Message"
L["RightClick"] = "Right Click"
L["RightClickToolTip"] = "Right Click Tooltip"
L["Settings"] = "Settings"
L["ShowMinimapButton"] = "Show Minimap Button"
L["ShowMinimapButtonDesc"] = "Show Minimap Button Description"
L["Trade"] = true
L["TradeChanDesc"] = "Shall we bark in the trade channel instead of General when available?"
L["Version"] = true
L["WeWillBarkInChannels"] = "We will be barking in the following channels"
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