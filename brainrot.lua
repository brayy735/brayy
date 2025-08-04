local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Player = game.Players.LocalPlayer

-- Ждем загрузки персонажа (если необходимо)
repeat task.wait() until Player.Character

-- Создаем окно
local Window = Rayfield:CreateWindow({
    Name = "Мое меню",
    LoadingTitle = "Загрузка...",
    LoadingSubtitle = "Ожидайте",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
})

-- АКТИВИРУЕМ ОКНО
Rayfield:Show()

-- КРАТКАЯ ЗАДЕРЖКА ДЛЯ СТАБИЛИЗАЦИИ
task.wait(1)

-- СОЗДАЕМ КНОПКУ
local Button = Window:CreateButton({
    Name = "Тестовая кнопка",
    Callback = function()
        Rayfield:Notify({
            Title = "Успех",
            Content = "Кнопка работает!",
            Duration = 3
        })
    end,
})

-- Для мобильных устройств
if game:GetService("UserInputService").TouchEnabled then
    Rayfield:SetMobile(true)
    Rayfield:SetConfiguration({
        MobileButtonSize = UDim2.new(0.3, 0, 0.07, 0),
        MobileTextSize = 20
    })
end

-- Проверка видимости
print("Rayfield GUI создан")
