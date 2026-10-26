-- SPENT HUB - PRISON LIFE GUI STYLE
-- Modern sidebar layout with tabbed content

if not game:IsLoaded() then game.Loaded:Wait() end
if not syn or not protectgui then getgenv().protectgui = function() end end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ============ SILENT AIM SETTINGS ============
local SilentAimSettings = {
    Enabled = false,
    ToggleKey = "RightAlt",
    TeamCheck = false,
    VisibleCheck = false,
    TargetPart = "HumanoidRootPart",
    SilentAimMethod = "Raycast",
    FOVRadius = 130,
    FOVVisible = false,
    ShowSilentAimTarget = false,
    MouseHitPrediction = false,
    MouseHitPredictionAmount = 0.165,
    HitChance = 100,
    TargetCop = true,
    TargetInmate = true,
    TargetCriminal = true,
    ESP_Enabled = false,
    ESP_Team = false,
    ESP_Highlight = true,
    ESP_Name = true,
    ESP_Health = true,
    ESP_Trace = false,
    ESP_MaxDistance = 1500,
    ESP_HighlightColor = Color3.fromRGB(255, 182, 193),
    ESP_NameColor = Color3.fromRGB(255, 255, 255),
    ESP_HPColor = Color3.fromRGB(80, 255, 100),
    ESP_TraceColor = Color3.fromRGB(255, 255, 255),
}
getgenv().SilentAimSettings = SilentAimSettings

-- ============ THEME ============
local Theme = {
    PRIMARY = Color3.fromRGB(255, 182, 193),
    BG_DARK = Color3.fromRGB(20, 25, 35),
    BG_PANEL = Color3.fromRGB(30, 38, 50),
    BG_HOVER = Color3.fromRGB(40, 50, 65),
    BORDER = Color3.fromRGB(100, 140, 180),
    TEXT = Color3.fromRGB(230, 235, 245),
    TEXT_DIM = Color3.fromRGB(150, 160, 175),
    ACCENT_BLUE = Color3.fromRGB(100, 180, 255),
}

local MainFileName = "UniversalSilentAim"
local SelectedFile, FileToSave = "", ""

-- ============ CREATE MAIN GUI ============
local gui = Instance.new("ScreenGui")
gui.Name = "SpentHubPrisonLife"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.DisplayOrder = 100
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ============ BACKGROUND ============
local background = Instance.new("Frame", gui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
background.BackgroundTransparency = 0
background.BorderSizePixel = 0
background.ZIndex = 0

-- ============ MAIN CONTAINER ============
local mainContainer = Instance.new("Frame", gui)
mainContainer.Size = UDim2.new(0, 1200, 0, 700)
mainContainer.Position = UDim2.new(0.5, -600, 0.5, -350)
mainContainer.BackgroundTransparency = 1
mainContainer.BorderSizePixel = 0
mainContainer.ZIndex = 1

-- ============ LEFT SIDEBAR (Icons) ============
local leftSidebar = Instance.new("Frame", mainContainer)
leftSidebar.Size = UDim2.new(0, 80, 1, 0)
leftSidebar.Position = UDim2.new(0, 0, 0, 0)
leftSidebar.BackgroundColor3 = Theme.BG_DARK
leftSidebar.BorderSizePixel = 1
leftSidebar.BorderColor3 = Theme.BORDER
leftSidebar.ZIndex = 10

local sidebarLayout = Instance.new("UIListLayout", leftSidebar)
sidebarLayout.Padding = UDim.new(0, 0)
sidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
sidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local sidebarPad = Instance.new("UIPadding", leftSidebar)
sidebarPad.PaddingTop = UDim.new(0, 15)
sidebarPad.PaddingBottom = UDim.new(0, 15)

-- ============ CENTER PANEL ============
local centerPanel = Instance.new("Frame", mainContainer)
centerPanel.Size = UDim2.new(1, -320, 1, 0)
centerPanel.Position = UDim2.new(0, 80, 0, 0)
centerPanel.BackgroundColor3 = Theme.BG_PANEL
centerPanel.BorderSizePixel = 1
centerPanel.BorderColor3 = Theme.BORDER
centerPanel.ZIndex = 5

-- ============ RIGHT PANEL ============
local rightPanel = Instance.new("Frame", mainContainer)
rightPanel.Size = UDim2.new(0, 240, 1, 0)
rightPanel.Position = UDim2.new(1, -240, 0, 0)
rightPanel.BackgroundColor3 = Theme.BG_DARK
rightPanel.BorderSizePixel = 1
rightPanel.BorderColor3 = Theme.BORDER
rightPanel.ZIndex = 5

-- ============ RIGHT PANEL CONTENT ============
local rightContent = Instance.new("Frame", rightPanel)
rightContent.Size = UDim2.new(1, -20, 1, -20)
rightContent.Position = UDim2.new(0, 10, 0, 10)
rightContent.BackgroundTransparency = 1
rightContent.BorderSizePixel = 0
rightContent.ZIndex = 6

local rightLayout = Instance.new("UIListLayout", rightContent)
rightLayout.Padding = UDim.new(0, 12)
rightLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Team Label
local teamLabel = Instance.new("TextLabel", rightContent)
teamLabel.Size = UDim2.new(1, 0, 0, 24)
teamLabel.BackgroundTransparency = 1
teamLabel.Text = "Guards"
teamLabel.TextColor3 = Theme.PRIMARY
teamLabel.Font = Enum.Font.GothamBold
teamLabel.TextSize = 12
teamLabel.TextXAlignment = Enum.TextXAlignment.Left
teamLabel.ZIndex = 7

-- Player list
local playerList = Instance.new("Frame", rightContent)
playerList.Size = UDim2.new(1, 0, 0, 150)
playerList.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
playerList.BorderSizePixel = 1
playerList.BorderColor3 = Theme.BORDER
playerList.ZIndex = 7
Instance.new("UICorner", playerList).CornerRadius = UDim.new(0, 4)

local playerListLayout = Instance.new("UIListLayout", playerList)
playerListLayout.Padding = UDim.new(0, 2)
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder

local playerPad = Instance.new("UIPadding", playerList)
playerPad.PaddingTop = UDim.new(0, 8)
playerPad.PaddingLeft = UDim.new(0, 8)
playerPad.PaddingRight = UDim.new(0, 8)
playerPad.PaddingBottom = UDim.new(0, 8)

-- ============ CENTER PANEL CONTENT ============
local centerContent = Instance.new("Frame", centerPanel)
centerContent.Size = UDim2.new(1, -30, 1, -30)
centerContent.Position = UDim2.new(0, 15, 0, 15)
centerContent.BackgroundTransparency = 1
centerContent.BorderSizePixel = 0
centerContent.ZIndex = 6

local contentLayout = Instance.new("UIListLayout", centerContent)
contentLayout.Padding = UDim.new(0, 15)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- ============ GREETING SECTION ============
local greetingFrame = Instance.new("Frame", centerContent)
greetingFrame.Size = UDim2.new(1, 0, 0, 80)
greetingFrame.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
greetingFrame.BorderSizePixel = 1
greetingFrame.BorderColor3 = Theme.BORDER
greetingFrame.ZIndex = 6
Instance.new("UICorner", greetingFrame).CornerRadius = UDim.new(0, 4)

local greetingLabel = Instance.new("TextLabel", greetingFrame)
greetingLabel.Size = UDim2.new(1, -20, 0, 30)
greetingLabel.Position = UDim2.new(0, 10, 0, 10)
greetingLabel.BackgroundTransparency = 1
greetingLabel.Text = "Good Evening, " .. LocalPlayer.Name .. "!"
greetingLabel.TextColor3 = Theme.TEXT
greetingLabel.Font = Enum.Font.GothamBold
greetingLabel.TextSize = 16
greetingLabel.TextXAlignment = Enum.TextXAlignment.Left
greetingLabel.ZIndex = 7

local statusLabel = Instance.new("TextLabel", greetingFrame)
statusLabel.Size = UDim2.new(1, -20, 0, 20)
statusLabel.Position = UDim2.new(0, 10, 0, 45)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Silent Aim: Disabled · ESP: Disabled"
statusLabel.TextColor3 = Theme.TEXT_DIM
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.ZIndex = 7

-- ============ SECTION HELPER ============
local function makeSection(parent, title, defaultExpanded)
    local section = Instance.new("Frame", parent)
    section.Size = UDim2.new(1, 0, 0, 300)
    section.BackgroundColor3 = Color3.fromRGB(25, 30, 40)
    section.BorderSizePixel = 1
    section.BorderColor3 = Theme.BORDER
    section.ZIndex = 6
    Instance.new("UICorner", section).CornerRadius = UDim.new(0, 4)
    
    local headerBtn = Instance.new("TextButton", section)
    headerBtn.Size = UDim2.new(1, 0, 0, 35)
    headerBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 55)
    headerBtn.BorderSizePixel = 0
    headerBtn.Text = ""
    headerBtn.ZIndex = 7
    
    local headerLabel = Instance.new("TextLabel", headerBtn)
    headerLabel.Size = UDim2.new(1, -40, 1, 0)
    headerLabel.Position = UDim2.new(0, 15, 0, 0)
    headerLabel.BackgroundTransparency = 1
    headerLabel.Text = title
    headerLabel.TextColor3 = Theme.TEXT
    headerLabel.Font = Enum.Font.GothamBold
    headerLabel.TextSize = 12
    headerLabel.TextXAlignment = Enum.TextXAlignment.Left
    headerLabel.ZIndex = 8
    
    local toggleIcon = Instance.new("TextLabel", headerBtn)
    toggleIcon.Size = UDim2.new(0, 24, 0, 24)
    toggleIcon.Position = UDim2.new(1, -30, 0.5, -12)
    toggleIcon.BackgroundTransparency = 1
    toggleIcon.Text = "▼"
    toggleIcon.TextColor3 = Theme.BORDER
    toggleIcon.Font = Enum.Font.GothamBold
    toggleIcon.TextSize = 12
    toggleIcon.ZIndex = 8
    
    local contentFrame = Instance.new("ScrollingFrame", section)
    contentFrame.Size = UDim2.new(1, 0, 1, -35)
    contentFrame.Position = UDim2.new(0, 0, 0, 35)
    contentFrame.BackgroundTransparency = 1
    contentFrame.BorderSizePixel = 0
    contentFrame.ScrollBarThickness = 3
    contentFrame.ScrollBarImageColor3 = Theme.BORDER
    contentFrame.ZIndex = 7
    
    local contentLayout = Instance.new("UIListLayout", contentFrame)
    contentLayout.Padding = UDim.new(0, 8)
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local contentPad = Instance.new("UIPadding", contentFrame)
    contentPad.PaddingTop = UDim.new(0, 10)
    contentPad.PaddingLeft = UDim.new(0, 10)
    contentPad.PaddingRight = UDim.new(0, 10)
    contentPad.PaddingBottom = UDim.new(0, 10)
    
    local isExpanded = defaultExpanded or true
    
    headerBtn.MouseButton1Click:Connect(function()
        isExpanded = not isExpanded
        contentFrame.Visible = isExpanded
        toggleIcon.Text = isExpanded and "▼" or "▶"
        TweenService:Create(toggleIcon, TweenInfo.new(0.2), {
            Rotation = isExpanded and 0 or -90
        }):Play()
    end)
    
    headerBtn.MouseEnter:Connect(function()
        TweenService:Create(headerBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(45, 55, 75)
        }):Play()
    end)
    
    headerBtn.MouseLeave:Connect(function()
        TweenService:Create(headerBtn, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(35, 42, 55)
        }):Play()
    end)
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
    return section, contentFrame
end

-- ============ TOGGLE HELPER ============
local function makeToggle(parent, name, default, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.new(1, 0, 0, 28)
    holder.BackgroundTransparency = 1
    holder.ZIndex = 8
    
    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(0.7, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.TEXT
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9
    
    local toggle = Instance.new("Frame", holder)
    toggle.Size = UDim2.new(0, 40, 0, 20)
    toggle.Position = UDim2.new(1, -50, 0.5, -10)
    toggle.BackgroundColor3 = default and Theme.PRIMARY or Color3.fromRGB(60, 65, 75)
    toggle.BorderSizePixel = 0
    toggle.ZIndex = 9
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(1, 0)
    
    local knob = Instance.new("Frame", toggle)
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    knob.BorderSizePixel = 0
    knob.ZIndex = 10
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    
    local state = default
    
    toggle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            state = not state
            TweenService:Create(knob, TweenInfo.new(0.2), {
                Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            }):Play()
            TweenService:Create(toggle, TweenInfo.new(0.2), {
                BackgroundColor3 = state and Theme.PRIMARY or Color3.fromRGB(60, 65, 75)
            }):Play()
            callback(state)
        end
    end)
    
    return holder
end

-- ============ DROPDOWN HELPER ============
local function makeDropdown(parent, name, options, default, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.new(1, 0, 0, 28)
    holder.BackgroundTransparency = 1
    holder.ZIndex = 8
    
    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(1, -45, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = name
    label.TextColor3 = Theme.TEXT
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9
    
    local currentIndex = 1
    for i, v in ipairs(options) do
        if v == default then currentIndex = i break end
    end
    
    local dropdown = Instance.new("TextButton", holder)
    dropdown.Size = UDim2.new(0, 40, 1, 0)
    dropdown.Position = UDim2.new(1, -45, 0, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(60, 65, 75)
    dropdown.BorderSizePixel = 0
    dropdown.Text = options[currentIndex]:sub(1, 3)
    dropdown.TextColor3 = Theme.TEXT
    dropdown.Font = Enum.Font.GothamMedium
    dropdown.TextSize = 9
    dropdown.ZIndex = 9
    Instance.new("UICorner", dropdown).CornerRadius = UDim.new(0, 3)
    
    dropdown.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        dropdown.Text = options[currentIndex]:sub(1, 3)
        callback(options[currentIndex])
    end)
    
    dropdown.MouseEnter:Connect(function()
        TweenService:Create(dropdown, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(80, 90, 110)
        }):Play()
    end)
    
    dropdown.MouseLeave:Connect(function()
        TweenService:Create(dropdown, TweenInfo.new(0.15), {
            BackgroundColor3 = Color3.fromRGB(60, 65, 75)
        }):Play()
    end)
    
    return holder
end

-- ============ SLIDER HELPER ============
local function makeSlider(parent, name, min, max, default, callback)
    local holder = Instance.new("Frame", parent)
    holder.Size = UDim2.new(1, 0, 0, 40)
    holder.BackgroundTransparency = 1
    holder.ZIndex = 8
    
    local label = Instance.new("TextLabel", holder)
    label.Size = UDim2.new(1, 0, 0, 16)
    label.BackgroundTransparency = 1
    label.Text = name .. ": " .. default
    label.TextColor3 = Theme.TEXT
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9
    
    local bar = Instance.new("Frame", holder)
    bar.Size = UDim2.new(1, 0, 0, 6)
    bar.Position = UDim2.new(0, 0, 0, 22)
    bar.BackgroundColor3 = Color3.fromRGB(60, 65, 75)
    bar.BorderSizePixel = 0
    bar.ZIndex = 9
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Theme.PRIMARY
    fill.BorderSizePixel = 0
    fill.ZIndex = 10
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            local value = math.floor(min + (max - min) * rel)
            fill.Size = UDim2.new(rel, 0, 1, 0)
            label.Text = name .. ": " .. value
            callback(value)
        end
    end)
    
    return holder
end

-- ============ BUILD SECTIONS ============

-- Silent Aim Section
local silentSection, silentContent = makeSection(centerContent, "Silent Aim", true)
makeToggle(silentContent, "Enabled", SilentAimSettings.Enabled, function(s)
    SilentAimSettings.Enabled = s
    statusLabel.Text = "● Silent Aim: " .. (s and "Enabled" or "Disabled") .. " · ESP: " .. (SilentAimSettings.ESP_Enabled and "Enabled" or "Disabled")
end)
makeDropdown(silentContent, "Target Part", {"Head", "HumanoidRootPart", "Random"}, SilentAimSettings.TargetPart, function(v)
    SilentAimSettings.TargetPart = v
end)
makeDropdown(silentContent, "Method", {"Raycast", "FindPartOnRay"}, SilentAimSettings.SilentAimMethod, function(v)
    SilentAimSettings.SilentAimMethod = v
end)
makeSlider(silentContent, "Hit Chance", 0, 100, SilentAimSettings.HitChance, function(v)
    SilentAimSettings.HitChance = v
end)

-- Filters Section
local filterSection, filterContent = makeSection(centerContent, "Filters", true)
makeToggle(filterContent, "Team Check", SilentAimSettings.TeamCheck, function(s)
    SilentAimSettings.TeamCheck = s
end)
makeToggle(filterContent, "Visible Check", SilentAimSettings.VisibleCheck, function(s)
    SilentAimSettings.VisibleCheck = s
end)

-- Target Teams Section
local teamSection, teamContent = makeSection(centerContent, "Target Teams", true)
makeToggle(teamContent, "Target Cops", SilentAimSettings.TargetCop, function(s)
    SilentAimSettings.TargetCop = s
end)
makeToggle(teamContent, "Target Inmates", SilentAimSettings.TargetInmate, function(s)
    SilentAimSettings.TargetInmate = s
end)
makeToggle(teamContent, "Target Criminals", SilentAimSettings.TargetCriminal, function(s)
    SilentAimSettings.TargetCriminal = s
end)

-- ESP Section
local espSection, espContent = makeSection(centerContent, "ESP", true)
makeToggle(espContent, "Enable ESP", SilentAimSettings.ESP_Enabled, function(s)
    SilentAimSettings.ESP_Enabled = s
    statusLabel.Text = "● Silent Aim: " .. (SilentAimSettings.Enabled and "Enabled" or "Disabled") .. " · ESP: " .. (s and "Enabled" or "Disabled")
end)
makeToggle(espContent, "Highlight", SilentAimSettings.ESP_Highlight, function(s)
    SilentAimSettings.ESP_Highlight = s
end)
makeToggle(espContent, "Names", SilentAimSettings.ESP_Name, function(s)
    SilentAimSettings.ESP_Name = s
end)
makeToggle(espContent, "Health Bars", SilentAimSettings.ESP_Health, function(s)
    SilentAimSettings.ESP_Health = s
end)
makeSlider(espContent, "Max Distance", 100, 3000, SilentAimSettings.ESP_MaxDistance, function(v)
    SilentAimSettings.ESP_MaxDistance = v
end)

-- ============ SIDE PANEL ICONS ============
local iconNames = {"ℹ", "⚙", "📊"}
local iconTooltips = {"Info", "Settings", "Stats"}

for i, iconText in ipairs(iconNames) do
    local iconBtn = Instance.new("TextButton", leftSidebar)
    iconBtn.Size = UDim2.new(0, 50, 0, 50)
    iconBtn.BackgroundColor3 = (i == 1) and Theme.ACCENT_BLUE or Color3.fromRGB(50, 60, 75)
    iconBtn.Text = iconText
    iconBtn.TextColor3 = Theme.TEXT
    iconBtn.Font = Enum.Font.GothamBold
    iconBtn.TextSize = 18
    iconBtn.BorderSizePixel = 1
    iconBtn.BorderColor3 = Theme.BORDER
    iconBtn.ZIndex = 11
    Instance.new("UICorner", iconBtn).CornerRadius = UDim.new(0, 6)
    
    iconBtn.MouseEnter:Connect(function()
        TweenService:Create(iconBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.ACCENT_BLUE
        }):Play()
    end)
    
    iconBtn.MouseLeave:Connect(function()
        if i ~= 1 then
            TweenService:Create(iconBtn, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 60, 75)
            }):Play()
        end
    end)
end

-- ============ POPULATE RIGHT PANEL ============
local players = {"another_sorryim", "cctowa", "freaknob", "Guy", "Yasseramalli"}
for _, playerName in ipairs(players) do
    local playerBtn = Instance.new("TextButton", playerList)
    playerBtn.Size = UDim2.new(1, 0, 0, 20)
    playerBtn.BackgroundTransparency = 1
    playerBtn.Text = playerName
    playerBtn.TextColor3 = Theme.TEXT_DIM
    playerBtn.Font = Enum.Font.Gotham
    playerBtn.TextSize = 10
    playerBtn.TextXAlignment = Enum.TextXAlignment.Left
    playerBtn.ZIndex = 8
    
    playerBtn.MouseEnter:Connect(function()
        TweenService:Create(playerBtn, TweenInfo.new(0.15), {
            TextColor3 = Theme.TEXT
        }):Play()
    end)
    
    playerBtn.MouseLeave:Connect(function()
        TweenService:Create(playerBtn, TweenInfo.new(0.15), {
            TextColor3 = Theme.TEXT_DIM
        }):Play()
    end)
end

-- ============ KEYBINDS ============
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    
    if input.KeyCode == Enum.KeyCode.RightAlt then
        SilentAimSettings.Enabled = not SilentAimSettings.Enabled
        statusLabel.Text = "● Silent Aim: " .. (SilentAimSettings.Enabled and "Enabled" or "Disabled") .. " · ESP: " .. (SilentAimSettings.ESP_Enabled and "Enabled" or "Disabled")
    end
    
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainContainer.Visible = not mainContainer.Visible
    end
    
    if input.KeyCode == Enum.KeyCode.End then
        gui:Destroy()
    end
end)

print("SPENT HUB - Prison Life Style loaded. Keybinds: RAlt (toggle aim), RShift (toggle GUI), END (unload)")
