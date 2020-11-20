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
local romanInitOptions = {
	profile = "Default",
	noswitch = false,
	nogui = true,
	nohelp = true,
	enhancedProfile = false,
}
local Roman = LibStub("LibInit"):NewAddon(ns, me, romanInitOptions, true)
local L = Roman:GetLocale()
local RomanDB = LibStub("LibMayronDB"):CreateDatabase(me, "RomanSV", false, "RomanDB")
romanDefaults = {}
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
function Roman:doStartup()
  -- Enable/disable modules based on saved settings
	for name, module in Roman:IterateModules() do
		module:SetEnabledState(RomanDB.profile.modules.enabledState[name] or false)
    if module.OnEnable then
      hooksecurefunc(module, "OnEnable", Roman.OnModuleEnable_Common)
    end
  end

--  Roman:RegisterEvent("PLAYER_DEAD", "ScheduleUpdate")
--  Roman:CreateDialogs()
--  Roman:MiniMapIcon()
--  Roman:UpdateIcon()
--  Roman:ScheduleUpdate() ]]--
end

function Roman:doConfig()
	LibStub("AceConfig-3.0"):RegisterOptionsTable(me, romanConfig, nil)
	local romanConfigDialog = LibStub("AceConfigDialog-3.0")
  RomanOptionFrames = {}
	RomanOptionFrames.general = romanConfigDialog:AddToBlizOptions(me, nil, nil, "general")
end

function Roman:OnModuleEnable_Common()
end

--[[function Roman:MiniMapIcon()
  if icon == nil or not icon then
    icon = LDB and LibStub("LibDBIcon-1.0")
    icon:Register("Roman_MapIcon", RomanLDB)
  end
end ]]--

function Roman:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(RomanOptionFrames.general)
	InterfaceOptionsFrame_OpenToCategory(RomanOptionFrames.general)
end

--[[
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

function Roman:OnInitialize()
	RomanDB:OnStartUp(function(self)
		RomanDB:AddToDefaults("global.addon", romanDefaults.globals)
		RomanDB:AddToDefaults("profile.options", romanDefaults.options)

		RomanDB:RegisterUpdateFunctions("profile.options.general", {
			testOption = function(value)
				LibStub("AceConfigRegistry-3.0"):NotifyChange(me)
				Roman:Print("testOption Updated to: ")
				Roman:Print(RomanDB.profile.options.general.testOption)
			end
		})

		RomanDB.global:Print(10)
		RomanDB.profile:Print(10)

		Roman:doStartup()
	end)
end

function Roman:OnEnable()
	Roman:doConfig()
end

function Roman:OnDisable()
end
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
