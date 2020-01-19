local AddonName, AddonTable = ...
local Options = ZActionbars:NewModule("Options", "AceConsole-3.0")


local options = {
    name = "Z-Actionbars",
    handler = ZActionbars,
    type = "group",
    args = {
        moduleToggles = {
            name = "Enable/Disable Modules",
            order = 1,
            type = "group",
            args = {
                disableBlizz = {
                    name = "Disable Blizzard",
                    order = 1,
                    type = "toggle",
                    set = function(info, input)
                        ZActionbars.db.profile.moduleToggles.disableBlizzard = input
                        LibStub("Z-Lib_AceHelper-1.0"):ToggleModule(ZActionbars, "DisableBlizzard", input)
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.moduleToggles.disableBlizzard
                    end,
                },
                actionBars = {
                    name = "Action Bars",
                    order = 2,
                    type = "toggle",
                    set = function(info, input)
                        ZActionbars.db.profile.moduleToggles.actionBars = input
                        LibStub("Z-Lib_AceHelper-1.0"):ToggleModule(ZActionbars, "ActionBars", input)
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.moduleToggles.actionBars
                    end,
                },
            },
        },
        actionBars = {
            name = "Action Bars",
            order = 5,
            disabled = function() return not ZActionbars.db.profile.moduleToggles.actionBars end,
            hidden = function() return not ZActionbars.db.profile.moduleToggles.actionBars end,
            type = "group",
            args = {
                numActionBars = {
                    name = "Number of Action Bars",
                    order = 1,
                    type = "range",
                    min = 1,
                    max = 20,
                    step = 1,
                    set = function(info, input)
                        ZActionbars.db.profile.actionBars.numActionBars = input
                        ZActionbars:GetModule("ActionBars"):UpdateBars()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.actionBars.numActionBars
                    end,
                },
                actionBarsConfig = {
                    name = "Action Bars Config",
                    order = 20,
                    type = "group",
                    args = {
                        actionBarSelect = {
                            name = "Action Bar Selection",
                            order = 1,
                            type = "select",
                            values = function()
                                local tbl = {}
                                for i = 1, ZActionbars.db.profile.actionBars.numActionBars do
                                    tbl[i] = "Bar" .. i
                                end
                                return tbl
                            end,
                            set = function(info, input)
                                ZActionbars.db.profile.actionBars.selectedBar = input
                            end,
                            get = function(info)
                                return ZActionbars.db.profile.actionBars.selectedBar
                            end,
                        },
                        actionBarsConfigSub = {
                            name = "Config",
                            order = 10,
                            type = "group",
                            inline = true,
                            args = {
                                barAnchorPoint = {
                                    name = "Anchor Point",
                                    order = 1,
                                    type = "select",
                                    values = {
                                        ["CENTER"] = "CENTER",
                                        ["TOPLEFT"] = "TOPLEFT",
                                        ["TOP"] = "TOP",
                                        ["TOPRIGHT"] = "TOPRIGHT",
                                        ["LEFT"] = "LEFT",
                                        ["RIGHT"] = "RIGHT",
                                        ["BOTTOMLEFT"] = "BOTTOMLEFT",
                                        ["BOTTOM"] = "BOTTOM",
                                        ["BOTTOMRIGHT"] = "BOTTOMRIGHT",
                                    },
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].AnchorPoint = input
                                        ZActionbars:GetModule("ActionBars"):UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].AnchorPoint
                                    end,
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}

local defaults = {
    profile = {
        moduleToggles = {
            ['**'] = {
                enabled = true,
            },
        },
        actionBars = {
            numActionBars = 1,
            selectedBar = 1,
            ['*'] = {
                AnchorPoint = "CENTER",
                BarX = 0,
                BarY = 0,
                BarWidth = 40,
                BarHeight = 40,
                ButtonsX = 1,
                ButtonsY = 1,
                ButtonSpacingX = 0,
                ButtonSpacingY = 0,
                OuterMargin = 2,
            },
        },
    },
    char = {

    },
    class = {

    },
    global = {

    },
}


function Options:OnInitialize()
    ZActionbars.db = LibStub("AceDB-3.0"):New("ZActionbars_DB", defaults, true)

    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(ZActionbars.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("Z-Actionbars", options, nil)
    Options:RegisterChatCommand("ZAB", "OpenStandaloneConfig")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Z-Actionbars")
end

function Options:OpenStandaloneConfig()
    LibStub("AceConfigDialog-3.0"):Open("Z-Actionbars")
end