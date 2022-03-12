local packages = require(script.Parent.common).Packages
local ContextControls = require(packages.contextcontrols)
local Trove = require(packages.trove) 

local Controller = {}
Controller.__index = Controller

function Controller:init()
    self.Actions = {
        SprintActionBegan = ContextControls.fromObject({
            name = "SprintActionBegan",
            inputTypes = {
                Enum.KeyCode.LeftShift,
            },
            inputState = Enum.UserInputState.Begin,
            callback = function(input: InputObject)
                self.Humanoid.WalkSpeed = 32
            end
        });
        SprintActionEnded = ContextControls.fromObject({
            name = "SprintActionEnded",
            inputTypes = {
                Enum.KeyCode.LeftShift,
            },
            inputState = Enum.UserInputState.End,
            callback = function(input: InputObject)
                self.Humanoid.WalkSpeed = 16
            end
        })
    }

    for _, v in ipairs(self.Actions) do
        self.Actions.v:bind()
        self._trove:Add(v, "unbind")
    end
end

function Controller.new(character: Model)
    local self = setmetatable({}, Controller)
    self._trove = Trove.new()

    self.Character = character
    self.Humanoid = character.Humanoid

    self:init()
    return self
end

function Controller:Destroy()
    self._trove:Destroy()
end

return Controller
