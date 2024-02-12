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

  if Roman.db.profile.messages.guildRecruit.useCustomMessage == true and Roman.db.profile.messages.guildRecruit.customMessage ~= nil then
    guildComment = Roman.db.profile.messages.guildRecruit.customMessage
  end

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
    Roman.pauseBreathe = Roman:ScheduleTimer("PauseBreathe", 30)
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
  local genChanID, genChanName = GetChannelName(L["General"])
  local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])
  
  if Roman.db.global.debug == true then
    Roman:Print("Can Bark General: " .. (canBarkGeneral and 'true' or 'false'))
    Roman:Print("Can Bark Trade: " .. (canBarkTrade and 'true' or 'false'))
    Roman:Print("Can Bark LFG: " .. (canBarkLFG and 'true' or 'false'))
  end
  
  if canBarkGeneral == true and canBarkTrade == false then
    Roman:PopUp()
  elseif canBarkGeneral == true and GetChannelName(GetChannelName(L["TradeChanName"])) < 1 then
    Roman:PopUp()
  else
    if Roman.db.global.debug == true then
      Roman:Print("Next " .. Roman:Colorize(genChanName, "uncommon") .. " Bark at approximately " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[genChanName] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
  end

  if canBarkTrade == true and GetChannelName(GetChannelName(L["TradeChanName"])) > 0 then
    Roman:PopUp()
  else
    if Roman.db.global.debug == true then
      Roman:Print("Next " .. Roman:Colorize(L["TradeChanName"], "rare") .. " Bark at approximately " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[L["TradeChanName"]] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
  end

  if canBarkLFG == true then
    Roman:PopUp()
  else
    if Roman.db.global.debug == true then
      Roman:Print("Next " .. Roman:Colorize(lfgChanName, "epic") .. " Bark at approximately " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[lfgChanName] + (Roman.db.profile.messages.guildRecruit.time * 60))))
    end
  end
  
  if canBarkGeneral == false and canBarkTrade == false and canBarkLFG == false then
    local nextRun = (10 + (60 * Roman.db.profile.messages.guildRecruit.time))
    Roman:Print("NextRun at approximately " .. date("%d %b %Y %H:%M:%S", (nextRun + GetServerTime())))
    local checkTimer = Roman:TimeLeft(Roman.announceTimer)
    if checkTimer ~= nil and checkTimer > 0 then
      if Roman.db.global.debug == true then
        Roman:Print("Timer Active, resetting.")
      end
      Roman:CancelTimer(Roman.announceTimer)
    else
      if Roman.db.global.debug == true then
        Roman:Print("Timer Not Active, moving on ...")
      end
    end
    Roman.announceTimer = Roman:ScheduleTimer("Bark", nextRun)
  end
end

function Roman:CheckTimes()
  local genChanID, genChanName = GetChannelName(L["General"])
  local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])
  Roman:Print(L["Next"] .. " " .. Roman:Colorize(genChanName, "uncommon") .. " " .. L["BarkPossibleAtApproximately"] .. " " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[genChanName] + (Roman.db.profile.messages.guildRecruit.time * 60))))
  Roman:Print(L["Next"] .. " " .. Roman:Colorize(L["TradeChanName"], "rare") .. " " .. L["BarkPossibleAtApproximately"] .. " " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[L["TradeChanName"]] + (Roman.db.profile.messages.guildRecruit.time * 60))))
  Roman:Print(L["Next"] .. " " .. Roman:Colorize(lfgChanName, "epic") .. " " .. L["BarkPossibleAtApproximately"] .. " " .. date("%d %b %Y %H:%M:%S", (Roman.db.profile.messages.guildRecruit.zones[lfgChanName]  + (Roman.db.profile.messages.guildRecruit.time * 60))))
end

function Roman:CheckZoneTime()
  local genChanID, genChanName = GetChannelName(L["General"])
  local time = GetServerTime()
  local lockTime = (60 * Roman.db.profile.messages.guildRecruit.time)
  if Roman.db.profile.messages.guildRecruit.zones[genChanName] == nil then
    Roman.db.profile.messages.guildRecruit.zones[genChanName] = time
  end
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones[genChanName]
  if time > testTime then
    if Roman.db.profile.messages.guildRecruit.channels.General == true and GetChannelName(GetChannelName(L["TradeChanName"])) < 1 then
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
  if Roman.db.profile.messages.guildRecruit.zones[L["TradeChanName"]] == nil then
    Roman.db.profile.messages.guildRecruit.zones[L["TradeChanName"]] = time
  end
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones[L["TradeChanName"]]
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
  local lfgChanID, lfgChanName = GetChannelName(L["LookingForGroup"])
  local time = GetServerTime()
  local lockTime = (60 * Roman.db.profile.messages.guildRecruit.time)
  if Roman.db.profile.messages.guildRecruit.zones[lfgChanName] == nil then
    Roman.db.profile.messages.guildRecruit.zones[lfgChanName] = time
  end
  local testTime = lockTime + Roman.db.profile.messages.guildRecruit.zones[lfgChanName]
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

function Roman:CommaSplitter(str)
  local fields = {}
  for field in str:gmatch('([^,]+)') do
    fields[#fields+1] = field
  end
  return fields
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