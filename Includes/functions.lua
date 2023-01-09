--[[
                                      \\\\///
                                     /       \
                                   (| (.)(.) |)
     .---------------------------.OOOo--()--oOOO.---------------------------.
     |                                                                      |
     |  PapaBearDoes's DadGratz Addon for World of Warcraft                 |
     |  @project-version@
     ######################################################################## ]]
--   ## Let's init this file shall we?
-- Imports
local _G = _G
local myName, addon = ...
local AddonStub = addon
local L = AddonStub:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
--[[ Addon Functions ]]
--[[ End Addon Functions ]]

--[[ Main Functions ]]
function AddonStub:ShowConfig()
  InterfaceOptionsFrame_OpenToCategory(AddonStubFrames.general)
  InterfaceOptionsFrame_OpenToCategory(AddonStubFrames.custom)
  InterfaceOptionsFrame_OpenToCategory(AddonStubFrames.profile)
end

function AddonStub:UpdateOptions()
  LibStub("AceConfigRegistry-3.0"):NotifyChange(me)
end

function AddonStub:UpdateProfile()
  AddonStub:ScheduleTimer("UpdateProfileDelayed", 0)
end

function AddonStub:OnProfileChanged(event, database, newProfileKey)
  AddonStub.db.profile = database.profile
end

function AddonStub:UpdateProfileDelayed()
  for timerKey, timerValue in AddonStub:IterateModules() do
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
  AddonStub:UpdateOptions()
end

function AddonStub:OnProfileReset()
end
--[[ End Main Functions ]]
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