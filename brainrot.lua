-- ERAFOX Global Fix v3.1 (04.08.2025)
getgenv().__EMERGENCY_FIX = true

-- 1. Фикс Attachments
for _, obj in ipairs(workspace:GetDescendants()) do
    if obj:IsA("Attachment") and not obj:IsDescendantOf(game.Players) then
        obj:Destroy()
    end
end

-- 2. Фикс nil-значений
debug.setmetatable(nil, {__index = function() return nil end})

-- 3. Фикс бесконечного ожидания
local function SafeWaitForChild(parent, name, timeout)
    timeout = timeout or 5
    local endTime = os.clock() + timeout
    while os.clock() < endTime do
        local child = parent:FindFirstChild(name)
        if child then return child end
        task.wait(0.1)
    end
    return nil
end

-- 4. Фикс поврежденных инстансов
workspace.DescendantAdded:Connect(function(desc)
    if desc:IsA("Model") and not desc.PrimaryPart then
        desc:Destroy()
    end
end)

-- 5. Фикс интерфейса Delta
if game:GetService("CoreGui"):FindFirstChild("DeltaMobileGUI") then
    game:GetService("CoreGui").DeltaMobileGUI:Destroy()
end

-- Модифицированный основной скрипт
local Player = game.Players.LocalPlayer
local Character = SafeWaitForChild(Player, "Character") or Player.CharacterAdded:Wait()

-- Безопасный Anti Ragdoll
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
        end)
    end
end)

-- NoClip с защитой
local Noclipping = false
game:GetService("RunService").Stepped:Connect(function()
    if Noclipping and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            pcall(function()
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end)
        end
    end
end)

-- SpeedBoost с проверками
pcall(function()
    if Character and Character.Humanoid then
        Character.Humanoid.WalkSpeed = 70
    end
end)
