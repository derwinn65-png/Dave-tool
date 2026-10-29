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
            local head = char:FindFirstChild("Head")
            
            local highlight = char:FindFirstChild("GhostfaceHighlight")
            local billboard = char:FindFirstChild("GhostfaceBillboard")
            
            if espEnabled and hrp and head then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "GhostfaceHighlight"
                    highlight.Parent = char
                    highlight.Adornee = char
                    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlight.FillTransparency = 0.4
                end
                
                if not billboard then
                    billboard = Instance.new("BillboardGui")
                    billboard.Name = "GhostfaceBillboard"
                    billboard.Parent = char
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
                    billboard.AlwaysOnTop = true
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Name = "InfoText"
                    textLabel.Parent = billboard
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Font = Enum.Font.GothamBold
                    textLabel.TextSize = 13
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextStrokeTransparency = 0
                end
                
                local backpack = player:FindFirstChild("Backpack")
                local hasKnife = char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
                local hasGun = char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))
                
                local roleName = "Inocente"
                local roleColor = Color3.fromRGB(0, 255, 0)
                
                if hasKnife then
                    roleName = "Asesino"
                    roleColor = Color3.fromRGB(255, 0, 0)
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                elseif hasGun then
                    roleName = "Sheriff"
                    roleColor = Color3.fromRGB(0, 120, 255)
                    highlight.FillColor = Color3.fromRGB(0, 120, 255)
                else
                    highlight.FillColor = Color3.fromRGB(0, 255, 0)
                end
                
                local dist = 0
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                end
                
                local infoText = billboard:FindFirstChild("InfoText")
                if infoText then
                    infoText.Text = string.format("%s\n[%s] - %dm", player.Name, roleName, dist)
                    infoText.TextColor3 = roleColor
                end
            else
                if highlight then highlight:Destroy() end
                if billboard then billboard:Destroy() end
            end
        end
    end
end)

local EspButton = Instance.new("TextButton")
EspButton.Parent = MainFrame
EspButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
EspButton.Position = UDim2.new(0.1, 0, 0.07, 0)
EspButton.Size = UDim2.new(0, 224, 0, 24)
EspButton.Font = Enum.Font.GothamSemibold
EspButton.Text = "ESP Roles: [OFF]"
EspButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EspButton.TextSize = 11
local eCorner = Instance.new("UICorner"); eCorner.CornerRadius = UDim.new(0, 6); eCorner.Parent = EspButton
EspButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    EspButton.Text = espEnabled and "ESP Roles: [ON]" or "ESP Roles: [OFF]"
    EspButton.BackgroundColor3 = espEnabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

-- 3. Auto-Agarrar Pistola Reparado
local gunGrabberEnabled = false
local GunButton = Instance.new("TextButton")
GunButton.Parent = MainFrame
GunButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
GunButton.Position = UDim2.new(0.1, 0, 0.125, 0)
GunButton.Size = UDim2.new(0, 224, 0, 24)
GunButton.Font = Enum.Font.GothamSemibold
GunButton.Text = "Auto-Agarrar Pistola: [OFF]"
GunButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GunButton.TextSize = 11
local gCorner = Instance.new("UICorner"); gCorner.CornerRadius = UDim.new(0, 6); gCorner.Parent = GunButton

GunButton.MouseButton1Click:Connect(function()
    gunGrabberEnabled = not gunGrabberEnabled
    GunButton.Text = gunGrabberEnabled and "Auto-Agarrar Pistola: [ON]" or "Auto-Agarrar Pistola: [OFF]"
    GunButton.BackgroundColor3 = gunGrabberEnabled and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if gunGrabberEnabled then
        pcall(function()
            for _, obj in ipairs(Workspace:GetChildren()) do
                if obj.Name == "GunDrop" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
                end
            end
        end)
    end
end)

-- 4. Speed (Velocidad)
local speedActive = false
local SpeedButton = Instance.new("TextButton")
SpeedButton.Parent = MainFrame
SpeedButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
SpeedButton.Position = UDim2.new(0.1, 0, 0.18, 0)
SpeedButton.Size = UDim2.new(0, 224, 0, 24)
SpeedButton.Font = Enum.Font.GothamSemibold
SpeedButton.Text = "Speed (25): [OFF]"
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.TextSize = 11
local spCorner = Instance.new("UICorner"); spCorner.CornerRadius = UDim.new(0, 6); spCorner.Parent = SpeedButton

SpeedButton.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    SpeedButton.Text = speedActive and "Speed (25): [ON]" or "Speed (25): [OFF]"
    SpeedButton.BackgroundColor3 = speedActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        if speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 25
        elseif not speedActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
        end
    end)
end)

-- 5. Fly (Vuelo)
local flyActive = false
local FlyButton = Instance.new("TextButton")
FlyButton.Parent = MainFrame
FlyButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
FlyButton.Position = UDim2.new(0.1, 0, 0.235, 0)
FlyButton.Size = UDim2.new(0, 224, 0, 24)
FlyButton.Font = Enum.Font.GothamSemibold
FlyButton.Text = "Fly (Vuelo): [OFF]"
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.TextSize = 11
local fCorner = Instance.new("UICorner"); fCorner.CornerRadius = UDim.new(0, 6); fCorner.Parent = FlyButton

FlyButton.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    FlyButton.Text = flyActive and "Fly (Vuelo): [ON]" or "Fly (Vuelo): [OFF]"
    FlyButton.BackgroundColor3 = flyActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if flyActive then
        pcall(function()
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.Velocity = Vector3.new(0, 1, 0)
            end
        end)
    end
end)

-- 6. X-Ray (Ver a través de paredes)
local xrayActive = false
local XrayButton = Instance.new("TextButton")
XrayButton.Parent = MainFrame
XrayButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
XrayButton.Position = UDim2.new(0.1, 0, 0.29, 0)
XrayButton.Size = UDim2.new(0, 224, 0, 24)
XrayButton.Font = Enum.Font.GothamSemibold
XrayButton.Text = "X-Ray: [OFF]"
XrayButton.TextColor3 = Color3.fromRGB(255, 255, 255)
XrayButton.TextSize = 11
local xrCorner = Instance.new("UICorner"); xrCorner.CornerRadius = UDim.new(0, 6); xrCorner.Parent = XrayButton

XrayButton.MouseButton1Click:Connect(function()
    xrayActive = not xrayActive
    XrayButton.Text = xrayActive and "X-Ray: [ON]" or "X-Ray: [OFF]"
    XrayButton.BackgroundColor3 = xrayActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part:IsDescendantOf(LocalPlayer.Character) then
            part.Transparency = xrayActive and 0.5 or 0
        end
    end
end)

-- 7. Invisibilidad
local invisActive = false
local InvisButton = Instance.new("TextButton")
InvisButton.Parent = MainFrame
InvisButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
InvisButton.Position = UDim2.new(0.1, 0, 0.345, 0)
InvisButton.Size = UDim2.new(0, 224, 0, 24)
InvisButton.Font = Enum.Font.GothamSemibold
InvisButton.Text = "Invisibilidad: [OFF]"
InvisButton.TextColor3 = Color3.fromRGB(255, 255, 255)
InvisButton.TextSize = 11
local invCorner = Instance.new("UICorner"); invCorner.CornerRadius = UDim.new(0, 6); invCorner.Parent = InvisButton

InvisButton.MouseButton1Click:Connect(function()
    invisActive = not invisActive
    InvisButton.Text = invisActive and "Invisibilidad: [ON]" or "Invisibilidad: [OFF]"
    InvisButton.BackgroundColor3 = invisActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
    pcall(function()
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                part.Transparency = invisActive and 1 or 0
            end
        end
    end)
end)

-- 8. Hitbox Extender (Agrandar cabezas/cuerpos)
local hitboxActive = false
local HitboxButton = Instance.new("TextButton")
HitboxButton.Parent = MainFrame
HitboxButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
HitboxButton.Position = UDim2.new(0.1, 0, 0.40, 0)
HitboxButton.Size = UDim2.new(0, 224, 0, 24)
HitboxButton.Font = Enum.Font.GothamSemibold
HitboxButton.Text = "Hitbox Grande: [OFF]"
HitboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxButton.TextSize = 11
local hbCorner = Instance.new("UICorner"); hbCorner.CornerRadius = UDim.new(0, 6); hbCorner.Parent = HitboxButton

HitboxButton.MouseButton1Click:Connect(function()
    hitboxActive = not hitboxActive
    HitboxButton.Text = hitboxActive and "Hitbox Grande: [ON]" or "Hitbox Grande: [OFF]"
    HitboxButton.BackgroundColor3 = hitboxActive and Color3.fromRGB(180, 0, 0) or Color3.fromRGB(45, 45, 55)
end)

RunService.RenderStepped:Connect(function()
    if hitboxActive then
        pcall(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    player.Character.HumanoidRootPart.Size = Vector3.new(5, 5, 5)
                    player.Character.HumanoidRootPart.Transparency = 0.7
                    player.Character.HumanoidRootPart.CanCollide = false
                end
            end
        end)
    end
end)

-- 9. Sección Fling (Sacar volando al Asesino Rojo y Sheriff Azul)
local flingAssassin = false
local FlingRedBtn = Instance.new("TextButton")
FlingRedBtn.Parent = MainFrame
FlingRedBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
FlingRedBtn.Position = UDim2.new(0.1, 0, 0.46, 0)
FlingRedBtn.Size = UDim2.new(0, 224, 0, 24)
FlingRedBtn.Font = Enum.Font.GothamSemibold
FlingRedBtn.Text = "Fling Asesino (Rojo): [OFF]"
FlingRedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingRedBtn.TextSize = 11
local frCorner = Instance.new("UICorner"); frCorner.CornerRadius = UDim.new(0, 6); frCorner.Parent = FlingRedBtn

FlingRedBtn.MouseButton1Click:Connect(function()
    flingAssassin = not flingAssassin
    FlingRedBtn.Text = flingAssassin and "Fling Asesino (Rojo): [ON]" or "Fling Asesino (Rojo): [OFF]"
end)

local flingSheriff = false
local FlingBlueBtn = Instance.new("TextButton")
FlingBlueBtn.Parent = MainFrame
FlingBlueBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 150)
FlingBlueBtn.Position = UDim2.new(0.1, 0, 0.515, 0)
FlingBlueBtn.Size = UDim2.new(0, 224, 0, 24)
FlingBlueBtn.Font = Enum.Font.GothamSemibold
FlingBlueBtn.Text = "Fling Sheriff (Azul): [OFF]"
FlingBlueBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlingBlueBtn.TextSize = 11
local fbCorner = Instance.new("UICorner"); fbCorner.CornerRadius = UDim.new(0, 6); fbCorner.Parent = FlingBlueBtn

FlingBlueBtn.MouseButton1Click:Connect(function()
    flingSheriff = not flingSheriff
    FlingBlueBtn.Text = flingSheriff and "Fling Sheriff (Azul): [ON]" or "Fling Sheriff (Azul): [OFF]"
end)

RunService.Stepped:Connect(function()
    pcall(function()
        local myHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not myHrp then return end
        
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local char = player.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local backpack = player:FindFirstChild("Backpack")
                local hasKnife = char:FindFirstChild("Knife") or (backpack and backpack:FindFirstChild("Knife"))
                local hasGun = char:FindFirstChild("Gun") or (backpack and backpack:FindFirstChild("Gun"))
                
                if hrp then
                    if flingAssassin and hasKnife then
                        myHrp.CFrame = hrp.CFrame
                        myHrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
                    elseif flingSheriff and hasGun then
                        myHrp.CFrame = hrp.CFrame
                        myHrp.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
                    end
                end
            end
        end
    end)
end)

-- 10. Sección de Cambiar Miras (Crosshairs)
local currentCrosshair = nil
local CrosshairSelector = Instance.new("TextButton")
CrosshairSelector.Parent = MainFrame
CrosshairSelector.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
CrosshairSelector.Position = UDim2.new(0.1, 0, 0.575, 0)
CrosshairSelector.Size = UDim2.new(0, 224, 0, 24)
CrosshairSelector.Font = Enum.Font.GothamSemibold
CrosshairSelector.Text = "Mire: [Punto Rojo]"
CrosshairSelector.TextColor3 = Color3.fromRGB(255, 255, 255)
CrosshairSelector.TextSize = 11
local csCorner = Instance.new("UICorner"); csCorner.CornerRadius = UDim.new(0, 6); csCorner.Parent = CrosshairSelector

local crossMode = 1
CrosshairSelector.MouseButton1Click:Connect(function()
    crossMode = crossMode + 1
    if crossMode > 3 then crossMode = 1 end
    
    if currentCrosshair then currentCrosshair:Destroy() end
    
    if crossMode == 1 then
        CrosshairSelector.Text = "Mire: [Punto Rojo]"
        currentCrosshair = Instance.new("Frame")
        currentCrosshair.Size = UDim2.new(0, 6, 0, 6)
        currentCrosshair.AnchorPoint = Vector2.new(0.5, 0.5)
        currentCrosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
        currentCrosshair.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        currentCrosshair.Parent = ScreenGui
    elseif crossMode == 2 then
        CrosshairSelector.Text = "Mire: [Cruz Verde]"
        currentCrosshair = Instance.new("Frame")
        currentCrosshair.Size = UDim2.new(0, 16, 0, 4)
        currentCrosshair.AnchorPoint = Vector2.new(0.5, 0.5)
        currentCrosshair.Position = UDim2.new(0.5, 0, 0.5, 0)
        currentCrosshair.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        currentCrosshair.Parent = ScreenGui
    elseif crossMode == 3 then
        CrosshairSelector.Text = "Mire: [OFF]"
        currentCrosshair = nil
    end
end)

-- 11. Anti Aimbot / Anti-Fling Externo
local antiFlingActive = false
local AntiFlingButton = Instance.new("TextButton")
AntiFlingButton.Parent = MainFrame
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
