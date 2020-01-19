local DisableBlizzard = ZActionbars:NewModule("DisableBlizzard")


DisableBlizzard.FramesToDisable = {MainMenuBarArtFrame, StatusTrackingBarManager, PetActionBarFrame, MicroButtonAndBagsBar}


function DisableBlizzard:OnInitialize()
    DisableBlizzard:SetEnabledState(ZActionbars.db.profile.moduleToggles.disableBlizzard)
end

function DisableBlizzard:OnEnable()
    for k, v in pairs(DisableBlizzard.FramesToDisable) do
        v:UnregisterAllEvents()
        v:Hide()
    end
end

function DisableBlizzard:OnDisable()
    for k, v in pairs(DisableBlizzard.FramesToDisable) do
        v:Show()
    end
end