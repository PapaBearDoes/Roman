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
--LDB
AddonStub_LDB = LibStub("LibDataBroker-1.1")
AddonStubLDB = AddonStub_LDB:NewDataObject("DadGratzLDB", {
  type = "data source",
  label = myName,
  text = "",
  icon = "Interface\\Icons\\Achievement_guildperk_bartering",
  OnClick = function(frame, click)
    if click == "RightButton" then
      AddonStub:ShowConfig()
    end
  end,
  OnTooltipShow = function(tooltip)
    if not tooltip or not tooltip.AddLine then
      return
    end
    tooltip:AddLine(myName .. " " .. GetAddOnMetadata(myName, L["Version"]))
    
    tooltip:AddLine(" ")
    tooltip:AddLine(AddonStub:Colorize(L["RightClick"] .. " ", "eda55f") .. L["RightClickToolTip"])
  end,
})

function AddonStub:MiniMapIcon()
  AddonStubIcon = LibStub("LibDBIcon-1.0")
  if not AddonStubIcon:IsRegistered(myName .. "_mapIcon") then
    AddonStubIcon:Register(myName .. "_mapIcon", AddonStubLDB, AddonStub.db.profile.mmIcon)
  end
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