local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- 1. Создаем главное окно
local Window = Rayfield:CreateWindow({
    Name = "Мое меню",
    LoadingTitle = "Загрузка интерфейса...",
    ConfigurationSaving = { Enabled = false }
})

-- Добавьте после создания Window
if UserInputService.TouchEnabled then
    Rayfield:SetMobile(true)
    Rayfield:SetConfiguration({
        MobileButtonSize = UDim2.new(0.3, 0, 0.07, 0),
        MobileTextSize = 20
    })
end

-- 2. Обязательно показываем окно
Rayfield:Show()

-- 3. Добавляем задержку для инициализации
task.wait(0.5)

-- 4. Создаем кнопку
local Button = Tab:CreateButton({
    Name = "Тестовая кнопка",
    Callback = function()
        print("Кнопка нажата!")
        Rayfield:Notify({
            Title = "Успех",
            Content = "Кнопка работает!",
            Duration = 3
        })
    end,
})
