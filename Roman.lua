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
end

function Roman:OnEnable()
  local RomanDialog = LibStub("AceConfigDialog-3.0")
  RomanFrames = {}
  RomanFrames.general = RomanDialog:AddToBlizOptions(myName, nil, nil, L["general"])
  RomanOptionFrames.profile = RomanDialog:AddToBlizOptions(myName, L["Profiles"], myName, L["profile"])
end

function Roman:ShowConfig()
  InterfaceOptionsFrame_OpenToCategory(RomanFrames.general)
  InterfaceOptionsFrame_OpenToCategory(RomanFrames.custom)
  InterfaceOptionsFrame_OpenToCategory(RomanFrames.profile)
end

function Roman:UpdateOptions()
  LibStub("AceConfigRegistry-3.0"):NotifyChange(me)
end

function Roman:UpdateProfile()
  Roman:ScheduleTimer("UpdateProfileDelayed", 0)
end

function Roman:OnProfileChanged(event, database, newProfileKey)
  Roman.db.profile = database.profile
end

function Roman:UpdateProfileDelayed()
  for timerKey, timerValue in Roman:IterateModules() do
    if timerValue.db.profile.on then
      if timerValue:IsEnabled() then
        timerValue:Disable()
        timerValue:Enable()
      else
        timerValue:Enable()
      end
    else
      timerValue:Disable()
    end
  end
  Roman:UpdateOptions()
end

function Roman:OnProfileReset()
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