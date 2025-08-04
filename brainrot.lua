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
 
-- erafox/StealABrainrot-Rayfield v1.5 (04.08.2025)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Создание мобильно-оптимизированного окна
local Window = Rayfield:CreateWindow({
   Name = "Brainrot Toolkit",
   LoadingTitle = "EraFox Mobile Suite",
   LoadingSubtitle = "by jaleyBreak systems",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false,
   MobileCompatible = true
})

-- NoClip функция
local NoclipActive = false
local NoclipToggle = Window:CreateToggle({
   Name = "Режим NoClip",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
       NoclipActive = Value
       if Player.Character then
           for _, part in ipairs(Player.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                   part.CanCollide = not Value
               end
           end
       end
   end,
})

-- SpeedBoost функция
local SpeedValue = 3.0
local SpeedActive = false

Window:CreateSlider({
   Name = "Множитель скорости",
   Range = {1.0, 5.0},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = SpeedValue,
   Flag = "SpeedSlider",
   Callback = function(Value)
       SpeedValue = Value
   end,
})

local SpeedToggle = Window:CreateToggle({
   Name = "Активировать SpeedBoost",
   CurrentValue = false,
   Flag = "SpeedToggle",
   Callback = function(Value)
       SpeedActive = Value
   end,
})

-- AntiRagdoll функция
local AntiRagdollActive = true
local AntiRagdollToggle = Window:CreateToggle({
   Name = "Система Anti-Ragdoll",
   CurrentValue = true,
   Flag = "AntiRagdollToggle",
   Callback = function(Value)
       AntiRagdollActive = Value
   end,
})

-- Мобильная оптимизация
Window:CreateSection("Настройки для телефона")
Window:CreateButton({
   Name = "Активировать сенсорное управление",
   Callback = function()
       Rayfield:SetMobile(true)
       Rayfield:SetMobilePlatform(Enum.TouchMovementMode.DynamicThumbstick)
       Rayfield:Notify({
           Title = "Сенсорный режим",
           Content = "Свайп вниз тремя пальцами для меню",
           Duration = 5,
           Image = 13047715178
       })
   end
})

-- Основной цикл
RunService.Heartbeat:Connect(function()
    -- NoClip поддержка
    if NoclipActive and Player.Character then
        for _, part in ipairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    
    -- SpeedBoost поддержка
    if SpeedActive and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 16 * SpeedValue
    elseif Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 16
    end
    
    -- AntiRagdoll поддержка
    if AntiRagdollActive then
        for _, child in ipairs(workspace:GetChildren()) do
            if child.Name == "Ragdoll" and child:IsA("Model") and child:FindFirstChild("Humanoid") then
                child:BreakJoints()
                task.wait(0.1)
                child:Destroy()
            end
        end
    end
    
    -- Авто-оптимизация для мобильных
    if Rayfield:GetMobile() then
        Rayfield:SetConfiguration({
            MobileTransparency = 0.85,
            MobileButtonSize = UDim2.new(0.28, 0, 0.065, 0),
            MobileTextSize = 20
        })
    end
end)

-- Защита от обнаружения
Window:CreateSection("Безопасность")
Window:CreateButton({
   Name = "Скрыть интерфейс",
   Callback = function()
       Rayfield:SetConfiguration({
           OverrideTheme = {
               Background = Color3.fromRGB(0, 0, 0, 0),
               Glow = Color3.fromRGB(0, 0, 0, 0),
               Accent = Color3.fromRGB(0, 0, 0, 0)
           },
           Transparency = 1
       })
   end
})

-- Экстренное отключение
Window:CreateButton({
   Name = "ЭКСТРЕННОЕ ОТКЛЮЧЕНИЕ",
   Callback = function()
       Rayfield:Destroy()
       NoclipActive = false
       SpeedActive = false
       if Player.Character and Player.Character:FindFirstChild("Humanoid") then
           Player.Character.Humanoid.WalkSpeed = 16
       end
   end
})

-- Загрузка защиты
loadstring(game:HttpGet("https://sirius.menu/security"))()
