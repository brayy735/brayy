-- Загрузка Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Основной интерфейс
local Window = Rayfield:CreateWindow({
    Name = "Sigma Hub",
    Icon = 0,
    LoadingTitle = "Загрузка интерфейса...",
    LoadingSubtitle = "Пожалуйста подождите",
    Theme = "Default",
    ToggleUIKeybind = "K",
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
    ConfigurationSaving = {
        Enabled = false,
    },
    Discord = {
        Enabled = false,
    },
    KeySystem = false
})

-- Главная вкладка
local MainTab = Window:CreateTab("Главная", 4483362458)

-- Кнопка
MainTab:CreateButton({
    Name = "Тестовая кнопка",
    Callback = function()
        print("Кнопка работает!")
        Rayfield:Notify({
            Title = "Успех",
            Content = "Функция выполнена",
            Duration = 3,
            Image = 0
        })
    end,
})

-- NoClip
local noclipActive = false
MainTab:CreateToggle({
    Name = "NoClip режим",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        noclipActive = Value
        if Value then
            RunService.Stepped:Connect(function()
                if Player.Character then
                    for _, part in ipairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
    end
})

-- Speed Boost
local speedActive = false
local speedValue = 3.0

MainTab:CreateSlider({
    Name = "Множитель скорости",
    Range = {1.0, 5.0},
    Increment = 0.1,
    Suffix = "x",
    CurrentValue = speedValue,
    Flag = "SpeedSlider",
    Callback = function(Value)
        speedValue = Value
    end
})

MainTab:CreateToggle({
    Name = "Активировать ускорение",
    CurrentValue = false,
    Flag = "SpeedToggle",
    Callback = function(Value)
        speedActive = Value
        if Player.Character and Player.Character:FindFirstChild("Humanoid") then
            Player.Character.Humanoid.WalkSpeed = Value and (16 * speedValue) or 16
        end
    end
})

-- Фикс для кнопок
local function ensureButtonsVisible()
    -- Принудительное создание кнопок
    if not MainTab:FindFirstChild("ButtonHolder") then
        local buttonContainer = Instance.new("Frame")
        buttonContainer.Name = "ButtonHolder"
        buttonContainer.Size = UDim2.new(1, 0, 1, 0)
        buttonContainer.BackgroundTransparency = 1
        buttonContainer.Parent = MainTab.Content
        
        -- Создаем основные кнопки
        local buttonNames = {"NoClip", "Speed", "Functions"}
        for i, name in ipairs(buttonNames) do
            local btn = Instance.new("TextButton")
            btn.Name = name
            btn.Size = UDim2.new(0.9, 0, 0.15, 0)
            btn.Position = UDim2.new(0.05, 0, 0.1 + (i-1)*0.2, 0)
            btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            btn.Text = name
            btn.TextColor3 = Color3.new(1, 1, 1)
            btn.TextSize = 14
            btn.Font = Enum.Font.GothamBold
            btn.Parent = buttonContainer
            
            -- Привязываем функционал
            if name == "NoClip" then
                btn.MouseButton1Click:Connect(function()
                    noclipActive = not noclipActive
                    Window.Flags["NoclipToggle"]:Set(noclipActive)
                end)
            elseif name == "Speed" then
                btn.MouseButton1Click:Connect(function()
                    speedActive = not speedActive
                    Window.Flags["SpeedToggle"]:Set(speedActive)
                end)
            end
        end
    end
    
    -- Принудительное отображение интерфейса
    if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
        game:GetService("CoreGui").Rayfield.Enabled = true
        for _, element in ipairs(game:GetService("CoreGui").Rayfield:GetDescendants()) do
            if element:IsA("GuiObject") then
                element.Visible = true
                element.Active = true
            end
        end
    end
end

-- Мобильный фикс
if game:GetService("UserInputService").TouchEnabled then
    Rayfield:SetMobile(true)
    
    -- Физическая кнопка активации
    local activationButton = Instance.new("TextButton")
    activationButton.Name = "ActivationButton"
    activationButton.Size = UDim2.new(0.4, 0, 0.08, 0)
    activationButton.Position = UDim2.new(0.3, 0, 0.9, 0)
    activationButton.BackgroundColor3 = Color3.fromRGB(30, 215, 96)
    activationButton.Text = "ОТКРЫТЬ МЕНЮ"
    activationButton.TextColor3 = Color3.new(0, 0, 0)
    activationButton.TextSize = 16
    activationButton.Font = Enum.Font.GothamBold
    activationButton.ZIndex = 100
    activationButton.Parent = game:GetService("CoreGui")
    
    activationButton.MouseButton1Click:Connect(function()
        Rayfield:ToggleUI()
        ensureButtonsVisible()
    end)
    
    -- Жесты для открытия
    local touchStart
    game:GetService("UserInputService").TouchStarted:Connect(function(_, processed)
        if not processed then
            touchStart = os.clock()
        end
    end)
    
    game:GetService("UserInputService").TouchEnded:Connect(function(_, processed)
        if not processed and touchStart and (os.clock() - touchStart) > 1 then
            Rayfield:ToggleUI()
            ensureButtonsVisible()
        end
        touchStart = nil
    end)
end

-- Автоматическое восстановление кнопок
task.spawn(function()
    task.wait(3) -- Даем время на загрузку
    ensureButtonsVisible()
    
    -- Периодическая проверка
    while task.wait(5) do
        if not game:GetService("CoreGui"):FindFirstChild("Rayfield") then
            Rayfield:Destroy()
            Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
            Window = Rayfield:CreateWindow({...}) -- Повторяем параметры
            MainTab = Window:CreateTab("Главная", 4483362458)
            ensureButtonsVisible()
        end
    end
end)
