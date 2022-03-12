local common = game:GetService("ReplicatedStorage").common
local RequestModel = common.RequestModel

function copyCharacterScripts(character: Model)
    local content = game.StarterPlayer.StarterCharacterScripts:GetChildren()
    for _, v in ipairs(content) do
        v:Clone().Parent = character
    end
end

function LoadCharacter(player: Player, model: Model)
    local rig = model:Clone()
    rig.Parent = workspace
    rig.Name = player.Name
    rig.Humanoid.DisplayName = player.DisplayName

    local spawnOffset = CFrame.new(0, rig:GetExtentsSize().Y / 2, 0)
    rig:SetPrimaryPartCFrame(workspace.SpawnLocation.CFrame * spawnOffset)

    player.Character = rig
    copyCharacterScripts(player.Character)
    
    player.CharacterAdded:Connect(function()
        copyCharacterScripts(player.Character)
    end)

    return player.Character
end

function RequestModel.OnServerInvoke(client: Player)
    -- TODO: make better rig
    return LoadCharacter(client, common.Rig)
end