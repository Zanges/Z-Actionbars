local Module = ZActionbars:NewModule("Options", "AceConsole-3.0")


local AceHelper = LibStub("Z-Lib_AceHelper-1.0")


--- @type ActionBars
local ActionBarsModule, MicroMenuModule


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
                        AceHelper:ToggleModule(ZActionbars, "DisableBlizzard", input)
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
                        AceHelper:ToggleModule(ZActionbars, "ActionBars", input)
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.moduleToggles.actionBars
                    end,
                },
                petActionBar = {
                    name = "Pet Actionbar",
                    order = 3,
                    type = "toggle",
                    set = function(info, input)
                        ZActionbars.db.profile.moduleToggles.petActionBar = input
                        AceHelper:ToggleModule(ZActionbars, "PetActionBar", input)
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.moduleToggles.petActionBar
                    end,
                },
                microMenu = {
                    name = "Micro Menu",
                    order = 4,
                    type = "toggle",
                    set = function(info, input)
                        ZActionbars.db.profile.moduleToggles.microMenu = input
                        AceHelper:ToggleModule(ZActionbars, "MicroMenu", input)
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.moduleToggles.microMenu
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
                        ActionBarsModule:UpdateBars()
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
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].anchorPoint = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].anchorPoint
                                    end,
                                },
                                barX = {
                                    name = "Bar X Position",
                                    order = 3,
                                    type = "range",
                                    min = -1 * floor(GetScreenWidth()),
                                    max = floor(GetScreenWidth()),
                                    step = 1,
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barX = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barX
                                    end,
                                },
                                barY = {
                                    name = "Bar Y Position",
                                    order = 4,
                                    min = -1 * floor(GetScreenHeight()),
                                    max = floor(GetScreenHeight()),
                                    step = 1,
                                    type = "range",
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barY = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barY
                                    end,
                                },
                                barWidth = {
                                    name = "Bar Width",
                                    order = 5,
                                    type = "range",
                                    min = 1,
                                    max = floor(GetScreenWidth()),
                                    step = 1,
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barWidth = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barWidth
                                    end,
                                },
                                barHeight = {
                                    name = "Bar Height",
                                    order = 6,
                                    min = 1,
                                    max = floor(GetScreenHeight()),
                                    step = 1,
                                    type = "range",
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barHeight = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].barHeight
                                    end,
                                },
                                barButtonsX = {
                                    name = "Bar Buttons X",
                                    order = 7,
                                    type = "range",
                                    min = 1,
                                    max = 100,
                                    step = 1,
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].buttonsX = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].buttonsX
                                    end,
                                },
                                barButtonsY = {
                                    name = "Bar Buttons Y",
                                    order = 8,
                                    min = 1,
                                    max = 100,
                                    step = 1,
                                    type = "range",
                                    set = function(info, input)
                                        ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].buttonsY = input
                                        ActionBarsModule:UpdateBars()
                                    end,
                                    get = function(info)
                                        return ZActionbars.db.profile.actionBars["bar" .. ZActionbars.db.profile.actionBars.selectedBar].buttonsY
                                    end,
                                },
                            },
                        },
                    },
                },
            },
        },
        microMenu = {
            name = "Micro Menu",
            order = 6,
            disabled = function() return not ZActionbars.db.profile.moduleToggles.microMenu end,
            hidden = function() return not ZActionbars.db.profile.moduleToggles.microMenu end,
            type = "group",
            args = {
                orientation = {
                    name = "Orientation",
                    order = 1,
                    type = "select",
                    values = {
                        ["HORIZONTAL"] = "HORIZONTAL",
                        ["VERTICAL"] = "VERTICAL",
                    },
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.orientation = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.orientation
                    end,
                },
                anchorPoint = {
                    name = "Anchor Point",
                    order = 2,
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
                        ZActionbars.db.profile.microMenu.anchorPoint = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.anchorPoint
                    end,
                },
                xPosition = {
                    name = "X Position",
                    order = 3,
                    type = "range",
                    min = -1 * floor(GetScreenWidth()),
                    max = floor(GetScreenWidth()),
                    step = 1,
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.xPosition = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.xPosition
                    end,
                },
                yPosition = {
                    name = "Y Position",
                    order = 4,
                    min = -1 * floor(GetScreenHeight()),
                    max = floor(GetScreenHeight()),
                    step = 1,
                    type = "range",
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.yPosition = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.yPosition
                    end,
                },
                width = {
                    name = "Bar Width",
                    order = 5,
                    type = "range",
                    min = 0,
                    max = floor(GetScreenWidth()),
                    step = 1,
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.width = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.width
                    end,
                },
                height = {
                    name = "Bar Height",
                    order = 6,
                    min = 0,
                    max = floor(GetScreenHeight()),
                    step = 1,
                    type = "range",
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.height = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.height
                    end,
                },
                buttonSpacing = {
                    name = "Button Spacing",
                    order = 7,
                    type = "range",
                    min = 0,
                    max = floor(GetScreenWidth()),
                    step = 1,
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.buttonSpacing = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.buttonSpacing
                    end,
                },
                outerMargin = {
                    name = "Outer Margin",
                    order = 8,
                    min = 0,
                    max = floor(GetScreenHeight()),
                    step = 1,
                    type = "range",
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.outerMargin = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.outerMargin
                    end,
                },
                font = {
                    name = "Button Font",
                    order = 9,
                    type = 'select',
                    dialogControl = 'LSM30_Font',
                    values = AceGUIWidgetLSMlists.font,
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.font = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.font
                    end,
                },
                fontSize = {
                    name = "Button Font Size",
                    order = 10,
                    min = 1,
                    max = 32,
                    step = 1,
                    type = "range",
                    set = function(info, input)
                        ZActionbars.db.profile.microMenu.fontSize = input
                        MicroMenuModule:UpdateMenuBar()
                    end,
                    get = function(info)
                        return ZActionbars.db.profile.microMenu.fontSize
                    end,
                },
            },
        },
    },
}

local defaults = {
    profile = {
        moduleToggles = {
            ['**'] = true,
            petActionBar = false, -- TODO FIX and re-enable
        },
        actionBars = {
            numActionBars = 2,
            selectedBar = 1,
            bar1 = {
                anchorPoint = "CENTER",
                barX = 0,
                barY = -160,
                barWidth = 320,
                barHeight = 90,
                buttonsX = 8,
                buttonsY = 2,
                buttonSpacingX = 0,
                buttonSpacingY = 0,
                outerMargin = 2,
            },
            bar2 = {
                anchorPoint = "BOTTOM",
                barX = 0,
                barY = 0,
                barWidth = 300,
                barHeight = 32,
                buttonsX = 18,
                buttonsY = 1,
                buttonSpacingX = 0,
                buttonSpacingY = 0,
                outerMargin = 2,
            },
            ['*'] = {
                anchorPoint = "CENTER",
                barX = 0,
                barY = 0,
                barWidth = 40,
                barHeight = 40,
                buttonsX = 1,
                buttonsY = 1,
                buttonSpacingX = 0,
                buttonSpacingY = 0,
                outerMargin = 2,
            },
        },
        microMenu = {
            orientation = "VERTICAL",
            anchorPoint = "BOTTOMRIGHT",
            xPosition = 0,
            yPosition = 0,
            width = 80,
            height = 180,
            buttonSpacing = 1,
            outerMargin = 2,
            font = "Friz Quadrata TT",
            fontSize = 7,
        },
        petBar = {
            anchorPoint = "CENTER",
            barX = -200,
            barY = -260,
            barWidth = 120,
            barHeight = 24,
            buttonsX = 10,
            buttonsY = 1,
            buttonSpacingX = 0,
            buttonSpacingY = 0,
            outerMargin = 2,
        },
    },
    char = {

    },
    class = {

    },
    global = {

    },
}


function Module:OnInitialize()
    ZActionbars.db = LibStub("AceDB-3.0"):New("Z-Actionbars_DB", defaults, true)

    options.args.profile = LibStub("AceDBOptions-3.0"):GetOptionsTable(ZActionbars.db)
    LibStub("AceConfig-3.0"):RegisterOptionsTable("Z-Actionbars", options, nil)
    Module:RegisterChatCommand("ZAB", "OpenStandaloneConfig")
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Z-Actionbars")
end

function Module:OnEnable()
    ActionBarsModule = ZActionbars:GetModule("ActionBars")
    MicroMenuModule= ZActionbars:GetModule("MicroMenu")
end

function Module:OpenStandaloneConfig()
    LibStub("AceConfigDialog-3.0"):Open("Z-Actionbars")
end