local MicroMenu = ZActionbars:NewModule("MicroMenu")
local AddonName, AddonTable = ...

local Media = LibStub:GetLibrary("Z-Lib_Media-1.0")


function MicroMenu:OnEnable()
    MicroMenu:CreateMenuBar()
end

function MicroMenu:CreateMenuBar()
    --- @type Frame
    local Bar = CreateFrame("Frame", AddonName .. "_MicroMenuBar")
    Bar:ClearAllPoints()
    Bar:SetPoint("CENTER")
    Bar:SetSize(100, 22)  -- TODO improve Scaling

    --TODO Style
    Bar:SetBackdrop(Media.CommonStyle.Simple)
    Bar:SetBackdropBorderColor(Media:Grayscale(0.4))
    Bar:SetBackdropColor(Media:Grayscale(0.15))

    --- @type Button
    --MicroMenu:CreateMenuButton(0, function() ToggleCharacter("PaperDollFrame") end)

    --- @type Button
    local Character = CharacterMicroButton
    LibStub("Z-Lib_Debug-1.0"):DebugTableRecursiveFormatted(Character)
    Character:SetParent(Bar)
    Character:ClearAllPoints()
    Character:SetPoint("CENTER")
end

function MicroMenu:CreateMenuButton(Index, ClickFunction)
    --- @type Button
    local Button = CreateFrame("Button", "myButton", UIParent)
    Button:SetSize(44, 44)
    Button:SetPoint("CENTER")
    Button:SetBackdrop(Media.CommonStyle.Simple)
    Button:SetBackdropBorderColor(Media:Grayscale(0.4))
    Button:SetBackdropColor(Media:Grayscale(0.15))

    Button:SetScript("OnClick", ClickFunction)

    Button:RegisterForClicks("AnyUp")

    Button:Show()

    return Button
end