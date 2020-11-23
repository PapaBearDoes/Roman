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
local L = Roman:GetLocale()
local RomanDB = LibStub("LibMayronDB"):GetDatabaseByName("RomanDB")
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
function Roman:AddBarksConfigList()
  local p = romanConfig.args.settings.args.phrases.args
  local c = {
    "General",
    "Trade",
    "LocalDefense",
    "Say"
  }

  for barkKey, barkTable in RomanDB.profile.options.phrases.barks:Iterate() do
    local barksListGroup = "barkList" .. barkKey
    local barkCats = "barkCats" .. barkKey
    local barkChans = "barkChans" .. barkKey
    local barkTime = "barkTime" .. barkKey
    local bark = "bark" .. barkKey
    p[barksListGroup] = {
      order = 0,
      type = "group",
      inline = true,
      args = {},
    }
    p[barksListGroup].name = barksListGroup

    p[barksListGroup].args[barkCats] = {
      name = L["Categories"],
      type = "multiselect",
      values = {},
    }
    for catIndex, cat in RomanDB.profile.options.phrases.categories:Iterate() do
      p[barksListGroup].args[barkCats].values[catIndex] = cat
      p[barksListGroup].args[barkCats].get = function(info, k, v)
        return RomanDB.profile.options.phrases.barks[barkKey].categories[k]
      end
    end
    p[barksListGroup].args[barkCats].set = function(info, k, v)
      RomanDB.profile.options.phrases.barks[barkKey].categories[k] = v
    end

    p[barksListGroup].args[barkChans] = {
      name = L["Channels"],
      type = "multiselect",
      values = {},
    }
    for chanIndex, chan in pairs(c) do
      p[barksListGroup].args[barkChans].values[chanIndex] = chan
      p[barksListGroup].args[barkChans].get = function(info, k, v)
        return RomanDB.profile.options.phrases.barks[barkKey].channels[k]
      end
    end
    p[barksListGroup].args[barkChans].set = function(info, k, v)
      RomanDB.profile.options.phrases.barks[barkKey].channels[k] = v
    end

    p[barksListGroup].args[barkTime] = {
      name = L["Times"],
      type = "group",
      inline = true,
      args = {
        timeMin = {
          order = 0,
          name = L["TimeMin"],
          type = "range",
          min = 1,
          max = 300,
          step = 1,
        },
        timeMax = {
          order = 1,
          name = L["TimeMax"],
          type = "range",
          min = 1,
          max = 300,
          step = 1,
        },
        timePause = {
          order = 2,
          name = L["TimePause"],
          type = "range",
          min = 1,
          max = 10,
          step = 0.1
        },
      },
    }
    p[barksListGroup].args[barkTime].args.timeMin.get = function()
      return RomanDB.profile.options.phrases.barks[barkKey].time.min
    end
    p[barksListGroup].args[barkTime].args.timeMax.get = function()
      return RomanDB.profile.options.phrases.barks[barkKey].time.max
    end
    p[barksListGroup].args[barkTime].args.timePause.get = function()
      return RomanDB.profile.options.phrases.barks[barkKey].time.pause
    end
    p[barksListGroup].args[barkTime].args.timeMin.set = function(info, v)
      RomanDB.profile.options.phrases.barks[barkKey].time.min = v
    end
    p[barksListGroup].args[barkTime].args.timeMax.set = function(info, v)
      RomanDB.profile.options.phrases.barks[barkKey].time.max = v
    end
    p[barksListGroup].args[barkTime].args.timePause.set = function(info, v)
      RomanDB.profile.options.phrases.barks[barkKey].time.pause = v
    end

    p[barksListGroup].args[bark] = {
      name = L["Bark"],
      type = "input",
      width = "full",
      multiline = true,
    }

    p[barksListGroup].args[bark].get = function()
      local barkValue = ""
      for i, barkVal in RomanDB.profile.options.phrases.barks[barkKey].bark:Iterate() do
        barkValue = strjoin("", barkValue, barkVal)
      end
      return barkValue
    end

    p[barksListGroup].args[bark].set = function(info, v)
      RomanDB.profile.options.phrases.barks[barkKey].bark = {}
      barkVal1, barkVal2, barkVal3 = Roman:SplitBarkString(v)

      if barkVal2 then
        if barkVal3 then
          RomanDB.profile.options.phrases.barks[barkKey].bark = {barkVal1, barkVal2, barkVal3}
        else
          RomanDB.profile.options.phrases.barks[barkKey].bark = {barkVal1, barkVal2}
        end
      else
        RomanDB.profile.options.phrases.barks[barkKey].bark = {barkVal1}
      end

      RomanDB.profile.options.phrases.barks:Print(10)
    end
  end
end

function Roman:SplitBarkString(value)
  --Take the given bark, and split it at 250 characters a max of 3 times
  local barkVal1, barkVal2, barkVal3
  local barkLen = strlen(value)
  Roman:Print(barkLen)
  barkVal1 = strsub(value, 1, 250)
  if barkLen >= 251 then
    barkVal2 = strsub(value, 251, 500)
  end
  if barkLen >= 501 then
    barkVal3 = strsub(value, 501, 750)
  end
  return barkVal1, barkVal2, barkVal3
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
