-- Ожидаем загрузку игры
repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer.Character

-- Загрузка Rayfield с обработкой ошибок
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
end)

if not success or not Rayfield then
    -- Попробуем альтернативный источник
    Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end

-- Создание окна
local Window = Rayfield:CreateWindow({
    Name = "Brainrot Toolkit",
    LoadingTitle = "EraFox Security Suite",
    LoadingSubtitle = "by jaleyBreak systems",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
    MobileCompatible = true
})

-- Принудительно показываем интерфейс
Rayfield:Show()

-- Далее ваш код создания кнопок и функций...

-- Пример создания кнопки
local Button = Tab:Create Button({
    Name = "Тестовая кнопка",
    Callback = function()
        Rayfield:Notify({
            Title = "Уведомление",
            Content = "Кнопка работает!",
            Duration = 5
        })
    end
})

-- Активируем мобильный режим, если нужно
if game:GetService("UserInputService").TouchEnabled then
    Rayfield:SetMobile(true)
end
