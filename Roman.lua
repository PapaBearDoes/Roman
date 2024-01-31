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
local Roman = LibStub("LibInit"):NewAddon(addon, myName, initOptions, true, "AceComm-3.0", "AceSerializer-3.0")
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
  Roman:RegisterChatCommand("roman", "ShowConfig")
  
  Roman:Init()
  
  Roman:Print("Addon Loaded")
  if Roman.db.profile.debug == true then
    Roman:Print("Debug On")
  end
end

function Roman:OnEnable()
  local RomanOptionsDialog = LibStub("AceConfigDialog-3.0")
  RomanOptionFrames = {}
  RomanOptionFrames.settings = RomanOptionsDialog:AddToBlizOptions(myName, nil, nil, "settings")
  RomanOptionFrames.profile = RomanOptionsDialog:AddToBlizOptions(myName, L["Profiles"], myName, "profile")
end

function Roman:ShowConfig(args)
  local arg = Roman:GetArgs(args)
  if arg == "time" then
    Roman:CheckTimes()
  else
    InterfaceOptionsFrame_OpenToCategory(RomanOptionFrames.settings)
  end
end

function Roman:Init()
  Roman:MiniMapIcon()
  Roman:RegisterComm("Roman-BarkTimers", "ReceiveBarkTimers")
  Roman:ScheduleTimer("CreateDialogs", 1)
  Roman:ScheduleTimer("ZONE_CHANGED_NEW_AREA", 5)
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