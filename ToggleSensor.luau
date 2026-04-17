local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CCOtoggleKey = Enum.KeyCode.H -- default hotkey
local submitToggleKey = Enum.KeyCode.T -- default hotkey
local removeToggleKey = Enum.KeyCode.V -- default hotkey
local LMB = Enum.UserInputType.MouseButton1 -- left mouse button

local toggleEvent = ReplicatedStorage:WaitForChild("ToggleCCO")
local submitEvent = ReplicatedStorage:WaitForChild("SubmitCSV")
local removeEvent = ReplicatedStorage:WaitForChild("RemoveCSV")
local LMBEvent = ReplicatedStorage:WaitForChild("LMBClick")

local isCCO = false
local isSubmit = false
local isRemove = false

local CCOkeyDown = false
local submitKeyDown = false
local removeKeyDown = false
local LMBDown = false

local CCOsound = workspace:FindFirstChild("Minecraft Sounds: UI Click")
local CSVsound = workspace:FindFirstChild("elevator ding")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end -- ignore typing in chat, etc.

	if input.KeyCode == CCOtoggleKey and not CCOkeyDown then
		CCOkeyDown = true
		CCOsound:Play()
		if isCCO then
			isCCO = false
			print(isCCO)
			toggleEvent:FireServer(isCCO)
		elseif not isCCO then
			isCCO = true
			print(isCCO)
			toggleEvent:FireServer(isCCO)
		end
	elseif input.KeyCode == submitToggleKey and not submitKeyDown then
		submitKeyDown = true
		isSubmit = true
		submitEvent:FireServer(isCCO)
		CSVsound:Play()
		isSubmit = false
	elseif input.KeyCode == removeToggleKey and not removeKeyDown then
		removeKeyDown = true
		isRemove = true
		removeEvent:FireServer(isCCO)
		isRemove = false
	elseif input.UserInputType == LMB and not LMBDown then
		LMBDown = true
		LMBEvent:FireServer()
	end
	
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == CCOtoggleKey then
		CCOkeyDown = false
	elseif input.KeyCode == submitToggleKey then
		submitKeyDown = false
	elseif input.KeyCode == removeToggleKey then
		removeKeyDown = false
	end
end)
