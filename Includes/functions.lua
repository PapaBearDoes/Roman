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
function Roman:GetGuildInfo()
  local guildInfo = ClubFinderGetCurrentClubListingInfo(C_Club.GetGuildClubId())
  local guildLink = GetClubFinderLink(guildInfo.clubFinderGUID, guildInfo.name)
  local guildComment = guildInfo.comment
  guildComment = string.gsub(guildComment, "%s+", " ")
  return guildComment, guildLink
end

function Roman:MakeGuildRecruitMessage()
  local guildComment, guildLink = Roman:GetGuildInfo()
  guildCommentLength = string.len(guildComment)
  if Roman.db.global.debug == true then
    Roman:Print("Comment Length: " .. guildCommentLength)
  end
  guildLinkLength = string.len(guildLink)
  if Roman.db.global.debug == true then
    Roman:Print("Link Length: " .. guildLinkLength)
  end
  msgMax = 1 + (255 - guildLinkLength)
  if Roman.db.global.debug == true then
    Roman:Print("Message Max: " .. msgMax)
  end
  
  local message = {}
  message[1] = guildLink
  message[2] = guildComment
  
  if Roman.db.global.debug == true then
    Roman:Print("Message 1: " .. message[1])
    Roman:Print("Message 2: " .. message[2])
  end
  
  return message
end

function Roman:ZONE_CHANGED_NEW_AREA()
  -- Check if instance
  local inInstance, _ = IsInInstance()
  if inInstance == true then
    if Roman.db.global.debug == true then
      Roman:Print("You are in an instance, we're not going to announce.")
    end
  else
    if Roman.db.global.debug == true then
      Roman:Print("No instance, continuing announcement checks.")
    end
    local checkTimer = Roman:TimeLeft(Roman.pauseBreathe)
    if checkTimer ~= nil and checkTimer > 0 then
      if Roman.db.global.debug == true then
        Roman:Print("Paused ... cancelling ...")
      end
      Roman:CancelTimer(Roman.pauseBreathe)
    else
      if Roman.db.global.debug == true then
        Roman:Print("Not Paused ...")
      end
    end
    if Roman.db.global.debug == true then
      Roman:Print("Continuing ...")
    end
    Roman.pauseBreathe = Roman:ScheduleTimer("PauseBreathe", 20)
  end
end

function Roman:PauseBreathe()
  if Roman.db.global.debug == true then
    Roman:Print("Pausing ... taking a breath ...")
  end
  Roman:ScheduleTimer("Bark", random(5))
end

function Roman:Bark()
  local canBarkGeneral = Roman:CheckZoneTime()
  local canBarkTrade = Roman:CheckTradeTime()
  local canBarkLFG = Roman:CheckLFGTime()
  if Roman.db.global.debug == true then
    Roman:Print("Can Bark General: " .. (canBarkGeneral and 'true' or 'false'))
    Roman:Print("Can Bark Trade: " .. (canBarkTrade and 'true' or 'false'))
    Roman:Print("Can Bark LFG: " .. (canBarkLFG and 'true' or 'false'))
  end
  
  if canBarkLFG == true then
    Roman:PopUp()
  else
    if Roman.db.global.debug == true then
      Roman:Print("Next LFG Bark at approximately " .. date("%H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones["LFG"] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
  end

  if canBarkTrade == true and GetChannelName((GetChannelName("Trade - City"))) > 0 then
    Roman:PopUp()
  else
    if Roman.db.global.debug == true then
      Roman:Print("Next Trade Bark at approximately " .. date("%H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones["Trade"] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
  end
  
  if canBarkGeneral == true and canBarkTrade == false then
    Roman:PopUp()
  elseif canBarkGeneral == true and GetChannelName((GetChannelName("Trade - City"))) < 1 then
    Roman:PopUp()
  else
    if Roman.db.global.debug == true then
      local genZone = GetZoneText()
      Roman:Print("Next General Bark at approximately " .. date("%H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[genZone] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
  end
end

function Roman:CheckTimes()
  local genZone = GetZoneText()
  Roman:Print(L["Next"] .. " " .. L["General"] .. " " .. L["BarkPossibleAtApproximately"] .. date("%H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[genZone] + (Roman.db.profile.messages.guildRecruit.time * 60))))
  Roman:Print(L["Next"] .. " " .. L["Trade"] .. " " .. L["BarkPossibleAtApproximately"] .. date("%H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones["Trade"] + (Roman.db.profile.messages.guildRecruit.time * 60))))
  Roman:Print(L["Next"] .. " " .. L["LFG"] .. " " .. L["BarkPossibleAtApproximately"] .. date("%H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones["LFG"] + (Roman.db.profile.messages.guildRecruit.time * 60))))
end

function Roman:CheckZoneTime()
  local zone = GetZoneText()
  local time = GetServerTime()
  local lockTime = (60 * Roman.db.profile.messages.guildRecruit.time)
  if Roman.db.profile.messages.guildRecruit.zones[zone] == nil then
    Roman.db.profile.messages.guildRecruit.zones[zone] = time
  end
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones[zone]
  if time > testTime then
    if Roman.db.profile.messages.guildRecruit.channels.General == true then
      return true
    else
      return false
    end
  else
    return false
  end
end

function Roman:CheckTradeTime()
  local time = GetServerTime()
  local lockTime = (60 * Roman.db.profile.messages.guildRecruit.time)
  if Roman.db.profile.messages.guildRecruit.zones["Trade"] == nil then
    Roman.db.profile.messages.guildRecruit.zones["Trade"] = time
  end
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones["Trade"]
  if time > testTime then
    if Roman.db.profile.messages.guildRecruit.channels.Trade == true then
      return true
    else
      return false
    end
  else
    return false
  end
end

function Roman:CheckLFGTime()
  local time = GetServerTime()
  local lockTime = (60 * Roman.db.profile.messages.guildRecruit.time)
  if Roman.db.profile.messages.guildRecruit.zones["LFG"] == nil then
    Roman.db.profile.messages.guildRecruit.zones["LFG"] = time
  end
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones["LFG"]
  if time > testTime then
    if Roman.db.profile.messages.guildRecruit.channels.LookingForGroup == true then
      return true
    else
      return false
    end
  else
    return false
  end
end

function Roman:Init()
  Roman:MiniMapIcon()
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