local Module = ZActionbars:NewModule("PetActionBar")        -- TODO FIX
local AddonName, AddonTable = ...

local Media = LibStub:GetLibrary("Z-Lib_Media-1.0")


local ButtonID = 0

local Bar


function Module:OnInitialize()
    Module:SetEnabledState(ZActionbars.db.profile.moduleToggles.petActionBar)
end

function Module:OnEnable()
    Module:UpdatePetBar()
end

function Module:OnDisable()
    if Bar then
        Bar:Hide()
    end
end

function Module:UpdatePetBar()
    if Bar then
        Bar:Show()
    else
        --- @type Frame
        Bar = CreateFrame("Frame", AddonName .. "_PetActionBar")
        Bar:SetBackdrop(Media.CommonStyle.Simple)

        Bar:SetBackdropBorderColor(Media:Grayscale(0.4))
        Bar:SetBackdropColor(Media:Grayscale(0.15))

        local Header = CreateFrame("Frame", AddonName .. "_PetBar_Header", Bar, "SecureHandlerStateTemplate")
        Bar.Header = Header
    end

    local Settings = ZActionbars.db.profile.petBar

    Bar:ClearAllPoints()
    Bar:SetPoint(Settings.anchorPoint, Settings.barX, Settings.barY)
    Bar:SetSize(Settings.barWidth, Settings.barHeight)  -- TODO improve Scaling

    Bar.ButtonsX, Bar.ButtonsY, Bar.ButtonSpacingX, Bar.ButtonSpacingY, Bar.OuterMargin = Settings.buttonsX, Settings.buttonsY, Settings.buttonSpacingX, Settings.buttonSpacingY, Settings.outerMargin

    Module:UpdatePetButtons(Bar)
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
function Module:UpdatePetButtons(Bar, BarWidth, BarHeight, ButtonsX, ButtonsY, ButtonSpacingX, ButtonSpacingY, OuterMargin)
    assert(Bar == not nil or type(Bar) == "table", "Bar must be a Frame")

    if ButtonID > 10 then
        return
    end


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
                Button = LibStub("LibActionButton-1.0"):CreateButton("Pet" .. ButtonID, "Z-Actionbars_PetBar" .. "_Button_X" .. x .. "_Y" .. y, Bar.Header)
                Button.ID = "Pet" .. ButtonID
                ButtonID = ButtonID + 1

                Button:SetParent(Bar)

                local MSQ = LibStub("Masque", true)
                if MSQ then
                    Button:AddToMasque(MSQ:Group(AddonName, "PetBar"))
                end

                Bar.Buttons[x][y] = Button
            end

            local ButtonWidth = ((Bar:GetWidth() - (2 * Bar.OuterMargin) - (Bar.ButtonSpacingX * (Bar.ButtonsX - 1))) / Bar.ButtonsX)
            local ButtonHeight = ((Bar:GetHeight() - (2 * Bar.OuterMargin) - (Bar.ButtonSpacingY * (Bar.ButtonsY - 1))) / Bar.ButtonsY)

            local xOff = Bar.OuterMargin + ((x - 1) * (ButtonWidth + Bar.ButtonSpacingX))
            local yOff = -1 * (Bar.OuterMargin + ((y - 1) * (ButtonHeight + Bar.ButtonSpacingY)))

            Button:SetPoint("TOPLEFT", Bar, "TOPLEFT", xOff, yOff)
            Button:SetSize(ButtonWidth, ButtonHeight)
            Button:Show()

            Button:SetAttribute("type", "pet")
            Button:SetAttribute("action", ButtonID)
            --Button:SetState(0, "pet", ButtonID)
        end
    end
end