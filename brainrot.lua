-- 1. Загрузка библиотеки с проверкой
local Rayfield, loadError = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
if not Rayfield then
    error("Ошибка загрузки Rayfield: "..tostring(loadError))
end

-- 2. Создание окна с правильным синтаксисом
local Window = Rayfield:CreateWindow({
    Name = "Мое меню",
    LoadingTitle = "Загрузка интерфейса",
    LoadingSubtitle = "Пожалуйста подождите...",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false, -- Отключить систему ключей
    Discord = { Enabled = false } -- Отключить интеграцию Discord
})

-- 3. Ожидание инициализации
repeat task.wait(0.1) until Window and Window.CreateButton

-- 4. Создание кнопки с проверкой
if type(Window.CreateButton) == "function" then
    Window:CreateButton({
        Name = "Тестовая кнопка",
        Callback = function()
            print("Кнопка работает!")
        end
    })
else
    warn("Метод CreateButton недоступен! Использую fallback")
    
    -- Fallback: ручное создание кнопки
    local button = Instance.new("TextButton")
    button.Name = "FallbackButton"
    button.Size = UDim2.new(0.2, 0, 0.1, 0)
    button.Position = UDim2.new(0.4, 0, 0.45, 0)
    button.Text = "Нажми меня"
    button.Parent = game:GetService("CoreGui")
    
    button.MouseButton1Click:Connect(function()
        print("Fallback кнопка сработала!")
    end)
end

-- 5. Для мобильных устройств
if game:GetService("UserInputService").TouchEnabled then
    Rayfield:SetMobile(true)
    Rayfield:SetConfiguration({
        MobileButtonSize = UDim2.new(0.35, 0, 0.08, 0),
        MobileTextSize = 22
    })
end

-- 6. Диагностика
print("Тип Rayfield:", typeof(Rayfield))
print("Тип Window:", typeof(Window))
print("Методы Window:")
for k,v in pairs(Window) do
    if type(v) == "function" then
        print(" - "..k)
    end
end
