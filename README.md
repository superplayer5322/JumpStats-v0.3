# JumpStats-v0.3
A Roblox Studio package that reports a player's distance travelled and elapsed camera angle while they are airborne.


# How to Prep JumpStats For Use

JumpStats consists of two LocalScripts, a GUI, eight RemoteEvents, and four sound files. You will need to place the files in the following locations:

- ToggleSensor.luau and CameraTracker.luau in StarterGUI
- JumpStats Sounds.rbxm in Workspace
- RemoteEvents.rbxm in ReplicatedStorage

You can also see each of these files in their correct placements in the actual JumpStats place (JumpStats.rbxl). You will need to import each of these assets through Roblox Studio in order to view them. 

# How to Use JumpStats

JumpStats will record new data every time the player lands on the ground. This data consists of:

- XZ distance travelled
- Y distance travelled
- Total distance travelled
- Elapsed Yaw (XZ Angle)
- Elapsed Pitch (Y Angle)
- Elapsed Total Angle
- Elapsed Airtime

and can be printed in a CSV format. Note that the current version of JumpStats prints the CSV using curly brackets, so a quick fix for now is to just use a "ctrl+f" replace command in Python to change it to regular brackets.

To print this data and save it to a CSV, press T. To remove the last data point from the CSV, press V. And, to switch between a second CSV (primarily used for obstacles of an obstacle course that cannot be classified normally) and the original CSV, press H.

The data string can then be put into the Python Template.ipynb to sort out the data and print graphs.
