-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    SongMode may take one of three values: None, Placeholder
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
    res = require 'resources'
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false
    state.Buff.Doom = false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    elemental_ws = S{"Aeolian Edge"}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'Refresh')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}

    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Carnwenhan', 'Twashtar', 'Tauret', }
    state.WeaponLock = M(false, 'Weapon Lock')

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2

    -- gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
    gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}
    gear.Linos_TP = {name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +3',}}
    gear.Linos_STP = {name="Linos", augments={'Accuracy +16','Store TP +4','Quadruple Attack +3',}}
    gear.Linos_WS = {name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6'}}

    gear.Artifact_Head = { name= "Brioso Roundlet +3" }
    gear.Artifact_Body = { name= "Brioso Justaucorps +3" }
    gear.Artifact_Hands = { name= "Brioso Cuffs +2" }
    gear.Artifact_Legs = { name= "Brioso Cannions +2" }
    gear.Artifact_Feet = { name= "Brioso Slippers +3" }

    gear.Relic_Head = { name= "Bihu Roundlet +3" }
    gear.Relic_Body = { name= "Bihu Justaucorps +3" }
    gear.Relic_Hands = { name= "Bihu Cuffs +3" }
    gear.Relic_Legs = { name= "Bihu Cannions +3" }
    gear.Relic_Feet = { name= "Bihu Slippers +3" }

    gear.Empyrean_Head = { name= "Fili Calot +1" }
    gear.Empyrean_Body = { name= "Fili Hongreline +2" }
    gear.Empyrean_Hands = { name= "Fili Manchettes +1" }
    gear.Empyrean_Legs = { name= "Fili Rhingrave +1" }
    gear.Empyrean_Feet = { name= "Fili Cothurnes +1" }

    gear.BRD_Song_Cape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}} --*
    gear.BRD_TP_Cape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.BRD_WS1_Cape = { name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*
    gear.BRD_WS2_Cape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*

    send_command('bind !` gs c cycle SongMode')
    send_command('bind ^` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')
    send_command('bind !t input /ja "Troubadour" <me>')
    send_command('bind ^t input /ja "Tenuto" <me>')
    send_command('bind !m input /ja "Marcato" <me>')
    send_command('bind !n input /ja "Nightingale" <me>')
    send_command('bind !h input /ma "Horde Lullaby II" <t>')
    send_command('bind !g input /ma "Foe Lullaby II" <t>')

    send_command('bind !insert gs c cycleback Etude')
    send_command('bind !delete gs c cycle Etude')

    send_command('bind !home gs c cycleback Carol')
    send_command('bind !end gs c cycle Carol')

    send_command('bind !pageup gs c cycleback Threnody')
    send_command('bind !pagedown gs c cycle Threnody')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind @1  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon VI" <me>')
    send_command('bind @2  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon V" <me>')
    send_command('bind @3  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon IV" <me>')
    send_command('bind @4  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon III" <me>')
    send_command('bind @5  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon II" <me>')

    set_macro_page(1, 10)
    send_command('wait 2; input /lockstyleset 10')
    send_command('gs enable range')

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
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind !home')
    send_command('unbind !end')
    send_command('unbind !pageup')
    send_command('unbind !pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad1')
    send_command('unbind !t')
    send_command('unbind ^t')
    send_command('unbind !n')
    send_command('unbind !m')
    send_command('unbind !p')
    send_command('unbind !h')
    send_command('unbind !g')

    send_command('unbind @1')
    send_command('unbind @2')
    send_command('unbind @3')
    send_command('unbind @4')
    send_command('unbind @5')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Fast cast sets for spells
    sets.precast.FC = {
        -- main=gear.Kali_Idle, --7
        -- sub=gear.Kali_Song, --7
        head="Vanya Hood", --10
        body="Inyanga Jubbah +2", --14
        hands="Volte Gloves", --6
        legs="Kaykaus Tights +1", --7
        feet=gear.Empyrean_Feet, --10
        neck="Baetyl Pendant", --4
        ear1="Enchanter's Earring +1", --2    
        ear2="Etiolation Earring", --1
        ring1="Weather. Ring", --4
        ring2="Kishar Ring", --4
        back="Fi Follet Cape +1", --10
        waist="Embla Sash", --5
    } --91

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet="Kaykaus Boots +1", --0/7
        ear2="Mendi. Earring", --0/5
    })

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head=gear.Empyrean_Head, --14
        body=gear.Artifact_Body, --15
        feet=gear.Telchine_SONG_Feet, --6
        neck="Loricate Torque +1",
        ear1="Odnowa Earring +1",
        ring2="Defending Ring",
    })

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    -- Precast sets to enhance JAs

    sets.precast.JA.Nightingale = {feet=gear.Relic_Feet}
    sets.precast.JA.Troubadour = {body=gear.Relic_Body}
    sets.precast.JA['Soul Voice'] = {legs=gear.Relic_Legs}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range=gear.Linos_WS,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BRD_WS1_Cape,
        waist="Fotia Belt",
    }

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {
        range=gear.Linos_TP,
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands=gear.Relic_Hands,
        legs="Zoar Subligar +1",
        feet=gear.Lustratio_D_Feet,
        ear1="Brutal Earring",
        ring1="Begrudging Ring",
        back=gear.BRD_WS2_Cape,
    })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        range=gear.Linos_TP,
        body=gear.Relic_Body,
        hands=gear.Relic_Hands,
        ear1="Brutal Earring",
        ring1="Shukuyu Ring",
        back=gear.BRD_WS1_Cape,
    })

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS, {
        neck="Bard's Charm +2",
        ear2="Regal Earring",
        ring2="Metamor. Ring +1",
        waist="Grunfeld Rope",
    })

    sets.precast.WS['Rudra\'s Storm'] = set_combine(sets.precast.WS, {
        neck="Bard's Charm +2",
        waist="Grunfeld Rope",
        back=gear.BRD_WS2_Cape,
    })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        neck="Baetyl Pendant",
        ring2="Shiva Ring +1",
        ear1="Friomisi Earring",
        -- back="Argocham. Mantle",
        waist="Orpheus's Sash",
    })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        neck="Bard's Charm +2",
        ring1="Epaminondas's Ring",
        ring2="Metamorph Ring +1",
        waist="Sailfi Belt +1",
        back=gear.BRD_WS2_Cape,
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        -- hands=gear.Chironic_WSD_Hands, --20
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
        waist="Rumination Sash", --10
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

  -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = { legs=gear.Empyrean_Legs }
    sets.midcast.Carol = { hands="Mousai Gages +1" }
    sets.midcast.Etude = { head="Mousai Turban +1" }
    sets.midcast.HonorMarch = { range="Marsyas", hands=gear.Empyrean_Hands }
    sets.midcast.Lullaby = {
        body=gear.Empyrean_Body,
        hands=gear.Artifact_Hands,
    }
    sets.midcast.Lullaby = { body=gear.Empyrean_Body }
    sets.midcast.Madrigal = { head=gear.Empyrean_Head }
    -- sets.midcast.Mambo = { feet="Mou. Crackows +1" }
    sets.midcast.March = { hands=gear.Empyrean_Hands }
    sets.midcast.Minne = { legs="Mou. Seraweels +1" }
    sets.midcast.Minuet = { body=gear.Empyrean_Body }
    sets.midcast.Paeon = { head=gear.Artifact_Head }
    sets.midcast.Threnody = { body="Mou. Manteel +1" }
    sets.midcast['Adventurer\'s Dirge'] = { range="Marsyas", hands=gear.Relic_Hands }
    sets.midcast['Adventurer\'s Dirge'] = { range="Marsyas" }
    sets.midcast['Foe Sirvente'] = { head=gear.Relic_Head }
    sets.midcast['Magic Finale'] = { legs=gear.Empyrean_Legs }
    sets.midcast["Sentinel's Scherzo"] = { feet=gear.Empyrean_Feet }
    sets.midcast["Chocobo Mazurka"] = { range="Marsyas" }

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEnhancing = {
        main="Carnwenhan",
        sub=gear.Kali_Idle,
        range="Gjallarhorn",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs="Inyanga Shalwar +2",
        feet=gear.Artifact_Feet,
        neck="Mnbw. Whistle +1",
        ear1="Enchanter's Earring +1",
        ear1="Etiolation Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Defending Ring",
        waist="Flume Belt +1",
        back=gear.BRD_Song_Cape,
    }

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Mnbw. Whistle +1",
        -- ear1="Digni. Earring",
        ear1="Enchanter's Earring +1",
        ear2="Regal Earring",
        left_ring=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back=gear.BRD_Song_Cape,
    }

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
        legs=gear.Artifact_Legs
    })

    -- For Horde Lullaby maxiumum AOE range.
    sets.midcast.SongStringSkill = {
        ear1="Gersemi Earring",
        -- ear2="Darkside Earring",
        body=gear.Empyrean_Body,
        hands="Inyan. Dastanas +2",
        neck="Mnbw. Whistle +1",
        waist="Acuity Belt +1",
        legs="Inyanga Shalwar +2",
        feet=gear.Relic_Feet,
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BRD_Song_Cape,
    }

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = {
        range=info.ExtraSongInstrument,
        head="Inyanga Tiara +2",
        body="Inyanga Jubbah +2",
        hands="Inyanga Dastanas +2",
        ring1="Defending Ring",
        ring1="Inyanga Ring",
        legs="Ayanmo Cosciales +2",
        feet="Inyanga Crackows +2",
        neck="Loricate Torque +1",       
    }

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Ammurapi Shield",
        head=gear.Kaykaus_B_Head, --11
        body=gear.Kaykaus_A_Body, --(+4)/(-6)
        hands=gear.Kaykaus_D_Hands, --11(+2)/(-6)
        legs=gear.Kaykaus_A_Legs, --11/(+2)/(-6)
        feet=gear.Kaykaus_B_Feet, --11(+2)/(-12)
        neck="Incanter's Torque",
        ear1="Beatific Earring",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back="Solemnity Cape", --7
        waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        -- neck="Nuna Gorget +1",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        body="Vanya Robe",
        legs="Aya. Cosciales +2",
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back=gear.BRD_Song_Cape,
        waist="Bishop's Sash",
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        -- hands="Hieros Mittens",
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        back="Oretan. Cape +1",
    })

    sets.midcast['Enhancing Magic'] = {
        main="Carnwenhan",
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
        waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
        head="Inyanga Tiara +2"
    })

    sets.midcast.Haste = sets.midcast['Enhancing Magic']

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Gishdubar Sash", 
        -- back="Grapevine Cape"
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck="Nodens Gorget", 
        waist="Siegel Sash"
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Emphatikos Rope"
    })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
        ring2="Sheltered Ring"
    })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        head=empty;
        body="Cohort Cloak +1",
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Mnbw. Whistle +1",
        -- ear1="Digni. Earring",
        ear1="Vor Earring",
        ear2="Regal Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
    }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        range="Gjallarhorn",
        head="Volte Beret",
        body="Mou. Manteel +1",
        -- legs="Volte Brais",
        hands=gear.Bunzi_Hands,
        legs=gear.Bunzi_Legs,
        feet=gear.Bunzi_Feet,
        -- feet="Volte Gaiters",
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Moonlight Cape",
        waist="Flume Belt +1",
    }

    sets.idle.DT = {
        head=gear.Artifact_Head, --6/0
        body=gear.Artifact_Body, --7/0
        hands=gear.Nyame_Hands,
        legs=gear.Artifact_Legs, --8/8
        feet="Inyan. Crackows +2", --0/3
        neck="Loricate Torque +1", --6/6
        ear1="Eabani Earring",
        ear1="Etiolation Earring", --0/3
        ear1="Odnowa Earring +1", --3/5
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring",  --10/10
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
    }

    sets.idle.MEva = {
        head="Inyanga Tiara +2", --0/5
        body="Inyanga Jubbah +2", --0/8
        legs="Inyanga Shalwar +2", --0/6
        feet="Inyan. Crackows +2", --0/3
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1="Purity Ring",
        ring2="Inyanga Ring",
        back="Moonlight Cape", --6/6
        waist="Carrier's Sash",
    }

    sets.idle.Town = set_combine(sets.idle, {
        range="Gjallarhorn",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Mnbw. Whistle +1",
        ear1="Enchntr. Earring +1",
        ear2="Regal Earring",
        back=gear.BRD_Song_Cape,
        waist="Acuity Belt +1",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = { feet=gear.Empyrean_Feet }
    sets.latent_refresh = { waist="Fucho-no-obi" }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        range=gear.Linos_TP,
        head="Ayanmo Zucchetto +2", --6
        body="Ayanmo Corazza +2", --(6/6)
        hands="Gazu Bracelets +1",
        legs="Volte Tights",
        feet=gear.Nyame_Feet,
        neck="Bard's Charm +2",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.BRD_TP_Cape,
        waist="Windbuffet Belt +1",
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        -- head="Aya. Zucchetto +2",
        -- hands="Gazu Bracelets +1",
        feet=gear.Relic_Feet,
        waist="Kentarch Belt +1",
    })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        range=gear.Linos_TP,
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2",
        hands="Gazu Bracelets +1",
        legs="Volte Tights",
        feet=gear.Nyame_Feet,
        neck="Bard's Charm +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.BRD_TP_Cape, --10 should be DW
        waist="Reiki Yotai", --7
        } -- 26%

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        head="Aya. Zucchetto +2",
        feet="Bihu Slippers +3",
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        range=gear.Linos_TP,
        head="Ayanmo Zucchetto +2",
        body="Ayanmo Corazza +2", --(6/6)
        hands=gear.Bunzi_Hands, --(8/8)
        legs="Volte Tights",
        feet=gear.Nyame_Feet, --(7/7)
        neck="Bard's Charm +2",
        ear1="Eabani Earring", --4
        ear2="Telos Earring",
        ring1=gear.Moonlight_1, --(5/5)
        ring2=gear.Moonlight_2, --(5/5)
        back=gear.BRD_TP_Cape, --(10/0)
        waist="Reiki Yotai", --7
    } --DT=(41/31)|DW=11

    sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW.MaxHaste, {
        head="Aya. Zucchetto +2",
        feet=gear.Relic_Feet,
        ear1="Cessance Earring",
        back=gear.BRD_DW_Cape,
        waist="Kentarch Belt +1",
    })

    sets.engaged.Aftermath = {
        -- head="Volte Tiara",
        -- body="Ashera Harness",
        -- hands=gear.Telchine_STP_Hands,
        legs="Volte Tights",
        -- feet="Volte Spats",
        neck="Bard's Charm +2",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.BRD_TP_Cape,
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        legs=gear.Nyame_Legs
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

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.SongDWDuration = { main="Carnwenhan", sub="Kali" }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.Obi = { waist="Hachirin-no-Obi" }

    sets.Carnwenhan = { main="Carnwenhan", sub="Blurred Knife +1" }
    sets.Twashtar = { main="Twashtar", sub="Fusetto +2" }
    sets.Tauret = { main="Tauret", sub="Ternion Dagger +1" }
    sets.Naegling = { main="Naegling", sub="Fusetto +2" }

    sets.DefaultShield = { sub="Genmei Shield" }

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
            else
                equip({range="Gjallarhorn"})
            end
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
    if spell.type == 'WeaponSkill' then
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
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
                equip(sets.midcast.SongStringSkill)
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false and (player.sub_job == 'DNC' or player.sub_job == 'NIN') then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
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

-- Called for direct player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <stnpc>')
    end

    gearinfo(cmdParams, eventArgs)
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
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
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

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

    local c_msg = state.CastingMode.value

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
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +2' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 27 then
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