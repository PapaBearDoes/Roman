--[[
                                      \\\\///
                                     /       \
                                   (| (.)(.) |)
     .---------------------------.OOOo--()--oOOO.---------------------------.
     |                                                                      |
     |  PapaBearDoes's AddonStub Addon for World of Warcraft                 |
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
local AddonStub = LibStub("LibInit"):NewAddon(addon, myName, initOptions, true)
AddonStub:SetDefaultModuleLibraries("AceConfig-3.0", "AceConsole-3.0", "AceDB-3.0", "AceDBOptions-3.0", "AceEvent-3.0", "AceGUI-3.0", "AceHook-3.0", "AceLocale-3.0", "AceTimer-3.0")
AddonStub:SetDefaultModuleState(true)
local L = AddonStub:GetLocale()
-- End Imports
--   ######################################################################## ]]
--   ## Do All The Things!!!
--[[FUNCTIONS]]
function AddonStub:OnInitialize()
  AddonStub.db = LibStub("AceDB-3.0"):New("AddonStubSV", AddonStub.dbDefaults, "Default")
  AddonStub.db.RegisterCallback(self, "OnProfileChanged", "UpdateProfile")
  AddonStub.db.RegisterCallback(self, "OnProfileCopied", "UpdateProfile")
  AddonStub.db.RegisterCallback(self, "OnProfileReset", "UpdateProfile")
  
  AddonStub.options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(AddonStub.db)
  LibStub("AceConfig-3.0"):RegisterOptionsTable(myName, AddonStub.options, nil)

  -- Enable/disable modules based on saved settings
	for name, module in AddonStub:IterateModules() do
		module:SetEnabledState(AddonStub.db.profile.moduleEnabledState[name] or false)
    if module.OnEnable then
      hooksecurefunc(module, "OnEnable", AddonStub.OnModuleEnable_Common)
    end
  end

  --AddonStub:RegisterEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
  AddonStub:MiniMapIcon()
end

function AddonStub:OnEnable()
  local AddonStubDialog = LibStub("AceConfigDialog-3.0")
  AddonStubFrames = {}
  AddonStubFrames.general = AddonStubDialog:AddToBlizOptions(myName, nil, nil, L["general"])
  AddonStubOptionFrames.profile = AddonStubDialog:AddToBlizOptions(myName, L["Profiles"], myName, L["profile"])
end

function AddonStub:OnModuleEnable_Common()
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