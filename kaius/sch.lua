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
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+H ]           Cycle Helix Mode
--              [ WIN+R ]           Cycle Regen Mode
--              [ WIN+S ]           Toggle Storm Surge
--
--  Abilities:  
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+[ ]          Rapture/Ebullience
--              [ CTRL+] ]          Altruism/Focalization
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+] ]           Perpetuance
--              [ ALT+; ]           Penury/Parsimony
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
--              gs c scholar power          Rapture                     Ebullience
--              gs c scholar duration       Perpetuance
--              gs c scholar accuracy       Altruism                    Focalization
--              gs c scholar enmity         Tranquility                 Equanimity
--              gs c scholar skillchain                                 Immanence
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
    info.addendumNukes = S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
        "Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V"}

    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
    state.Weather = M{['description']='Weather',
    "Aurorastorm II", "Thunderstorm II", "Hailstorm II", 'Firestorm II', 'Windstorm II',
    "Rainstorm II", "Sandstorm II", "Voidstorm II"}

    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}

    state.Buff.Doom = false

    update_active_strategems()

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    degrade_array = {
        ['Aspirs'] = {'Aspir','Aspir II'}
    }
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Seidr', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.StormSurge = M(false, 'Stormsurge')

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    gear.Artifact_Head = { name= "Academic's Mortarboard +3" }
    gear.Artifact_Body = { name= "Academic's Gown +2" }
    gear.Artifact_Hands = { name= "Academic's Bracers +2" }
    gear.Artifact_Legs = { name= "Academic's Pants +1" }
    gear.Artifact_Feet = { name= "Academic's Loafers +3" }

    gear.Relic_Head = { name= "Pedagogy Mortarboard +3" }
    gear.Relic_Body = { name= "Pedagogy Gown +3" }
    gear.Relic_Hands = { name= "Pedagogy Bracers +3" }
    gear.Relic_Legs = { name= "Pedagogy Pants +3" }
    gear.Relic_Feet = { name= "Pedagogy Loafers +3" }

    gear.Empyrean_Head = { name= "Arbatel Bonnet +3" }
    gear.Empyrean_Body = { name= "Arbatel Gown +3" }
    gear.Empyrean_Hands = { name= "Arbatel Bracers +3" }
    gear.Empyrean_Legs = { name= "Arbatel Pants +3" }
    gear.Empyrean_Feet = { name= "Arbatel Loafers +3" }

    gear.SCH_MAB_Cape = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Mag. Evasion+15',}}
    gear.SCH_REG_Cape = { name="Bookworm's Cape", augments={'INT+1','MND+3','Helix eff. dur. +13','"Regen" potency+10',}}

    send_command('bind !s input /ja Sublimation <me>')
    send_command('bind !e input /ja Enlightenment <me>')
    send_command('bind !m input /ja "Modus Veritas" <t>')

    send_command('bind !p input /ma "Protect V" <stpc>')
    send_command('bind !o input /ma "Shell V" <stpc>')
    send_command('bind !i input /ma "Phalanx" <me>')
    send_command('bind !u input /ma "Aquaveil" <me>')

    send_command('bind !h input /ma "Haste" <stpc>')
    send_command('bind !f input /ma "Flurry" <stpc>')
    send_command('bind !g input /ma "Gravity" <t>')
    send_command('bind !b input /ma "Bind" <t>')
    
    send_command('bind !- gs c scholar light')
    send_command('bind != gs c scholar dark')

    send_command('bind ![ gs c scholar power')
    send_command('bind !] gs c scholar accuracy')

    send_command('bind ^[ gs c scholar aoe')
    send_command('bind ^] gs c scholar duration')

    send_command('bind ^; gs c scholar speed')   
    send_command('bind !; gs c scholar cost')

    send_command('bind @q gs c toggle MagicBurst')
    send_command('bind @r gs c cycle RegenMode')
    send_command('bind @s gs c toggle StormSurge')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !insert gs c cycleback Weather')
    send_command('bind !delete gs c cycle Weather')
    send_command('bind !home gs c cycleback BarElement')
    send_command('bind !end gs c cycle BarElement')
    send_command('bind !pageup gs c cycleback BarStatus')
    send_command('bind !pagedown gs c cycle BarStatus')

    -- ALT + Numpad ===> Enfeebles --
    send_command('bind !numpad7 input /ma "Paralyze" <t>')
    send_command('bind !numpad8 input /ma "Slow" <t>')
    send_command('bind !numpad9 input /ma "Silence" <t>')  
    send_command('bind !numpad5 input /ma "Distract" <t>')
    send_command('bind !numpad6 input /ma "Frazzle" <t>')
    send_command('bind !numpad2 input /ma "Blind" <t>')
    send_command('bind !numpad3 input /ma "Poison II" <t>')
    
     -- CTRL + Numpad ===> SelfSC --
     send_command('bind ^numpad7 input /gs c skillchain fusion')
     send_command('bind ^numpad8 input /gs c skillchain distortion')
     send_command('bind ^numpad9 input /gs c skillchain fragmentation')

     send_command('bind ^numpad4 input /gs c skillchain scission')
     send_command('bind ^numpad5 input /gs c skillchain reverberation')
     send_command('bind ^numpad6 input /gs c skillchain detonation')
     send_command('bind ^numpad1 input /gs c skillchain liquefaction')
     send_command('bind ^numpad2 input /gs c skillchain induration')
     send_command('bind ^numpad3 input /gs c skillchain impaction')
     send_command('bind ^numpad0 input /gs c skillchain gravitation')

 

    if player.sub_job == 'RDM' then
        send_command('bind !y input /ja "Convert" <me>')
    end

    
    include('Global-Binds.lua')

    set_macro_page(1, 20)
    send_command('wait 2; input /lockstyleset 20')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !s') -- Sub
    send_command('unbind !e') -- Enlight
    send_command('unbind !m') -- Modus

    send_command('unbind !p') -- Prot
    send_command('unbind !o') -- Shell
    send_command('unbind !i') -- Phalanx
    send_command('unbind !u') -- Aquaveil
    send_command('unbind !y') -- Convert
    send_command('unbind !h') -- Haste
    send_command('unbind !f') -- Flurry
    send_command('unbind !g') -- Gravity
    send_command('unbind !b') -- Bind
    send_command('unbind !c') -- Convert

    send_command('unbind ^`') -- Imm
    send_command('unbind !`') -- MB Mode

    send_command('unbind !-') -- LA
    send_command('unbind !=') -- DA

    send_command('unbind ^[') -- power
    send_command('unbind ^]') -- acc

    send_command('unbind ![') -- aoe
    send_command('unbind !]') -- dur

    send_command('unbind ^;') -- speed
    send_command('unbind !;') -- cost

    send_command('unbind @q') -- MB mode
    send_command('unbind @h') -- helix mode
    send_command('unbind @r') -- regen mode
    send_command('unbind @s') -- stormsurge mode
    send_command('unbind @w') -- lock weapon mode
end



-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Tabula Rasa'] = {legs=gear.Relic_Legs}
    sets.precast.JA['Enlightenment'] = {body=gear.Relic_Body}
    
    sets.precast.JA['Sublimation'] = {
        main="Musa",
        sub="Enki Strap",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Artifact_Legs,
        -- feet="Skaoi Boots",
        neck="Unmoving Collar +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1="Gelatinous Ring +1",
        ring2="Eihwaz Ring",
        back="Moonlight Cape",
        waist="Eschan Stone",
    }

    -- Fast cast sets for spells
    sets.precast.FC = {
    --    /RDM --20
        main="Musa", --10
        ammo="Sapience Orb", --2
        head=gear.Amalric_A_Head, --11
        body="Pinga Tunic +1", --15
        hands=gear.Artifact_Hands, --9
        -- legs="Volte Brais", --8
        legs=gear.Agwu_Legs, -- 7
        feet=gear.Relic_Feet, --8
        neck="Baetyl Pendant", --4
        ear1="Malignance Earring", --4
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Weather. Ring", --4/(3)
        back="Fi Follet Cape +1", --10
        waist="Embla Sash", --5
    } --93

     sets.precast.FC.Grimoire = {
        head=gear.Relic_Head, --13 
        feet=gear.Artifact_Feet --10
    } -- 93 - 11 - 8 = 74 + (23) = 97.

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash"
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet=gear.Kaykaus_B_Feet, --7
        ear1="Mendi. Earring", --5
        ring1="Lebeche Ring", --(2)
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Twilight Cloak", waist="Shinjutsu-no-Obi +1"})
    
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield"
    })

    sets.precast.Storm = set_combine(sets.precast.FC, {
        ring2=gear.Stikini_2,
    })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Epaminondas's Ring",
        ring2="Rufescent Ring",
        back=gear.SCH_MAB_Cape,
        waist="Orpheus Sash",
    }

    sets.precast.WS['Cataclysm'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Epaminondas's Ring",
        ring2="Archon Ring",
        back=gear.SCH_MAB_Cape,
        waist="Orpheus Sash",
    }

      sets.precast.WS['Aeolian Edge'] = {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back=gear.SCH_MAB_Cape,
        waist="Orpheus Sash",
    }

    sets.precast.WS['Omniscience'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Relic_Body,
        legs=gear.Relic_Legs,
        feet="Merlinic Crackows",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring2="Archon Ring",
        back=gear.SCH_MAB_Cape,
        waist="Sacro Cord",
    })


    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Amalric_A_Body,
        hands=gear.Kaykaus_D_Hands,
        legs=gear.Amalric_A_Legs,
        feet=gear.Kaykaus_B_Feet,
        -- neck="Orunmila's Torque",
        ear1="Loquacious Earring",
        ear2="Etiolation Earring",
        ring1="Mephitas's Ring +1",
        ring2="Metamor. Ring +1",
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
    } -- Max MP


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        main="Musa", --25
        sub="Khonsu", --0/(-5)
        ammo="Staunch Tathlum +1",
        head=gear.Kaykaus_B_Head, --11(+2)/(-6)
        body=gear.Empyrean_Body, --(-28)
        hands=gear.Relic_Hands, --(+3)/(-7)
        legs=gear.Kaykaus_A_Legs, --11(+2)/(-6)
        feet=gear.Kaykaus_B_Feet, --11(+2)/(-12)
        neck="Loricate Torque +1",
        ear1="Mendicant's Earring",
        ear2="Magnetic Earring",
        ring1="Mephitas's Ring +1", --3/(-5)
        ring2="Gelatinous Ring +1",
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
    }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff", --10
        waist="Hachirin-no-Obi",
        back="Twilight Cape",
    })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        neck="Argute Stole +2",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.StatusRemoval = {
        main="Musa",
        sub="Khonsu", --0/(-5)
        head="Vanya Hood",
        body="Vanya Robe",
        hands=gear.Relic_Hands,
        legs=gear.Artifact_Legs,
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        waist="Bishop's Sash",
    }

    sets.midcast.Cursna = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head="Vanya Hood",
        -- hands="Hieros Mittens",
        --feet="Gende. Galosh. +1",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        body=gear.Relic_Body,
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        back="Oretan. Cape +1",
        legs=gear.Artifact_Legs,
        feet="Vanya Clogs",
    }

    sets.midcast['Enhancing Magic'] = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Telchine_ENH_Head,
        body=gear.Relic_Body,
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
        body=gear.Relic_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Musa",
        sub="Khonsu", --0/(-5)
        head=gear.Empyrean_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        back=gear.SCH_MAB_Cape,
        back=gear.SCH_REG_Cape,
    })

    sets.midcast.RegenDuration = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Telchine_ENH_Head,
        back=gear.SCH_MAB_Cape,
    })

    sets.midcast.Haste = sets.midcast.EnhancingDuration

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head,
        waist="Gishdubar Sash",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        -- main="Vadose Rod",
        -- sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        head=gear.Amalric_A_Head,
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring1="Freke Ring",
        waist="Emphatikos Rope",
    })

    sets.midcast.Storm = sets.midcast.EnhancingDuration

    sets.midcast.Stormsurge = set_combine(sets.midcast.Storm, {feet=gear.Relic_Feet})

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    -- Custom spell classes
    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=empty;
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",
        waist="Luminary Sash",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        sub="Ammurapi Shield",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        legs="Chironic Hose",
        waist="Acuity Belt +1",
    })

    sets.midcast.ElementalEnfeeble = sets.midcast.Enfeebles

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Artifact_Feet,
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast.Kaustra = {
        main="Bunzi's Rod", --10
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body=gear.Agwu_Body, --10
        hands=gear.Amalric_D_Hands, --(5)
        legs="Mallquis Trews +2", --6
        feet=gear.Amalric_D_Feet, --11
        neck="Argute Stole +2", --10
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Archon Ring",
        back=gear.SCH_MAB_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        feet=gear.Agwu_Feet,
        waist="Fucho-no-obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
        back=gear.SCH_MAB_Cape,
    })

    -- Elemental Magic
    sets.midcast['Elemental Magic'] = {
        main="Marin Staff +1",
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head=gear.Relic_Head,
        body=gear.Amalric_A_Body,
        hands=gear.Amalric_D_Hands,
        legs=gear.Amalric_A_Legs,
        feet=gear.Amalric_D_Feet,
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.SCH_MAB_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast['Elemental Magic'].Seidr = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Pemphredo Tathlum",
        body="Seidr Cotehardie",
        legs=gear.Relic_Legs,
        neck="Erra Pendant",
        waist="Acuity Belt +1",
    })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Pemphredo Tathlum",
        -- head="Merlinic Hood",
        -- legs="Merlinic Shalwar",
        neck="Erra Pendant",
        waist="Sacro Cord",
    })

    sets.midcast.Helix = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        -- sub="Culminus", --Technically better non MB
        ammo="Ghastly Tathlum +1",
        head=gear.Agwu_Head,
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        body=gear.Agwu_Body,
        hands=gear.Amalric_D_Hands,
        ring1="Freke Ring",
        ring2="Mallquis Ring",
        back=gear.SCH_MAB_Cape,
        waist="Acuity Belt +1",
        legs=gear.Agwu_Legs,
        feet=gear.Amalric_D_Feet,
    }

    sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
        head="Pixie Hairpin +1",
        ring2="Archon Ring",
    })

    sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {
        main="Daybreak",
        sub="Ammurapi Shield",
        ring2="Weather. Ring"
    })

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        main="Malignance Pole",
        sub="Khonsu",
        ammo="Homiliary",
        head="Volte Beret",
        body=gear.Empyrean_Body,
        hands="Volte Gloves",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.SCH_MAB_Cape,
        waist="Carrier's Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        main="Malignance Pole",
        sub="Khonsu",
        ammo="Staunch Tathlum +1", --3/3
        head="Volte Beret",
        body=gear.Empyrean_Body, --10/0
        -- hands="Gende. Gages +1", --4/4
        -- feet="Volte Gaiters",
        neck="Loricate Torque +1", --6/6
        ear1="Etiolation Earring",
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
    })

    sets.idle.Town = set_combine(sets.idle, {
        main="Musa",
        sub="Khonsu", --0/(-5)
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Argute Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back=gear.SCH_MAB_Cape,
        waist="Acuity Belt +1",
    })

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        sub="Mensch Strap +1",
        waist="Shinjutsu-no-Obi +1",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
    sets.Kiting = { feet="Herald's Gaiters" }
    sets.latent_refresh = { waist="Fucho-no-obi" }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        head="Blistering Sallet +1",
        body=gear.Nyame_Body,
        hands="Gazu Bracelets +1",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Crep. Earring",
        ear2="Telos Earring",
        ring1="Hetairoi Ring",
        ring2=gear.Chirich_2,
        back=gear.SCH_MAB_Cape,
        waist="Windbuffet Belt +1",

    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.magic_burst = {
        main="Bunzi's Rod", --10
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=gear.Relic_Head, --(4)
        -- head=gear.Agwu_Head, --7
        neck="Argute Stole +2", --10
        ear1="Malignance Earring",
        ear2="Regal Earring",
        body=gear.Agwu_Body, --10
        hands=gear.Amalric_D_Hands, --(6)
        ring1="Freke Ring",
        ring2="Mujin Band", --(5)
        back=gear.SCH_MAB_Cape,
        waist="Acuity Belt +1",
        legs=gear.Agwu_Legs, --9
        feet=gear.Empyrean_Feet, --6
    } -- 45/15

    --sets.buff['Ebullience'] = {head=gear.Empyrean_Head}
    sets.buff['Rapture'] = {head=gear.Empyrean_Head}
    sets.buff['Perpetuance'] = {hands=gear.Empyrean_Hands}
    sets.buff['Immanence'] = {hands=gear.Empyrean_Hands}
    sets.buff['Penury'] = {legs=gear.Empyrean_Legs}
    sets.buff['Parsimony'] = {legs=gear.Empyrean_Legs}
    sets.buff['Celerity'] = {feet=gear.Relic_Feet}
    sets.buff['Alacrity'] = {feet=gear.Relic_Feet}
    sets.buff['Klimaform'] = {feet=gear.Empyrean_Feet}

    sets.buff.FullSublimation = {
       head=gear.Artifact_Head, --4
       body=gear.Relic_Body, --5
       ear1="Savant's Earring", --1
       waist="Embla Sash", --5
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.LightArts = { 
        legs=gear.Artifact_Legs, 
        feet=gear.Artifact_Feet 
    }

    sets.DarkArts = { 
        body=gear.Artifact_Body, 
        feet=gear.Artifact_Feet 
    }

    sets.Obi = { waist="Hachirin-no-Obi" }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"])) or
        (spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"])) then
        equip(sets.precast.FC.Grimoire)
    elseif spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the general midcast() is done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if spellMap == "Helix" then
            equip(sets.midcast['Elemental Magic'])
            if spell.english:startswith('Lumino') then
                equip(sets.midcast.LightHelix)
            elseif spell.english:startswith('Nocto') then
                equip(sets.midcast.DarkHelix)
            else
                equip(sets.midcast.Helix)
            end
        end
        if buffactive['Klimaform'] and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end
    if spell.action_type == 'Magic' then
        apply_grimoire_bonuses(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Enfeebling Magic' then
        if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then
            equip(sets.LightArts)
        elseif spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then
            equip(sets.DarkArts)
        end
    end
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
        if spell.english == "Impact" then
            equip(sets.midcast.Impact)
        end
    end
    if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
        if (spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element])) and spellMap ~= 'Helix' then
            equip(sets.Obi)
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
       elseif (spell.element == world.day_element and spell.element == world.weather_element) and spellMap ~= 'Helix' then
            equip(sets.Obi)
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
       elseif (spell.element == world.day_element or spell.element == world.weather_element) and spellMap ~= 'Helix' then
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
        if state.Buff.Perpetuance then
            equip(sets.buff['Perpetuance'])
        end
        if spellMap == "Storm" and state.StormSurge.value then
            equip (sets.midcast.Stormsurge)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" then
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
    if buff == "Sublimation: Activated" then
        handle_equipping_gear(player.status)
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
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_rings()
    check_moving()
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_active_strategems()
    update_sublimation()
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        elseif spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        end
    end
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.FullSublimation)
    end
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
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
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
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'skillchain' then
        sch_skillchain(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'weather' then
        send_command('@input /ma "'..state.Weather.value..'" <me>')
    end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

-- Reset the state vars tracking strategems.
function update_active_strategems()
    state.Buff['Ebullience'] = buffactive['Ebullience'] or false
    state.Buff['Rapture'] = buffactive['Rapture'] or false
    state.Buff['Perpetuance'] = buffactive['Perpetuance'] or false
    state.Buff['Immanence'] = buffactive['Immanence'] or false
    state.Buff['Penury'] = buffactive['Penury'] or false
    state.Buff['Parsimony'] = buffactive['Parsimony'] or false
    state.Buff['Celerity'] = buffactive['Celerity'] or false
    state.Buff['Alacrity'] = buffactive['Alacrity'] or false

    state.Buff['Klimaform'] = buffactive['Klimaform'] or false
end

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

-- Equip sets appropriate to the active buffs, relative to the spell being cast.
function apply_grimoire_bonuses(spell, action, spellMap)
    if state.Buff.Perpetuance and spell.type =='WhiteMagic' and spell.skill == 'Enhancing Magic' then
        equip(sets.buff['Perpetuance'])
    end
    if state.Buff.Rapture and (spellMap == 'Cure' or spellMap == 'Curaga') then
        equip(sets.buff['Rapture'])
    end
    if spell.skill == 'Elemental Magic' and spellMap ~= 'ElementalEnfeeble' then
        if state.Buff.Ebullience and spell.english ~= 'Impact' then
            equip(sets.buff['Ebullience'])
        end
        if state.Buff.Immanence then
            equip(sets.buff['Immanence'])
        end
        if state.Buff.Klimaform and spell.element == world.weather_element then
            equip(sets.buff['Klimaform'])
        end
    end

    if state.Buff.Penury then equip(sets.buff['Penury']) end
    if state.Buff.Parsimony then equip(sets.buff['Parsimony']) end
    if state.Buff.Celerity then equip(sets.buff['Celerity']) end
    if state.Buff.Alacrity then equip(sets.buff['Alacrity']) end
end


function sch_skillchain(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use skillchains in town.')
        return
    end
	if not cmdParams[2] then
        add_to_chat(123,'No skillchain type given.')
        return
    end
	local sctype = cmdParams[2]:lower()
	if sctype == 'compression' then
		send_command('input /p [Compression][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "blizzard" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Compression][Dark];input /ma "noctohelix" <t>;')
	elseif sctype == 'detonation' then
		send_command('input /p [Detonation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "stone" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Detonation][Wind];input /ma "aero" <t>;')
	elseif sctype == 'impaction' then
		send_command('input /p [Impaction][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "water" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Impaction][Thunder];input /ma "thunder" <t>;')
	elseif sctype == 'induration' then
		send_command('input /p [Induration][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "water" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Induration][Ice];input /ma "blizzard" <t>;')
	elseif sctype == 'liquefaction' then
		send_command('input /p [Liquefaction][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "stone" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Liquefaction][Fire]; input /ma "fire" <t>;')
	elseif sctype == 'reverberation' then
		send_command('input /p [Reverberation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "stone" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Reverberation][Water];input /ma "water" <t>;')
	elseif sctype == 'scission' then
		send_command('input /p [Scission][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "fire" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Scission][Earth];input /ma "stone" <t>;')
	elseif sctype == 'transfixion' then
		send_command('input /p [Transfixion][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "noctohelix" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Transfixion][Light];input /ma "luminohelix" <t>;')
	elseif sctype == 'distortion' then
		send_command('input /p [Distortion][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "luminohelix" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Distortion][Water][Ice];input /ma "stone" <t>;')
	elseif sctype == 'fragmentation' then
		send_command('input /p [Fragmentation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "blizzard" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Fragmentation][Wind][Thunder];input /ma "water" <t>;')
	elseif sctype == 'fusion' then
		send_command('input /p [Fusion][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "fire" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Fusion][Fire][Light];input /ma "thunder" <t>;')
	elseif sctype == 'gravitation' then
		send_command('input /p [Gravitation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.0;input /ma "aero" <t>;pause 4.0;input /ja "Immanence" <me>;pause 2.0;input /p Closing [Gravitation][Stone][Dark];input /ma "noctohelix" <t>;')
	else
		add_to_chat(123,'Error: Unknown skillchain ['..sctype..']')
	end
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
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
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
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end


-- Gets the current number of available strategems based on the recast remaining
-- and the level of the sch.
function get_current_strategem_count()
    -- returns recast in seconds.
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]

    local maxStrategems = (player.main_job_level + 10) / 20

    local fullRechargeTime = 4*60

    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)

    return currentCharges
end

function refine_various_spells(spell, action, spellMap, eventArgs)
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.name:startswith('Aspir') then
            spell_index = table.find(degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
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

function check_rings()
    rings = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}

    if rings:contains(player.equipment.left_ring) then
        disable("left_ring")
    else
        enable("left_ring")
    end

    if rings:contains(player.equipment.right_ring) then
        disable("right_ring")
    else
        enable("right_ring")
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