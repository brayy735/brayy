-- erafox/StealABrainrot-MobileOptimized v1.2 (04.08.2025)
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local player = game.Players.LocalPlayer

-- Анти-детект функция
local function sanitize()
    getfenv().script = nil
    debug.setupvalue = function() end
end

-- NoClip (режим приседания)
local noclipActive = false
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.LeftControl then
        noclipActive = not noclipActive
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not noclipActive
                end
            end
        end
    end
end)

-- SpeedBoost (x2.5)
local speedMultiplier = 2.5
RS.Heartbeat:Connect(function()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = (UIS:IsKeyDown(Enum.KeyCode.Space) and 32 * speedMultiplier or 16
    end
end)

-- AntiRagdoll
workspace.ChildAdded:Connect(function(child)
    if child.Name == "Ragdoll" and child:IsA("Model") then
        task.wait(0.15)
        child:BreakJoints()
        task.wait(0.7)
        child:Destroy()
    end
end)

-- erafox/StealABrainrot-GUI v1.3 (04.08.2025)
loadstring(game:HttpGet("https://raw.githubusercontent.com/shlxware/Rayfield/main/source"))()

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

-- Создание адаптивного интерфейса
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function createButton(name, position)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(0.25, 0, 0.08, 0)
    Button.Position = position
    Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Button.BorderSizePixel = 0
    Button.TextScaled = true
    Button.Font = Enum.Font.GothamBold
    Button.TextColor3 = Color3.new(1, 1, 1)
    Button.Text = name
    Button.Parent = ScreenGui
    
    -- Тактильная обратная связь
    Button.MouseButton1Click:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
        task.wait(0.2)
        Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    end)
    
    return Button
end

-- Позиции кнопок для мобильных устройств
local noclipBtn = createButton("NOFLY", UDim2.new(0.1, 0, 0.8, 0))
local speedBtn = createButton("SPEEDx3", UDim2.new(0.4, 0, 0.8, 0))
local antiragBtn = createButton("NO-RAG", UDim2.new(0.7, 0, 0.8, 0))

-- Состояния функций
local noclipActive = false
local speedActive = false
local antiragActive = true

-- NoClip система
noclipBtn.MouseButton1Click:Connect(function()
    noclipActive = not noclipActive
    noclipBtn.Text = noclipActive and "NOFLY ON" or "NOFLY OFF"
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipActive
            end
        end
    end
end)

-- SpeedBoost система
speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    speedBtn.Text = speedActive and "SPEEDx3 ON" or "SPEEDx3 OFF"
    RS.Heartbeat:Connect(function()
        if speedActive and player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 48
        else
            player.Character.Humanoid.WalkSpeed = 16
        end
    end)
end)

-- AntiRagdoll система
antiragBtn.MouseButton1Click:Connect(function()
    antiragActive = not antiragActive
    antiragBtn.Text = antiragActive and "NO-RAG ON" or "NO-RAG OFF"
    workspace.ChildAdded:Connect(function(child)
        if antiragActive and child.Name == "Ragdoll" and child:IsA("Model") then
            task.wait(0.1)
            child:BreakJoints()
            child:Destroy()
        end
    end)
end)

-- Оптимизация для мобильных устройств
UIS.WindowFocusReleased:Connect(function()
    ScreenGui.Enabled = false
end)
UIS.WindowFocused:Connect(function()
    ScreenGui.Enabled = true
end)
