local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local angleEvent = ReplicatedStorage:WaitForChild("AngleSender")

local airborneEvent = ReplicatedStorage:WaitForChild("AirborneNotify")
local airborne = false

local totalAngle = 0
local totalYaw = 0
local totalPitch = 0

local function onCharacterAdded(character)
	local humanoid = character:WaitForChild("Humanoid")

	local lastLookVector = nil
	totalAngle = 0
	totalYaw = 0
	totalPitch = 0
	airborne = false
	
	
	airborneEvent.OnClientEvent:Connect(function(state)
		airborne = state 
			if airborne then
				totalAngle = 0
				lastLookVector = camera.CFrame.LookVector
			else
				-- sending total angle, yaw, and pitch over
			angleEvent:fireServer(string.format("%.2f",tostring(totalAngle)),string.format("%.2f",tostring(totalYaw)),string.format("%.2f",tostring(totalPitch)))
			
			-- Reset after landing
			totalAngle = 0
			totalYaw = 0
			totalPitch = 0
			lastLookVector = nil
			end
	end)

	RunService.RenderStepped:Connect(function()
		if not airborne or not lastLookVector then return end
		local currentLookVector = camera.CFrame.LookVector

		-- Angle between last and current frame
		local dot = math.clamp(lastLookVector:Dot(currentLookVector), -1, 1)
		local angle = math.acos(dot)

		totalAngle += math.abs(angle)

		-- YAW (horizontal rotation)
		local lastFlat = Vector3.new(lastLookVector.X, 0, lastLookVector.Z).Unit
		local currentFlat = Vector3.new(currentLookVector.X, 0, currentLookVector.Z).Unit

		local yawDot = math.clamp(lastFlat:Dot(currentFlat), -1, 1)
		local yawAngle = math.acos(yawDot)

		totalYaw += math.abs(yawAngle)

		-- PITCH (vertical rotation)
		local lastPitch = Vector3.new(lastLookVector.Y, 0, 0).Unit
		local currentPitch = Vector3.new(currentLookVector.Y, 0, 0).Unit

		local pitchDot = math.clamp(lastPitch:Dot(currentPitch), -1, 1)
		local pitchAngle = math.acos(pitchDot)
		
		totalPitch += math.abs(pitchAngle)

		lastLookVector = currentLookVector
	end)
end

-- Setup character
if player.Character then
	onCharacterAdded(player.Character)
end

player.CharacterAdded:Connect(onCharacterAdded)