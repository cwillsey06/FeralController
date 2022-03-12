local common = require(script.common)
local RequestModel = common.RequestModel
local packages = common.Packages
local Promise = require(packages.promise)

local Controller = require(script.Controller)

Promise.try(function()
    -- Load Feral Rig
    return RequestModel:InvokeServer()
end)
    :andThen(function(character)
        -- Load Controller
        Controller.new(character)
    end)
    :catch(warn)