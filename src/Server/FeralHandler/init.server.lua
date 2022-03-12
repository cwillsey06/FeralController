local common = game:GetService("ReplicatedStorage").common
local RequestModel = common.RequestModel

function copyCharacterScripts(character: Model)
    local content = game.StarterPlayer.StarterCharacterScripts:GetChildren()
    for _, v in ipairs(content) do
        content:Clone().Parent = character
    end
end

function LoadCharacter(player: Player, model: Model)
    local rig = model:Clone()
    rig.Parent = workspace
    rig.Name = player.Name
    rig.Humanoid.DisplayName = player.DisplayName

    local spawnOffset = CFrame.new(0, rig:GetExtentsSize().Y / 2, 0)
    rig:SetPrimaryPartCFrame(workspace.SpawnPoint.CFrame * spawnOffset)

    player.Character = rig
    copyCharacterScripts(player.Character)
    print('1')

    player.CharacterAdded:Connect(function()
        print('2')
        copyCharacterScripts(player.Character)
    end)
end

RequestModel.OnServerEvent:Connect(function(client: Player)
        -- TODO: make better rig
    LoadCharacter(client, common.Rig)
end)