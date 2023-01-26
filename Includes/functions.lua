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
  local inInstance, instanceType = IsInInstance()
  if inInstance == true then
    if Roman.db.global.debug == true then
      Roman:Print("You are in an instance, we're not going to announce.")
    end
  else
    if Roman.db.global.debug == true then
      Roman:Print("No instance, continuing announcement checks.")
    end
    Roman:ScheduleTimer("RunAnnouncement", 10)
  end
end

function Roman:RunAnnouncement()
  local canAnnounceGeneral = Roman:CheckZoneTime()
  local canAnnounceTrade = Roman:CheckTradeTime()
  local canAnnounceLFG = Roman:CheckLFGTime()
  if Roman.db.global.debug == true then
    Roman:Print("Can Announce General: " .. (canAnnounceGeneral and 'true' or 'false'))
    Roman:Print("Can Announce Trade: " .. (canAnnounceTrade and 'true' or 'false'))
    Roman:Print("Can Announce LFG: " .. (canAnnounceLFG and 'true' or 'false'))
  end
  if canAnnounceGeneral == true then
    Roman:PopUp()
  elseif canAnnounceTrade == true then
    Roman:PopUp()
  elseif canAnnounceLFG == true then
    Roman:PopUp()
  end
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
    return true
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
    return true
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
    return true
  else
    return false
  end
end

function Roman:Init()
  Roman:CreateDialogs()
  Roman:MiniMapIcon()
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