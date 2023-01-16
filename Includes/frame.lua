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
  -- function that draws the widgets for the first tab
  local function DrawGroup1(container)
    local desc = RomanUI:Create("Label")
    desc:SetText("This is Tab 1")
    desc:SetFullWidth(true)
    container:AddChild(desc)
    
    local button = RomanUI:Create("Button")
    button:SetText("Tab 1 Button")
    button:SetWidth(200)
    container:AddChild(button)
  end
  
  -- function that draws the widgets for the second tab
  local function DrawGroup2(container)
    local desc = RomanUI:Create("Label")
    desc:SetText("This is Tab 2")
    desc:SetFullWidth(true)
    container:AddChild(desc)
    
    local button = RomanUI:Create("Button")
    button:SetText("Tab 2 Button")
    button:SetWidth(200)
    container:AddChild(button)
  end
  
  -- Callback function for OnGroupSelected
  local function SelectGroup(container, event, group)
    container:ReleaseChildren()
    if group == "tab1" then
      DrawGroup1(container)
    elseif group == "tab2" then
      DrawGroup2(container)
    end
  end

  -- Create the frame container
  local frame = RomanUI:Create("Frame")
  frame:SetTitle("Example Frame")
  frame:SetStatusText("AceGUI-3.0 Example Container Frame")
  frame:SetCallback("OnClose", function(widget) RomanUI:Release(widget) end)
  -- Fill Layout - the TabGroup widget will fill the whole frame
  frame:SetLayout("Fill")
  
  -- Create the TabGroup
  local tab = RomanUI:Create("TabGroup")
  tab:SetLayout("Flow")
  -- Setup which tabs to show
  tab:SetTabs({
    {
      text="Tab 1",
      value="tab1"
    },
    {
      text="Tab 2",
      value="tab2"
    }
  })
  -- Register callback
  tab:SetCallback("OnGroupSelected", SelectGroup)
  -- Set initial Tab (this will fire the OnGroupSelected callback)
  tab:SelectTab("tab1")
  
  -- add to the frame container
  frame:AddChild(tab)
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