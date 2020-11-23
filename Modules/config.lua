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
romanConfig = {
  order = 0,
  type = "group",
  name = me,
  args = {
    settings = {
      name = L["Settings"],
      order = 0,
      type = "group",
      args = {
generalSettings = {
  name = L["GeneralSettings"],
  type = "group",
  order = 0,
  args = {
    general = {
      order = 0,
      inline = true,
      name = L["GeneralSettings"],
      type = "group",
      args = {
        showMiniMapIcon = {
          order = 0,
          type = "toggle",
          name = L["ShowMiniMapIcon"],
          desc = L["ShowMiniMapIconDesc"],
          get = function()
            if RomanDB.profile.options.general.mmIcon.hide == true then
              show = false
            else
              show = true
            end
            return show
          end,
          set = function(key, value)
            if value == true then
              RomanDB.profile.options.general.mmIcon.hide = false
              RomanIcon:Show("RomanMapIcon")
            else
              RomanDB.profile.options.general.mmIcon.hide = true
              RomanIcon:Hide("RomanMapIcon")
            end
          end,
        },
      },
    },
  },
},
phrases = {
  name = L["Barks"],
  type = "group",
  order = 1,
  --childGroups = "tabs",
  args = {


    categories = {
      order = 1,
      name = L["Categories"],
      type="group",
      args = {
        catListHeader = {
          order = 0,
          name = L["CategoriesList"],
          type = "header",
          width = "full",
        },
        catListDesc = {
          order = 1,
          name = "Checking a category will delete it from the database", --L["CatListDesc"]
          type = "description",
          width = "full",
        },
        categoriesList = {
          order = 2,
          name = "",
          type = "multiselect",
          width = "full",
          confirm = true,
          confirmText =[=[Are you sure you wish to delete this category?
|CFFFF0000This is not recoverable!|r]=],
          values = function()
            local list = {}
            for key, value in RomanDB.profile.options.phrases.categories:Iterate() do
              list[key] = value
            end
            return list
          end,
          set = function(v, key)
            RomanDB.profile.options.phrases.categories[key] = nil
          end,
        },
        addCategory = {
          order = 3,
          inline = true,
          name = L["AddCategories"],
          type="group",
          args = {
            addCat = {
              order = 0,
              name = L["AddCategory"],
              desc = L["AddCategoryDesc"],
              type = "input",
              width = "full",
              set = function(key, value)
                local n = RomanDB.profile.options.phrases.categories:GetLength()
                n = n + 1
                RomanDB.profile.options.phrases.categories[n] = value
              end,
            },
          },
        },
      },
    },
    barks = {
      order = 1,
      name = L["Barks"],
      type="group",
      args = {
        barksListGroup = {
          order = 0,
          name = L["Barks"],
          type = "group",
          inline = true,
          args = {
            barksListHeader = {
              order = 0,
              name = L["BarksList"],
              type = "header",
              width = "full",
            },
            barksListDesc = {
              order = 1,
              name = "Checking a Bark will delete it from the database", --L["CatListDesc"]
              type = "description",
              width = "full",
            },
            barksList = {
              order = 2,
              name = "",
              type = "multiselect",
              width = "full",
              confirm = true,
              confirmText =[=[Are you sure you wish to delete this Bark?
    |CFFFF0000This is not recoverable!|r]=],
              values = function()
                local list = {}
                for key, value in RomanDB.profile.options.phrases.barks:Iterate() do
                  list[key] = value
                end
                return list
              end,
              set = function(v, key)
                RomanDB.profile.options.phrases.barks[key] = nil
                RomanDB:TriggerUpdateFunction("RomanDB.profile.options.phrases")
              end,
            },
          },
        },
        addBarksGroup = {
          order = 0,
          name = L["Barks"],
          type = "group",
          inline = true,
          args = {
            addBark = {
              order = 3,
              inline = true,
              name = L["AddBarks"],
              type="group",
              args = {
                bark = {
                  order = 0,
                  name = L["AddBark"],
                  desc = L["AddBarkDesc"],
                  type = "input",
                  width = "full",
                  set = function(key, value)
                    local n = RomanDB.profile.options.phrases.barks:GetLength()
                    n = n + 1
                    RomanDB.profile.options.phrases.barks[n] = value
                    RomanDB:TriggerUpdateFunction("RomanDB.profile.options.phrases")
                  end,
                },
              },
            },
          },
        },
      },
    },
  },
},
      },
    },
  },
}

function Roman:AddBarksList()
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

    p[barksListGroup].args[barkTime] = {
      name = L["Times"],
      type = "group",
      inline = true,
      args = {
        timeMin = {
          order = 0,
          name = L["TimeMin"],
          type = "range",
          min = 0,
          softMin = 10,
          max = 300,
          step = 1,
        },
        timeMax = {
          order = 1,
          name = L["TimeMax"],
          type = "range",
          min = 0,
          softMin = 10,
          max = 300,
          step = 1,
        },
        timePause = {
          order = 2,
          name = L["TimePause"],
          type = "range",
          min = 0,
          softMin = 10,
          max = 300,
          step = 1,
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

    p[barksListGroup].args[bark] = {
      name = L["Bark"],
      type = "input",
      width = "full",
      multiline = true,
    }

    local barkValue = ""
    for iBark, barkVal in RomanDB.profile.options.phrases.barks[barkKey].bark:Iterate() do
      barkValue = barkValue .. "" .. barkVal
      p[barksListGroup].args[bark].get = function()
        return barkValue
      end
    end

    --[[for channelNum, channelName in pairs(barkTable.channels) do
      if channels == "" then
        channels = channelName
      else
        channels = channelName .. ", " .. channels
      end
    end
    timeMin = barkTable.time.min
    timeMax = barkTable.time.max
    timePause = barkTable.time.pause
    for key, value in pairs(barkTable.bark) do
      if bark == "" then
        bark = value
      else
        bark = bark .. " " .. value
      end
    end
  end

  list = categories .. "\n" .. channels .. "\n" .. timeMin .. "\n" .. timeMax .. "\n" .. timePause .. "\n" .. bark

  Roman:Print(list)

  return list]]--
end
end
--[[
Barks table setup

RomanDB.profile.options.phrases.barks = {
  barkIndexKey = {
    categories = {
      catIndex = cat,
      catIndex2 = cat2,
      ...,
    },
    channels = {
      channelNum = channelName,
      channelNum2 = channelName,
      ...,
    },
    time = {
      min = 30,
      max = 300,
      pause = 3,
    },
    bark = {
      barkIndex = "",
      BarkIndex2 = "", --In case bark is longer than 250 characters
      ...,
    },
  },
}
]]--

--[[combat = {
  name= L["In Combat"],
  type="group",
  order = 0,
  args={
    combat = {
      inline = true,
      name= L["In Combat"],
      type="group",
      order = 0,
      args={
        hidetooltip = {
          type = 'toggle',
          order = 1,
          name = L["Disable Tooltips"],
          desc = L["Disable Tooltips"],
          --get = function(info, value)
          --		return db.combathidetip
          --end,
          --set = function(info, value)
          --		db.combathidetip = value
          --end,
        },
      },
    },
  },
},
fontAndTextures = {
  name = L["Fonts and Textures"],
  type = "group",
  order = 4,
  args = {
    textures = {
      inline = true,
      name = L["Textures"],
      type = "group",
      order = 2,
      args = {
        colour = {
          type = "color",
          order = 5,
          name = L["Texture Color/Alpha"],
          desc = L["Texture Color/Alpha"],
          hasAlpha = true,
          --get = function(info)
          --	local t = db.background.color
          --	return t.r, t.g, t.b, t.a
          --end,
          --set = function(info, r, g, b, a)
          --	local t = db.background.color
          --	t.r, t.g, t.b, t.a = r, g, b, a
          --	ChocolateBar:UpdateBarOptions("UpdateColors")
          --end,
        },
      },
    },
    font = {
      inline = true,
      name = L["Font"],
      type = "group",
      order = 1,
      args ={
        fontSize = {
          type = 'range',
          order = 2,
          name = L["Font Size"],
          desc = L["Font Size"],
          min = 8,
          max = 20,
          step = .5,
          --get = function(name)
          --	return db.fontSize
          --end,
          --set = function(info, value)
          --	db.fontSize = value
          --	ChocolateBar:UpdateChoclates("updatefont")
          --end,
        },
      },
    },
  },
},]]--
--[[bars={
  name = L["Bars"],
  type ="group",
  order = 20,
  args ={
    new = {
      type = 'execute',
            --width = "half",
      order = 0,
      name = L["Create Bar"],
            desc = L["Create New Bar"],
            func = function()
        local name = ChocolateBar:AddBar()
        ChocolateBar:AddBarOptions(name)
      end,
    },
  },
},]]--
--[[chocolates={
  name = L["Plugins"],
  type="group",
  order = 30,
  args={
    stats = {
      inline = true,
      name = L["Plugin Statistics"],
      type="group",
      order = 1,
      args={
        stats = {
          order = 1,
          type = "description",
          name = GetStats,
        },
      },
    },
  },
},]]--

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
