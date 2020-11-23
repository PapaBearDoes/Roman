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
--  Roman:RegisterEvent("PLAYER_DEAD", "ScheduleUpdate")
--  Roman:CreateDialogs()
  Roman:MiniMapIcon()
--  Roman:UpdateIcon()
--  Roman:ScheduleUpdate()
end

function Roman:doConfig()
	Roman:AddTestBark()
	--RomanDB.profile.options.phrases.barks = {}
	Roman:AddBarksList()
	LibStub("AceConfig-3.0"):RegisterOptionsTable(me, romanConfig, nil)
	local romanConfigDialog = LibStub("AceConfigDialog-3.0")
  RomanOptionFrames = {}
	RomanOptionFrames.settings = romanConfigDialog:AddToBlizOptions(me, me, nil, "settings")
end

function Roman:ShowConfig()
	InterfaceOptionsFrame_OpenToCategory(RomanOptionFrames.settings)
	InterfaceOptionsFrame_OpenToCategory(RomanOptionFrames.settings)
end

function Roman:MiniMapIcon()
  if RomanIcon == nil or not RomanIcon then
		RomanIcon = LibStub("LibDBIcon-1.0")
    RomanIcon:Register("RomanMapIcon", RLDB, RomanDB.profile.options.general.mmIcon)
  end
end

function Roman:OnInitialize()
	RomanDB:OnStartUp(function(self)
		RomanDB:AddToDefaults("global.addon", romanDefaults.globals)
		RomanDB:AddToDefaults("profile.options", romanDefaults.options)

		--Register For Updates to Config Changes
		--[[RomanDB:RegisterUpdateFunctions("RomanDB.profile.options.phrases", function()
			Roman:Print("Barks Updated!")
			Roman:UpdateConfigBarksList()
			LibStub("AceConfigRegistry-3.0"):NotifyChange(me)
		end)]]--

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

function Roman:AddTestBark()
	RomanDB.profile.options.phrases.barks = {
		{
			categories = {
				true, true, false,
			},
			channels = {
				true, --General
				true, --Trade
				false, --LocalDefense
				true, -- Say
			},
			time = {
				min = 30,
				max = 300,
				pause = 3,
			},
			bark = {
				"Line 1 of bark.  Trunc",
				"ated add to bark",
			},
		},
		{
			categories = {
				true, false, true,
			},
			channels = {
				true, --General
				true, --Trade
				false, --LocalDefense
				true, -- Say
			},
			time = {
				min = 30,
				max = 300,
				pause = 3,
			},
			bark = {
				"Line 1 of bark.  Tru",
				"ncated add to bark",
			},
		},
  }

  RomanDB.profile.options.phrases.barks:Print(5)
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
