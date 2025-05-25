-- ESP + Aimbot com Tracking e Team Check
-- Para uso autorizado e teste de trapaças

-- Configurações
local settings = {
    espEnabled = true,
    aimbotEnabled = false,
    teamCheck = true,
    aimPart = "Head" -- "Head" ou "HumanoidRootPart"
}

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 200, 0, 170)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
Frame.BorderSizePixel = 0

local function createToggle(name, yPos, callback)
    local button = Instance.new("TextButton", Frame)
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, yPos)
    button.Text = name .. ": OFF"
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.TextColor3 = Color3.new(1,1,1)
    button.MouseButton1Click:Connect(function()
        settings[name] = not settings[name]
        button.Text = name .. ": " .. (settings[name] and "ON" or "OFF")
        callback(settings[name])
    end)
end

createToggle("espEnabled", 10, function() end)
createToggle("aimbotEnabled", 45, function() end)
createToggle("teamCheck", 80, function() end)

-- ESP
local function createESP(player)
    if player == game.Players.LocalPlayer then return end

    local box = Drawing.new("Text")
    box.Text = player.Name
    box.Color = Color3.new(1, 1, 1)
    box.Size = 16
    box.Center = true
    box.Outline = true
    box.Visible = false

    game:GetService("RunService").RenderStepped:Connect(function()
        if not settings.espEnabled then
            box.Visible = false
            return
        end

        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if settings.teamCheck and player.Team == game.Players.LocalPlayer.Team then
                box.Visible = false
                return
            end

            local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(character.HumanoidRootPart.Position)
            if onScreen then
                box.Position = Vector2.new(pos.X, pos.Y)
                box.Text = player.Name
                box.Visible = true
            else
                box.Visible = false
            end
        else
            box.Visible = false
        end
    end)
end

for _, player in pairs(game.Players:GetPlayers()) do
    createESP(player)
end

game.Players.PlayerAdded:Connect(createESP)

-- Aimbot com tracking contínuo
local RunService = game:GetService("RunService
