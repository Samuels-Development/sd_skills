return { -- table of skills
    ["CHEMISTRY"] = { -- Identifier
        -- XP required to progress from the current level to the next level.
        -- Starting level is 1.
        -- The first entry corresponds to the XP needed to go from Level 1 to Level 2.
        -- For example:
        -- Total XP to reach Level 3 is cumulative:
        -- - Level 1 to Level 2 requires 100 XP (first entry).
        -- - Level 2 to Level 3 requires 150 XP (second entry).
        -- - Therefore, total XP to reach Level 3 is 100 (to reach Level 2) + 150 (to reach Level 3) = 250 XP.
        -- Note:
        -- - Each level requires the specified amount of XP to progress from the previous level.
        -- - The XP required for each level is not just an incremental increase over the previous level's requirement.
        -- - For instance, Level 3 requires 150 XP more than Level 2, not just an additional 50 XP over Level 2's requirement.
        xpPerLevel = {
            100, -- Level 1 to Level 2 requires 100 XP
            150, -- Level 2 to Level 3 requires 150 XP
            200, -- Level 3 to Level 4 requires 200 XP
            250, -- Level 4 to Level 5 requires 250 XP
            300, -- Level 5 to Level 6 requires 300 XP
            350, -- Level 6 to Level 7 requires 350 XP
            400, -- Level 7 to Level 8 requires 400 XP
            450, -- Level 8 to Level 9 requires 450 XP
            500, -- Level 9 to Level 10 requires 500 XP
            -- The number of entries determines the maximum level attainable.
            -- In this case, maximum level is Level 10 (starting from Level 1).
        },
    },
    ["COOKING"] = {
        xpPerLevel = {
            100, 150, 200, 250, 300, 350, 400, 450, 500, 550,
        },
    },
    ["CRAFTING"] = {
        xpPerLevel = {
            100, 150, 200, 250, 300, 350, 400, 450, 500, 550,
        },
    },
    ["STAMINA"] = {
        xpPerLevel = {
            100, 150, 200, 250, 300, 350, 400, 450, 500, 550,
        },
    },
    ["HACKING"] = {
        xpPerLevel = {
            120, 170, 230, 290, 360, 430, 500, 580, 660, 750,
        },
    },
    ["MEDICINE"] = {
        xpPerLevel = {
            110, 160, 220, 280, 350, 420, 490, 570, 650, 740,
        },
    },
    ["ARCHERY"] = {
        xpPerLevel = {
            100, 150, 210, 270, 340, 410, 480, 560, 640, 730,
        },
    },
    ["BLACKSMITHING"] = {
        xpPerLevel = {
            130, 180, 240, 310, 380, 450, 530, 610, 690, 780,
        },
    },
    ["SURVIVAL"] = {
        xpPerLevel = {
            100, 160, 220, 290, 360, 430, 510, 590, 670, 760,
        },
    },
    ["ENGINEERING"] = {
        xpPerLevel = {
            120, 170, 230, 300, 370, 450, 530, 620, 710, 800,
        },
    },
    ["ASTRONOMY"] = {
        xpPerLevel = {
            130, 190, 250, 320, 390, 470, 550, 640, 730, 830,
        },
    },
    ["PHOTOGRAPHY"] = {
        xpPerLevel = {
            100, 160, 220, 290, 360, 440, 520, 610, 700, 800,
        },
    },
}
