local AddonName, AddonTable = ...
ZActionbars = LibStub("AceAddon-3.0"):NewAddon("Z-Actionbars", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Z-Actionbars", true)


local DisableBlizzard


function ZActionbars:OnInitialize()
    LibStub("Z-Lib_Debug-1.0"):Debug(AddonName .. " initializing...")

    DisableBlizzard = self:GetModule("DisableBlizzard")

    LibStub("Z-Lib_Debug-1.0"):Debug("Done!")
end

function ZActionbars:OnEnable()
    -- Called when the addon is enabled
end

function ZActionbars:OnDisable()
    -- Called when the addon is disabled
end