-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+- ]           Cycle Treasure Hunter Mode
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
--
--  TH Modes:  None                 Will never equip TH gear
--             Tag                  Will equip TH gear sufficient for initial contact with a mob (either melee,
--
--             SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
--             Fulltime - Will keep TH gear equipped fulltime


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.Buff.Doom = false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Aeneas_Twash', 'Twashtar_Gleti', 'Twashtar_TP', 'Tauret_Twash', 'Tauret_Gleti', 'Gandring'}
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name="Pillager's Bonnet +1" }
    gear.Artifact_Body = { name="Pillager's Vest +3" }
    gear.Artifact_Hands = { name="Pillager's Armlets +1" }
    gear.Artifact_Legs = { name="Pillager's Culottes +1" }
    gear.Artifact_Feet = { name="Pillager's Poulaines +1" }

    gear.Relic_Head = { name="Plunderer's Bonnet +3" }
    gear.Relic_Body = { name="Plunderer's Vest +3" }
    gear.Relic_Hands = { name="Plunderer's Armlets +3" }
    gear.Relic_Legs = { name="Plunderer's Culottes +3" }
    gear.Relic_Feet = { name="Plunderer's Poulaines +3" }

    gear.Empyrean_Head = { name="Skulker's Bonnet +2" }
    gear.Empyrean_Body = { name="Skulker's Vest +2" }
    gear.Empyrean_Hands = { name="Skulker's Armlets +1" }
    gear.Empyrean_Legs = { name="Skulker's Culottes +1" }
    gear.Empyrean_Feet = { name="Skulker's Poulaines +1" }

    gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.THF_WS_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind !` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind !numpad7 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Cyclone" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad8 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Energy Drain" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad9 input /equip Main "Wax Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Red Lotus Blade" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad4 input /equip Main "Wax Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Blade" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad5 input /equip Main "Ash Club"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Strike" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad6 input /equip Main "Iapetus"; input /ws "Raiden Thrust" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad1 input /equip Main "Lament";input /ws "Freezebite" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad2 input /equip Main "Profane Staff"; input /ws "Earth Crusher" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad3 input /equip Main "Profane Staff"; input /ws "Sunburst" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad0 input /equip Main "Lost Sickle"; input /ws "Shadow of Death" <t>;gs c set WeaponLock true;')
    

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
        send_command('bind !t input /ja "Animated Flourish" <t>')
        set_macro_page(2, 6)
    end

    send_command('bind !h input /ja "Hide" <me>')
    send_command('bind !m input /ja "Mug" <me>')
    
    send_command('wait 2; input /lockstyleset 6')
    
    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !t')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        hands=gear.Relic_Hands,
    }

    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Accomplice'] = { head=gear.Empyrean_Head }
    sets.precast.JA['Aura Steal'] = { head=gear.Relic_Head }
    sets.precast.JA['Collaborator'] = set_combine(sets.TreasureHunter, { head=gear.Empyrean_Head })
    sets.precast.JA['Flee'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Hide'] = { body=gear.Artifact_Body }
    sets.precast.JA['Conspirator'] = set_combine(sets.TreasureHunter, { body=gear.Empyrean_Body })

    sets.precast.JA['Steal'] = {
        -- ammo="Barathrum",
        head=gear.Relic_Head,
        -- hands=gear.Artifact_Hands,
        feet=gear.Artifact_Feet,
    }

    sets.precast.JA['Despoil'] = { 
        -- ammo="Barathrum", 
        legs=gear.Empyrean_Legs, 
        feet=gear.Empyrean_Feet,
    }

    sets.precast.JA['Perfect Dodge'] = { hands=gear.Relic_Hands }
    sets.precast.JA['Feint'] = { legs=gear.Relic_Legs }

    sets.precast.Waltz = {
        ammo="Yamarang",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        body="Passion Jacket",
        legs="Dashing Subligar",
        ring1="Asklepian Ring",
        ring2="Gelatinous Ring +1",
        waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        ammo="Sapience Orb",
        head=gear.Herc_WSD_Head, --7
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Baetyl Pendant", --4
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Weather. Ring", --6(4)
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring1="Lebeche Ring",
    })

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Gleti_Head,
        body=gear.Empyrean_Body,
        hands="Meg. Gloves +2",
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.THF_WS_Cape,
        waist="Fotia Belt",
    } -- default set

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
    })

    sets.precast.WS.Critical = {
        ammo="Yetshila +1",
        ear1="Odr Earring",
        feet=gear.Lustratio_D_Feet,
    }

    sets.precast.WS['Rudra\'s Storm'] ={
        ammo="Seething Bomblet +1",
        neck="Asn. Gorget +2",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
        back=gear.THF_WS_Cape,
    }

    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
    })

     sets.precast.WS['Rudra\'s Storm'].SA = set_combine(sets.precast.WS['Rudra\'s Storm'],{
        ammo="Yetshila +1",
        ear1="Odr Earring",
        feet=gear.Lustratio_D_Feet,
    })

    sets.precast.WS['Rudra\'s Storm'].Acc.SA = sets.precast.WS['Rudra\'s Storm'].SA

    sets.precast.WS['Rudra\'s Storm'].TA = set_combine(sets.precast.WS['Rudra\'s Storm'],{
        ammo="Yetshila +1",
        ear1="Odr Earring",
        feet=gear.Lustratio_D_Feet,
    })

    sets.precast.WS['Rudra\'s Storm'].Acc.TA = sets.precast.WS['Rudra\'s Storm'].TA

    sets.precast.WS['Rudra\'s Storm'].SATA = set_combine(sets.precast.WS['Rudra\'s Storm'],{
        ammo="Yetshila +1",
        ear1="Odr Earring",
        feet=gear.Lustratio_D_Feet,
    })

    sets.precast.WS['Rudra\'s Storm'].Acc.SATA = sets.precast.WS['Rudra\'s Storm'].SATA

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        head=gear.Adhemar_B_Head,
        body=gear.Adhemar_B_Body,
        legs="Meg. Chausses +2",
        feet="Meg. Jam. +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring2="Ilabrat Ring",
    })

    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {

    })

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head=gear.Adhemar_B_Head,
        neck="Fotia Gorget",
        body=gear.Relic_Body,
        hands=gear.Adhemar_B_Hands,
        waist="Fotia Belt",
        legs="Zoar Subligar +1",
        feet=gear.Lustratio_D_Feet,
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        back=gear.THF_WS_Cape,
    })

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        ammo="Voluspa Tathlum",
        -- legs=gear.Artifact_Legs,
        ring1="Regal Ring",
    })

   
    sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]
    sets.precast.WS['Mandalic Stab'].Acc = sets.precast.WS["Rudra's Storm"].Acc

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Legs,
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Metamor. Ring +1",
        ring2="Epaminondas's Ring",
        -- back="Argocham. Mantle",
        waist="Orpheus's Sash",
    })

    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS['Exenterator'], {
        hands=gear.Adhemar_B_Hands,
        feet=gear.Relic_Legs,
        ring2="Gere Ring"
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.THF_TP_Cape,
        waist="Sveltesse Gouriz +1",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Aurgelmir Orb +1",
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Skulker's Earring +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Adhemar_A_Hands,
        back=gear.THF_TP_Cape,
        feet=gear.Relic_Feet,
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        waist="Reiki Yotai",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = {

    }

    sets.defense.MDT = {

    }

    -- sets.Kiting = {feet="Pill. Poulaines +3"}
    sets.Kiting = {feet="Jute Boots +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Yamarang",
        head=gear.Adhemar_A_Head,
        body=gear.Artifact_Body,
        hands=gear.Adhemar_A_Hands,
        -- legs="Samnuha Tights",
        legs=gear.Malignance_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Brutal Earring",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Windbuffet Belt +1",
    }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        ring1=gear.Chirich_1,
        ear2="Telos Earring",
    })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ammo="Yamarang",
        body=gear.Artifact_Body,
        ear1="Cessance Earring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="C. Palug Stone",
        hands="Gazu Bracelets +1",
        legs=gear.Artifact_Legs,
        ear2="Mache Earring +1",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })

    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Adhemar_B_Body, -- 6
        hands=gear.Adhemar_A_Hands,
        -- legs="Samnuha Tights",
        legs=gear.Herc_TA_Legs,
        feet=gear.Taeon_DW_Feet, --9
        neck="Asn. Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape, --Should be DW --10
        waist="Reiki Yotai", --7
    } -- 41%

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
        ring1=gear.Chirich_1,
    })

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
        ammo="Yamarang",
        body=gear.Artifact_Body,
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        ammo="C. Palug Stone",
        hands="Gazu Bracelets +1",
        legs=gear.Artifact_Legs,
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Adhemar_B_Body, -- 6
        hands=gear.Adhemar_A_Hands,
        -- legs="Samnuha Tights",
        legs=gear.Herc_TA_Legs,
        feet=gear.Taeon_DW_Feet, --9
        neck="Asn. Gorget +2",
        ear1="Cessance Earring",
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape, --Should be DW --10
        waist="Reiki Yotai", --7
    } -- 37%

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        ring1=gear.Chirich_1,
    })

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
        ammo="Yamarang",
        body=gear.Artifact_Body,
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        ammo="C. Palug Stone",
        hands="Gazu Bracelets +1",
        legs=gear.Artifact_Legs,
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Adhemar_A_Hands,
        -- legs="Samnuha Tights",
        legs=gear.Herc_TA_Legs,
        feet="Plun. Poulaines +3",
        neck="Asn. Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape, --Should be DW --10
        waist="Reiki Yotai", --7
    } -- 26%

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        ring1=gear.Chirich_1,
    })

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
        ammo="Yamarang",
        ear1="Cessance Earring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        ammo="C. Palug Stone",
        hands="Gazu Bracelets +1",
        legs=gear.Artifact_Legs,
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Adhemar_A_Hands,
         -- legs="Samnuha Tights",
        legs=gear.Herc_TA_Legs,
        feet="Plun. Poulaines +3",
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape, --Should be DW --10
        waist="Reiki Yotai", --7
    } -- 22%

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        neck="Combatant's Torque",
        ring1=gear.Chirich_1,
    })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
        ammo="Yamarang",
        ear1="Cessance Earring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        ammo="C. Palug Stone",
        hands="Gazu Bracelets +1",
        legs=gear.Artifact_Legs,
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Adhemar_A_Hands,
        -- legs="Samnuha Tights",
        legs=gear.Herc_TA_Legs,
        feet="Plun. Poulaines +3",
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Skulker's Earring +1",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", --7
    } -- 7%

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        ring1=gear.Chirich_1,
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
        ammo="Yamarang",
        -- head="Dampening Tam",
        ear1="Cessance Earring",
        ring2="Ilabrat Ring",
    })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        ammo="C. Palug Stone",
        hands="Gazu Bracelets +1",
        legs=gear.Artifact_Legs,
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        -- feet=gear.Malignance_Feet, --4/4
        -- ring2="Defending Ring", --10/10
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.Aeneas_Twash = {main="Aeneas", sub="Twashtar"}
    sets.Twashtar_Gleti = {main="Twashtar", sub="Gleti's Knife"}
    sets.Twashtar_TP = {main="Twashtar", sub="Fusetto +2"}
    sets.Tauret_Gleti = {main="Tauret", sub="Gleti's Knife"}
    sets.Tauret_Twash = {main="Tauret", sub="Twashtar"}
    sets.Gandring = {main="Gandring", sub="Gleti's Knife"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end

    if not midaction() then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    check_weaponset()
end



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode

    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    if state.Buff['Sneak Attack'] then
        wsmode = (wsmode or '') .. 'SA'
    end

    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()

    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.TreasureMode.value ~= 'None' then
        msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 6 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 6 and DW_needed <= 22 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 22 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 26 and DW_needed <= 37 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 37 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end


-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
    end
end


-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)

