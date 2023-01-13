--[[
                                      \\\\///
                                     /       \
                                   (| (.)(.) |)
     .---------------------------.OOOo--()--oOOO.---------------------------.
     |                                                                      |
     |  PapaBearDoes's Roman Addon for World of Warcraft                    |
     |  @project-version@
     ######################################################################## ]]
--   ## Let's init this file shall we?
-- Imports
local _G = _G
local myName, addon = ...
local Roman = addon
local L = Roman:GetLocale()
local RomanUI = LibStub("AceGUI-3.0")
-- End Imports
--[[ ######################################################################## ]]
--   ## Do All The Things!!!
function Roman:ShowUI()
  local Frame = RomanUI:Create("Frame")
  Frame:SetWidth(800)
  Frame:SetTitle(myName)
  Frame:SetStatusText(L["MessageBarkerForWoW"])
  Frame:SetCallback("OnClose", function(widget) RomanUI:Release(widget) end)
  Frame:SetLayout("Flow")
  
  local LeftFrame = RomanUI:Create("Frame")
  LeftFrame:SetWidth(200)
  LeftFrame:SetTitle("Message Type")
  Frame:AddChild(LeftFrame)
  
  local RightFrame = RomanUI:Create("Frame")
  RightFrame:SetWidth(600)
  RightFrame:SetTitle("Message Type")
  Frame:AddChild(RightFrame)

  local EditBox = RomanUI:Create("EditBox")
  EditBox:SetLabel("Insert text:")
  EditBox:SetWidth(200)
  Frame:AddChild(EditBox)
  
  local Button = RomanUI:Create("Button")
  Button:SetText("Click Me!")
  Button:SetWidth(200)
  Frame:AddChild(Button)
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