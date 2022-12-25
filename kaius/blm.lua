-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+D ]           Toggle Death Casting Mode Toggle
--
--  Spells:     [ Alt+T ]          Stun
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad0 ]    Myrkr
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
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'}
    }

    state.Buff.Doom = false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.CastingMode:options('Normal', 'Resistant', 'Spaekona')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.DeathMode = M(false, 'Death Mode')
    state.WeaponSet = M{['description']='Weapon Set', 'Xoanon', 'Malevolence' }


    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    -- gear.Artifact_Head = { name="Spaekona's Petasos +3" }
    gear.Artifact_Body = { name="Spaekona's Coat +3" }
    -- gear.Artifact_Hands = { name="Spaekona's Gloves +3" }
    -- gear.Artifact_Legs = { name="Spaekona's Tonban +3" }
    -- gear.Artifact_Feet = { name="Spaekona's Sabots +3" }

    gear.Relic_Head = { name="Archmage's Petasos +3" }
    gear.Relic_Body = { name="Archmage's Coat +3" }
    gear.Relic_Hands = { name="Archmage's Gloves +3" }
    gear.Relic_Legs = { name="Archmage's Tonban +3" }
    gear.Relic_Feet = { name="Archmage's Sabots +3" }

    -- gear.Empyrean_Head = { name="Wicce Petasos +1" }
    -- gear.Empyrean_Body = { name="Wicce Coat +1" }
    -- gear.Empyrean_Hands = { name="Wicce Gloves +1" }
    -- gear.Empyrean_Legs = { name="Wicce Tonban +1" }
    gear.Empyrean_Feet = { name="Wicce Sabots +1" }

    gear.BLM_MAB_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    gear.BLM_Death_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}

    send_command('bind @q gs c toggle MagicBurst')
    send_command('bind @d gs c toggle DeathMode')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    if player.sub_job == 'RDM' then
        send_command('bind !g input /ma "Gravity" <t>')
    end

    send_command('bind !t input /ma "Stun" <t>')
    send_command('bind !b input /ma "Bind" <t>')

    set_macro_page(1, 4)
    send_command('wait 2; input /lockstyleset 4')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !t')
    send_command('unbind @q')
    send_command('unbind @d')
    send_command('unbind @w') 
    send_command('unbind !g')
    send_command('unbind !b')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------

    ---- Precast Sets ----

    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {
        feet="Wicce Sabots +1",
        back=gear.BLM_Death_Cape,
    }

    sets.precast.JA.Manafont = { body=gear.Relic_Body }

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Amalric_A_Head, --11
        body="Zendik Robe", --13
        hands="Merlinic Dastanas", --6
        legs=gear.Agwu_Legs, --7
        feet="Regal Pumps +1", --6
        neck="Baetyl Pendant", --4
        ear1="Malignance Earring", --4
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Weather. Ring", --5
        back="Fi Follet Cape +1", --10
        waist="Embla Sash", --5
    } --79

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        back="Perimede Cape",
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.Storm = set_combine(sets.precast.FC, {
        ring2=gear.Stikini_2,
    })

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Epaminondas's Ring",
        ring2="Shukuyu Ring",
        back="Relucent Cape",
        waist="Fotia Belt",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Vidohunir'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Amalric_A_Body,
        hands=gear.Amalric_D_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Archon Ring",
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    } -- INT

    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Amalric_A_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Amalric_A_Legs,
        feet="Medium's Sabots",
        -- neck="Orunmila's Torque",
        neck="Baetyl Pendant",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Mephitas's Ring +1",
        ring2="Fenrir Ring +1",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",
    } -- Max MP


    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Sors Shield", --3/(-5)
        ammo="Esper Stone +1", --0/(-5)
        body="Shamash Robe",
        hands=gear.Telchine_ENH_Hands, --10
        feet="Medium's Sabots", --12
        neck="Nodens Gorget", --5
        ear1="Mendi. Earring", --5
        ear2="Regal Earring", --5
        ring1="Lebeche Ring", --3/(-5)
        ring2="Haoma's Ring",
        back="Oretan. Cape +1", --6
        waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        -- neck="Nuna Gorget +1",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        main=gear.Gada_ENH,
        sub="Genmei Shield",
        head="Vanya Hood",
        body="Vanya Robe",
        -- hands="Hieros Mittens",
        feet="Vanya Clogs",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
    })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
    }

    sets.midcast.EnhancingDuration = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head,
        --feet="Inspirited Boots",
        waist="Gishdubar Sash",
        -- back="Grapevine Cape",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        -- main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        head=gear.Amalric_A_Head,
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring"
    })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=empty;
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs="Ea Slops +1",
        -- feet="Skaoi Boots",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Luminary Sash",
    } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        sub="Ammurapi Shield",
        waist="Acuity Belt +1",
    }) -- INT/Magic accuracy

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",
        body="Ea Houppe. +1",
        hands=gear.Amalric_D_Hands,
        legs="Ea Slops +1",
        feet="Merlinic Crackows",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        feet=gear.Agwu_Feet,
        ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        -- feet="Volte Gaiters",
    })

    sets.midcast.Death = {
        main=gear.Grioavolr_MB, --5
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Merl_MB_Body, --10
        hands=gear.Amalric_D_Hands, --(5)
        legs=gear.Amalric_A_Legs,
        feet="Merlinic Crackows", --11
        neck="Mizu. Kubikazari", --10
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        ring2="Metamor. Ring +1",
        back=gear.BLM_Death_Cape, --5
        waist="Sacro Cord",
    }

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
        main=gear.Grioavolr_MB,
        sub="Enki Strap",
        head=gear.Amalric_A_Head,
        waist="Acuity Belt +1",
    })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Marin Staff +1",
        sub="Enki Strap",
        ammo="Sroda Tathlum",
        head=gear.Relic_Head,
        body=gear.Relic_Body,
        hands=gear.Relic_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    }

  

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        main="Marin Staff +1",
        sub="Khonsu",
        ammo="Pemphredo Tathlum",
        legs="Merlinic Shalwar",
        neck="Sanctity Necklace",
        waist="Acuity Belt +1",
    })

    sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
        main="Marin Staff +1",
        sub="Khonsu",
        ammo="Pemphredo Tathlum",
        body="Spaekona's Coat +2",
        legs="Merlinic Shalwar",
        feet="Merlinic Crackows",
        neck="Erra Pendant",
    })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    }

    -- Idle sets

    sets.idle = {
        main="Malignance Pole",
        sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head=gear.Agwu_Head,
        body="Shamash Robe",
        hands="Volte Gloves",
        legs="Assid. Pants +1",
        feet=gear.Agwu_Feet,
        neck="Sibyl Scarf",
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BLM_MAB_Cape,
        waist="Carrier's Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        main="Malignance Pole",
        sub="Khonsu",
        ammo="Staunch Tathlum +1", --3/3
        head="Volte Beret",
        body="Shamash Robe", --8/8
        hands="Volte Gloves",
        feet=gear.Agwu_Feet,
        neck="Loricate Torque +1", --6/6
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
    })

    sets.idle.ManaWall = {
        body="Shamash Robe",
        feet="Wicce Sabots +1",
        back=gear.BLM_Death_Cape,
    }

    sets.idle.Town = set_combine(sets.idle, {
        main="Marin Staff +1",
        sub="Khonsu",
        ammo="Sroda Tathlum";
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Relic_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = { feet="Herald's Gaiters" }
    sets.latent_refresh = { waist="Fucho-no-obi" }
    -- sets.latent_dt = { ear2="Sorcerer's Earring" }

    sets.magic_burst = {
        main="Marin Staff +1",
        sub="Enki Strap",
        head="Ea Hat +1", --7/(7)
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        body="Ea Houppe. +1", --9/(9)
        hands=gear.Amalric_D_Hands,
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back=gear.BLM_MAB_Cape, --5
        waist="Acuity Belt +1",
        legs="Ea Slops +1", --8/(8)
        feet=gear.Agwu_Feet,
    }

    sets.magic_burst.Resistant = {
        feet=gear.Relic_Feet, --11
    }

    -- Death Sets

    sets.idle.DeathMode = {
        -- main=gear.Lathi_MAB,
        main=gear.Grioavolr_MB,
        sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        -- body="Rosette Jaseran +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Amalric_A_Legs,
        feet=gear.Nyame_Feet,
        neck="Sanctity Necklace",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        ring2="Defending Ring",
        back=gear.BLM_Death_Cape,
        waist="Shinjutsu-no-Obi +1",
    }

    sets.precast.FC.DeathMode = {
        ammo="Sapience Orb",
        head=gear.Amalric_A_Head, --11
        -- body="Rosette Jaseran +1",
        body="Zendik Robe", --14
        hands="Agwu's Gages", --6
        -- legs="Volte Brais", --8 
        feet=gear.Amalric_D_Feet, --6
        -- neck="Orunmila's Torque", --5
        neck="Baetyl Pendant",
        ear1="Etiolation Earring", --1
        ear2="Loquacious Earring", --2
        ring1="Mephitas's Ring +1",
        ring2="Weather. Ring", --5
        back="Bane Cape", --4
        waist="Embla Sash",
    }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        main="Marin Staff +1",
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Amalric_A_Body,
        hands=gear.Amalric_D_Hands,
        legs=gear.Amalric_A_Legs,
        feet=gear.Amalric_D_Feet,
        waist="Acuity Belt +1",
        ring1="Mephitas's Ring +1",
        ring2="Archon Ring",
        back=gear.BLM_Death_Cape,
    })

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = {
        head="Blistering Sallet +1",
        body=gear.Agwu_Body,
        hands="Gazu Bracelets +1",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sanctity Necklace",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back="Relucent Cape",
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.DarkAffinity = { head="Pixie Hairpin +1",ring2="Archon Ring" }
    sets.Obi = { waist="Hachirin-no-Obi" }

    sets.Xoanon = { main="Xoanon", sub="Khonsu" }
    sets.Malevolence = { main=gear.Malevolence_A, sub="Ammurapi Shield"}
    sets.DefaultShield = { sub="Ammurapi Shield" }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end

    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
            equip(sets.Obi)
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
        elseif spell.element == world.day_element and spell.element == world.weather_element then
            equip(sets.Obi)
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
        elseif spell.element == world.day_element or spell.element == world.weather_element then
            equip(sets.Obi)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
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
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            --send_command('gs enable all')
            equip(sets.precast.JA['Mana Wall'])
            --send_command('gs disable all')
        else
            --send_command('gs enable all')
            handle_equipping_gear(player.status)
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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
    check_weaponset()
end

-- -- latent DT set auto equip on HP% change
--     windower.register_event('hpp change', function(new, old)
--         if new<=25 then
--             equip(sets.latent_dt)
--         end
--     end)


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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if player.hpp <= 25 then
        idleSet = set_combine(idleSet, sets.latent_dt)
    end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
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
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    check_weaponset()
    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end

    return defenseSet
end


-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.DeathMode.value then
        msg = msg .. ' Death: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local aspirs = S{'Aspir','Aspir II','Aspir III'}

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if aspirs:contains(spell.name) then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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
    end
)