-- Mainxio Combat - Enhanced Version
-- Place in StarterPlayer > StarterPlayerScripts as a LocalScript

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Wait for everything to load
if not localPlayer.Character then
    localPlayer.CharacterAdded:Wait()
end

local playerGui = localPlayer:WaitForChild("PlayerGui")

-- Create the GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MainxioCombat"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Center Dot (removed FOV circle)
local centerDot = Instance.new("Frame")
centerDot.Name = "CenterDot"
centerDot.Size = UDim2.new(0, 4, 0, 4)
centerDot.Position = UDim2.new(0.5, -2, 0.5, -2)
centerDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
centerDot.BorderSizePixel = 0
centerDot.Parent = screenGui

local centerDotCorner = Instance.new("UICorner")
centerDotCorner.CornerRadius = UDim.new(1, 0)
centerDotCorner.Parent = centerDot

-- MODERN MENU DESIGN
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250) -- Centered
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
mainFrame.BackgroundTransparency = 0.05
mainFrame.Visible = true -- Opens by itself
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 50)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MAINXIO"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -60, 0, 15)
subtitle.Position = UDim2.new(0, 15, 0, 30)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Combat System"
subtitle.TextColor3 = Color3.fromRGB(180, 180, 220)
subtitle.TextSize = 10
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

-- Close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -40, 0.5, -15)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
closeButton.TextSize = 24
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

-- Tabs
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -40, 0, 40)
tabContainer.Position = UDim2.new(0, 20, 0, 60)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local tabs = {"AIM", "VISUAL", "HACKS", "SETTINGS"}
local tabButtons = {}
local contentFrames = {}

for i, tabName in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.24, -2, 1, 0)
    tabButton.Position = UDim2.new((i-1) * 0.24, 0, 0, 0)
    tabButton.Text = tabName
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    tabButton.TextSize = 12
    tabButton.Font = Enum.Font.GothamBold
    tabButton.Parent = tabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 6)
    tabCorner.Parent = tabButton
    
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -40, 0, 370)
    contentFrame.Position = UDim2.new(0, 20, 0, 110)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = (i == 1)
    contentFrame.Parent = mainFrame
    
    tabButtons[tabName] = tabButton
    contentFrames[tabName] = contentFrame
end

-- Function to switch tabs
local function showTab(tabName)
    for name, frame in pairs(contentFrames) do
        frame.Visible = (name == tabName)
    end
    for name, button in pairs(tabButtons) do
        if name == tabName then
            button.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        else
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        end
    end
end

-- Connect tab buttons
for tabName, button in pairs(tabButtons) do
    button.MouseButton1Click:Connect(function()
        showTab(tabName)
    end)
end

-- AIM TAB CONTENT
local aimFrame = contentFrames["AIM"]

-- Aimbot Toggle
local aimbotToggleContainer = Instance.new("Frame")
aimbotToggleContainer.Size = UDim2.new(1, 0, 0, 50)
aimbotToggleContainer.Position = UDim2.new(0, 0, 0, 0)
aimbotToggleContainer.BackgroundTransparency = 1
aimbotToggleContainer.Parent = aimFrame

local aimbotStatus = Instance.new("TextLabel")
aimbotStatus.Size = UDim2.new(0.6, 0, 0, 20)
aimbotStatus.Position = UDim2.new(0, 0, 0, 0)
aimbotStatus.BackgroundTransparency = 1
aimbotStatus.Text = "AIMBOT"
aimbotStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotStatus.TextSize = 14
aimbotStatus.Font = Enum.Font.GothamBold
aimbotStatus.TextXAlignment = Enum.TextXAlignment.Left
aimbotStatus.Parent = aimbotToggleContainer

local aimbotStatusSub = Instance.new("TextLabel")
aimbotStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
aimbotStatusSub.Position = UDim2.new(0, 0, 0, 20)
aimbotStatusSub.BackgroundTransparency = 1
aimbotStatusSub.Text = "OFF"
aimbotStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
aimbotStatusSub.TextSize = 11
aimbotStatusSub.Font = Enum.Font.Gotham
aimbotStatusSub.TextXAlignment = Enum.TextXAlignment.Left
aimbotStatusSub.Parent = aimbotToggleContainer

local aimbotToggle = Instance.new("TextButton")
aimbotToggle.Size = UDim2.new(0, 50, 0, 25)
aimbotToggle.Position = UDim2.new(1, -50, 0, 12)
aimbotToggle.Text = ""
aimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
aimbotToggle.Parent = aimbotToggleContainer

local toggleKnob = Instance.new("Frame")
toggleKnob.Size = UDim2.new(0, 21, 1, -4)
toggleKnob.Position = UDim2.new(0, 2, 0, 2)
toggleKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
toggleKnob.Parent = aimbotToggle

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(1, 0)
toggleCorner.Parent = aimbotToggle

local knobCorner = Instance.new("UICorner")
knobCorner.CornerRadius = UDim.new(1, 0)
knobCorner.Parent = toggleKnob

-- Team Check Toggle
local teamCheckToggleContainer = Instance.new("Frame")
teamCheckToggleContainer.Size = UDim2.new(1, 0, 0, 50)
teamCheckToggleContainer.Position = UDim2.new(0, 0, 0, 60)
teamCheckToggleContainer.BackgroundTransparency = 1
teamCheckToggleContainer.Parent = aimFrame

local teamCheckStatus = Instance.new("TextLabel")
teamCheckStatus.Size = UDim2.new(0.6, 0, 0, 20)
teamCheckStatus.Position = UDim2.new(0, 0, 0, 0)
teamCheckStatus.BackgroundTransparency = 1
teamCheckStatus.Text = "TEAM CHECK"
teamCheckStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
teamCheckStatus.TextSize = 14
teamCheckStatus.Font = Enum.Font.GothamBold
teamCheckStatus.TextXAlignment = Enum.TextXAlignment.Left
teamCheckStatus.Parent = teamCheckToggleContainer

local teamCheckStatusSub = Instance.new("TextLabel")
teamCheckStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
teamCheckStatusSub.Position = UDim2.new(0, 0, 0, 20)
teamCheckStatusSub.BackgroundTransparency = 1
teamCheckStatusSub.Text = "ON"
teamCheckStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
teamCheckStatusSub.TextSize = 11
teamCheckStatusSub.Font = Enum.Font.Gotham
teamCheckStatusSub.TextXAlignment = Enum.TextXAlignment.Left
teamCheckStatusSub.Parent = teamCheckToggleContainer

local teamCheckToggle = Instance.new("TextButton")
teamCheckToggle.Size = UDim2.new(0, 50, 0, 25)
teamCheckToggle.Position = UDim2.new(1, -50, 0, 12)
teamCheckToggle.Text = ""
teamCheckToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
teamCheckToggle.Parent = teamCheckToggleContainer

local teamCheckKnob = Instance.new("Frame")
teamCheckKnob.Size = UDim2.new(0, 21, 1, -4)
teamCheckKnob.Position = UDim2.new(1, -23, 0, 2)
teamCheckKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
teamCheckKnob.Parent = teamCheckToggle

local teamCheckToggleCorner = Instance.new("UICorner")
teamCheckToggleCorner.CornerRadius = UDim.new(1, 0)
teamCheckToggleCorner.Parent = teamCheckToggle

local teamCheckKnobCorner = Instance.new("UICorner")
teamCheckKnobCorner.CornerRadius = UDim.new(1, 0)
teamCheckKnobCorner.Parent = teamCheckKnob

-- Aimbot Settings
local settingsContainer = Instance.new("Frame")
settingsContainer.Size = UDim2.new(1, 0, 0, 120)
settingsContainer.Position = UDim2.new(0, 0, 0, 120)
settingsContainer.BackgroundTransparency = 1
settingsContainer.Parent = aimFrame

-- Aim Part
local aimPartButton = Instance.new("TextButton")
aimPartButton.Size = UDim2.new(1, 0, 0, 30)
aimPartButton.Position = UDim2.new(0, 0, 0, 0)
aimPartButton.Text = "Target: Head"
aimPartButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimPartButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
aimPartButton.TextSize = 12
aimPartButton.Font = Enum.Font.Gotham
aimPartButton.Parent = settingsContainer

local aimPartCorner = Instance.new("UICorner")
aimPartCorner.CornerRadius = UDim.new(0, 6)
aimPartCorner.Parent = aimPartButton

-- Smoothness
local smoothnessButton = Instance.new("TextButton")
smoothnessButton.Size = UDim2.new(1, 0, 0, 30)
smoothnessButton.Position = UDim2.new(0, 0, 0, 40)
smoothnessButton.Text = "Smoothness: 0.3"
smoothnessButton.TextColor3 = Color3.fromRGB(255, 255, 255)
smoothnessButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
smoothnessButton.TextSize = 12
smoothnessButton.Font = Enum.Font.Gotham
smoothnessButton.Parent = settingsContainer

local smoothnessCorner = Instance.new("UICorner")
smoothnessCorner.CornerRadius = UDim.new(0, 6)
smoothnessCorner.Parent = smoothnessButton

-- Keybind
local keybindButton = Instance.new("TextButton")
keybindButton.Size = UDim2.new(1, 0, 0, 30)
keybindButton.Position = UDim2.new(0, 0, 0, 80)
keybindButton.Text = "Keybind: Right Mouse"
keybindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
keybindButton.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
keybindButton.TextSize = 12
keybindButton.Font = Enum.Font.Gotham
keybindButton.Parent = settingsContainer

local keybindCorner = Instance.new("UICorner")
keybindCorner.CornerRadius = UDim.new(0, 6)
keybindCorner.Parent = keybindButton

-- Instructions
local aimInstructions = Instance.new("TextLabel")
aimInstructions.Size = UDim2.new(1, 0, 0, 40)
aimInstructions.Position = UDim2.new(0, 0, 0, 250)
aimInstructions.BackgroundTransparency = 1
aimInstructions.Text = "Hold keybind to aimbot\nTeam Check: Only targets enemies"
aimInstructions.TextColor3 = Color3.fromRGB(150, 150, 150)
aimInstructions.TextSize = 10
aimInstructions.Font = Enum.Font.Gotham
aimInstructions.TextWrapped = true
aimInstructions.Parent = aimFrame

-- VISUAL TAB CONTENT
local visualFrame = contentFrames["VISUAL"]

-- Highlights Toggle
local highlightToggleContainer = Instance.new("Frame")
highlightToggleContainer.Size = UDim2.new(1, 0, 0, 50)
highlightToggleContainer.Position = UDim2.new(0, 0, 0, 0)
highlightToggleContainer.BackgroundTransparency = 1
highlightToggleContainer.Parent = visualFrame

local highlightStatus = Instance.new("TextLabel")
highlightStatus.Size = UDim2.new(0.6, 0, 0, 20)
highlightStatus.Position = UDim2.new(0, 0, 0, 0)
highlightStatus.BackgroundTransparency = 1
highlightStatus.Text = "PLAYER HIGHLIGHTS"
highlightStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
highlightStatus.TextSize = 14
highlightStatus.Font = Enum.Font.GothamBold
highlightStatus.TextXAlignment = Enum.TextXAlignment.Left
highlightStatus.Parent = highlightToggleContainer

local highlightStatusSub = Instance.new("TextLabel")
highlightStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
highlightStatusSub.Position = UDim2.new(0, 0, 0, 20)
highlightStatusSub.BackgroundTransparency = 1
highlightStatusSub.Text = "OFF"
highlightStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
highlightStatusSub.TextSize = 11
highlightStatusSub.Font = Enum.Font.Gotham
highlightStatusSub.TextXAlignment = Enum.TextXAlignment.Left
highlightStatusSub.Parent = highlightToggleContainer

local highlightToggle = Instance.new("TextButton")
highlightToggle.Size = UDim2.new(0, 50, 0, 25)
highlightToggle.Position = UDim2.new(1, -50, 0, 12)
highlightToggle.Text = ""
highlightToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
highlightToggle.Parent = highlightToggleContainer

local highlightKnob = Instance.new("Frame")
highlightKnob.Size = UDim2.new(0, 21, 1, -4)
highlightKnob.Position = UDim2.new(0, 2, 0, 2)
highlightKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
highlightKnob.Parent = highlightToggle

local highlightToggleCorner = Instance.new("UICorner")
highlightToggleCorner.CornerRadius = UDim.new(1, 0)
highlightToggleCorner.Parent = highlightToggle

local highlightKnobCorner = Instance.new("UICorner")
highlightKnobCorner.CornerRadius = UDim.new(1, 0)
highlightKnobCorner.Parent = highlightKnob

-- Name ESP Toggle
local nameESPToggleContainer = Instance.new("Frame")
nameESPToggleContainer.Size = UDim2.new(1, 0, 0, 50)
nameESPToggleContainer.Position = UDim2.new(0, 0, 0, 60)
nameESPToggleContainer.BackgroundTransparency = 1
nameESPToggleContainer.Parent = visualFrame

local nameESPStatus = Instance.new("TextLabel")
nameESPStatus.Size = UDim2.new(0.6, 0, 0, 20)
nameESPStatus.Position = UDim2.new(0, 0, 0, 0)
nameESPStatus.BackgroundTransparency = 1
nameESPStatus.Text = "NAME ESP"
nameESPStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
nameESPStatus.TextSize = 14
nameESPStatus.Font = Enum.Font.GothamBold
nameESPStatus.TextXAlignment = Enum.TextXAlignment.Left
nameESPStatus.Parent = nameESPToggleContainer

local nameESPStatusSub = Instance.new("TextLabel")
nameESPStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
nameESPStatusSub.Position = UDim2.new(0, 0, 0, 20)
nameESPStatusSub.BackgroundTransparency = 1
nameESPStatusSub.Text = "OFF"
nameESPStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
nameESPStatusSub.TextSize = 11
nameESPStatusSub.Font = Enum.Font.Gotham
nameESPStatusSub.TextXAlignment = Enum.TextXAlignment.Left
nameESPStatusSub.Parent = nameESPToggleContainer

local nameESPToggle = Instance.new("TextButton")
nameESPToggle.Size = UDim2.new(0, 50, 0, 25)
nameESPToggle.Position = UDim2.new(1, -50, 0, 12)
nameESPToggle.Text = ""
nameESPToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
nameESPToggle.Parent = nameESPToggleContainer

local nameESPKnob = Instance.new("Frame")
nameESPKnob.Size = UDim2.new(0, 21, 1, -4)
nameESPKnob.Position = UDim2.new(0, 2, 0, 2)
nameESPKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
nameESPKnob.Parent = nameESPToggle

local nameESPToggleCorner = Instance.new("UICorner")
nameESPToggleCorner.CornerRadius = UDim.new(1, 0)
nameESPToggleCorner.Parent = nameESPToggle

local nameESPKnobCorner = Instance.new("UICorner")
nameESPKnobCorner.CornerRadius = UDim.new(1, 0)
nameESPKnobCorner.Parent = nameESPKnob

-- Skeleton ESP Toggle
local skeletonToggleContainer = Instance.new("Frame")
skeletonToggleContainer.Size = UDim2.new(1, 0, 0, 50)
skeletonToggleContainer.Position = UDim2.new(0, 0, 0, 120)
skeletonToggleContainer.BackgroundTransparency = 1
skeletonToggleContainer.Parent = visualFrame

local skeletonStatus = Instance.new("TextLabel")
skeletonStatus.Size = UDim2.new(0.6, 0, 0, 20)
skeletonStatus.Position = UDim2.new(0, 0, 0, 0)
skeletonStatus.BackgroundTransparency = 1
skeletonStatus.Text = "SKELETON ESP"
skeletonStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
skeletonStatus.TextSize = 14
skeletonStatus.Font = Enum.Font.GothamBold
skeletonStatus.TextXAlignment = Enum.TextXAlignment.Left
skeletonStatus.Parent = skeletonToggleContainer

local skeletonStatusSub = Instance.new("TextLabel")
skeletonStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
skeletonStatusSub.Position = UDim2.new(0, 0, 0, 20)
skeletonStatusSub.BackgroundTransparency = 1
skeletonStatusSub.Text = "OFF"
skeletonStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
skeletonStatusSub.TextSize = 11
skeletonStatusSub.Font = Enum.Font.Gotham
skeletonStatusSub.TextXAlignment = Enum.TextXAlignment.Left
skeletonStatusSub.Parent = skeletonToggleContainer

local skeletonToggle = Instance.new("TextButton")
skeletonToggle.Size = UDim2.new(0, 50, 0, 25)
skeletonToggle.Position = UDim2.new(1, -50, 0, 12)
skeletonToggle.Text = ""
skeletonToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
skeletonToggle.Parent = skeletonToggleContainer

local skeletonKnob = Instance.new("Frame")
skeletonKnob.Size = UDim2.new(0, 21, 1, -4)
skeletonKnob.Position = UDim2.new(0, 2, 0, 2)
skeletonKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
skeletonKnob.Parent = skeletonToggle

local skeletonToggleCorner = Instance.new("UICorner")
skeletonToggleCorner.CornerRadius = UDim.new(1, 0)
skeletonToggleCorner.Parent = skeletonToggle

local skeletonKnobCorner = Instance.new("UICorner")
skeletonKnobCorner.CornerRadius = UDim.new(1, 0)
skeletonKnobCorner.Parent = skeletonKnob

-- Tracer ESP Toggle
local tracerToggleContainer = Instance.new("Frame")
tracerToggleContainer.Size = UDim2.new(1, 0, 0, 50)
tracerToggleContainer.Position = UDim2.new(0, 0, 0, 180)
tracerToggleContainer.BackgroundTransparency = 1
tracerToggleContainer.Parent = visualFrame

local tracerStatus = Instance.new("TextLabel")
tracerStatus.Size = UDim2.new(0.6, 0, 0, 20)
tracerStatus.Position = UDim2.new(0, 0, 0, 0)
tracerStatus.BackgroundTransparency = 1
tracerStatus.Text = "TRACER ESP"
tracerStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
tracerStatus.TextSize = 14
tracerStatus.Font = Enum.Font.GothamBold
tracerStatus.TextXAlignment = Enum.TextXAlignment.Left
tracerStatus.Parent = tracerToggleContainer

local tracerStatusSub = Instance.new("TextLabel")
tracerStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
tracerStatusSub.Position = UDim2.new(0, 0, 0, 20)
tracerStatusSub.BackgroundTransparency = 1
tracerStatusSub.Text = "OFF"
tracerStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
tracerStatusSub.TextSize = 11
tracerStatusSub.Font = Enum.Font.Gotham
tracerStatusSub.TextXAlignment = Enum.TextXAlignment.Left
tracerStatusSub.Parent = tracerToggleContainer

local tracerToggle = Instance.new("TextButton")
tracerToggle.Size = UDim2.new(0, 50, 0, 25)
tracerToggle.Position = UDim2.new(1, -50, 0, 12)
tracerToggle.Text = ""
tracerToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
tracerToggle.Parent = tracerToggleContainer

local tracerKnob = Instance.new("Frame")
tracerKnob.Size = UDim2.new(0, 21, 1, -4)
tracerKnob.Position = UDim2.new(0, 2, 0, 2)
tracerKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tracerKnob.Parent = tracerToggle

local tracerToggleCorner = Instance.new("UICorner")
tracerToggleCorner.CornerRadius = UDim.new(1, 0)
tracerToggleCorner.Parent = tracerToggle

local tracerKnobCorner = Instance.new("UICorner")
tracerKnobCorner.CornerRadius = UDim.new(1, 0)
tracerKnobCorner.Parent = tracerKnob

-- Health Bar ESP Toggle
local healthBarToggleContainer = Instance.new("Frame")
healthBarToggleContainer.Size = UDim2.new(1, 0, 0, 50)
healthBarToggleContainer.Position = UDim2.new(0, 0, 0, 240)
healthBarToggleContainer.BackgroundTransparency = 1
healthBarToggleContainer.Parent = visualFrame

local healthBarStatus = Instance.new("TextLabel")
healthBarStatus.Size = UDim2.new(0.6, 0, 0, 20)
healthBarStatus.Position = UDim2.new(0, 0, 0, 0)
healthBarStatus.BackgroundTransparency = 1
healthBarStatus.Text = "HEALTH BAR ESP"
healthBarStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
healthBarStatus.TextSize = 14
healthBarStatus.Font = Enum.Font.GothamBold
healthBarStatus.TextXAlignment = Enum.TextXAlignment.Left
healthBarStatus.Parent = healthBarToggleContainer

local healthBarStatusSub = Instance.new("TextLabel")
healthBarStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
healthBarStatusSub.Position = UDim2.new(0, 0, 0, 20)
healthBarStatusSub.BackgroundTransparency = 1
healthBarStatusSub.Text = "OFF"
healthBarStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
healthBarStatusSub.TextSize = 11
healthBarStatusSub.Font = Enum.Font.Gotham
healthBarStatusSub.TextXAlignment = Enum.TextXAlignment.Left
healthBarStatusSub.Parent = healthBarToggleContainer

local healthBarToggle = Instance.new("TextButton")
healthBarToggle.Size = UDim2.new(0, 50, 0, 25)
healthBarToggle.Position = UDim2.new(1, -50, 0, 12)
healthBarToggle.Text = ""
healthBarToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
healthBarToggle.Parent = healthBarToggleContainer

local healthBarKnob = Instance.new("Frame")
healthBarKnob.Size = UDim2.new(0, 21, 1, -4)
healthBarKnob.Position = UDim2.new(0, 2, 0, 2)
healthBarKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
healthBarKnob.Parent = healthBarToggle

local healthBarToggleCorner = Instance.new("UICorner")
healthBarToggleCorner.CornerRadius = UDim.new(1, 0)
healthBarToggleCorner.Parent = healthBarToggle

local healthBarKnobCorner = Instance.new("UICorner")
healthBarKnobCorner.CornerRadius = UDim.new(1, 0)
healthBarKnobCorner.Parent = healthBarKnob

-- Visual Instructions
local visualInstructions = Instance.new("TextLabel")
visualInstructions.Size = UDim2.new(1, 0, 0, 40)
visualInstructions.Position = UDim2.new(0, 0, 0, 300)
visualInstructions.BackgroundTransparency = 1
visualInstructions.Text = "Tracer: Line from top of screen\nHealth Bar: Thin bar above head\nTeam Check applies to all ESP"
visualInstructions.TextColor3 = Color3.fromRGB(150, 150, 150)
visualInstructions.TextSize = 10
visualInstructions.Font = Enum.Font.Gotham
visualInstructions.TextWrapped = true
visualInstructions.Parent = visualFrame

-- HACKS TAB CONTENT
local hacksFrame = contentFrames["HACKS"]

-- Wallhack Toggle
local wallhackToggleContainer = Instance.new("Frame")
wallhackToggleContainer.Size = UDim2.new(1, 0, 0, 50)
wallhackToggleContainer.Position = UDim2.new(0, 0, 0, 0)
wallhackToggleContainer.BackgroundTransparency = 1
wallhackToggleContainer.Parent = hacksFrame

local wallhackStatus = Instance.new("TextLabel")
wallhackStatus.Size = UDim2.new(0.6, 0, 0, 20)
wallhackStatus.Position = UDim2.new(0, 0, 0, 0)
wallhackStatus.BackgroundTransparency = 1
wallhackStatus.Text = "WALLHACK"
wallhackStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
wallhackStatus.TextSize = 14
wallhackStatus.Font = Enum.Font.GothamBold
wallhackStatus.TextXAlignment = Enum.TextXAlignment.Left
wallhackStatus.Parent = wallhackToggleContainer

local wallhackStatusSub = Instance.new("TextLabel")
wallhackStatusSub.Size = UDim2.new(0.6, 0, 0, 15)
wallhackStatusSub.Position = UDim2.new(0, 0, 0, 20)
wallhackStatusSub.BackgroundTransparency = 1
wallhackStatusSub.Text = "OFF"
wallhackStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
wallhackStatusSub.TextSize = 11
wallhackStatusSub.Font = Enum.Font.Gotham
wallhackStatusSub.TextXAlignment = Enum.TextXAlignment.Left
wallhackStatusSub.Parent = wallhackToggleContainer

local wallhackToggle = Instance.new("TextButton")
wallhackToggle.Size = UDim2.new(0, 50, 0, 25)
wallhackToggle.Position = UDim2.new(1, -50, 0, 12)
wallhackToggle.Text = ""
wallhackToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
wallhackToggle.Parent = wallhackToggleContainer

local wallhackKnob = Instance.new("Frame")
wallhackKnob.Size = UDim2.new(0, 21, 1, -4)
wallhackKnob.Position = UDim2.new(0, 2, 0, 2)
wallhackKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
wallhackKnob.Parent = wallhackToggle

local wallhackToggleCorner = Instance.new("UICorner")
wallhackToggleCorner.CornerRadius = UDim.new(1, 0)
wallhackToggleCorner.Parent = wallhackToggle

local wallhackKnobCorner = Instance.new("UICorner")
wallhackKnobCorner.CornerRadius = UDim.new(1, 0)
wallhackKnobCorner.Parent = wallhackKnob

-- Hacks Instructions
local hacksInstructions = Instance.new("TextLabel")
hacksInstructions.Size = UDim2.new(1, 0, 0, 60)
hacksInstructions.Position = UDim2.new(0, 0, 0, 60)
hacksInstructions.BackgroundTransparency = 1
hacksInstructions.Text = "Wallhack: See through walls\nNote: Bullet penetration requires additional setup"
hacksInstructions.TextColor3 = Color3.fromRGB(150, 150, 150)
hacksInstructions.TextSize = 10
hacksInstructions.Font = Enum.Font.Gotham
hacksInstructions.TextWrapped = true
hacksInstructions.Parent = hacksFrame

-- SETTINGS TAB CONTENT
local settingsFrame = contentFrames["SETTINGS"]

-- Unload Button
local unloadButton = Instance.new("TextButton")
unloadButton.Size = UDim2.new(1, 0, 0, 35)
unloadButton.Position = UDim2.new(0, 0, 0, 0)
unloadButton.Text = "UNLOAD SCRIPT (Press 0)"
unloadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
unloadButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
unloadButton.TextSize = 12
unloadButton.Font = Enum.Font.GothamBold
unloadButton.Parent = settingsFrame

local unloadCorner = Instance.new("UICorner")
unloadCorner.CornerRadius = UDim.new(0, 6)
unloadCorner.Parent = unloadButton

-- Settings Instructions
local settingsInstructions = Instance.new("TextLabel")
settingsInstructions.Size = UDim2.new(1, 0, 0, 60)
settingsInstructions.Position = UDim2.new(0, 0, 0, 45)
settingsInstructions.BackgroundTransparency = 1
settingsInstructions.Text = "Press RightShift to toggle menu\nPress 0 to unload script"
settingsInstructions.TextColor3 = Color3.fromRGB(150, 150, 150)
settingsInstructions.TextSize = 10
settingsInstructions.Font = Enum.Font.Gotham
settingsInstructions.TextWrapped = true
settingsInstructions.Parent = settingsFrame

-- FEATURE VARIABLES
local aimbotEnabled = false
local highlightsEnabled = false
local nameESPEnabled = false
local skeletonESPEnabled = false
local tracerESPEnabled = false
local healthBarESPEnabled = false
local wallhackEnabled = false
local teamCheckEnabled = true

local aimPart = "Head"
local smoothness = 0.3
local currentKeybind = Enum.UserInputType.MouseButton2

local currentTarget = nil
local isAimbotKeyDown = false

local activeHighlights = {}
local nameLabels = {}
local skeletonParts = {}
local tracerLines = {}
local healthBars = {}
local connections = {}

-- TEAM CHECK FUNCTION
local function isEnemy(player)
    if not teamCheckEnabled then return true end
    
    -- If game doesn't use teams, treat everyone as enemy
    if not localPlayer.Team then return true end
    if not player.Team then return true end
    
    return localPlayer.Team ~= player.Team
end

-- ESP FUNCTIONS
local function createNameESP(player)
    if player == localPlayer or not isEnemy(player) then return end
    
    local character = player.Character
    if character and nameESPEnabled then
        if nameLabels[player] then
            nameLabels[player]:Destroy()
            nameLabels[player] = nil
        end
        
        local head = character:FindFirstChild("Head")
        if head then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "NameESP"
            billboard.Size = UDim2.new(0, 200, 0, 50)
            billboard.StudsOffset = Vector3.new(0, 3, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = head
            billboard.Parent = head
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = player.Name
            label.TextColor3 = Color3.fromRGB(255, 50, 50)
            label.TextSize = 14
            label.Font = Enum.Font.GothamBold
            label.TextStrokeTransparency = 0
            label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            label.Parent = billboard
            
            nameLabels[player] = billboard
        end
    end
end

local function createHealthBarESP(player)
    if player == localPlayer or not isEnemy(player) then return end
    
    local character = player.Character
    if character and healthBarESPEnabled then
        if healthBars[player] then
            healthBars[player]:Destroy()
            healthBars[player] = nil
        end
        
        local head = character:FindFirstChild("Head")
        local humanoid = character:FindFirstChild("Humanoid")
        if head and humanoid then
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "HealthBarESP"
            billboard.Size = UDim2.new(0, 50, 0, 4)
            billboard.StudsOffset = Vector3.new(0, 2.5, 0)
            billboard.AlwaysOnTop = true
            billboard.Adornee = head
            billboard.Parent = head
            
            local background = Instance.new("Frame")
            background.Size = UDim2.new(1, 0, 1, 0)
            background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            background.BorderSizePixel = 0
            background.Parent = billboard
            
            local healthBar = Instance.new("Frame")
            healthBar.Size = UDim2.new(humanoid.Health / humanoid.MaxHealth, 0, 1, 0)
            healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            healthBar.BorderSizePixel = 0
            healthBar.Parent = background
            
            healthBars[player] = {billboard = billboard, bar = healthBar, humanoid = humanoid}
        end
    end
end

local function updateHealthBarESP()
    for player, healthData in pairs(healthBars) do
        if player.Character and healthBarESPEnabled and healthData.humanoid then
            local healthPercent = healthData.humanoid.Health / healthData.humanoid.MaxHealth
            healthData.bar.Size = UDim2.new(healthPercent, 0, 1, 0)
            
            -- Change color based on health
            if healthPercent > 0.5 then
                healthData.bar.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- Green
            elseif healthPercent > 0.2 then
                healthData.bar.BackgroundColor3 = Color3.fromRGB(255, 255, 0) -- Yellow
            else
                healthData.bar.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Red
            end
        end
    end
end

local function createSkeletonESP(player)
    if player == localPlayer or not isEnemy(player) then return end
    
    local character = player.Character
    if character and skeletonESPEnabled then
        -- Remove existing skeleton
        if skeletonParts[player] then
            for _, part in pairs(skeletonParts[player]) do
                part:Destroy()
            end
            skeletonParts[player] = nil
        end
        
        skeletonParts[player] = {}
        
        -- Define bone connections for skeleton (improved)
        local boneConnections = {
            {"Head", "UpperTorso"},
            {"UpperTorso", "LowerTorso"},
            {"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
            {"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"},
            {"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
            {"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"}
        }
        
        for _, connection in pairs(boneConnections) do
            local part1 = character:FindFirstChild(connection[1])
            local part2 = character:FindFirstChild(connection[2])
            
            if part1 and part2 then
                local beam = Instance.new("Beam")
                beam.Color = ColorSequence.new(Color3.fromRGB(255, 50, 50)) -- Red skeleton
                beam.Width0 = 0.1
                beam.Width1 = 0.1
                beam.FaceCamera = true
                beam.LightInfluence = 0
                
                local attachment0 = Instance.new("Attachment")
                attachment0.Parent = part1
                attachment0.Position = Vector3.new(0, 0, 0)
                
                local attachment1 = Instance.new("Attachment")
                attachment1.Parent = part2
                attachment1.Position = Vector3.new(0, 0, 0)
                
                beam.Attachment0 = attachment0
                beam.Attachment1 = attachment1
                beam.Parent = character
                
                table.insert(skeletonParts[player], beam)
                table.insert(skeletonParts[player], attachment0)
                table.insert(skeletonParts[player], attachment1)
            end
        end
    end
end

local function createTracerESP(player)
    if player == localPlayer or not isEnemy(player) then return end
    
    local character = player.Character
    if character and tracerESPEnabled then
        if tracerLines[player] then
            tracerLines[player]:Destroy()
            tracerLines[player] = nil
        end
        
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local line = Instance.new("Frame")
            line.Name = "TracerLine"
            line.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
            line.BorderSizePixel = 0
            line.ZIndex = 10
            line.Parent = screenGui
            
            tracerLines[player] = line
        end
    end
end

local function updateTracerESP()
    for player, line in pairs(tracerLines) do
        if player.Character and tracerESPEnabled then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local screenPoint, onScreen = camera:WorldToViewportPoint(root.Position)
                
                if onScreen then
                    line.Visible = true
                    -- Draw line from TOP center to player position
                    local startPos = Vector2.new(camera.ViewportSize.X / 2, 0)
                    local endPos = Vector2.new(screenPoint.X, screenPoint.Y)
                    
                    local distance = (endPos - startPos).Magnitude
                    local angle = math.atan2(endPos.Y - startPos.Y, endPos.X - startPos.X)
                    
                    line.Size = UDim2.new(0, distance, 0, 1)
                    line.Position = UDim2.new(0, startPos.X, 0, startPos.Y)
                    line.Rotation = math.deg(angle)
                else
                    line.Visible = false
                end
            else
                line.Visible = false
            end
        else
            line.Visible = false
        end
    end
end

local function removeNameESP(player)
    if nameLabels[player] then
        nameLabels[player]:Destroy()
        nameLabels[player] = nil
    end
end

local function removeHealthBarESP(player)
    if healthBars[player] then
        healthBars[player].billboard:Destroy()
        healthBars[player] = nil
    end
end

local function removeSkeletonESP(player)
    if skeletonParts[player] then
        for _, part in pairs(skeletonParts[player]) do
            part:Destroy()
        end
        skeletonParts[player] = nil
    end
end

local function removeTracerESP(player)
    if tracerLines[player] then
        tracerLines[player]:Destroy()
        tracerLines[player] = nil
    end
end

local function removeAllESP()
    for player, label in pairs(nameLabels) do
        if label then label:Destroy() end
    end
    for player, healthData in pairs(healthBars) do
        if healthData then healthData.billboard:Destroy() end
    end
    for player, skeleton in pairs(skeletonParts) do
        if skeleton then
            for _, part in pairs(skeleton) do
                part:Destroy()
            end
        end
    end
    for player, line in pairs(tracerLines) do
        if line then line:Destroy() end
    end
    nameLabels = {}
    healthBars = {}
    skeletonParts = {}
    tracerLines = {}
end

-- HIGHLIGHT SYSTEM FUNCTIONS (ENEMY PLAYERS ONLY)
local function highlightPlayer(player)
    if player == localPlayer or not isEnemy(player) then return end
    
    local character = player.Character
    if character and highlightsEnabled then
        if activeHighlights[player] then
            activeHighlights[player]:Destroy()
            activeHighlights[player] = nil
        end
        
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid and humanoid.Health > 0 then
            local highlight = Instance.new("Highlight")
            highlight.Name = "PlayerHighlight"
            highlight.FillColor = Color3.fromRGB(255, 50, 50)
            highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
            highlight.FillTransparency = 0.7
            highlight.OutlineTransparency = 0
            highlight.Parent = character
            
            activeHighlights[player] = highlight
        end
    end
end

local function removeHighlight(player)
    if activeHighlights[player] then
        activeHighlights[player]:Destroy()
        activeHighlights[player] = nil
    end
end

local function removeAllHighlights()
    for player, highlight in pairs(activeHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    activeHighlights = {}
end

local function addESPToAllPlayers()
    for _, player in ipairs(Players:GetPlayers()) do
        highlightPlayer(player)
        createNameESP(player)
        createHealthBarESP(player)
        createSkeletonESP(player)
        createTracerESP(player)
    end
end

-- WALLHACK FUNCTIONS
local function toggleWallhack()
    wallhackEnabled = not wallhackEnabled
    
    if wallhackEnabled then
        wallhackStatusSub.Text = "ON"
        wallhackStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        wallhackToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        wallhackKnob.Position = UDim2.new(1, -23, 0, 2)
        
        -- Make walls transparent (only non-player parts)
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part:FindFirstAncestorOfClass("Model") then
                part.LocalTransparencyModifier = 0.5
            end
        end
    else
        wallhackStatusSub.Text = "OFF"
        wallhackStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        wallhackToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        wallhackKnob.Position = UDim2.new(0, 2, 0, 2)
        
        -- Reset transparency
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

-- TOGGLE FUNCTIONS
local function toggleTeamCheck()
    teamCheckEnabled = not teamCheckEnabled
    
    if teamCheckEnabled then
        teamCheckStatusSub.Text = "ON"
        teamCheckStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        teamCheckToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        teamCheckKnob.Position = UDim2.new(1, -23, 0, 2)
    else
        teamCheckStatusSub.Text = "OFF"
        teamCheckStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        teamCheckToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        teamCheckKnob.Position = UDim2.new(0, 2, 0, 2)
    end
    
    -- Refresh ESP when team check changes
    removeAllHighlights()
    removeAllESP()
    if highlightsEnabled or nameESPEnabled or skeletonESPEnabled or tracerESPEnabled or healthBarESPEnabled then
        addESPToAllPlayers()
    end
end

local function toggleHighlights()
    highlightsEnabled = not highlightsEnabled
    
    if highlightsEnabled then
        highlightStatusSub.Text = "ON"
        highlightStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        highlightToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        highlightKnob.Position = UDim2.new(1, -23, 0, 2)
        addESPToAllPlayers()
    else
        highlightStatusSub.Text = "OFF"
        highlightStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        highlightToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        highlightKnob.Position = UDim2.new(0, 2, 0, 2)
        removeAllHighlights()
    end
end

local function toggleNameESP()
    nameESPEnabled = not nameESPEnabled
    
    if nameESPEnabled then
        nameESPStatusSub.Text = "ON"
        nameESPStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        nameESPToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        nameESPKnob.Position = UDim2.new(1, -23, 0, 2)
        addESPToAllPlayers()
    else
        nameESPStatusSub.Text = "OFF"
        nameESPStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        nameESPToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        nameESPKnob.Position = UDim2.new(0, 2, 0, 2)
        removeAllESP()
        -- Re-add highlights if they're enabled
        if highlightsEnabled then
            addESPToAllPlayers()
        end
    end
end

local function toggleSkeletonESP()
    skeletonESPEnabled = not skeletonESPEnabled
    
    if skeletonESPEnabled then
        skeletonStatusSub.Text = "ON"
        skeletonStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        skeletonToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        skeletonKnob.Position = UDim2.new(1, -23, 0, 2)
        addESPToAllPlayers()
    else
        skeletonStatusSub.Text = "OFF"
        skeletonStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        skeletonToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        skeletonKnob.Position = UDim2.new(0, 2, 0, 2)
        removeAllESP()
        -- Re-add highlights and name ESP if they're enabled
        if highlightsEnabled or nameESPEnabled then
            addESPToAllPlayers()
        end
    end
end

local function toggleTracerESP()
    tracerESPEnabled = not tracerESPEnabled
    
    if tracerESPEnabled then
        tracerStatusSub.Text = "ON"
        tracerStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        tracerToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        tracerKnob.Position = UDim2.new(1, -23, 0, 2)
        addESPToAllPlayers()
    else
        tracerStatusSub.Text = "OFF"
        tracerStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        tracerToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        tracerKnob.Position = UDim2.new(0, 2, 0, 2)
        removeAllESP()
        -- Re-add other ESP if they're enabled
        if highlightsEnabled or nameESPEnabled or skeletonESPEnabled then
            addESPToAllPlayers()
        end
    end
end

local function toggleHealthBarESP()
    healthBarESPEnabled = not healthBarESPEnabled
    
    if healthBarESPEnabled then
        healthBarStatusSub.Text = "ON"
        healthBarStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        healthBarToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        healthBarKnob.Position = UDim2.new(1, -23, 0, 2)
        addESPToAllPlayers()
    else
        healthBarStatusSub.Text = "OFF"
        healthBarStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        healthBarToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        healthBarKnob.Position = UDim2.new(0, 2, 0, 2)
        removeAllESP()
        -- Re-add other ESP if they're enabled
        if highlightsEnabled or nameESPEnabled or skeletonESPEnabled or tracerESPEnabled then
            addESPToAllPlayers()
        end
    end
end

-- AIMBOT SYSTEM FUNCTIONS (ENEMY PLAYERS ONLY)
local function isValidTarget(player)
    if player == localPlayer then return false end
    if not player.Character then return false end
    if teamCheckEnabled and not isEnemy(player) then return false end
    
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return false end
    
    local targetPart = player.Character:FindFirstChild(aimPart)
    if not targetPart then return false end
    
    local distance = (targetPart.Position - camera.CFrame.Position).Magnitude
    if distance > 1000 then return false end
    
    return true
end

local function findBestTarget()
    local bestTarget = nil
    local closestDistance = 1000
    
    for _, player in ipairs(Players:GetPlayers()) do
        if isValidTarget(player) then
            local targetPart = player.Character:FindFirstChild(aimPart)
            if targetPart then
                local distance = (targetPart.Position - camera.CFrame.Position).Magnitude
                if distance < closestDistance then
                    closestDistance = distance
                    bestTarget = player
                end
            end
        end
    end
    
    return bestTarget
end

local function aimAtTarget(target)
    if not target or not target.Character then return end
    
    local targetPart = target.Character:FindFirstChild(aimPart)
    if not targetPart then return end
    
    local targetPosition = targetPart.Position
    local cameraPos = camera.CFrame.Position
    local direction = (targetPosition - cameraPos).Unit
    local currentLook = camera.CFrame.LookVector
    local smoothedDirection = currentLook:Lerp(direction, smoothness)
    local newCFrame = CFrame.lookAt(cameraPos, cameraPos + smoothedDirection)
    
    camera.CFrame = newCFrame
end

local function toggleAimbot()
    aimbotEnabled = not aimbotEnabled
    
    if aimbotEnabled then
        aimbotStatusSub.Text = "ON"
        aimbotStatusSub.TextColor3 = Color3.fromRGB(0, 255, 0)
        aimbotToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        toggleKnob.Position = UDim2.new(1, -23, 0, 2)
    else
        aimbotStatusSub.Text = "OFF"
        aimbotStatusSub.TextColor3 = Color3.fromRGB(255, 50, 50)
        aimbotToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        toggleKnob.Position = UDim2.new(0, 2, 0, 2)
        currentTarget = nil
        isAimbotKeyDown = false
    end
end

-- BUTTON CONNECTIONS
aimbotToggle.MouseButton1Click:Connect(toggleAimbot)
teamCheckToggle.MouseButton1Click:Connect(toggleTeamCheck)
highlightToggle.MouseButton1Click:Connect(toggleHighlights)
nameESPToggle.MouseButton1Click:Connect(toggleNameESP)
skeletonToggle.MouseButton1Click:Connect(toggleSkeletonESP)
tracerToggle.MouseButton1Click:Connect(toggleTracerESP)
healthBarToggle.MouseButton1Click:Connect(toggleHealthBarESP)
wallhackToggle.MouseButton1Click:Connect(toggleWallhack)

aimPartButton.MouseButton1Click:Connect(function()
    if aimPart == "Head" then
        aimPart = "HumanoidRootPart"
    elseif aimPart == "HumanoidRootPart" then
        aimPart = "UpperTorso"
    else
        aimPart = "Head"
    end
    aimPartButton.Text = "Target: " .. aimPart
end)

smoothnessButton.MouseButton1Click:Connect(function()
    if smoothness == 0.1 then
        smoothness = 0.3
    elseif smoothness == 0.3 then
        smoothness = 0.5
    else
        smoothness = 0.1
    end
    smoothnessButton.Text = "Smoothness: " .. smoothness
end)

keybindButton.MouseButton1Click:Connect(function()
    if currentKeybind == Enum.UserInputType.MouseButton2 then
        currentKeybind = Enum.KeyCode.Q
        keybindButton.Text = "Keybind: Q"
    elseif currentKeybind == Enum.KeyCode.Q then
        currentKeybind = Enum.KeyCode.E
        keybindButton.Text = "Keybind: E"
    else
        currentKeybind = Enum.UserInputType.MouseButton2
        keybindButton.Text = "Keybind: Right Mouse"
    end
end)

closeButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

unloadButton.MouseButton1Click:Connect(function()
    removeAllHighlights()
    removeAllESP()
    screenGui:Destroy()
end)

-- KEYBIND INPUT HANDLING
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- Toggle menu with RightShift
    if input.KeyCode == Enum.KeyCode.RightShift then
        mainFrame.Visible = not mainFrame.Visible
    end
    
    -- Unload with 0 key
    if input.KeyCode == Enum.KeyCode.Zero then
        removeAllHighlights()
        removeAllESP()
        screenGui:Destroy()
    end
    
    -- Aimbot keybind
    if input.UserInputType == currentKeybind or input.KeyCode == currentKeybind then
        isAimbotKeyDown = true
        if aimbotEnabled then
            currentTarget = findBestTarget()
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.UserInputType == currentKeybind or input.KeyCode == currentKeybind then
        isAimbotKeyDown = false
        currentTarget = nil
    end
end)

-- MAIN LOOPS
connections.aimloop = RunService.RenderStepped:Connect(fun... (3 kB verbleibend)
