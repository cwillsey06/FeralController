local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("common")

assert(common, "Please place \"common\" inside ReplicatedStorage!")
common:WaitForChild("Packages")

return common