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
local _G = _G
local me, ns = ...
local Roman = LibStub("LibInit"):NewAddon(ns, me, true, "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
local RomanDB = LibStub("LibMayronDB"):CreateDatabase(me, "RomanSV", false, "RomanDB")
local L = Roman:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
function Roman:OnInitialize()
  if not RomanDB then
    local errorDB = L["ErrorDB"]
    Roman:print(errorDB)
  end

  RomanDB:OnStartUp(function(self)
    -- your code here!
    -- self is a reference to the database.
  end);

  RomanDB:OnProfileChange(function(self, newProfileName, oldProfileName)
    self:TriggerUpdateFunction("profile.myModule.width");
  end)

  RomanDB:AddToDefaults("global", RomanDB.defaults)
  RomanDB:AddToDefaults("profile", RomanDB.defaults)

--[[  LibStub("AceConfig-3.0"):RegisterOptionsTable(me, Roman.options, nil)

  -- Enable/disable modules based on saved settings
	for name, module in Roman:IterateModules() do
		module:SetEnabledState(RomanDB.profile.moduleEnabledState[name] or false)
    if module.OnEnable then
      hooksecurefunc(module, "OnEnable", Roman.OnModuleEnable_Common)
    end
  end

  Roman:RegisterEvent("PLAYER_DEAD", "ScheduleUpdate")
  Roman:CreateDialogs()
  Roman:MiniMapIcon()
  Roman:UpdateIcon()
  Roman:ScheduleUpdate() ]]--
end

--[[function Roman:OnModuleEnable_Common()
end

function Roman:MiniMapIcon()
  if icon == nil or not icon then
    icon = LDB and LibStub("LibDBIcon-1.0")
    icon:Register("Roman_MapIcon", RomanLDB)
  end
end ]]--

function Roman:OnEnable()
  --[[local Roman_Dialog = LibStub("AceConfigDialog-3.0")
  Roman_OptionFrames = {}
  Roman_OptionFrames.general = Roman_Dialog:AddToBlizOptions("Roman", nil, nil, "general")
  Roman_OptionFrames.profile = Roman_Dialog:AddToBlizOptions("Roman", L["Profiles"], "Roman", "profile")
  Roman:ScheduleRepeatingTimer("MainUpdate", 1) ]]--
  RomanDB:PrintDefaults(5)
end

--[[
function Roman:OnDisable()
end

-- Config window --
function Roman:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(Roman_OptionFrames.profile)
	InterfaceOptionsFrame_OpenToCategory(Roman_OptionFrames.general)
end
-- End Options --

function Roman:UpdateOptions()
  LibStub("AceConfigRegistry-3.0"):NotifyChange(me)
end

function Roman:UpdateProfile()
  Roman:ScheduleTimer("UpdateProfileDelayed", 0)
end

function Roman:OnProfileChanged(event, database, newProfileKey)
  RomanDB.profile = database.profile
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
end ]]--
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
