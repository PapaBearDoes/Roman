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
function Roman:Main()
end

function Roman:ShowUI()
  local RomanUI = LibStub("AceGUI-3.0")
  local RomanFrame = RomanUI:Create("Frame")
  RomanFrame:SetTitle("Example Frame")
  RomanFrame:SetStatusText("AceGUI-3.0 Example Container Frame")
  RomanFrame:SetCallback("OnClose", function(widget) RomanUI:Release(widget) end)
  RomanFrame:SetLayout("Flow")
  
  local RomanFrameEditBox = RomanUI:Create("EditBox")
  RomanFrameEditBox:SetLabel("Insert text:")
  RomanFrameEditBox:SetWidth(200)
  RomanFrame:AddChild(RomanFrameEditBox)
  
  local RomanFrameButton = RomanUI:Create("Button")
  RomanFrameButton:SetText("Click Me!")
  RomanFrameButton:SetWidth(200)
  RomanFrame:AddChild(RomanFrameButton)
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