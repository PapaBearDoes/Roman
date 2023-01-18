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
  -- Draw the Guild Recruitment barks tab
  local function DrawTab1(container)
    local editTab1 = RomanUI:Create("InlineGroup")
    editTab1:SetTitle("Guild Recruitment Barks")
    editTab1:SetLayout("Flow")
    editTab1:SetFullWidth(true)

      local editChans1 = RomanUI:Create("InlineGroup")
      editChans1:SetLayout("Flow")
      editChans1:SetRelativeWidth(0.5)
      editChans1:SetTitle("Which channels should we bark in?")
      
        local genChan1 = RomanUI:Create("CheckBox")
        genChan1:SetType("checkbox")
        genChan1:SetLabel("General")
        --Add stuff here
        editChans1:AddChild(genChan1)
        
        local tradeChan1 = RomanUI:Create("CheckBox")
        tradeChan1:SetType("checkbox")
        tradeChan1:SetLabel("Trade")
        --Add stuff here
        editChans1:AddChild(tradeChan1)
        
        local LFGChan1 = RomanUI:Create("CheckBox")
        LFGChan1:SetType("checkbox")
        LFGChan1:SetLabel("Looking For Group")
        --Add stuff here
        editChans1:AddChild(LFGChan1)
      
      editTab1:AddChild(editChans1)
      
      local editTime1 = RomanUI:Create("Slider")
      editTime1:SetSliderValues(15, 180, 5)
      editTime1:SetRelativeWidth(0.5)
      editTime1:SetLabel("How long in between barks (in minutes)?")
      editTime1:SetCallback("OnMouseUp", function(_, _, data) DevTools_Dump(data) end)
      editTab1:AddChild(editTime1)
      
      local editBox1 = RomanUI:Create("MultiLineEditBox")
      editBox1:SetLabel("Add Bark (Max 250 Chars)")
      editBox1:SetFullWidth(true)
      editBox1:SetNumLines(3)
      editBox1:SetMaxLetters(250)
      editBox1:SetFocus()
      editBox1:SetCallback("OnEnterPressed", function(_, _, data) DevTools_Dump(data) end)
      editTab1:AddChild(editBox1)
      
      container:AddChild(editTab1)
    
    local scrollTab1 = RomanUI:Create("InlineGroup")
    scrollTab1:SetTitle("Guild Recruitment Barks")
    scrollTab1:SetFullWidth(true)
    scrollTab1:SetFullHeight(true)
    scrollTab1:SetLayout("Fill")
    container:AddChild(scrollTab1)
  end
  
  -- Draw the Trade barks tab
  function DrawTab2(container)
    local scrollTab2 = RomanUI:Create("InlineGroup")
    scrollTab2:SetFullWidth(true)
    scrollTab2:SetFullHeight(true)
    scrollTab2:SetLayout("Fill")
    container:AddChild(scrollTab2)
  end
  
  -- Draw the LFG barks tab
  function DrawTab3(container)
    local scrollTab3 = RomanUI:Create("InlineGroup")
    scrollTab3:SetFullWidth(true)
    scrollTab3:SetFullHeight(true)
    scrollTab3:SetLayout("Fill")
    container:AddChild(scrollTab3)
  end

  local function SelectTab(container, event, group)
    container:ReleaseChildren()
    if group == "tab1" then
      DrawTab1(container)
    elseif group == "tab2" then
      DrawTab2(container)
    elseif group == "tab3" then
      DrawTab3(container)
    end
  end

  -- Create the frame container
  local frame = RomanUI:Create("Frame")
  frame:SetTitle("Roman")
  frame:SetStatusText("A Message Barker")
  frame:SetHeight(600)
  frame:SetCallback("OnClose", function(widget) RomanUI:Release(widget) end)
  frame:SetLayout("Fill")
  
  -- Create the TabGroup
  local tab = RomanUI:Create("TabGroup")
  tab:SetLayout("Flow")
  tab:SetTabs({{
    text="Guild Recruitment",
    value="tab1"
  }, {
    text="Trade",
    value="tab2"
  }, {
    text="LFG",
    value="tab3"
  }})
  tab:SetCallback("OnGroupSelected", SelectTab)

  tab:SelectTab("tab1")

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