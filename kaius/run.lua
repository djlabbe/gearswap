-- Original: Motenten / Modified: Arislan

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
--              [ WIN+H ]           Toggle Charm Defense Mods
--              [ WIN+D ]           Toggle Death Defense Mods
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Use current Rune
--              [ CTRL+Insert ]          Rune element cycle forward.
--              [ CTRL+Delete ]          Rune element cycle backward.
--              [ CTRL+` ]          Use current Rune
--
--              [ CTRL+Numpad/ ]    Berserk/Meditate/Souleater
--              [ CTRL+Numpad* ]    Warcry/Sekkanoki/Arcane Circle
--              [ CTRL+Numpad- ]    Aggressor/Third Eye/Weapon Bash
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+G ]          Cycles between available greatswords
--              [ CTRL+W ]          Toggle Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Resolution
--              [ CTRL+Numpad8 ]    Upheaval
--              [ CTRL+Numpad9 ]    Dimidiation
--              [ CTRL+Numpad5 ]    Ground Strike
--              [ CTRL+Numpad6 ]    Full Break
--              [ CTRL+Numpad1 ]    Herculean Slash
--              [ CTRL+Numpad2 ]    Shockwave
--              [ CTRL+Numpad3 ]    Armor Break
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------


--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()

    rune_enchantments = S{'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda',
        'Lux','Tenebrae'}

    -- /BLU Spell Maps
    blue_magic_maps = {}

    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific',
        'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    rayke_duration = 35
    gambit_duration = 96

    state.Buff.Doom = false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')
    state.PhysicalDefenseMode:options('PDT', 'HP')
    state.MagicalDefenseMode:options('MDT')

    state.WeaponSet = M{['description']='Weapon Set', 'Aettir'}
    -- state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Lionheart', 'Aettir', 'Lycurgos'}
    state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    gear.Artifact_Head = { name="Runeist Bandeau +1" }
    gear.Artifact_Body = { name="Runeist Coat +1" }
    gear.Artifact_Legs = { name="Runeist Trousers +1" }
    gear.Artifact_Hands = { name="Runeist Mitons +1" }
    gear.Artifact_Feet = { name="Runeist Bottes +1" }

    gear.Relic_Head = { name="Futhark Bandeau +1" }
    gear.Relic_Body = { name="Futhark Coat +1" }
    gear.Relic_Legs = { name="Futhark Trousers +3" }
    gear.Relic_Hands = { name="Futhark Mitons +3" }
    gear.Relic_Feet = { name="Futhark Boots +3" }

    gear.Empyrean_Head = { name="Erilaz Galea +1" }
    gear.Empyrean_Body = { name="Erilaz Surcoat +2" }
    gear.Empyrean_Legs = { name="Erilaz Leg Guards +2" }
    gear.Empyrean_Hands = { name="Erilaz Gauntlets +1" }
    gear.Empyrean_Feet = { name="Erilaz Greaves +1" }

    gear.RUN_HPD_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_HPP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_TP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_WS1_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_WS2_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind !` input //gs c rune')
    send_command('bind ^` input /ja "Vivacious Pulse" <me>')

    send_command('bind !insert gs c cycleback Runes')
    send_command('bind !delete gs c cycle Runes')

    send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')


    set_macro_page(1, 22)
    send_command('wait 2; input /lockstyleset 22')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind @a')

    send_command('unbind @d')
    send_command('unbind !q')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind !o')
    send_command('unbind !p')
    send_command('unbind ^,')
    send_command('unbind @w')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Enmity = {
        ammo={name="Aqreqaq Bomblet", priority=1}, --2
        head="Halitus Helm", --8
        body="Emet Harness +1", --10
        hands="Kurys Gloves", --9       
        legs="Eri. Leg Guards +2", --11
        feet="Ahosi Leggings",--7
        neck={name="Unmoving Collar +1", priority=4}, --10
        --neck="Moonlight Necklace", --15
        ear1={name="Tuisto Earring", priority=3},
        --ear1="Cryptic Earring", --4
        ear2="Trux Earring",
        ring1={name="Pernicious Ring", priority=2}, --5
        ring2="Eihwaz Ring", --5
        back=gear.RUN_HPD_Cape, --10
        waist="Kasiri Belt", --3
    }

    sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {
        body=gear.Artifact_Body,
        legs=gear.Relic_Legs,
        back=gear.RUN_HPD_Cape,
    })

    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']

    sets.precast.JA['Pflug'] = set_combine(sets.Enmity, {feet=gear.Artifact_Feet})
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity, {head=gear.Relic_Head})
    sets.precast.JA['Liement'] = set_combine(sets.Enmity, {body=gear.Relic_Body})

    sets.precast.JA['Lunge'] = {
        ammo="Ghastly Tathlum +1",
        head=gear.Herc_MAB_Head,
        body=gear.Carmine_B_Body,
        hands=gear.Carmine_D_Hands,
        legs=gear.Herc_MAB_Legs,
        -- feet=gear.Herc_MAB_Feet,
        neck="Baetyl Pendant",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1={name="Fenrir Ring +1", bag="wardrobe3"},
        ring2={name="Fenrir Ring +1", bag="wardrobe4"},
        back="Argocham. Mantle",
        waist="Eschan Stone",
        }

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity, {hands=gear.Artifact_Hands})
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity, {feet=gear.Relic_Feet})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, {body=gear.Relic_Body})
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, {hands=gear.Relic_Hands})

    sets.precast.JA['Vivacious Pulse'] = {
        ammo={name="Aqreqaq Bomblet", priority=1},
        head={name="Runeist's Bandeau +3", priority=3},
        body={name="Runeist's Coat +3", priority=5},
        legs="Rune. Trousers +3",
        feet={name="Turms Leggings +1", priority=2},
        neck="Incanter's Torque",
        ear1={name="Tuisto Earring", priority=4},
        ear2="Saxnot Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        --back="Altruistic Cape",
        back=gear.RUN_HPD_Cape,
        waist="Bishop's Sash",
        }

    sets.precast.JA['Vivacious Pulse'].Status = {head="Erilaz Galea +1",}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head={name="Rune. Bandeau +3", priority=3},
        body=gear.Empyrean_Body, --10
        hands="Leyline Gloves", --8
        legs="Aya. Cosciales +2", --6
        feet=gear.Carmine_B_Feet, --8
        neck="Orunmila's Torque", --5
        ear1={name="Tuisto Earring", priority=5},
        ear2={name="Odnowa Earring +1", priority=4},
        ring1={name="Moonlight Ring", priority=2},
        ring2="Weather. Ring", --6(4)
        back=gear.RUN_FC_Cape, --10
        waist={name="Oneiros Belt", priority=1}
        }

    sets.precast.FC.HP = set_combine(sets.precast.FC, {
        ammo={name="Aqreqaq Bomblet", priority=1},
        head={name="Rune. Bandeau +3", priority=4},
        body={name="Runeist's Coat +3", priority=8},
        neck={name="Unmoving Collar +1", priority=3}, --10
        ear1={name="Tuisto Earring", priority=7},
        ear2={name="Odnowa Earring +1", priority=6},
        ring1={name="Moonlight Ring", priority=5},
        waist={name="Oneiros Belt", priority=2}
    })

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs=gear.Relic_Legs,
     })

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Herc_WSD_Head,
        body=gear.Herc_WSD_Body,
        hands="Meg. Gloves +2",
        legs=gear.Herc_WSD_Legs,
        feet=gear.Herc_TA_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.RUN_WS1_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Voluspa Tathlum",
        body=gear.Adhemar_B_Body,
        legs="Meg. Chausses +2",
        ear2="Telos Earring",
    })

    sets.precast.WS.Uncapped = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
    })

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
        head="Lustratio Cap +1",
        body="Lustr. Harness +1",
        hands=gear.Adhemar_B_Hands,
        legs="Samnuha Tights",
        feet="Lustra. Leggings +1",
        neck="Futhark Torque +2",
        ring1="Epona's Ring",
        back=gear.RUN_WS1_Cape,
    })

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {
        ammo="Voluspa Tathlum",
        head="Blistering Sallet +1",
        hands=gear.Adhemar_A_Hands,
        legs="Meg. Chausses +2",
        ear2="Telos Earring",
        })

    sets.precast.WS['Resolution'].Uncapped = set_combine(sets.precast.WS['Resolution'], {
        body=gear.Adhemar_B_Body,
        legs="Meg. Chausses +2",
        feet=gear.Herc_TA_Feet,
        ring1="Regal Ring",
        })

    sets.precast.WS['Resolution'].Safe = set_combine(sets.precast.WS['Resolution'], {
        head="Blistering Sallet +1",
        body=gear.Adhemar_B_Body,
        feet=gear.Herc_TA_Feet,
        })

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        body=gear.Adhemar_B_Body,
        legs="Lustr. Subligar +1",
        feet="Lustra. Leggings +1",
        ear1="Odr Earring",
        ring2="Epaminondas's Ring",
        back=gear.RUN_WS2_Cape,
        })

    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'], {
        ammo="Voluspa Tathlum",
        body=gear.Adhemar_B_Body,
        legs="Samnuha Tights",
        ear2="Mache Earring +1",
        })

    sets.precast.WS['Dimidiation'].Uncapped = set_combine(sets.precast.WS['Dimidiation'], {
        neck="Caro Necklace",
        waist="Grunfeld Rope",
        })

    sets.precast.WS['Dimidiation'].Safe = set_combine(sets.precast.WS['Dimidiation'], {
        legs="Lustr. Subligar +1",
        feet=gear.Herc_TA_Feet,
        })

    sets.precast.WS['Herculean Slash'] = sets.precast.JA['Lunge']

    sets.precast.WS['Shockwave'] = {
        ammo="Pemphredo Tathlum",
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands="Leyline Gloves",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Moonshade Earring",
        ring1="Metamor. Ring +1",
        ring2="Weather. Ring +1",
        back=gear.RUN_WS1_Cape,
        waist="Acuity Belt +1",
        }

    sets.precast.WS['Fell Cleave'] = set_combine(sets.precast.WS, {
        feet="Lustra. Leggings +1",
        ear2="Ishvara Earring",
        back=gear.RUN_WS1_Cape,
        waist="Sailfi Belt +1",
    })

    sets.precast.WS['Fell Cleave'].Acc = set_combine(sets.precast.WS.Acc, {
        ear2="Ishvara Earring",
        back=gear.RUN_WS1_Cape,
        waist="Sailfi Belt +1",
    })

    sets.precast.WS['Fell Cleave'].Safe = set_combine(sets.precast.WS, {
        feet="Futhark Boots +3",
    })

    sets.precast.WS['Steel Cyclone'] = sets.precast.WS['Fell Cleave']
    sets.precast.WS['Steel Cyclone'].Acc = sets.precast.WS['Fell Cleave'].Acc
    sets.precast.WS['Steel Cyclone'].Safe = sets.precast.WS['Fell Cleave'].Safe

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Upheaval'].Acc = sets.precast.WS['Resolution'].Acc
    sets.precast.WS['Upheaval'].Safe = sets.precast.WS['Resolution'].Safe

    sets.precast.WS['Shield Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        head={name="Runeist's Bandeau +3", priority=2},
        body=gear.Taeon_Phalanx_Body, --10
        hands=gear.Taeon_Phalanx_Hands, --10
        legs=gear.Taeon_Phalanx_Legs, --10
        feet=gear.Taeon_Phalanx_Feet, --10
        neck="Moonlight Necklace", --15
        ear1={name="Tuisto Earring", priority=3},
        ear2="Magnetic Earring", --8
        ring1={name="Moonlight Ring", priority=1},
        ring2="Evanescence Ring", --5
        back=gear.RUN_FC_Cape, --10
        waist="Audumbla Sash", --10
    } -- +10% from merit points

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.Cure = {
        -- sub="Refined Grip +1",
        ammo="Staunch Tathlum +1",
        head={name="Runeist's Bandeau +3", priority=2},
        body="Vrikodara Jupon", -- 13
        hands={name="Regal Gauntlets", priority=4},
        legs="Aya. Cosciales +2",
        feet="Skaoi Boots", --7
        neck="Sacro Gorget", -- 10
        ear1={name="Tuisto Earring", priority=3},
        ear2="Mendi. Earring", -- 5
        ring1="Lebeche Ring", -- 3
        ring2="Menelaus's Ring", --5
        back="Solemnity Cape", -- 7
        waist={name="Oneiros Belt", priority=1}
        }

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.SpellInterrupt, {
        head="Erilaz Galea +1",
        hands="Regal Gauntlets",
        legs="Futhark Trousers +3",
    })

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Deacon Sword", --4
        head="Fu. Bandeau +3", --7
        body=gear.Taeon_Phalanx_Body, --3(10)
        hands=gear.Taeon_Phalanx_Hands, --3(10)
        legs=gear.Taeon_Phalanx_Legs, --3(10)
        feet=gear.Taeon_Phalanx_Feet, --3(10)
    })

    sets.midcast['Aquaveil'] = set_combine(sets.midcast['Enhancing Magic'], {
        main="Nibiru Faussar", --1
        -- sub="Refined Grip +1",
    })

    sets.midcast.Temper = {
        main="Pukulatmuj +1",
        head=gear.Carmine_D_Head,
        body="Manasa Chasuble",
        hands=gear.Artifact_Hands,
        legs=gear.Carmine_D_Legs,
        feet={name="Turms Leggings +1", priority=2},
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Merciful Cape",
        waist="Olympus Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head="Rune. Bandeau +3", neck="Sacro Gorget"})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head=gear.Empyrean_Head, waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Divine Magic'] = sets.Enmity

    sets.midcast['Enfeebling Magic'] = {
        main="Lycurgos",
        -- sub="Khonsu",
        ammo="Pemphredo Tathlum",
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands="Aya. Manopolas +2",
        legs="Aya. Cosciales +2",
        feet="Aya. Gambieras +2",
        neck="Erra Pendant",
        ear1="Digni. Earring",
        ear2="Vor Earring",
        ring1="Metamor. Ring +1",
        ring2="Weather. Ring +1",
        back="Evasionist's Cape",
        waist="Acuity Belt +1",
    }

    sets.midcast.Flash = sets.Enmity
    sets.midcast.Foil = sets.Enmity
    sets.midcast.Stun = sets.Enmity
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {
        ammo="Staunch Tathlum",
        head=gear.Empyrean_Head, --8
        body="Emet Harness +1", --10
        -- hands="Kurys Gloves", --9       
        legs=gear.Carmine_D_Legs,
        feet=gear.Empyrean_Feet,
        neck="Moonlight Necklace",
        -- ear1="Cryptic Earring",
        -- ear2="Trux Earring",
        ring1="Supershear Ring",
        ring2="Eihwaz Ring",
        back=gear.RUN_HPD_Cape, --10
        waist="Audumbla Sash", --3
    }

    sets.midcast['Blue Magic'].Enmity = sets.Enmity
    sets.midcast['Blue Magic'].Cure = sets.midcast.Cure
    sets.midcast['Blue Magic'].Buff = {}


    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = {
        -- sub="Refined Grip +1", --3/3
        ammo="Staunch Tathlum +1", --3/3
        -- head="Turms Cap +1",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands="Turms Mittens +1",
        legs=gear.Empyrean_Legs, --11
        -- body="Runeist's Coat +3",
        -- hands="Turms Mittens +1",
        -- legs="Eri. Leg Guards +1", --7/0
        feet="Turms Leggings +1",
        neck="Futhark Torque +2", --7/7
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1", --3/5
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        -- back=gear.RUN_HPD_Cape, --10/0
        back=gear.RUN_HPD_Cape,
        waist="Engraved Belt",
    }

    sets.defense.MDT = {
        -- sub="Refined Grip +1", --3/3
        ammo="Staunch Tathlum +1", --3/3
        head="Turms Cap +1",
        body="Runeist's Coat +3",
        hands="Turms Mittens +1",
        legs="Eri. Leg Guards +1", --7/0
        feet="Turms Leggings +1",
        neck="Futhark Torque +2", --7/7
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1", --3/5
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back=gear.RUN_HPD_Cape, --10/0
        waist="Engraved Belt",
        }

    sets.defense.HP = {
        -- sub="Mensch Strap +1", --5/0
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Adhemar_D_Head, --4/0
        body={name="Runeist's Coat +3", priority=2},
        hands={name="Regal Gauntlets", priority=3},
        legs="Eri. Leg Guards +1", --7/0
        feet="Turms Leggings +1",
        neck="Futhark Torque +2", --7/7
        ear1={name="Tuisto Earring", priority=6},
        ear2={name="Odnowa Earring +1", priority=5}, --3/5
        ring1={name="Moonlight Ring", priority=4}, --5/5
        ring2="Defending Ring", --10/10
        back={name="Moonlight Cape", priority=1}, --6/6
        waist="Engraved Belt",
        }

    sets.defense.Parry = {
        hands="Turms Mittens +1",
        legs=gear.Empyrean_Legs,
        feet="Turms Leggings +1",
        back=gear.RUN_HPP_Cape,
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        -- sub="Utu Grip",
        ammo="Aurgelmir Orb +1",
        head=gear.Adhemar_B_Head,
        body=gear.Adhemar_B_Body,
        hands=gear.Adhemar_B_Hands,
        legs="Samnuha Tights",
        feet=gear.Herc_TA_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Brutal Earring",
        ring1="Epona's Ring",
        ring2="Niqmaddu Ring",
        back=gear.RUN_TP_Cape,
        waist="Sailfi Belt +1",
    }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        head="Dampening Tam",
        hands=gear.Adhemar_A_Hands,
        neck="Combatant's Torque",
        waist="Ioskeha Belt +1",
        })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ammo="Yamarang",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ammo="C. Palug Stone",
        head=gear.Carmine_D_Head,
        body="Carm. Sc. Mail +1",
        hands="Gazu Bracelet +1",
        legs="Carmine Cuisses +1",
        ear1="Odr Earring",
        ear2="Mache Earring +1",
        waist="Olseni Belt",
    })


    sets.engaged.Aftermath = {
        head="Aya. Zucchetto +2",
        body="Ashera Harness",
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        waist="Kentarch Belt +1",
        }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Hybrid = {
        head=gear.Adhemar_D_Head, --4/0
        body="Ashera Harness", --7/7
        neck="Futhark Torque +2", --7/7
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        back=gear.RUN_TP_Cape, --10/0
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.Hybrid)

    sets.engaged.Aftermath.DT = {
        head="Aya. Zucchetto +2",
        body="Ashera Harness",
        hands=gear.Adhemar_A_Hands,
        legs="Meg. Chausses +2",
        neck="Futhark Torque +2",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        back=gear.RUN_TP_Cape,
        waist="Sailfi Belt +1",
    }

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        -- sub="Mensch Strap +1",
        ammo="Homiliary",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        -- head="Turms Cap +1",
        -- body="Futhark Coat +3",
        -- hands="Regal Gauntlets",
        -- legs="Turms Subligar +1",
        -- feet="Turms Leggings +1",
        neck="Bathy Choker +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RUN_HPD_Cape,
        -- waist="Ioskeha Belt +1",
        waist="Engraved Belt",
    }

    sets.idle.DT = {
        -- sub="Mensch Strap +1", --5/0
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        -- head="Fu. Bandeau +3", --6/0
        -- body="Runeist's Coat +3",
        -- hands="Turms Mittens +1",
        -- legs="Turms Subligar +1",
        -- feet="Turms Leggings +1",
        neck="Futhark Torque +2", --7/7
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1", --0/2
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        back=gear.RUN_HPD_Cape, --10/0
        waist="Flume Belt +1", --4/0
    }

    sets.idle.Refresh = set_combine(sets.idle, {
        ammo="Homiliary",
        head=gear.Herc_Idle_Head,
        body=gear.Artifact_Body,
        hands="Regal Gauntlets",
        legs="Rawhide Trousers",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
    })

    sets.idle.Town = sets.defense.PDT

    sets.Kiting = {legs=gear.Carmine_D_Legs}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}

    -- sets.Epeolatry = { main="Epeolatry", sub="Utu Grip" }
    -- sets.Lionheart = {main="Lionheart", sub="Utu Grip"}
    sets.Aettir = {main="Aettir", sub="Utu Grip"}
    -- sets.Lycurgos = {main="Lycurgos", sub="Utu Grip"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Action stopped due to status.')
        eventArgs.cancel = true
        return
    end
    if rune_enchantments:contains(spell.english) then
        eventArgs.handled = true
    end
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' then
        currentSpell = spell.english
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            equip(sets.precast.FC.HP)
        end
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
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
    if spell.english == 'Vivacious Pulse' then
        if buffactive['poison'] or buffactive['paralysis'] or buffactive['blindness'] or buffactive['silence']
        or buffactive['curse'] or buffactive['bane'] or buffactive['doom'] or buffactive['disease'] or buffactive['plague'] then
             equip(sets.precast.JA['Vivacious Pulse'].Status)
        end
    end
end

--[[function job_midcast(spell, action, spellMap, eventArgs)
    if state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.current == 'HP' and spell.english ~= "Phalanx" then
        eventArgs.handled = true
        if spell.action_type == 'Magic' then
            if spell.english == 'Flash' or spell.english == 'Foil' or spell.english == 'Stun'
                or blue_magic_maps.Enmity:contains(spell.english) then
                equip(sets.Enmity)
            elseif spell.skill == 'Enhancing Magic' then
                equip(sets.midcast.EnhancingDuration)
            end
        end
    end
end--]]

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    --[[if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end--]]
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.PhalanxDuration)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end

    if spell.name == 'Rayke' and not spell.interrupted then
        send_command('@timers c "Rayke ['..spell.target.name..']" '..rayke_duration..' down spells/00136.png')
        send_command('wait '..rayke_duration..';input /echo [Rayke just wore off!];')
    elseif spell.name == 'Gambit' and not spell.interrupted then
        send_command('@timers c "Gambit ['..spell.target.name..']" '..gambit_duration..' down spells/00136.png')
        send_command('wait '..gambit_duration..';input /echo [Gambit just wore off!];')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.Charm.current)
    classes.CustomDefenseGroups:append(state.Death.current)

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.Charm.current)
    classes.CustomMeleeGroups:append(state.Death.current)
    check_weaponset()
end

function job_buff_change(buff,gain)
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff:startswith('Aftermath') then
        state.Buff.Aftermath = gain
        customize_melee_set()
        handle_equipping_gear(player.status)
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
    
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Epeolatry" and state.DefenseMode.value == 'None' then
        if state.HybridMode.value == "DT" then
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath.DT)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()
    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

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

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, action, spellMap)
    if spell.type == 'WeaponSkill' then
        if state.DefenseMode.value ~= 'None' or state.HybridMode.value == 'DT' then
            return "Safe"
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        send_command('@input /ja '..state.Runes.value..' <me>')
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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