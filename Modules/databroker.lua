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
--Durrr = select(2, ...)
local me, ns = ...
local Roman = ns
local RomanDB = LibStub("LibMayronDB"):GetDatabaseByName("RomanDB")
local L = Roman:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
-- Do LDB stuff --
RomanLDB = LibStub("LibDataBroker-1.1")
RLDB = RomanLDB:NewDataObject("RomanLDB", {
  type = "data source",
  label = "",
  text = "",
  icon = "",
  OnClick = function(frame, click)
    if click == "RightButton" then
      Roman:ShowConfig()
    end
    Roman:MainUpdate()
  end,
  OnTooltipShow = function(tooltip)
    if not tooltip or not tooltip.AddLine then return end
    tooltip:AddLine(L["AddonName"] .. " " .. GetAddOnMetadata(me, "Version"))
    tooltip:AddLine(" ")

    tooltip:AddLine(Roman:Colorize(L["RightClick"] .. " ", "eda55f") .. L["RightToolTip"])
  end,
})

function Roman:MainUpdate()
end

function Roman:UpdateIcon()
end
-- End LDB stuff --

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
