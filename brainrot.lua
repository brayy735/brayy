local Rayfield, loadError = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "sigma porno sex",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "жди секса",
   LoadingSubtitle = "пожалуйста",
   ShowText = "brayy", -- for mobile users to unhide rayfield, change if you'd like
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   ToggleUIKeybind = "K", -- The keybind to toggle the UI visibility (string like "K" or Enum.KeyCode)

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = false, -- Set this to true to use our key system
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"Hello"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local MainTab = MainWindow:CreateTab("main", 4483362458) -- Title, Image


local Button = MainTab:CreateButton({
   Name = "принт брбр патапим",
   Callback = function(а)
   a = print  "брбр патапим" 
   end,
})

local Toggle = MainTab:CreateToggle({
   Name = "NoClip",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
      if Player.Character then
           for _, part in ipairs(Player.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                   part.CanCollide = not Value
               end
           end
       end
   end,
   -- The variable (Value) is a boolean on whether the toggle is true or false
   end,
})

local SpeedValue = 3.0
local SpeedSlider = Tab:CreateSlider({
   Name = "тип. флэш ускорялка",
   Range = {1.0, 5.0},
   Increment = 0.1,
   Suffix = "x",
   CurrentValue = SpeedValue,
   Flag = "SpeexSlider", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
         SpeedValue = Value
   -- The function that takes place when the slider changes
   -- The variable (Value) is a number which correlates to the value the slider is currently at
   end,
})
