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
local initOptions = {
  profile = "Default",
  noswitch = false,
  nogui = false,
  nohelp = false,
  enhancedProfile = true
}
local Roman = LibStub("LibInit"):NewAddon(addon, myName, initOptions, true)
local L = Roman:GetLocale()
-- End Imports
--   ######################################################################## ]]
--   ## Do All The Things!!!
--[[FUNCTIONS]]
function Roman:OnInitialize()
  Roman.db = LibStub("AceDB-3.0"):New("RomanSV", Roman.dbDefaults, "Default")
  Roman.db.RegisterCallback(self, "OnProfileChanged", "UpdateProfile")
  Roman.db.RegisterCallback(self, "OnProfileCopied", "UpdateProfile")
  Roman.db.RegisterCallback(self, "OnProfileReset", "UpdateProfile")
  
  Roman.options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(Roman.db)
  LibStub("AceConfig-3.0"):RegisterOptionsTable(myName, Roman.options, nil)

  Roman:RegisterEvent("ZONE_CHANGED_NEW_AREA")
  Roman:RegisterChatCommand("roman", "ShowUI")
  
  Roman:Init()
  
  Roman:Main()
  
  Roman:Print("Addon Loaded")
  if Roman.db.profile.debug == true then
    Roman:Print("Debug On")
  end
end

function Roman:OnEnable()
  local RomanOptionsDialog = LibStub("AceConfigDialog-3.0")
  RomanOptionFrames = {}
  RomanOptionFrames.settings = RomanOptionsDialog:AddToBlizOptions(myName, nil, nil, "settings")
  RomanOptionFrames.recruit = RomanOptionsDialog:AddToBlizOptions(myName, L["GuildRecruitment"], myName, "recruit")
--  RomanOptionFrames.trade = RomanOptionsDialog:AddToBlizOptions(myName, L["Trade"], myName, "trade")
--  RomanOptionFrames.LFG = RomanOptionsDialog:AddToBlizOptions(myName, L["LFG"], myName, "LFG")
  RomanOptionFrames.profile = RomanOptionsDialog:AddToBlizOptions(myName, L["Profiles"], myName, "profile")
end

function Roman:ShowConfig()
  InterfaceOptionsFrame_OpenToCategory(RomanOptionFrames.settings)
end
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