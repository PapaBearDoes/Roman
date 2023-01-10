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

  --Roman:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
  Roman:MiniMapIcon()
  Roman:Main()
end

function Roman:OnEnable()
  local RomanOptionsDialog = LibStub("AceConfigDialog-3.0")
  RomanOptionFrames = {}
  RomanOptionFrames.general = RomanOptionsDialog:AddToBlizOptions(myName, nil, nil, L["general"])
  RomanOptionFrames.profile = RomanOptionsDialog:AddToBlizOptions(myName, L["Profiles"], myName, L["profile"])
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