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
local Roman = addon
local L = Roman:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
--LDB
Roman_LDB = LibStub("LibDataBroker-1.1")
RomanLDB = Roman_LDB:NewDataObject("RomanLDB", {
  type = "data source",
  label = myName,
  text = myName,
  icon = "Interface\\Icons\\Inv_aussiepup_bcollie",
  OnClick = function(frame, click)
    if click == "RightButton" then
      Roman:ShowConfig("")
    elseif click == "LeftButton" then
      Roman:CheckTimes()
    end
  end,
  OnTooltipShow = function(tooltip)
    local genChanID, genChanName = GetChannelName(L["General"])
    local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])
    if not tooltip or not tooltip.AddLine then
      return
    end
    tooltip:AddLine(myName .. " " .. GetAddOnMetadata(myName, L["Version"]))
    tooltip:AddLine(L["Next"] .. " " .. Roman:Colorize(genChanName, "uncommon") .. " " .. L["BarkPossibleAtApproximately"] .. ": " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[genChanName] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    if Roman.db.profile.messages.guildRecruit.channels.Trade == true then
      tooltip:AddLine(L["Next"] .. " " .. Roman:Colorize(L["TradeChanName"], "rare") .. " " .. L["BarkPossibleAtApproximately"] .. ": " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[L["TradeChanName"]] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
    if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
      tooltip:AddLine(L["Next"] .. " " .. Roman:Colorize(lfgChanName, "epic") .. " " .. L["BarkPossibleAtApproximately"] .. ": " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[lfgChanName] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
    tooltip:AddLine(" ")
    tooltip:AddLine(Roman:Colorize(L["RightClick"] .. " ", "eda55f") .. L["RightClickToolTip"])
  end,
})

function Roman:MiniMapIcon()
  RomanIcon = LibStub("LibDBIcon-1.0")
  if not RomanIcon:IsRegistered(myName .. "_mapIcon") then
    RomanIcon:Register(myName .. "_mapIcon", RomanLDB, Roman.db.profile.mmIcon)
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