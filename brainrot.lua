local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- Переменные состояния
local noclip = false
local speed = false
local walkspeedMultiplier = 2.5

-- Создаем интерфейс
local gui = Instance.new("ScreenGui")
gui.Name = "MobileHubUI"
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

-- Функция создания кнопки
local function createButton(text, position, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.3, 0, 0.06, 0)
    button.Position = position
    button.Text = text
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Parent = gui

    button.MouseButton1Click:Connect(callback)
    return button
end

-- NoClip
createButton("NoClip", UDim2.new(0.05, 0, 0.85, 0), function()
    noclip = not noclip
end)

RunService.Stepped:Connect(function()
    if noclip and Player.Character then
        for _, part in pairs(Player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- Speed Boost
createButton("Speed", UDim2.new(0.37, 0, 0.85, 0), function()
    speed = not speed
end)

RunService.Heartbeat:Connect(function()
    if speed and Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 16 * walkspeedMultiplier
    elseif Player.Character and Player.Character:FindFirstChild("Humanoid") then
        Player.Character.Humanoid.WalkSpeed = 16
    end
end)

-- Anti-Ragdoll
local function removeRagdoll()
    local char = Player.Character
    if not char then return end

    for _, obj in pairs(char:GetDescendants()) do
        if obj:IsA("BallSocketConstraint") or obj:IsA("HingeConstraint") or obj.Name:lower():find("ragdoll") then
            obj:Destroy()
        end
    end
end

createButton("AntiRagdoll", UDim2.new(0.69, 0, 0.85, 0), function()
    removeRagdoll()
    print("Ragdoll удалён")
end)

-- Автоматически удалять ragdoll после возрождения
Player.CharacterAdded:Connect(function(char)
    wait(1)
    removeRagdoll()
end)
