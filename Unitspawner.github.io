--// Create UI
local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.ResetOnSpawn = false

local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
frame.Active = true
frame.Draggable = true

local textbox = Instance.new("TextBox", frame)
textbox.Size = UDim2.new(1, -10, 0.4, -5)
textbox.Position = UDim2.new(0, 5, 0, 5)
textbox.PlaceholderText = "Enter Unit Name"
textbox.Text = "UnitName"
textbox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
textbox.TextColor3 = Color3.fromRGB(255, 255, 255)

local button = Instance.new("TextButton", frame)
button.Size = UDim2.new(1, -10, 0.4, -5)
button.Position = UDim2.new(0, 5, 0.55, 0)
button.Text = "SpawnUnit"
button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
button.TextColor3 = Color3.fromRGB(255, 255, 255)

--// Button Clicked
button.MouseButton1Click:Connect(function()
	local unitName = textbox.Text

	-- Validate name input
	if unitName == "" then
		warn("Unit name is empty!")
		return
	end

	-- Get player and position
	local character = player.Character or player.CharacterAdded:Wait()
	local root = character:WaitForChild("HumanoidRootPart")

	local spawnCFrame = CFrame.new(
		root.Position.X - 5,
		root.Position.Y,
		root.Position.Z
	)

	local args = {
		unitName,
		spawnCFrame
	}

	-- Send to server
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlaceTower"):InvokeServer(unpack(args))
	game:GetService("ReplicatedStorage"):WaitForChild("Functions"):WaitForChild("SpawnTower"):InvokeServer(unpack(args))
end)
