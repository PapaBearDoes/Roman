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
-- Draw the Guild Recruitment barks tab
function Roman:DrawTab1(container)
  local editTab1 = RomanUI:Create("InlineGroup")
    if Roman.db.global.debug == true then
      Roman:Print("General: " .. (Roman.db.profile.messages.guildRecruit.channels.General and 'true' or 'false'))
      Roman:Print("Trade: " .. (Roman.db.profile.messages.guildRecruit.channels.Trade and 'true' or 'false'))
      Roman:Print("LookingForGroup: " .. (Roman.db.profile.messages.guildRecruit.channels.LookingForGroup and 'true' or 'false'))
      Roman:Print("Time: " .. Roman.db.profile.messages.guildRecruit.time)
      Roman:Print("Message: " .. Roman.db.profile.messages.guildRecruit.message)
    end
    editTab1:SetTitle("Guild Recruitment Barks")
    editTab1:SetFullWidth(true)
    editTab1:SetLayout("Flow")
    Roman:BarkChannels(editTab1, "GuildRecruitment")
    Roman:BarkTime(editTab1, Roman.db.profile.messages.guildRecruit.time)
    Roman:EditBark(editTab1)
  container:AddChild(editTab1)
end

--[[
-- Draw the Trade barks tab
function Roman:DrawTab2(container)
  local scrollTab2 = RomanUI:Create("InlineGroup")
  scrollTab2:SetFullWidth(true)
  scrollTab2:SetFullHeight(true)
  scrollTab2:SetLayout("Fill")
  container:AddChild(scrollTab2)
end

-- Draw the LFG barks tab
function Roman:DrawTab3(container)
  local scrollTab3 = RomanUI:Create("InlineGroup")
  scrollTab3:SetFullWidth(true)
  scrollTab3:SetFullHeight(true)
  scrollTab3:SetLayout("Fill")
  container:AddChild(scrollTab3)
end
]]

function Roman:EditBark(container)
  local editBox = RomanUI:Create("MultiLineEditBox")
  editBox:SetDisabled(Roman.db.profile.messages.guildRecruit.useGuildFinder)
  editBox:SetLabel("Bark (Max 250 Chars)")
  editBox:SetFullWidth(true)
  editBox:SetNumLines(4)
  editBox:SetMaxLetters(250)
  if Roman.db.profile.messages.guildRecruit.useGuildFinder == true then
    local message = Roman:MakeGuildRecruitMessage()
    editBox:SetText(message[2])
  else
    editBox:SetText(Roman.db.profile.messages.guildRecruit.message)
  end
  
  editBox:SetCallback("OnEnterPressed", function(_, _, text)
    Roman.db.profile.messages.guildRecruit.message = text
    Roman:UpdateProfile()
  end)
  container:AddChild(editBox)
end

function Roman:BarkChannels(container, type)
  local editChans = RomanUI:Create("InlineGroup")
    editChans:SetLayout("Flow")
    editChans:SetRelativeWidth(0.5)
    editChans:SetTitle("Which channels should we bark in?")
    if type == "GuildRecruitment" then
      Roman:BarkChannelCheckBox(editChans, "General", Roman.db.profile.messages.guildRecruit.channels.General)
      Roman:BarkChannelCheckBox(editChans, "Trade", Roman.db.profile.messages.guildRecruit.channels.Trade)
      Roman:BarkChannelCheckBox(editChans, "LookingForGroup", Roman.db.profile.messages.guildRecruit.channels.LookingForGroup)
    elseif type == "Trade" then
    elseif type == "LookingForGroup" then
    end
  container:AddChild(editChans)
end

function Roman:BarkChannelCheckBox(container, channel, checked)
  local Channel = RomanUI:Create("CheckBox")
  Channel:SetType("checkbox")
  Channel:SetValue(checked)
  Channel:SetLabel(channel)
  Channel:SetCallback("OnValueChanged", function(_, _, value)
    if channel == "General" then
      Roman.db.profile.messages.guildRecruit.channels.General = value
    elseif channel == "Trade" then
      Roman.db.profile.messages.guildRecruit.channels.Trade = value
    elseif channel == "LookingForGroup" then
      Roman.db.profile.messages.guildRecruit.channels.LookingForGroup = value
    end
    Roman:UpdateProfile()
  end)
  container:AddChild(Channel)
end

function Roman:BarkTime(container, time)
  local editTime = RomanUI:Create("Slider")
  editTime:SetSliderValues(15, 180, 5)
  editTime:SetRelativeWidth(0.5)
  editTime:SetValue(time)
  editTime:SetLabel("How long in between barks (in minutes)?")
  editTime:SetCallback("OnMouseUp", function(_, _, time)
    Roman.db.profile.messages.guildRecruit.time = time
    Roman:UpdateProfile()
  end)
  container:AddChild(editTime)
end

function Roman:ShowUI()
  local function SelectTab(container, event, group)
    container:ReleaseChildren()
    if group == "tab1" then
      Roman:DrawTab1(container)
--    elseif group == "tab2" then
--      Roman:DrawTab2(container)
--    elseif group == "tab3" then
--      Roman:DrawTab3(container)
    end
  end

  -- Create the frame container
  local frame = RomanUI:Create("Frame")
  frame:SetTitle("Roman")
  frame:SetStatusText("A Message Barker")
  frame:SetHeight(400)
  frame:SetCallback("OnClose", function(widget) RomanUI:Release(widget) end)
  frame:SetLayout("Fill")
  
  -- Create the TabGroup
  local tab = RomanUI:Create("TabGroup")
  tab:SetLayout("Flow")
  tab:SetTabs({{
    text="Guild Recruitment",
    value="tab1"
--  }, {
--    text="Trade",
--    value="tab2"
--  }, {
--    text="LFG",
--    value="tab3"
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