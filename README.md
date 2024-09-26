# sd-skills

`sd-skills` is a comprehensive and flexible skills script for FiveM, allowing you to add, manage, and track player skills, levels, and progress within your server.

## UI Preview
![FiveM_b3095_GTAProcess_RJpJwWj1zH](https://github.com/user-attachments/assets/5ff71723-10f7-45c2-bf42-099ca2b5834f)



## 🔔 Contact

Author: Samuel#0008  
Discord: [Join the Discord](https://discord.gg/samueldev)  
Store: [Click Here](https://fivem.samueldev.shop)

## 💾 Installation

1. Download the latest release from the [GitHub repository](https://github.com/Samuels-Development/sd_skills/releases).
2. Extract the downloaded file and rename the folder to `sd_skills`.
3. Place the `sd_skills` folder into your server's `resources` directory.
4. Add `ensure sd_skills` to your `server.cfg` to ensure the resource starts with your server.
5. Import the provided SQL file (`run_me.sql`) into your database to create the necessary tables.


## 📖 Dependencies
- qb-core, qbx_core or es_extended.
- [oxymsql](https://github.com/overextended/oxmysql) 
- [sd_lib](https://github.com/Samuels-Development/sd_lib/releases)

## 📖 Usage

### Command
You can use `/skills` to open the UI, this can be changed in the `client/main.lua`.

### Overview

`sd-skills` provides a set of exported functions and events that allow you to manage player skills and XP. You can increase or decrease a player's XP, set their XP directly, and retrieve their current level and progress towards the next level.

### Exports

The following functions are exported and can be used in your scripts:

#### **Server-Side Exports:**


 - `GetPlayerXP(playerId, skillName)`
    - **Description:** Retrieves a player's current XP in a specific skill.
    - **Parameters:**
      - `playerId` *(number)*: The player's server ID.
      - `skillName` *(string)*: The name of the skill.
    - **Returns:**
      - *(number)*: The player's current XP in the specified skill.

  - `GetPlayerLevelAndProgress(playerId, skillName)`
    - **Description:** Retrieves a player's level and progress in a skill based on their current XP.
    - **Parameters:**
      - `playerId` *(number)*: The player's server ID.
      - `skillName` *(string)*: The name of the skill.
    - **Returns:**
      - *(table)* containing:
        - `level` *(number)*: The player's current level in the skill.
        - `progress` *(number)*: The percentage progress towards the next level.

  - `SetPlayerXP(playerId, skillName, xpAmount)`
    - **Description:** Sets a player's XP in a specific skill.
    - **Parameters:**
      - `playerId` *(number)*: The player's server ID.
      - `skillName` *(string)*: The name of the skill.
      - `xpAmount` *(number)*: The new XP amount to set.
    - **Returns:**
      - *None* (This function does not return a value).

  - `IncreasePlayerXP(playerId, skillName, amount)`
    - **Description:** Increases a player's XP in a skill by a given amount.
    - **Parameters:**
      - `playerId` *(number)*: The player's server ID.
      - `skillName` *(string)*: The name of the skill.
      - `amount` *(number)*: The amount of XP to add.
    - **Returns:**
      - *None* (This function does not return a value).

  - `DecreasePlayerXP(playerId, skillName, amount)`
    - **Description:** Decreases a player's XP in a skill by a given amount.
    - **Parameters:**
      - `playerId` *(number)*: The player's server ID.
      - `skillName` *(string)*: The name of the skill.
      - `amount` *(number)*: The amount of XP to subtract.
    - **Returns:**
      - *None* (This function does not return a value).


#### Usage Examples

Here's how you can use these exports in your scripts:

```lua
-- Get a player's current XP in a skill
local currentXP = exports['sd_skills']:GetPlayerXP(source, 'MINING')
print('Current Mining XP:', currentXP)

-- Increase a player's XP in a skill
exports['sd_skills']:IncreasePlayerXP(source, 'MINING', 150)

-- Decrease a player's XP in a skill
exports['sd_skills']:DecreasePlayerXP(source, 'LOCKPICKING', 50)

-- Set a player's XP in a skill directly
exports['sd_skills']:SetPlayerXP(source, 'FISHING', 5000)

-- Get a player's level and progress in a skill
local levelData = exports['sd-skills']:GetPlayerLevelAndProgress(playerId, 'Crafting')
print('Level:', levelData.level)
print('Progress:', levelData.progress .. '%')
