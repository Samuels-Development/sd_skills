-- Flag to track whether the skills UI is visible
local skillsVisible = false

-- Table to store the player's skills data
local skills = {}

-- Function to update the skills data in the UI.
---param skillsData A table containing the skills data to display.
local UpdateSkillsUI = function(skillsData)
    SendNUIMessage({
        action = "updateSkills",
        skills = skillsData
    })
end

-- Function to toggle the visibility of the skills UI.
--- param show A boolean indicating whether to show or hide the UI.
local ToggleSkillsUI = function(show)
    skillsVisible = show
    SendNUIMessage({
        action = "toggleUI",
        show = skillsVisible
    })
    SetNuiFocus(skillsVisible, skillsVisible)
end

-- Event handler for closing the UI
RegisterNUICallback('closeUI', function(data, cb)
    ToggleSkillsUI(false)
    cb('ok')
end)

-- Event handler for receiving skills data from the server
RegisterNetEvent('sd-skills:client:updateSkills', function(serverSkills)
    if serverSkills then
        print(skills)
        skills = serverSkills
        UpdateSkillsUI(skills)
    end
end)

RegisterCommand("skills", function()
    ToggleSkillsUI(true)
end, false)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        -- Request initial skills data from the server
        TriggerServerEvent('sd-skills:server:requestInitialSkillsData')
    end
end)