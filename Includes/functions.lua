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
  if Roman.db.global.debug == true then
    Roman:Print("Guild Comment:")
    Roman:Print(guildComment)
    Roman:Print("Guild Link:")
    Roman:Print(guildLink)
  end
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
  Roman:ScheduleTimer("RunAnnouncement", 5)
end

function Roman:RunAnnouncement()
  --Check if can announce due to time constraints
  local canAnnounce = Roman:CheckAnnounceTime()
  if Roman.db.global.debug == true then
    Roman:Print("Can Announce: " .. (canAnnounce and 'true' or 'false'))
  end
  
  if canAnnounce == true then
    Roman:PopUp()
  end
end

function Roman:CheckChannel(channel)
  local chanID, chanName, chanInstanceID, chanIsCommunitiesChannel
  if channel == "General" then
    if GetChannelName((GetChannelName("General - " .. GetZoneText()))) > 0 then
      chanID, chanName, chanInstanceID, chanIsCommunitiesChannel = GetChannelName("General - " .. GetZoneText())
      if Roman.db.global.debug == true then
        Roman:Print("Channel Name: " .. chanName)
        Roman:Print("Channel ID: " .. chanID)
      end
      return chanID, chanName
    end
  elseif channel == "Trade" then
    if GetChannelName((GetChannelName("Trade - City"))) > 0 then
      chanID, chanName, chanInstanceID, chanIsCommunitiesChannel = GetChannelName("Trade - City")
      if Roman.db.global.debug == true then
        Roman:Print("Channel Name: " .. chanName)
        Roman:Print("Channel ID: " .. chanID)
      end
      return chanID, chanName
    end
  elseif channel == "LFG" then
    if GetChannelName((GetChannelName("LookingForGroup"))) > 0 then
      chanID, chanName, chanInstanceID, chanIsCommunitiesChannel = GetChannelName("LookingForGroup")
      if Roman.db.global.debug == true then
        Roman:Print("Channel Name: " .. chanName)
        Roman:Print("Channel ID: " .. chanID)
      end
      return chanID, chanName
    end
  end
end

function Roman:CheckAnnounceTime()
  local zone = GetZoneText()
  local time = GetServerTime()
  local lockTime = (60 * Roman.db.profile.messages.guildRecruit.time)
  if Roman.db.global.debug == true then
    Roman:Print("Zone: " .. zone)
    Roman:Print("Current Time: " .. time)
    Roman:Print("LockOut Time: " .. lockTime .. " seconds")
  end
  
  if not Roman.db.profile.messages.guildRecruit.zones[zone]
  or Roman.db.profile.messages.guildRecruit.zones[zone] == nil
  or Roman.db.profile.messages.guildRecruit.zones[zone] == "" then
    Roman.db.profile.messages.guildRecruit.zones[zone] = time
  end
  if Roman.db.global.debug == true then
    DevTools_Dump(Roman.db.profile.messages.guildRecruit.zones)
  end
  
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones[zone]
  if Roman.db.global.debug == true then
    Roman:Print("Test Time: " .. testTime)
  end
  
  if time > testTime then
    if Roman.db.global.debug == true then
      Roman:Print("Time is expired ... announcing.")
    end
    return true
  else
    if Roman.db.global.debug == true then
      Roman:Print("Time is not yet expired ... not announcing.")
      Roman:Print("Can announce next at: " .. date("%H:%M:%S", testTime))
    end
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