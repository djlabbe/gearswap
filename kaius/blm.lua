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

    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II','Aspir III'}
     }
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

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder'}

    -- Additional local binds
    include('Global-Binds.lua') 

    send_command('bind !t input /ma "Stun" <t>')
    send_command('bind !` gs c toggle MagicBurst')
    send_command('bind @d gs c toggle DeathMode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !g input /ma "Gravity" <t>')
    send_command('bind !b input /ma "Bind" <t>')

    set_macro_page(1, 4)
    send_command('wait 2; input /lockstyleset 4')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !t')
    send_command('unbind !`')
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
        -- feet="Wicce Sabots +1",
        -- back=gear.BLM_Death_Cape,
    }

    sets.precast.JA.Manafont = {
        -- body="Arch. Coat +1"
    }

    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Vanya Hood", --10
        body="Zendik Robe", --13
        legs="Jhakri Slops +2", --3
        feet="Regal Pumps +1", --7
        ear1="Malignance Earring", --4
        ear2="Enchntr. Earring +1", --2
        ring1="Jhakri Ring", --4
        ring2="Weather. Ring", --4
        waist="Embla Sash", --5
        back="Fi Follet Cape +1", --10
    } --63

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear2="Mendi. Earring", --5
        ring2="Lebeche Ring", --(2)
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    -- sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.Storm = set_combine(sets.precast.FC, {ring2=gear.Stikini_2,})

    sets.precast.FC.DeathMode = {
        ammo="Ghastly Tathlum +1",
        head="Amalric Coif +1", --11
        body="Amalric Doublet +1",
        -- hands="Merlinic Dastanas", --6
        -- legs="Volte Brais", --8
        -- feet="Volte Gaiters", --6
        -- neck="Orunmila's Torque", --5
        -- ear1="Etiolation Earring", --1
        ear2="Loquacious Earring", --2
        ring1="Mephitas's Ring +1",
        ring2="Weather. Ring", --5
        -- back="Bane Cape", --4
        waist="Embla Sash",
    }

    -- sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        -- --ammo="Floestone",
        -- head="Jhakri Coronal +2",
        body="Jhakri Robe +2",
        hands="Jhakri Cuffs +2",
        legs=gear.Telchine_ENH_legs,
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Epaminondas's Ring",
        -- ring2="Shukuyu Ring",
        back="Relucent Cape",
        waist="Fotia Belt",
        }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Vidohunir'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        -- legs="Merlinic Shalwar",
        -- feet="Merlinic Crackows",
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        -- ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Archon Ring",
        -- back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    } -- INT

    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Ea Houppelande +1",
        legs="Amalric Slops +1",
        -- neck="Orunmila's Torque",
        ear1="Loquacious Earring",
        ear2="Barkarole Earring",
        ring1="Mephitas's Ring",
        ring2="Mephitas's Ring +1",     
        -- back="Bane Cape",
        waist="Shinjutsu-no-Obi",
    } -- Max MP


    ---- Midcast Sets ----

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        -- ammo="Esper Stone +1", --0/(-5)
        -- body="Vanya Robe",
        hands=gear.Telchine_ENH_hands, --10
        neck="Nodens Gorget", --5
        ear1="Mendi. Earring", --5
        -- ear2="Roundel Earring", --5
        ring1="Lebeche Ring", --3/(-5)
        -- ring2="Haoma's Ring",
        back="Tempered Cape +1", --6
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
        -- body="Vanya Robe",
        -- hands="Hieros Mittens",
        -- feet="Vanya Clogs",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
    })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
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
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
        waist="Embla Sash",
        }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
        })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head="Amalric Coif +1",
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
        head="Amalric Coif +1",
        hands="Regal Cuffs",
        -- ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        -- waist="Emphatikos Rope",
    })

    sets.midcast.MndEnfeebles = {
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

    -- sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.midcast['Dark Magic'] = {
        -- main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",
        body="Ea. Houppe +1",
        -- hands="Raetic Bangles +1",
        legs="Ea Slops +1",
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}},
        neck="Erra Pendant",
        ear1="Malignance Earring",
        -- ear2="Mani Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back=gear.BLM_MAB_Cape,
        -- waist="Acuity Belt +1",
        }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        feet="Merlinic Crackows",
        -- ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        waist="Fucho-no-obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    -- sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
    --     feet="Volte Gaiters",
    -- })

    sets.midcast.Death = {
        -- main=gear.Grioavolr_MB, --5
        -- sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        -- body=gear.Merl_MB_body, --10
        hands="Amalric Gages +1", --(5)
        legs="Amalric Slops +1",
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}},
        -- neck="Mizu. Kubikazari", --10
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Metamor. Ring +1",
        ring2="Mephitas's Ring +1",       
        -- back=gear.BLM_Death_Cape, --5
        -- waist="Sacro Cord",
        }

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
        -- main=gear.Grioavolr_MB,
        -- sub="Enki Strap",
        -- head="Amalric Coif +1",
        -- waist="Acuity Belt +1",
        })

    -- Elemental Magic sets

    sets.midcast['Elemental Magic'] = {
        main="Marin Staff +1",
        sub="Elan Strap +1",
        ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
        head=empty;
        body={ name="Cohort Cloak +1", augments={'Path: A',}},
        hands=gear.Amalric_D_hands,
        legs=gear.Amalric_A_legs,
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}},
        neck={ name="Src. Stole +2", augments={'Path: A',}},
        waist="Orpheus's Sash",
        left_ear="Malignance Earring",
        right_ear="Barkaro. Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Shiva Ring +1",
        back="Seshaw Cape",
    }

    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        -- main=gear.Grioavolr_MB,
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        legs="Amalric Slops +1",
        -- feet="Merlinic Crackows",
        -- back=gear.BLM_Death_Cape,
    })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        -- sub="Khonsu",
        ammo="Pemphredo Tathlum",
        -- legs="Merlinic Shalwar",
        neck="Sanctity Necklace",
        -- waist="Sacro Cord",
    })

    -- sets.midcast['Elemental Magic'].Spaekona = set_combine(sets.midcast['Elemental Magic'], {
    --     sub="Khonsu",
    --     ammo="Pemphredo Tathlum",
    --     body="Spaekona's Coat +2",
    --     legs="Merlinic Shalwar",
    --     feet="Merlinic Crackows",
    --     neck="Erra Pendant",
    --     })

    sets.magic_burst = {
        ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
        head="Ea Hat +1",
        body="Ea Houppe. +1",
        hands=gear.Amalric_D_hands,
        legs="Ea Slops +1",
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}},
        neck={ name="Src. Stole +2", augments={'Path: A',}},
        waist="Orpheus's Sash",
        left_ear="Malignance Earring",
        right_ear="Barkaro. Earring",
        left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
        right_ring="Mujin Band",
        back="Seshaw Cape",
    }

    sets.magic_burst.Resistant = {
        -- feet="Merlinic Crackows", --11
        -- neck="Sanctity Necklace",
    }


    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    }

    -- Idle sets
    sets.idle = {
        main="Malignance Pole",
        sub="Mensch Strap",
        ammo="Staunch Tathlum +1",
        head="Nyame Helm",
        body="Jhakri Robe +2",
        hands="Nyame Gauntlets",
        legs={ name="Assid. Pants +1", augments={'Path: A',}},
        feet="Nyame Sollerets",
        neck="Sibyl Scarf",
        waist="Slipor Sash",
        left_ear="Infused Earring",
        right_ear="Eabani Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Seshaw Cape",
    }

    sets.idle.DT = {
        ammo="Staunch Tathlum +1",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
        body="Jhakri Robe +2",
        hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
        legs="Ea Slops +1",
        feet={ name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}},
        neck="Warder's Charm +1",
        waist="Carrier's Sash",
        left_ear="Eabani Earring",
        right_ear="Assuage Earring",
        left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
        right_ring="Defending Ring",
        back="Moonbeam Cape",
     }

    sets.idle.ManaWall = {
        -- feet="Wicce Sabots +1",
        -- back=gear.BLM_Death_Cape,
    }

    sets.idle.DeathMode = {
        -- main=gear.Lathi_MAB,
        -- sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body="Amalric Doublet +1",
        hands="Amalric Gages +1",
        legs="Amalric Slops +1",
        -- feet="Merlinic Crackows",
        neck="Sanctity Necklace",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Mephitas's Ring +1",
        -- ring2="Mephitas's Ring",
        -- back=gear.BLM_Death_Cape,
        waist="Shinjutsu-no-Obi +1",
    }

    sets.idle.Town = set_combine(sets.idle, {
        feet="Herald's Gaiters",
    })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = { 
        feet="Herald's Gaiters" 
    }

    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.latent_dt = {
        -- ear2="Sorcerer's Earring"
    }



    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- Normal melee group

    sets.engaged = sets.idle

    -- sets.buff.Doom = {
    --     neck="Nicander's Necklace", --20
    --     ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
    --     ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
    --     waist="Gishdubar Sash", --10
    --     }

    sets.DarkAffinity = { 
        head="Pixie Hairpin +1", 
        -- ring2="Archon Ring" 
    }

    sets.Obi = {waist="Hachirin-no-Obi"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- if spell.action_type == 'Magic' and state.DeathMode.value then
    --     eventArgs.handled = true
    --     equip(sets.precast.FC.DeathMode)
    --     if spell.english == "Impact" then
    --         equip(sets.precast.FC.Impact.DeathMode)
    --     end
    -- end
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    -- if buffactive['Mana Wall'] then
    --     equip(sets.precast.JA['Mana Wall'])
    -- end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    -- if spell.name == 'Impact' then
    --     equip(sets.precast.FC.Impact)
    -- end
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
            --if state.CastingMode.value == "Resistant" then
                --equip(sets.magic_burst.Resistant)
            --else
                equip(sets.magic_burst)
            --end
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
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

    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
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
end

-- latent DT set auto equip on HP% change
    windower.register_event('hpp change', function(new, old)
        if new<=25 then
            equip(sets.latent_dt)
        end
    end)


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

    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
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
end

windower.register_event('zone change',
    function()
      
    end
)
