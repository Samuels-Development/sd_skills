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

-- Function to refresh skills data from the server
local RefreshSkills = function()
    SD.Callback('sd-skills:server:getSkillsData', false, function(serverSkills)
        if serverSkills then
            skills = serverSkills
            UpdateSkillsUI(skills)
        else
        end
    end)
end

-- NUI Callback for refreshing skills
RegisterNUICallback('refreshSkills', function(data, cb)
    RefreshSkills()
    cb('ok')
end)

-- Function to toggle the visibility of the skills UI.
--- param show A boolean indicating whether to show or hide the UI.
local ToggleSkillsUI = function(show)
    skillsVisible = show
    SendNUIMessage({
        action = "toggleUI",
        show = skillsVisible
    })
    SetNuiFocus(skillsVisible, skillsVisible)

    if skillsVisible then
        SD.Callback('sd-skills:server:getSkillsData', false, function(serverSkills)
            if serverSkills then
                skills = serverSkills
                UpdateSkillsUI(skills)
            else
            end
        end)
    end
end

-- NUI Callback for closing the UI
RegisterNUICallback('closeUI', function(data, cb)
    ToggleSkillsUI(false)
    cb('ok')
end)

-- Command to open the skills UI
RegisterCommand("skills", function()
    ToggleSkillsUI(true)
end, false)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        Wait(3250)
        SD.Callback('sd-skills:server:getSkillsData', false, function(serverSkills)
        if serverSkills then
            skills = serverSkills
        end
    end)
    end
end)