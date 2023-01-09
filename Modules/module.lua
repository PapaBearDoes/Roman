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
local moduleLibs = {
  "AceConfig-3.0",
  "AceConsole-3.0",
  "AceDB-3.0",
  "AceDBOptions-3.0",
  "AceEvent-3.0",
  "AceGUI-3.0",
  "AceHook-3.0",
  "AceLocale-3.0",
  "AceTimer-3.0"
}
local RomanModule = Roman:NewModule("RomanModule", moduleLibs)
local L = Roman:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!

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