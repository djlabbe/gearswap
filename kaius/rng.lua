-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


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
    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
    state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
    state.Buff['Double Shot'] = buffactive['Double Shot'] or false
    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Arrow", "Stone Arrow" }
    state.Buff.Doom = false

    -- Whether a warning has been given for low ammo
    state.warned = M(false)

    elemental_ws = S{'Aeolian Edge', 'Trueflight', 'Wildfire'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring",
              "Era. Bul. Pouch", "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Quelling B. Quiver",
              "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc', 'Enmity')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Gastraphetes', 'Fomalhaut', 'Armageddon', 'Annihilator', 'Savage'}
    state.WeaponLock = M(false, 'Weapon Lock')

    DefaultAmmo = {['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
                   }

    AccAmmo = {    ['Yoichinoyumi'] = "Yoichi's Arrow",
                   ['Gandiva'] = "Yoichi's Arrow",
                   ['Fail-Not'] = "Yoichi's Arrow",
                   ['Annihilator'] = "Eradicating Bullet",
                   ['Armageddon'] = "Eradicating Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Devastating Bullet",
                   }

    WSAmmo = {     ['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Chrono Bullet",
                   ['Armageddon'] = "Chrono Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Chrono Bullet",
                   }

    MagicAmmo = {  ['Yoichinoyumi'] = "Chrono Arrow",
                   ['Gandiva'] = "Chrono Arrow",
                   ['Fail-Not'] = "Chrono Arrow",
                   ['Annihilator'] = "Devastating Bullet",
                   ['Armageddon'] = "Devastating Bullet",
                   ['Gastraphetes'] = "Quelling Bolt",
                   ['Fomalhaut'] = "Devastating Bullet",
                   }

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    gear.Artifact_Head = { name="Orion Beret +3" }
    -- gear.Artifact_Body = { name="Orion Jerkin +1" }
    gear.Artifact_Legs = { name="Orion Braccae +1" }
    gear.Artifact_Hands = { name="Orion Bracers +2" }
    gear.Artifact_Feet = { name="Orion Socks +2" }

    gear.Relic_Head = { name="Arcadian Beret +3" }
    gear.Relic_Body = { name="Arcadian Jerkin +3" }
    gear.Relic_Legs = { name="Arcadian Braccae +3" }
    gear.Relic_Hands = { name="Arcadian Bracers +3" }
    gear.Relic_Feet = { name="Arcadian Socks +3" }

    gear.Empyrean_Head = { name="Amini Gapette +1" }
    gear.Empyrean_Body = { name="Amini Caban +2" }
    gear.Empyrean_Legs = { name="Amini Brague +2" }
    gear.Empyrean_Hands = { name="Amini Glovelettes +2" }
    gear.Empyrean_Feet = { name="Amini Bottillons +2" }

    gear.RNG_DW_Cape ={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.RNG_RA_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RNG_SNP_Cape = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
    gear.RNG_TP_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RNG_LS_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.RNG_TF_Cape = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')
    send_command('bind @r gs c cycle WeaponSet')

    send_command('bind !` input /ja "Velocity Shot" <me>')
    send_command('bind ^` input /ja "Hover Shot" <me>')
    send_command('bind !b input /ja "Shadowbind" <t>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
        set_macro_page(1, 11)
    elseif player.sub_job == 'DNC' then
        send_command('bind @` input /ja "Chocobo Jig" <me>')
        set_macro_page(2, 11)
    else
        set_macro_page(1, 11)
    end

    send_command('wait 2; input /lockstyleset 11')

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
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
end


-- Set up all gear sets.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Eagle Eye Shot'] = { legs=gear.Relic_Legs }
    -- sets.precast.JA['Bounty Shot'] = { hands=gear.Empyrean_Hands }
    -- sets.precast.JA['Camouflage'] = { body=gear.Artifact_Body }
    sets.precast.JA['Scavenge'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Shadowbind'] = { hands=gear.Artifact_Feet }
    sets.precast.JA['Sharpshot'] = { legs=gear.Artifact_Legs }

    -- Fast cast sets for spells

    sets.precast.Waltz = {
        body="Passion Jacket",
        ring1="Asklepian Ring",
        waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        head=gear.Carmine_D_Head, --14
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet=gear.Carmine_B_Feet, --8
        neck="Baetyl Pendant", --4
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Weather. Ring", --6(4)
        -- waist="Rumination Sash",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring2="Lebeche Ring",
    })


    -- (10% Snapshot, 5% Rapid from Merits)
    sets.precast.RA = {
        head=gear.Taeon_SNAP_Head, --10/0
        body=gear.Empyrean_Body,
        hands=gear.Carmine_D_Hands, --8/11
        legs=gear.Artifact_Legs, --15/0
        feet="Meg. Jam. +2", --10/0
        neck="Scout's Gorget +2", --4/0
        ring1="Crepuscular Ring", --3/0
        back=gear.RNG_SNP_Cape, --10/0
        waist="Impulse Belt", --3/0
    } --60/11

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        head=gear.Artifact_Head, --0/18
        legs=gear.Adhemar_D_Legs, --10/13
    }) --45/42

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        feet=gear.Relic_Feet, --0/10
        waist="Yemaya Belt", --0/5
    }) --32/57

    
    sets.precast.RA.Gastra = {
        head=gear.Artifact_Head, --15/0
    }
    sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {
        feet=gear.Relic_Feet, --0/10
    })

    sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {
        legs="Pursuer's Pants", --0/19
    })
    


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        head=gear.Artifact_Head, --10
        body=gear.Ikenga_Body,
        hands="Meg. Gloves +2", --7
        legs=gear.Relic_Legs, --10
        feet=gear.Empyrean_Feet, --8
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring", --5
        back=gear.RNG_LS_Cape, --10
        waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS.Enmity = set_combine(sets.precast.WS, {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })

    sets.precast.WS["Last Stand"] = set_combine(sets.precast.WS, {
        neck="Scout's Gorget +2",
    })

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.ACCbullet,
        feet=gear.Artifact_Feet,
        ear1="Beyla Earring",
        ear2="Telos Earring",
        ring2="Hajduk Ring +1",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Last Stand'].Enmity = set_combine(sets.precast.WS['Last Stand'], {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })



    sets.precast.WS['Apex Arrow'] = sets.precast.WS

    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        feet=gear.Artifact_Feet,
        ear1="Beyla Earring",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Apex Arrow'].Enmity = set_combine(sets.precast.WS['Apex Arrow'], {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })

    sets.precast.WS['Jishnu\'s Radiance'] = set_combine(sets.precast.WS, {
        head=gear.Adhemar_A_Head,
         -- body="Abnoba Kaftan",
        body=gear.Adhemar_A_Body,
        hands="Mummu Wrists +2",
        feet="Thereoid Greaves",
        ear1="Sherida Earring",
        ring1="Begrudging Ring",
        ring2="Mummu Ring",
    })

    sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
        legs="Mummu Kecks +2",
        feet=gear.Relic_Feet,
        neck="Iskur Gorget",
        ear1="Beyla Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Hajduk Ring +1",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Jishnu\'s Radiance'].Enmity = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })

   

    sets.precast.WS["Coronach"] = set_combine(sets.precast.WS['Last Stand'], {
        neck="Scout's Gorget +2",
        ear1="Sherida Earring",
        ear2="Mache Earring +1",
    })

    sets.precast.WS["Coronach"].Acc = set_combine(sets.precast.WS['Coronach'], {
        ear1="Beyla Earring",
        ear2="Telos Earring",
    })

    sets.precast.WS["Coronach"].Enmity = set_combine(sets.precast.WS['Coronach'], {
        ear1="Beyla Earring",
    })

    sets.precast.WS["Trueflight"] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Scout's Gorget +2",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Weather. Ring",
        ring2="Epaminondas's Ring",
        back=gear.RNG_TF_Cape,
        waist="Eschan Stone",
    }

    sets.precast.WS["Wildfire"] = set_combine(sets.precast.WS["Trueflight"], {
        ring1="Regal Ring",
        waist="Skrymir Cord +1",
    })

    sets.precast.WS['Savage Blade'] = {
        head=gear.Artifact_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Empyrean_Feet,
        neck="Scout's Gorget +2",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",       
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.RNG_LS_Cape,
        waist="Sailfi Belt +1",
      
    }

    sets.precast.WS['Evisceration'] = {
        head=gear.Adhemar_B_Head,
        -- body="Abnoba Kaftan",
        body=gear.Adhemar_A_Body,
        hands="Mummu Wrists +2",
        legs="Zoar Subligar +1",
        neck="Fotia Gorget",
        ear2="Mache Earring +1",
        ring1="Begrudging Ring",
        ring2="Mummu Ring",
        back=gear.RNG_TP_Cape,
        waist="Fotia Belt",
    }


    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        body=gear.Adhemar_B_Body,
        legs=gear.Nyame_Legs,
        ring1="Regal Ring",
    })

    sets.precast.WS['Rampage'] = set_combine(sets.precast.WS['Evisceration'], {
        feet=gear.Herc_TA_Feet
    })

    sets.precast.WS['Rampage'].Acc = sets.precast.WS['Evisceration'].Acc


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast recast for spells

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        body=gear.Taeon_Phalanx_Body, --10
        hands="Rawhide Gloves", --15
        legs=gear.Carmine_D_Legs, --20
        feet=gear.Taeon_Phalanx_Feet, --10
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
        waist="Rumination Sash", --10
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Ranged sets

    sets.midcast.RA = {
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Scout's Gorget +2",
        -- ear1="Enervating Earring",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        -- ring1="Regal Ring",
        ring="Crepuscular Ring",
        ring2="Dingir Ring",
        back=gear.RNG_RA_Cape,
        waist="Yemaya Belt",
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        -- head=gear.Artifact_Head,
        -- body=gear.Artifact_Body,
        -- hands=gear.Artifact_Hands,
        feet=gear.Empyrean_Feet,
        ear1="Beyla Earring",
        ring2="Hajduk Ring +1",
        waist="K. Kachina Belt +1",
    })

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
        head="Meghanada Visor +2",
        body="Mummu Jacket +2",
        hands="Kobo Kote",
        legs="Mummu Kecks +2",
        feet="Osh. Leggings +1",
        ring1="Begrudging Ring",
        ring2="Mummu Ring",
        waist="K. Kachina Belt +1",
    })

    sets.DoubleShot = {
        head=gear.Relic_Head,
        body=gear.Relic_Body,
        hands="Oshosi Gloves +1", -- 5
        legs="Osh. Trousers +1", --7
        feet="Osh. Leggings +1", --4
    } --25

    sets.DoubleShot.Critical = {
        head="Meghanada Visor +2",
        waist="K. Kachina Belt +1",
    }

    sets.TrueShot = {
        body="Nisroch Jerkin",
        legs="Osh. Trousers +1",
    }


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    -- Idle sets
    sets.idle = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Bathy Choker +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RNG_RA_Cape,
        waist="Carrier's Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Scout's Gorget +2",
        ear1="Crepuscular earring",
        ear2="Telos Earring",
        ring1="Crepuscular Ring",
        ring2="Regal Ring",      
        back=gear.RNG_RA_Cape,
        waist="K. Kachina Belt +1",
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    -- sets.Kiting = {feet="Orion Socks +3"}
    sets.Kiting = {feet="Jute Boots +1"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Sherida Earring",
        ear2="Brutal Earring",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back=gear.RNG_TP_Cape,
        waist="Windbuffet Belt +1",
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        waist="Kentarch Belt +1",
    })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Suppanomimi", --5
        ear2="Eabani Earring", --4
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back=gear.RNG_DW_Cape, --10
        waist="Windbuffet Belt +1",
    }

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        ear1="Crep. Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        waist="Kentarch Belt +1",
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW.LowHaste
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc.LowHaste

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste =  sets.engaged.DW.MidHaste
    sets.engaged.DW.Acc.HighHaste =  sets.engaged.DW.Acc.MidHaste

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back=gear.RNG_DW_Cape,
        waist="Windbuffet Belt +1",
    } -- 10%

    sets.engaged.DW.Acc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        ear1="Crep. Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        waist="Kentarch Belt +1",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        ring2="Defending Ring", --10/10
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Barrage = {hands=gear.Artifact_Hands}
    sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {
        body=gear.Empyrean_Body, 
        back=gear.RNG_TP_Cape
    })
    
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.FullTP = { ear1="Crematio Earring" }

    sets.Savage = {main="Naegling", sub="Kraken Club", ranged="Sparrowhawk +2", ammo="Hauksbok Arrow"}
    sets.Annihilator = {main="Perun +1", sub="Blurred Knife +1", ranged="Annihilator"}
    sets.Fomalhaut = {main="Perun +1", sub="Blurred Knife +1", ranged="Fomalhaut"}
    sets.Armageddon = {main="Perun +1", sub="Malevolence", ranged="Armageddon"}
    sets.Gastraphetes = {
        main={ name="Malevolence", augments={'INT+10','"Mag.Atk.Bns."+6',}},
        sub={ name="Malevolence", augments={'INT+4','Mag. Acc.+3','"Mag.Atk.Bns."+2','"Fast Cast"+2',}}, 
        ranged="Gastraphetes"
    }

    sets.DefaultShield = {sub="Nusku Shield"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        state.CombatWeapon:set(player.equipment.range)
    end
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
        check_ammo(spell, action, spellMap, eventArgs)
    end
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
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if spell.action_type == 'Ranged Attack' then
            if player.equipment.ranged == "Gastraphetes" then
                if flurry == 2 then
                    equip(sets.precast.RA.Gastra.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Gastra.Flurry1)
                else
                    equip(sets.precast.RA.Gastra)
                end
            else
                if flurry == 2 then
                    equip(sets.precast.RA.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Flurry1)
                else
                    equip(sets.precast.RA)
                end
            end
            if player.equipment.main == "Perun +1" then
                equip({waist="Yemaya Belt"})
            end
        end
    elseif spell.type == 'WeaponSkill' then
        if (spell.english == 'Trueflight' or spell.english == 'Aeolian Edge') and player.tp > 2900 then
            equip(sets.FullTP)
        end
        if (spell.skill == 'Archery') then
            special_ammo_check()
        end
        -- Equip obi if weather/day matches for WS.
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    elseif (spell.english == 'Shadowbind' or spell.english == 'Bounty Shot' or spell.english == 'Eagle Eye Shot') then
        special_ammo_check()
    end
    
    
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Double Shot'] then
            equip(sets.DoubleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.DoubleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
            end
        end
        if state.Buff.Barrage then
            equip(sets.buff.Barrage)
        end
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english == "Shadowbind" then
        send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
        end
    end

    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end
end

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
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
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
        if state.RangedMode.value == 'Acc' then
            wsmode = 'Acc'
            add_to_chat(1, 'WS Mode Auto Acc')
        end
    elseif (spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery') then
        if state.OffenseMode.value == 'Acc' then
            wsmode = 'Acc'
        end
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

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
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

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] then
                    add_to_chat(3,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Default ammo unavailable.  Leaving empty.")
                end
            else
                add_to_chat(3,"Unable to determine default ammo for current weapon.  Leaving empty.")
            end
        end
    elseif spell.type == 'WeaponSkill' then
        -- magical weaponskills
        if elemental_ws:contains(spell.english) then
            if player.inventory[MagicAmmo[player.equipment.range]] then
                equip({ammo=MagicAmmo[player.equipment.range]})
            else
                add_to_chat(3,"Magic ammo unavailable.  Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            end
        --physical weaponskills
        else
            if state.RangedMode.value == 'Acc' then
                if player.inventory[AccAmmo[player.equipment.range]] then
                    equip({ammo=AccAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Acc ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            else
                if player.inventory[WSAmmo[player.equipment.range]] then
                    equip({ammo=WSAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"WS ammo unavailable.  Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            end
        end
    end
    if player.equipment.ammo ~= 'empty' and player.inventory[player.equipment.ammo].count < 15 then
        add_to_chat(39,"*** Ammo '"..player.inventory[player.equipment.ammo].shortname.."' running low! *** ("..player.inventory[player.equipment.ammo].count..")")
    end
end

function update_offense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end


function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
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
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end

function check_weaponset()
    if state.OffenseMode.value == 'Acc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
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
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)