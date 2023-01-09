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
Roman:SetDefaultModuleLibraries("AceConfig-3.0", "AceConsole-3.0", "AceDB-3.0", "AceDBOptions-3.0", "AceEvent-3.0", "AceGUI-3.0", "AceHook-3.0", "AceLocale-3.0", "AceTimer-3.0")
Roman:SetDefaultModuleState(true)
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

  -- Enable/disable modules based on saved settings
	for name, module in Roman:IterateModules() do
		module:SetEnabledState(Roman.db.profile.moduleEnabledState[name] or false)
    if module.OnEnable then
      hooksecurefunc(module, "OnEnable", Roman.OnModuleEnable_Common)
    end
  end

  --Roman:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
  Roman:MiniMapIcon()
end

function Roman:OnEnable()
  local RomanDialog = LibStub("AceConfigDialog-3.0")
  RomanFrames = {}
  RomanFrames.general = RomanDialog:AddToBlizOptions(myName, nil, nil, L["general"])
  RomanOptionFrames.profile = RomanDialog:AddToBlizOptions(myName, L["Profiles"], myName, L["profile"])
end

function Roman:OnModuleEnable_Common()
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