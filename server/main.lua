-- Table to store player XP data
local playerXP = {}

-- Table to store skills configuration
local skillsConfig = require('skills')

-- Retrieves the player's current XP in a skill.
---@param playerId The player's server ID.
---@param skillName The name of the skill.
---@return The player's current XP in the skill.
local GetPlayerXP = function(playerId, skillName)
    if playerXP[playerId] and playerXP[playerId][skillName] then
        return playerXP[playerId][skillName]
    else
        return 0
    end
end

exports("GetPlayerXP", GetPlayerXP)

-- Determines the player's level and progress in a skill based on their XP.
---@param playerId The player's server ID.
---@param skillName The name of the skill.
---@return A table containing the level and progress percentage.
local GetPlayerLevelAndProgress = function(playerId, skillName)
    local skill = skillsConfig[skillName]
    if not skill or not skill.xpPerLevel then
        return { level = 1, progress = 0 }
    end

    local xp = GetPlayerXP(playerId, skillName)
    local totalXP = 0

    for lvl, xpRequired in ipairs(skill.xpPerLevel) do
        totalXP = totalXP + xpRequired
        if xp < totalXP then
            local xpIntoLevel = xp - (totalXP - xpRequired)
            local progress = (xpIntoLevel / xpRequired) * 100
            return { level = lvl, progress = progress }
        end
    end

    return { level = #skill.xpPerLevel, progress = 100 }
end

exports("GetPlayerLevelAndProgress", GetPlayerLevelAndProgress)

-- Saves the player's XP data to the database.
---@param playerId The player's server ID.
local SavePlayerXPToDatabase = function(playerId)
    local identifier = SD.GetIdentifier(playerId)
    MySQL.Async.execute("UPDATE players_xp SET xp_data = @xp_data WHERE identifier = @identifier", {
        ['@identifier'] = identifier,
        ['@xp_data'] = json.encode(playerXP[playerId])
    })
end

-- Loads the player's XP data from the database.
---@param playerId The player's server ID.
local LoadPlayerXPFromDatabase = function(playerId)
    local identifier = SD.GetIdentifier(playerId)
    MySQL.Async.fetchAll("SELECT xp_data FROM players_xp WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    }, function(result)
        if result[1] then
            playerXP[playerId] = json.decode(result[1].xp_data) or {}
        else
            playerXP[playerId] = {}
            MySQL.Async.execute("INSERT INTO players_xp (identifier, xp_data) VALUES (@identifier, @xp_data)", {
                ['@identifier'] = identifier,
                ['@xp_data'] = json.encode({})
            })
        end
    end)
end

-- Initializes a player's XP data.
---@param playerId The player's server ID.
local InitializePlayerXP = function(playerId)
    if playerXP[playerId] then return end
    playerXP[playerId] = {}
    LoadPlayerXPFromDatabase(playerId)
end

-- Sets the player's XP in a skill.
---@param playerId The player's server ID.
---@param skillName The name of the skill.
---@param xpAmount The new XP amount to set.
local SetPlayerXP = function(playerId, skillName, xpAmount)
    InitializePlayerXP(playerId)
    playerXP[playerId][skillName] = xpAmount
    SavePlayerXPToDatabase(playerId)
end

exports("SetPlayerXP", SetPlayerXP)

-- Modifies a player's XP in a specific skill by a given amount (positive or negative).
---@param playerId The player's server ID.
---@param skillName The name of the skill.
---@param amount The amount of XP to adjust (can be positive or negative).
local ModifyPlayerXP = function(playerId, skillName, amount)
    if amount == 0 then return end

    local skill = skillsConfig[skillName]
    if not skill or not skill.xpPerLevel then return end

    local currentXP = GetPlayerXP(playerId, skillName) or 0

    if not skill.maxTotalXP then
        local totalXP = 0
        for _, xpRequired in ipairs(skill.xpPerLevel) do
            totalXP = totalXP + xpRequired
        end
        skill.maxTotalXP = totalXP
    end

    local newXP = currentXP + amount
    newXP = math.max(0, math.min(newXP, skill.maxTotalXP))

    SetPlayerXP(playerId, skillName, newXP)
end

-- Increases a player's XP in a skill by a given amount.
---@param playerId The player's server ID.
---@param skillName The name of the skill.
---@param amount The amount of XP to add.
local IncreasePlayerXP = function(playerId, skillName, amount)
    if amount > 0 then
        ModifyPlayerXP(playerId, skillName, amount)
    end
end

exports("IncreasePlayerXP", IncreasePlayerXP)

-- Decreases a player's XP in a skill by a given amount.
---@param playerId The player's server ID.
---@param skillName The name of the skill.
---@param amount The amount of XP to remove.
local DecreasePlayerXP = function(playerId, skillName, amount)
    if amount > 0 then
        ModifyPlayerXP(playerId, skillName, -amount)
    end
end

exports("DecreasePlayerXP", DecreasePlayerXP)

-- Callback to send skills data to the client
SD.Callback.Register('sd-skills:server:getSkillsData', function(source)
    local playerId = source
    InitializePlayerXP(playerId)
    local skillsData = {}
    for skillName, _ in pairs(skillsConfig) do
        local xpAmount = GetPlayerXP(playerId, skillName)
        local levelData = GetPlayerLevelAndProgress(playerId, skillName)
        skillsData[skillName] = {
            name = skillName,
            xp = xpAmount,
            level = levelData.level,
            progress = levelData.progress
        }
    end
    return skillsData
end)

-- Event handler for player disconnection.
AddEventHandler('playerDropped', function()
    local playerId = source
    playerXP[playerId] = nil
end)

SD.CheckVersion('Samuels-Development/sd_skills') -- Check version of specified resource
