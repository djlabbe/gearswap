-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+R ]           Toggle Regen Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ CTRL+[ ]          Divine Seal
--              [ CTRL+] ]          Divine Caress
--              [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Spells:     [ ALT+O ]           Regen IV
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Black Halo
--              [ CTRL+Numpad8 ]    Hexa Strike
--              [ CTRL+Numpad9 ]    Realmrazer
--              [ CTRL+Numpad1 ]    Flash Nova
--              [ CTRL+Numpad0 ]    Mystic Boon
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--              Addendum Commands:
--              Shorthand versions for each strategem type that uses the version appropriate for
--              the current Arts.
--                                          Light Arts                    Dark Arts
--                                          ----------                  ---------
--              gs c scholar light          Light Arts/Addendum
--              gs c scholar dark                                       Dark Arts/Addendum
--              gs c scholar cost           Penury                      Parsimony
--              gs c scholar speed          Celerity                    Alacrity
--              gs c scholar aoe            Accession                   Manifestation
--              gs c scholar addendum       Addendum: White             Addendum: Black


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
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false

    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    lockstyleset = 1

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'MEva')

    state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}

    state.WeaponLock = M(false, 'Weapon Lock')

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind !s input /ja Sublimation <me>')
    send_command('bind !d input /ja "Divine Seal" <me>')
    send_command('bind !` input /ja "Afflatus Solace" <me>')
    send_command('bind ^` input /ja "Afflatus Misery" <me>')
    send_command('bind !p input /ma "Protectra V" <stpc>')
    send_command('bind !o input /ma "Shellra V" <stpc>')
    send_command('bind !- gs c scholar light')
    send_command('bind != gs c scholar dark')
    send_command('bind ^[ gs c scholar aoe')
    send_command('bind numlock gs c scholar aoe')
    send_command('bind ^; gs c scholar speed')   
    send_command('bind !; gs c scholar cost')
    send_command('bind !insert gs c cycleback BoostSpell')
    send_command('bind !delete gs c cycle BoostSpell')
    send_command('bind !home gs c cycleback BarElement')
    send_command('bind !end gs c cycle BarElement')
    send_command('bind !pageup gs c cycleback BarStatus')
    send_command('bind !pagedown gs c cycle BarStatus')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle RegenMode')
    send_command('bind !h input /ma "Haste" <stpc>')

    set_macro_page(1, 3) -- page,set
    send_command('wait 2; input /lockstyleset 3')
end

function user_unload()
    send_command('unbind !s')
    send_command('unbind !d')
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !p')
    send_command('unbind !o')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^[')
    send_command('unbind numlock gs c scholar aoe')
    send_command('unbind ^;')   
    send_command('unbind !;')
    send_command('unbind ^!nsert')
    send_command('unbind !delete')
    send_command('unbind !home')
    send_command('unbind !end')
    send_command('unbind !pageup')
    send_command('unbind !pagedown')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind !h')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    -- Fast cast sets for spells

    sets.precast.FC = {
        -- main="Marin Staff +1",--3
        main="Malignance Pole", -- 150HP
        ammo="Incantor Stone", --2
        head="Vanya Hood", --10
        neck="Cleric's Torque +2", --4
        -- ear1="Loquacious earring", --2
        ear1="Odnowa Earring +1",
        ear2="Malignance earring", --4
        body="Inyanga jubbah +2", --14
        hands="Volte gloves", --6
        left_ring="Weather. Ring", --5
        right_ring="Kishar Ring", --2
        back="Fi Follet Cape +1", --10
        waist="Shinjutsu-no-Obi +1", --5
        legs="Kaykaus Tights +1", -- 7
        feet="Regal Pumps +1", --4
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        -- ammo="Impatiens", --(2)
        -- head="Piety Cap +3", --15
        feet="Kaykaus Boots +1", --7
        left_ring="Weather. Ring", --5
        right_ring="Kishar Ring", --2
        -- back="Perimede Cape", --(4)
        waist="Shinjutsu-no-Obi +1", --5
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure


    -- Precast sets to enhance JAs
    --sets.precast.JA.Benediction = {}

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        -- --ammo="Floestone",
        -- head="Piety Cap +3",
        -- body="Piety Briault +3",
        -- hands="Piety Mitts +3",
        -- legs="Piety Pantaln. +3",
        -- feet="Piety Duckbills +2",
        -- neck="Fotia Gorget",
        -- ear1="Moonshade Earring",
        -- ear2="Ishvara Earring",
        -- ring1="Epaminondas's Ring",
        -- ring2="Shukuyu Ring",
        -- back=gear.WHM_WS_Cape,
        -- waist="Fotia Belt",
    }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        neck="Republican Platinum Medal",
    })

    -- sets.precast.WS['Hexa Strike'] = set_combine(sets.precast.WS, {
    --     head="Blistering Sallet +1",
    --     ring2="Begrudging Ring",
    --     back=gear.WHM_DA_Cape,
    --     })

    -- sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS, {
    --     ammo="Ghastly Tathlum +1",
    --     head=empty;
    --     body="Cohort Cloak +1",
    --     legs="Kaykaus Tights +1",
    --     })

    -- Midcast Sets

    sets.midcast.FC = sets.precast.FC

    sets.midcast.ConserveMP = {
        --main="Sucellus",
        --sub="Thuellaic Ecu +1",
        head="Vanya Hood",
        --body="Vedic Coat",
        --hands="Shrieker's Cuffs",
        --legs="Vanya Slops",
        feet="Kaykaus Boots +1",
        ear2="Mendi. Earring",
        back="Solemnity Cape",
        waist="Shinjutsu-no-Obi +1",
    }

    -- Cure sets

    sets.midcast.CureSolace = {
        main="Chatoyant Staff", --10(+20)
        sub="Enki Strap",
        ammo="Pemphredo Tathlum",
        head="Kaykaus Mitra +1", --11(+2)/(-6)
        neck="Clr. Torque +2", --10/(-25)
        ear1="Glorious Earring", -- (+2)/(-5)
        ear2="Nourishing earring +1",
        body="Ebers Bliaut +1",
        hands="Kaykaus Cuffs +1",
        legs="Ebers Pant. +1",
        feet="Kaykaus Boots +1", --11(+2)/(-12)    
        -- ring1="Lebeche Ring", --3/(-5)
        -- ring2="Mephitas's Ring +1",
        ring1="Gelatinous Ring +1",
        ring2="Menelaus's Ring",
        back=gear.WHM_Cure_Cape, --10
        waist="Shinjutsu-no-Obi +1",
      }

    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        ear2="Nourish. Earring +1", --7
        waist="Hachirin-no-Obi",
    })

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
        -- body="Theo. Briault +3", --0(+6)/(-6)
     })

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        hands="Kaykaus Cuffs +1", --11/(-6)
        ear2="Nourish. Earring +1", --7
        waist="Hachirin-no-Obi",
    })

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {
        -- body="Theo. Briault +3", --0(+6)/(-6)
        ring1="Metamor. Ring +1",
        ring2="Mephitas's Ring +1",
        waist="Luminary Sash",
        })

    sets.midcast.CuragaWeather = {
        -- body="Theo. Briault +3", --0(+6)/(-6)
        hands="Kaykaus Cuffs +1", --11/(-6)
        ring1="Metamor. Ring +1",
        ring2="Mephitas's Ring +1",
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    }

    --sets.midcast.CureMelee = sets.midcast.CureSolace

    sets.midcast.StatusRemoval = {
        -- main="Yagrush",
        -- sub="Chanter's Shield",
        head="Vanya Hood",
        body="Inyanga Jubbah +2",
        hands="Fanatic Gloves",
        legs="Aya. Cosciales +1",
        -- neck="Orunmila's Torque",
        ear1="Loquacious Earring",
        -- ear2="Etiolation Earring",
        ring1="Kishar Ring",
        ring2="Weather. Ring",
        back=gear.WHM_Cure_Cape,
        waist="Embla Sash",
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        -- main="Yagrush",
        -- sub="Chanter's Shield",
        body="Ebers Bliaut +1",
        -- hands="Fanatic Gloves", --15
        -- legs="Th. Pant. +3", --21
        -- feet="Vanya Clogs", --5
        --feet="Gende. Galosh. +1", --10
        neck="Debilis Medallion", --15
        ear1="Beatific Earring",
        -- ear2="Meili Earring",
        ring1="Haoma's Ring", --15
        ring2="Menelaus's Ring", --20
        back=gear.WHM_Cure_Cape,
        waist="Bishop's Sash",
    })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {neck="Clr. Torque +2"})

    -- 110 total Enhancing Magic Skill; caps even without Light Arts
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
        head="Inyanga Tiara +2",
        -- body="Piety Briault +3",
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Telchine_ENH_feet,
    })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        body=gear.Telchine_ENH_body,
        hands=gear.Telchine_ENH_hands,
        -- legs="Th. Pant. +3",
        -- feet="Theo. Duckbills +3",
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
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
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        -- waist="Emphatikos Rope",
    })

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet="Ebers Duckbills +1",
    })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        main="Beneficus",
        sub="Ammurapi Shield",
        head="Ebers Cap +1",
        body="Ebers Bliaut +1",
        hands="Ebers Mitts +1",
        -- legs="Piety Pantaln. +3",
        feet="Ebers Duckbills +1",
    })

    sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {
        feet="Ebers Duckbills +1"
    })


    sets.midcast['Divine Magic'] = {
        -- main="Yagrush",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        -- head="Theophany Cap +3",
        -- body="Theo. Briault +3",
        -- hands="Piety Mitts +3",
        legs=gear.Chironic_ENF_legs,
        -- feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        -- ear1="Digni. Earring",
        -- ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
        }

    sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {
        -- main="Daybreak",
        sub="Ammurapi Shield",
        head=empty;
        body="Cohort Cloak +1",
        hands="Fanatic Gloves",
        legs="Kaykaus Tights +1",
        neck="Sanctity Necklace",
        ear1="Malignance Earring",
        ring1="Freke Ring",
        ring2="Weather. Ring",
        waist="Refoccilation Stone",
    })

    -- sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['Dark Magic'] = {
        -- main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body="Theo. Briault +3",
        hands="Theophany Mitts +3",
        legs=gear.Chironic_ENF_legs,
        -- feet="Theo. Duckbills +3",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        -- ear2="Mani Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back="Aurist's Cape +1",
        waist="Fucho-no-Obi",
    }

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        -- main="Yagrush",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=empty;
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs=gear.Chironic_ENF_legs,
        feet="Regal pumps +1",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring2=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Luminary Sash",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        waist="Acuity Belt +1",
    })


    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Sets to return to when not performing an action.

    -- Resting sets
    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    }

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
        main="Malignance Pole",
        sub="Mensch Strap",
        ammo="Homiliary",
        head="Inyanga Tiara +2",
        body="Ebers Bliaut +1",
        hands="Volte Gloves",
        legs={ name="Assid. Pants +1", augments={'Path: A',}},
        feet="Inyan. Crackows +2",
        neck="Sibyl Scarf",
        ear1="Infused Earring",
        ear2="Eabani Earring",
        ring1=gear.Stikini_1,
        ring2="Inyanga Ring",
        back=gear.WHM_Cure_Cape,
        waist="Slipor Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        main="Malignance Pole", --20
        sub="Mensch Strap", --4
        ammo="Homiliary",
        head="Nyame Helm", --7
        body="Nyame Mail", --9
        hands="Nyame Gauntlets", --7
        feet="Nyame Sollerets", --7
        neck="Sibyl Scarf",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.WHM_Cure_Cape,
        waist="Slipor Sash",
    })

    sets.idle.MEva = set_combine(sets.idle.DT, {
        main="Malignance Pole",
        sub="Mensch Strap",
        ammo="Staunch Tathlum +1",
        head="Inyanga Tiara +2",
        body="Inyanga Jubbah +2",
        hands="Inyanga dastanas +2",
        legs="Inyanga Shalwar +2",
        feet="Inyan. Crackows +2",
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        -- ear2="Sanare Earring",
        ring1="Purity Ring",
        ring2="Inyanga Ring",
        back=gear.WHM_Cure_Cape,
        waist="Slipor Sash",
    })

    -- Defense sets

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Herald's Gaiters"}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- -- Basic set for if no TP weapon is defined.
    -- sets.engaged = {
    --     main="Yagrush",
    --     sub="Ammurapi Shield",
    --     head="Blistering Sallet +1",
    --     body="Ayanmo Corazza +2",
    --     hands=gear.Telchine_STP_hands,
    --     legs="Aya. Cosciales +2",
    --     feet=gear.Chironic_QA_feet,
    --     neck="Combatant's Torque",
    --     ear1="Cessance Earring",
    --     ear2="Telos Earring",
    --     ring1=gear.Chirich_1,
    --     ring2=gear.Chirich_2,
    --     back=gear.WHM_DA_Cape,
    --     waist="Windbuffet Belt +1",
    --     }

    -- sets.engaged.Acc = set_combine(sets.engaged, {
    --     hands="Gazu Bracelet +1",
    --     feet="Volte Boots",
    --     waist="Olseni Belt",
    --     })


    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Divine Caress'] = {hands="Ebers Mitts +1", back="Mending Cape"}
    -- sets.buff['Devotion'] = {head="Piety Cap +3"}
    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.Obi = {waist="Hachirin-no-Obi"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.english == "Paralyna" and buffactive.Paralyzed then
        -- no gear swaps if we're paralyzed, to avoid blinking while trying to remove it.
        eventArgs.handled = true
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
        if spellMap == "Regen" and state.RegenMode.value == 'Duration' then
            equip(sets.midcast.RegenDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    if buff == "Sublimation: Activated" then
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
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_sublimation()
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
              end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
              end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Yagrush" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

    return meleeSet
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.Sublimation)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local r_msg = state.RegenMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Regen: ' ..string.char(31,001)..r_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
    end

    gearinfo(cmdParams, eventArgs)
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- General handling of strategems in an Arts-agnostic way.
-- Format: gs c scholar <strategem>
function handle_strategems(cmdParams)
    -- cmdParams[1] == 'scholar'
    -- cmdParams[2] == strategem to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
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

function check_moving()
end

function check_gear()
end

windower.register_event('zone change',
    function()
      
    end
)