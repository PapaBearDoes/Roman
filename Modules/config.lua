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
  type = "group",
  name = me,
  args = {
    barkSettings = {
      name = L["BarksSettings"],
      order = 0,
      type = "group",
      args = {
        generalSettings = {
  				name = L["GeneralSettings"],
  				type = "group",
  				order = 0,
  				args = {
  					general = {
  						inline = true,
  						name = L["GeneralSettings"],
  						type = "group",
  						order = 3,
  						args = {
                showMiniMapIcon = {
                  order = 3,
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
  					--[[defaults = {
  						inline = true,
  						name= L["Defaults"],
  						type="group",
  						order = 4,
  						args={
  							label = {
  								order = 0,
  								type = "description",
  								name = L["Automatically disable new plugins of type:"],
  							},
  						},
  					},]]--
          },
        },
        phrases = {
  				name = L["Barks"],
  				type = "group",
  				order = 1,
  				args = {
  					categories = {
  						inline = true,
  						name = L["Categories"],
  						type="group",
  						order = 3,
  						args = {
  							--[[locked = {
  								type = 'toggle',
  								order = 1,
  								name = L["Lock Plugins"],
  								desc = L["Hold alt key to drag a plugin."],
  								get = function(info, value)
  										return
  								end,
  								set = function(info, value)
  										--db.locked = value
  								end,
  							},]]--
  						},
  					},
  				},
  			},
      },
    },
  },
}
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
