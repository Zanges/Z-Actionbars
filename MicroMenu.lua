local Module = ZActionbars:NewModule("MicroMenu")
local AddonName, AddonTable = ...


local Media = LibStub:GetLibrary("Z-Lib_Media-1.0")

local CreateButtonsFor = {
    {
        Name = "Inventory",
        Letter = "I",
        ClickFunction = function()
            ToggleAllBags()
        end,
        MessageInCombat = "Toggling Inventory",
    },
    {
        Name = "Character",
        Letter = "C",
        ClickFunction = function()
            ToggleFrame(CharacterFrame)
        end,
        MessageInCombat = "Opening Character Panel",
    },
    {
        Name = "Spellbook",
        Letter = "S",
        ClickFunction = function()
            ToggleFrame(SpellBookFrame)
        end,
        MessageInCombat = "Opening Spellbook",
    },
    {
        Name = "Talents",
        Letter = "T",
        ClickFunction = function()
            TalentFrame_LoadUI()
            ToggleFrame(PlayerTalentFrame)
        end,
        MessageInCombat = "Opening Talents Window",
    },
    {
        Name = "Achievements",
        Letter = "A",
        ClickFunction = function()
            AchievementFrame_LoadUI()
            AchievementFrame_ToggleAchievementFrame()
        end,
        MessageInCombat = "Opening Achievements Window",
    },
    {
        Name = "Quest Log",
        Letter = "Q",
        ClickFunction = function()
            AdventureMapFrame_LoadUI()
            ToggleFrame(WorldMapFrame)
        end,
        MessageInCombat = "Opening Quest Log",
    },
    {
        Name = "Guild / Community",
        Letter = "G/C",
        ClickFunction = function()
            Communities_LoadUI()
            ToggleFrame(CommunitiesFrame)
        end,
        MessageInCombat = "Opening Guild / Community Window",
    },
    {
        Name = "Group Finder",
        Letter = "D",
        ClickFunction = function()
            PVEFrame_ToggleFrame()
        end,
        MessageInCombat = "Opening Group Finder Window",
    },
    {
        Name = "Collections",
        Letter = "M",
        ClickFunction = function()
            CollectionsJournal_LoadUI()
            ToggleFrame(CollectionsJournal)
        end,
        MessageInCombat = "Opening Collections Window",
    },
    {
        Name = "Adventure Guide",
        Letter = "J",
        ClickFunction = function()
            EncounterJournal_LoadUI()
            ToggleFrame(EncounterJournal)
        end,
        MessageInCombat = "Opening Adventure Guide",
    },
    {
        Name = "Social",
        Letter = "F",
        ClickFunction = function()
            ToggleFrame(FriendsFrame)
        end,
        MessageInCombat = "Opening Adventure Guide",
    },
    {
        Name = "Reload",
        Letter = "R",
        ClickFunction = function()
            ReloadUI()
        end,
        MessageInCombat = "Reload UI",
    },
    {
        Name = "Game Menu",
        Letter = "ESC",
        ClickFunction = function()
            ToggleFrame(GameMenuFrame)
        end,
        MessageInCombat = "Opening Game Menu",
    },
}

local Buttons = {}

local Bar


function Module:OnEnable()
    Module:UpdateMenuBar()
end

function Module:OnDisable()
    if Bar then
        Bar:Hide()
    end
end

function Module:UpdateMenuBar()
    if Bar then
        Bar:Show()
    else
        --- @type Frame
        Bar = CreateFrame("Frame", AddonName .. "_MicroMenuBar")
        Bar:SetBackdrop(Media.CommonStyle.Simple)

        Bar:SetBackdropBorderColor(Media:Grayscale(0.4))
        Bar:SetBackdropColor(Media:Grayscale(0.15))
    end

    Bar:ClearAllPoints()
    Bar:SetPoint(ZActionbars.db.profile.microMenu.anchorPoint, ZActionbars.db.profile.microMenu.xPosition, ZActionbars.db.profile.microMenu.yPosition)
    Bar:SetSize(ZActionbars.db.profile.microMenu.width, ZActionbars.db.profile.microMenu.height)  -- TODO improve Scaling

    Module:UpdateMenuButtons(Bar)
end

function Module:UpdateMenuButtons(Parent)
    local Width, Height, Point, OffsetX, OffsetY

    for i, Info in pairs(CreateButtonsFor) do
        --- @type Button
        local Button
        if Buttons[Info.Name] then
            Button = Buttons[Info.Name]
        else
            Button = CreateFrame("Button", "Z-Actionbars_MicroMenu_" .. Info.Name, Parent)

            Button:SetBackdrop(Media.CommonStyle.Simple)

            Button:SetScript("OnClick", function()
                LibStub("Z-Lib_CombatLockdownHelper-1.0"):ExecuteSave(Info.Name, Info.MessageInCombat, Info.ClickFunction)
            end)
            Button:RegisterForClicks("AnyUp")

            Button:SetBackdropBorderColor(Media:Grayscale(0.3))
            Button:SetBackdropColor(Media:Grayscale(0.15))

            local function OnEnter(self, motion)
                GameTooltip:SetOwner(Button, "ANCHOR_CURSOR")
                GameTooltip:SetText(Info.Name)
                GameTooltip:Show()
            end

            local function OnLeave(self, motion)
                GameTooltip:Hide()
            end

            Button:SetScript("OnEnter", OnEnter)
            Button:SetScript("OnLeave", OnLeave)

            Button:Show()

            Buttons[Info.Name] = Button
        end

        if ZActionbars.db.profile.microMenu.orientation == "HORIZONTAL" then
            Width = ((Parent:GetWidth() - (2 * ZActionbars.db.profile.microMenu.outerMargin) - (ZActionbars.db.profile.microMenu.buttonSpacing * (#(CreateButtonsFor) - 1))) / #(CreateButtonsFor))
            Height = (Parent:GetHeight() - (2 * ZActionbars.db.profile.microMenu.outerMargin))
            Point = "LEFT"
            OffsetX = ((i - 1) * (Width + ZActionbars.db.profile.microMenu.buttonSpacing)) + ZActionbars.db.profile.microMenu.outerMargin
            OffsetY = 0
        else
            Width = (Parent:GetWidth() - (2 * ZActionbars.db.profile.microMenu.outerMargin))
            Height = ((Parent:GetHeight() - (2 * ZActionbars.db.profile.microMenu.outerMargin) - (ZActionbars.db.profile.microMenu.buttonSpacing * (#(CreateButtonsFor) - 1))) / #(CreateButtonsFor))
            Point = "TOP"
            OffsetX = 0
            OffsetY = (-1 * ((i - 1) * (Height + ZActionbars.db.profile.microMenu.buttonSpacing)) - ZActionbars.db.profile.microMenu.outerMargin)
        end
        Button:SetSize(Width, Height)
        Button:ClearAllPoints()
        Button:SetPoint(Point, OffsetX, OffsetY)

        --- @type Font
        local Font = Button:CreateFontString()
        Font:SetFont(LibStub("LibSharedMedia-3.0"):Fetch("font", ZActionbars.db.profile.microMenu.font), ZActionbars.db.profile.microMenu.fontSize)
        Font:SetTextColor(Media:Grayscale(0.75))
        Button:SetFontString(Font)

        Font:SetText(Info.Name)
        if Font:GetStringWidth() > Width then
            Font:SetText(Info.Letter)
        end

        LibStub("Z-Lib_CombatLockdownHelper-1.0"):AlterWhileInCombat(Info.Name,
                function() -- Enter Combat
                    Button:SetBackdropBorderColor(Media:Grayscale(0.11))
                    Button:SetBackdropColor(Media:Grayscale(0.3))
                    Font:SetTextColor(Media:Grayscale(0.11))
                    Button:SetFontString(Font)
                    --Button:SetNormalFontObject(Font)
                end,
                function() -- Leave Combat
                    Button:SetBackdropBorderColor(Media:Grayscale(0.3))
                    Button:SetBackdropColor(Media:Grayscale(0.15))
                    Font:SetTextColor(Media:Grayscale(0.75))
                    Button:SetFontString(Font)
                end)
    end
end