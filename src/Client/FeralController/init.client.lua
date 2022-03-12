local common = require(script.Parent.common)
local RequestModel = common.RequestModel
local packages = common.Packages
local Promise = require(packages.Promise)

Promise.try(function()
    RequestModel:FireServer()
end):catch(warn)