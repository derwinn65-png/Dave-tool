-- MM2 GHOSTFACE | Panel Pro Definitivo (Delta)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Evitar duplicados
if CoreGui:FindFirstChild("MM2GhostfacePro") then
    CoreGui.MM2GhostfacePro:Destroy()
end

-- 1. Interfaz Gráfica (GUI)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2GhostfacePro"
ScreenGui.Parent = CoreGui

-- Botón Flotante (MG)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ToggleButton.BorderColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.Text = "MG"
ToggleButton.TextColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextSize = 16
ToggleButton.Active = true
ToggleButton.Draggable = true

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleButton

-- Menú Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -270)
MainFrame.Size = UDim2.new(0, 280, 0, 580)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 8)
MainCorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 6)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "MM2 GHOSTFACE | Pro"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.TextSize = 15

ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- 2. ESP de Roles Avanzado (Highlight + BillboardGui con Nombre, Rol y Distancia)
local espEnabled = false
RunService.RenderStepped:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
AntiFlingButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
AntiFlingButton.Position = UDim2.new(0.1, 0, 0.635, 0)
AntiFlingButton.Size = UDim2.new(0, 224, 0, 24)
AntiFlingButton.Font = Enum.Font.GothamSemibold
AntiFlingButton.Text = "Anti Scripts (Anti-Fling): [OFF]"
AntiFlingButton.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiFlingButton.TextSize = 11
local afCorner = Instance.new("UICorner"); afCorner.CornerRadius = UDim.new(0, 6); afCorner.Parent = AntiFlingButton

AntiFlingButton.MouseButton1Click:Connect(function()
    antiFlingActive = not antiFlingActive
    AntiFlingButton.Text = antiFlingActive and "Anti Scripts (Anti-Fling): [ON]" or "Anti Scripts (Anti-Fling): [OFF]"
    AntiFlingButton.BackgroundColor3 = antiFlingActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.Stepped:Connect(function()
    if antiFlingActive then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
                    hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end
end)

-- 12. Aimbot de Roles
local aimbotEnabled = false
local aimbotButton = Instance.new("TextButton")
aimbotButton.Parent = MainFrame
aimbotButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
aimbotButton.Position = UDim2.new(0.1, 0, 0.695, 0)
aimbotButton.Size = UDim2.new(0, 224, 0, 24)
aimbotButton.Font = Enum.Font.GothamSemibold
aimbotButton.Text = "Aimbot Roles: [OFF]"
aimbotButton.TextColor3 = Color3.fromRGB(255, 255, 255)
aimbotButton.TextSize = 11
local aCorner = Instance.new("UICorner"); aCorner.CornerRadius = UDim.new(0, 6); aCorner.Parent = aimbotButton

aimbotButton.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotButton.Text = aimbotEnabled and "Aimbot Roles: [ON]" or "Aimbot Roles: [OFF]"
    aimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        pcall(function()
            local targetPart = nil
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    local backpack = player:FindFirstChild("Backpack")
                    local hasKnife = player.Character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
                    local hasGun = player.Character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))
                    if hasKnife or hasGun then
                        targetPart = player.Character.HumanoidRootPart
                        break
                    end
                end
            end
            if targetPart then
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            end
        end)
    end
end)

-- 13. Matar al Sheriff / Asesino
local killSheriffActive = false
local KsButton = Instance.new("TextButton")
KsButton.Parent = MainFrame
KsButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
KsButton.Position = UDim2.new(0.1, 0, 0.755, 0)
KsButton.Size = UDim2.new(0, 224, 0, 24)
KsButton.Font = Enum.Font.GothamSemibold
KsButton.Text = "Matar Sheriff/Asesino: [OFF]"
KsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KsButton.TextSize = 11
local ksCorner = Instance.new("UICorner"); ksCorner.CornerRadius = UDim.new(0, 6); ksCorner.Parent = KsButton

KsButton.MouseButton1Click:Connect(function()
    killSheriffActive = not killSheriffActive
    KsButton.Text = killSheriffActive and "Matar Sheriff/Asesino: [ON]" or "Matar Sheriff/Asesino: [OFF]"
    KsButton.BackgroundColor3 = killSheriffActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if killSheriffActive then
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = player.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            local backpack = player:FindFirstChild("Backpack")
                            local hasKnife = player.Character:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
                            local hasGun = player.Character:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))
                            if hasKnife or hasGun then
                                hrp.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2.5)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- 14. Kill All (Asesino)
local killAllActive = false
local KaButton = Instance.new("TextButton")
KaButton.Parent = MainFrame
KaButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
KaButton.Position = UDim2.new(0.1, 0, 0.815, 0)
KaButton.Size = UDim2.new(0, 224, 0, 24)
KaButton.Font = Enum.Font.GothamSemibold
KaButton.Text = "Kill All (Asesino): [OFF]"
KaButton.TextColor3 = Color3.fromRGB(255, 255, 255)
KaButton.TextSize = 11
local kaCorner = Instance.new("UICorner"); kaCorner.CornerRadius = UDim.new(0, 6); kaCorner.Parent = KaButton

KaButton.MouseButton1Click:Connect(function()
    killAllActive = not killAllActive
    KaButton.Text = killAllActive and "Kill All (Asesino): [ON]" or "Kill All (Asesino): [OFF]"
    KaButton.BackgroundColor3 = killAllActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if killAllActive then
        pcall(function()
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local knife = char:FindFirstChild("Knife") or LocalPlayer.Backpack:FindFirstChild("Knife")
            if knife and hrp then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hum = player.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            hrp.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.5)
                            task.wait(0.06)
                        end
                    end
                end
            end
        end)
    end
end)

-- 15. Skins Visuales
local skinsActive = false
local skinButton = Instance.new("TextButton")
skinButton.Parent = MainFrame
skinButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
skinButton.Position = UDim2.new(0.1, 0, 0.875, 0)
skinButton.Size = UDim2.new(0, 224, 0, 24)
skinButton.Font = Enum.Font.GothamSemibold
skinButton.Text = "Skins Visuales: [OFF]"
skinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
skinButton.TextSize = 11
local sCorner = Instance.new("UICorner"); sCorner.CornerRadius = UDim.new(0, 6); sCorner.Parent = skinButton
skinButton.MouseButton1Click:Connect(function`()
    skinsActive = not skinsActive
    skinButton.Text = skinsActive and "Skins Visuales: [ON]" or "Skins Visuales: [OFF]"
    skinButton.BackgroundColor3 = skinsActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if skinsActive then
        pcall(function()
            local char = LocalPlayer.Character
            local backpack = LocalPlayer.Backpack
            for _, item in ipairs(char:GetChildren()) do
                if item:IsA("Tool") then
                    for _, part in ipairs(item:GetDescendants()) do
                        if part:IsA("BasePart") then part.Color = Color3.fromRGB(255, 0, 128) end
                    end
                end
            end
            for _, item in ipairs(backpack:GetChildren()) do
                if item:IsA("Tool") then
                    for _, part in ipairs(item:GetDescendants()) do
                        if part:IsA("BasePart") then part.Color = Color3.fromRGB(255, 0, 128) end
                    end
                end
            end
        end)
    end
end)

LocalPlayer.OnTeleport:Connect(function()
    ScreenGui:Destroy()
end)
