local Module = ZActionbars:NewModule("DisableBlizzard")


Module.FramesToDisable = { MainMenuBarArtFrame, StatusTrackingBarManager, PetActionBarFrame, MicroButtonAndBagsBar, MainMenuBar, TimerTracker}


function Module:OnInitialize()
    Module:SetEnabledState(ZActionbars.db.profile.moduleToggles.disableBlizzard)
end

function Module:OnEnable()
    for _, v in pairs(Module.FramesToDisable) do
        v:SetScript("OnEvent", nil)
        v:Hide()
        v:ClearAllPoints()
    end
end

function Module:OnDisable()
    for _, v in pairs(Module.FramesToDisable) do
        v:Show()
    end
end