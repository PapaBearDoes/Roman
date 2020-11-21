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
  args = {
    categories = {
      order = 0,
      --inline = true,
      name = L["Categories"],
      type="group",
      args = {
        categories2 = {
          order = 0,
          inline = true,
          name = L["Categories"],
          type="group",
          args = {},
        },
        addCategory = {
          order = 1,
          inline = true,
          name = L["AddCategories"],
          type="group",
          args = {
            add = {
              order = 0,
              name = L["AddCategory"],
              desc = L["AddCategoryDesc"],
              type = "input",
              width = "full",
              set = function(key, value)
                local n = RomanDB.profile.options.phrases.categories:GetLength()
                n = n + 1
                RomanDB.profile.options.phrases.categories[n] = value
                RomanDB.profile.options.phrases.categories:Print(3)
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
}

function Roman:ConfigCategoryList()
  local n = 0
  for key, value in RomanDB.profile.options.phrases.categories:Iterate() do
    Roman:Print(key)
    Roman:Print(value)
    RomanDB.profile.options.phrases.categories:Print(3)
    Roman:Print("romanConfig.args.settings.args.phrases.args.categories.args.categories2.args.Cat"..key)
    Roman:Print("romanConfig.args.settings.args.phrases.args.categories.args.categories2.args.Cat"..key.."Del")
    Roman:Print("romanConfig.args.settings.args.phrases.args.categories.args.categories2.args.Cat"..key.."Spacer")

    romanConfig.args.settings.args.phrases.args.categories.args.categories2.args["Cat"..key] = {
      ["order"] = n,
      ["type"] = "description",
      ["fontSize"] = "medium",
      ["name"] = value,
      ["width"] = "full",
    }

    romanConfig.args.settings.args.phrases.args.categories.args.categories2.args["Cat"..key.."Del"] = {
      ["order"] = n + 1,
      ["type"] = "execute",
      ["name"] = "Delete: " .. value,
      ["width"] = "half",
      ["func"] = function()
        for key2, value2 in RomanDB.profile.options.phrases.categories:Iterate() do
          if key2 == key then
            Roman:Print("RomanDB.profile.options.phrases.categories."..key)
            RomanDB.profile.options.phrases.categories[key] = nil
            RomanDB.profile.options.phrases.categories:Print(3)
          end
        end
      end,
    }

    romanConfig.args.settings.args.phrases.args.categories.args.categories2.args["Cat"..key.."Spacer"] = {
      ["order"] = n + 2,
      ["type"] = "header",
      ["name"] = "",
      ["width"] = "full",
    }
    n = n + 10
  end
end

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
