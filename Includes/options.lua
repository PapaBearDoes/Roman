--[[
                                      \\\\///
                                     /       \
                                   (| (.)(.) |)
     .---------------------------.OOOo--()--oOOO.---------------------------.
     |                                                                      |
     |  PapaBearDoes's DadGratz Addon for World of Warcraft                 |
     |  @project-version@
     ######################################################################## ]]
--   ## Let's init this file shall we?
-- Imports
local _G = _G
local myName, addon = ...
local AddonStub = addon
local L = AddonStub:GetLocale()
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
--OptionsTable
AddonStub.options = {
  type = "group",
  name = myName,
  args = {
    general = {
      order = 1,
      type = "group",
      name = L["GeneralSettings"],
      cmdInline = true,
      args = {
        separator1 = {
          order = 1,
          type = "header",
          name = L["Options"],
        },
        doThing = {
          order = 2,
          type = "toggle",
          name = L["DoThing"],
          desc = L["DoThingDesc"],
          get = function()
            return AddonStub.db.profile.doThing
          end,
          set = function(key, value)
            AddonStub.db.profile.doThing = value
            if not AddonStub.db.profile.doThjing then
              AddonStub.db.profile.doThing = value
            end
          end,
        },
        showMinimapButton = {
          order = 5,
          type = "toggle",
          name = L["ShowMinimapButton"],
          desc = L["ShowMinimapButtonDesc"],
          get = function()
            if AddonStub.db.profile.mmIcon.hide == true then
              show = false
            else
              show = true
            end
            return show
          end,
          set = function(key, value)
            if value == true then
              AddonStub.db.profile.mmIcon.hide = false
              AddonStubIcon:Show(myName .. "_mapIcon")
            else
              AddonStub.db.profile.mmIcon.hide = true
              AddonStubIcon:Hide(myName .. "_mapIcon")
            end
          end
        },
      },
    },
  },
}
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