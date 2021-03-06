--- @class ActionBars
local Module = ZActionbars:NewModule("ActionBars")
local AddonName, AddonTable = ...

local Media = LibStub:GetLibrary("Z-Lib_Media-1.0")

local MSQ = LibStub("Masque", true)


local ButtonID = 0
---@type table
local Bars = {}


function Module:OnInitialize()
    Module:SetEnabledState(ZActionbars.db.profile.moduleToggles.actionBars)
end

function Module:OnEnable()
    Module:UpdateBars()

    if Bars then
        for k, v in pairs(Bars) do
            if v then
                v:Show()
            end
        end
    end
end

function Module:OnDisable()
    for k, v in pairs(Bars) do
        if v then
            v:Hide()
        end
    end
end

function Module:UpdateBars()
    for i = 1, ZActionbars.db.profile.actionBars.numActionBars do
        ---@type Frame
        local Bar
        if not Bars[i] then
            Bar = CreateFrame("Frame", AddonName .. "_Bar" .. i)

            Bar:SetBackdrop(Media.CommonStyle.Simple)

            local Header = CreateFrame("Frame", AddonName .. "_Bar" .. i .. "_Header", Bar, "SecureHandlerStateTemplate")
            RegisterStateDriver(Header, "page", "[mod:alt]2;1")
            Header:SetAttribute("_onstate-page", [[
                self:SetAttribute("state", newstate)
                control:ChildUpdate("state", newstate)
            ]])
            Bar.Header = Header

            Bars[i] = Bar
        else
            Bar = Bars[i]
        end

        local Settings = ZActionbars.db.profile.actionBars["bar"..i]

        Bar:ClearAllPoints()
        Bar:SetPoint(Settings.anchorPoint, Settings.barX, Settings.barY)
        Bar:SetSize(Settings.barWidth, Settings.barHeight)  -- TODO improve Scaling

        --TODO Style
        Bar:SetBackdropBorderColor(Media:Grayscale(0.4))
        Bar:SetBackdropColor(Media:Grayscale(0.15))

        Bar.ButtonsX, Bar.ButtonsY, Bar.ButtonSpacingX, Bar.ButtonSpacingY, Bar.OuterMargin, Bar.ID = Settings.buttonsX, Settings.buttonsY, Settings.buttonSpacingX, Settings.buttonSpacingY, Settings.outerMargin, i

        Module:UpdateButtons(Bar)
    end
end

--- Updates the Buttons for the Bar
--- @param Bar Frame  @ Bar to Update
--- @param BarWidth number  @ New Bar Width (nil to keep)
--- @param BarHeight number @ New Bar Height (nil to keep)
--- @param ButtonsX number @ New Number of Buttons on the X Axis (nil to keep)
--- @param ButtonsY number @ New Number of Buttons on the Y Axis (nil to keep)
--- @param ButtonSpacingX number @ New Spacing between the Buttons on the Y Axis (nil to keep)
--- @param ButtonSpacingY number @ New Spacing between the Buttons on the Y Axis (nil to keep)
--- @param OuterMargin number @ New Outer Margin between the Bar and Buttons (nil to keep)
function Module:UpdateButtons(Bar, BarWidth, BarHeight, ButtonsX, ButtonsY, ButtonSpacingX, ButtonSpacingY, OuterMargin)
    assert(Bar == not nil or type(Bar) == "table", "Bar must be a Frame")


    if BarWidth then
        Bar:SetWidth(BarWidth)
    end
    if BarHeight then
        Bar:SetHeight(BarHeight)
    end

    if ButtonsX then
        Bar.ButtonsX = ButtonsX
    end
    if ButtonsY then
        Bar.ButtonsY = ButtonsY
    end

    if ButtonSpacingX then
        Bar.ButtonSpacingX = ButtonSpacingX
    end
    if ButtonSpacingY then
        Bar.ButtonSpacingY = ButtonSpacingY
    end

    if OuterMargin then
        Bar.OuterMargin = OuterMargin
    end


    for x = 1, Bar.ButtonsX do
        for y = 1, Bar.ButtonsY do
            local Button

            if not Bar.Buttons then
                Bar.Buttons = {}
            end

            if not Bar.Buttons[x] then
                Bar.Buttons[x] = {}
            end

            if Bar.Buttons[x][y] then
                Button = Bar.Buttons[x][y]
            else
                Button = LibStub("LibActionButton-1.0"):CreateButton(ButtonID, "Z-Actionbars_Bar".. Bar.ID .. "_Button_X" .. x .. "_Y" .. y, Bar.Header)
                Button.ID = ButtonID
                ButtonID = ButtonID + 1

                Button:SetParent(Bar)

                Bar.Buttons[x][y] = Button
            end

            local ButtonWidth = ((Bar:GetWidth() - (2 * Bar.OuterMargin) - (Bar.ButtonSpacingX * (Bar.ButtonsX - 1))) / Bar.ButtonsX)
            local ButtonHeight = ((Bar:GetHeight() - (2 * Bar.OuterMargin) - (Bar.ButtonSpacingY * (Bar.ButtonsY - 1))) / Bar.ButtonsY)

            local xOff = Bar.OuterMargin + ((x - 1) * (ButtonWidth + Bar.ButtonSpacingX))
            local yOff = -1 * (Bar.OuterMargin + ((y - 1) * (ButtonHeight + Bar.ButtonSpacingY)))

            Button:SetPoint("TOPLEFT", Bar, "TOPLEFT", xOff, yOff)
            Button:SetSize(ButtonWidth, ButtonHeight)
            Button:Show()

            Button:SetState(0, "action", Button.ID)
                
            -- Handle Masque integration
            if MSQ then
                Group = MSQ:Group(AddonName, "Bar" .. Bar.ID)
                Button:AddToMasque(Group)
                Group:ReSkin()
            end
        end
    end
end