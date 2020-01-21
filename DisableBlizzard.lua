local DisableBlizzard = ZActionbars:NewModule("DisableBlizzard")


--local MainMenuBar = _G["MainMenuBar"]
--local TimerTracker = _G["TimerTracker"]
--local MultiBarLeft = _G["MultiBarLeft"]

DisableBlizzard.FramesToDisable = {MainMenuBarArtFrame, StatusTrackingBarManager, PetActionBarFrame, MicroButtonAndBagsBar}--, MainMenuBar, TimerTracker}


function DisableBlizzard:OnInitialize()
    DisableBlizzard:SetEnabledState(ZActionbars.db.profile.moduleToggles.disableBlizzard)
end

function DisableBlizzard:OnEnable() -- /run ZActionbars:GetModule("DisableBlizzard"):OnEnable()
    for k, v in pairs(DisableBlizzard.FramesToDisable) do
        v:SetScript("OnEvent", nil)
        v:Hide()
    end
end

function DisableBlizzard:OnDisable()
    for k, v in pairs(DisableBlizzard.FramesToDisable) do
        v:Show()
    end
end