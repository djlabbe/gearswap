-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

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
--              [ ALT+` ]           Toggle Magic Burst Mode
--
--
--  Spells:     [ CTRL+` ]          Stun
--              [ ALT+Q ]           Temper
--              [ ALT+W ]           Flurry II
--              [ ALT+E ]           Haste II
--              [ ALT+R ]           Refresh II
--              [ ALT+Y ]           Phalanx
--              [ ALT+O ]           Regen II
--              [ ALT+P ]           Shock Spikes
--              [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad9 ]    Chant Du Cygne
--              [ CTRL+Numpad4 ]    Requiescat
--              [ CTRL+Numpad1 ]    Sanguine Blade
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

    state.Buff.Composure = buffactive.Composure or false
    state.Buff.Saboteur = buffactive.Saboteur or false
    state.Buff.Stymie = buffactive.Stymie or false

    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle',
        'Frazzle II',  'Gravity', 'Gravity II', 'Silence'}

    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}

    enfeebling_magic_effect = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Blind', 'Blind II'}

    enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga'}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}

    include('Mote-TreasureHunter')
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')

    state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
    state.GainSpell = M{['description']='GainSpell', 'Gain-MND', 'Gain-STR', 'Gain-INT', 'Gain-DEX', 'Gain-AGI', 'Gain-VIT', 'Gain-CHR'}

    state.WeaponSet = M{['description']='Weapon Set', 'Crocea', 'Naegling'}
    state.WeaponLock = M(true, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
    state.EnspellMode = M(true, 'Enspell Melee Mode')

    gear.Artifact_Head = { name= "Atrophy Chapeau +1" }
    gear.Artifact_Body = { name= "Atrophy Tabard +3" }
    gear.Artifact_Hands = { name= "Atrophy Gloves +3" }
    gear.Artifact_Legs = { name= "Atrophy Tights +2" }

    gear.Relic_Head = { name= "Vitiation Chapeau +3" }
    gear.Relic_Body = { name= "Vitiation Tabard +3" }
    gear.Relic_Hands = { name= "Vitiation Gloves +3" }
    gear.Relic_Legs = { name= "Vitiation Tights +3" }
    gear.Relic_Feet = { name= "Vitiation Boots +3" }

    gear.Empyrean_Head = { name= "Lethargy Chappel +1" }
    gear.Empyrean_Body = { name= "Lethargy Sayon +1" }
    gear.Empyrean_Hands = { name= "Lethargy Gantherots +1" }
    gear.Empyrean_Legs = { name= "Lethargy Fuseau +1" }
    gear.Empyrean_Feet = { name= "Lethargy Houseaux +1" }

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind ^= gs c cycle treasuremode')

    send_command('bind !` input /ja "Composure" <me>')
    send_command('bind ^` gs c toggle MagicBurst')  

    send_command('bind !s input /ja "Saboteur" <me>')
    send_command('bind !p input /ma "Protect V" <stpc>')
    send_command('bind !o input /ma "Shell V" <stpc>')
    send_command('bind !h input /ma "Haste II" <stpc>')
    send_command('bind !f input /ma "Flurry II" <stpc>')
    send_command('bind !g input /ma "Gravity II" <t>')
    send_command('bind !b input /ma "Bind" <t>')

    -- ALT + Numpad ===> Enfeebles --
    send_command('bind !numpad7 input /ma "Paralyze II" <t>')
    send_command('bind !numpad8 input /ma "Slow II" <t>')
    send_command('bind !numpad9 input /ma "Silence" <t>')  
    send_command('bind !numpad4 input /ma "Addle II" <t>')
    send_command('bind !numpad5 input /ma "Distract III" <t>')
    send_command('bind !numpad6 input /ma "Frazzle III" <t>')
    send_command('bind !numpad1 input /ma "Inundation" <t>')
    send_command('bind !numpad2 input /ma "Blind II" <t>')
    send_command('bind !numpad3 input /ma "Poison II" <t>')    

    send_command('bind !insert gs c cycleback EnSpell')
    send_command('bind !delete gs c cycle EnSpell')
    send_command('bind ^insert gs c cycleback GainSpell')
    send_command('bind ^delete gs c cycle GainSpell')
    send_command('bind !home gs c cycleback BarElement')
    send_command('bind !end gs c cycle BarElement')
    send_command('bind !pageup gs c cycleback BarStatus')
    send_command('bind !pagedown gs c cycle BarStatus')

    send_command('bind @s gs c cycle SleepMode')
    send_command('bind @r gs c cycle EnspellMode')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    -- -- Enter "Enspell" mode by default, can WIN+E to Toggle OFF --
    -- send_command('gs c cycle EnspellMode');

    if player.sub_job == 'NIN' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'WHM' then
        set_macro_page(2, 5)
    elseif player.sub_job == 'BLM' then
        set_macro_page(3, 5)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 5)
    else
        set_macro_page(1, 5)
    end

    send_command('wait 2; input /lockstyleset ' .. 5)
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^=')
    send_command('unbind !~')

    send_command('unbind !s')
    send_command('unbind !p')
    send_command('unbind !o')
    send_command('unbind !h')
    send_command('unbind !f')
    send_command('unbind !g')
    send_command('unbind !b')

    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')  
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind !home')
    send_command('unbind !end')
    send_command('unbind !pageup')
    send_command('unbind !pagedown')

    send_command('unbind @s')
    send_command('unbind @e')
    send_command('unbind @w')
    send_command('unbind @r')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body=gear.Relic_Body}
 
    -- Fast cast sets for spells (80% cap - 38% job = 42% target)
    sets.precast.FC = {
        head="Vanya Hood", --10
        body=gear.Relic_Body, --14
        ear1="Malignance Earring", --4
        ear2="Enchanter's Earring +1", --2 
        feet=gear.Carmine_B_feet, --8
        ring2="Weatherspoon Ring", --4
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ammo="Impatiens", --(2)
        ring1="Lebeche Ring", --(2)
        ring2="Weatherspoon Ring", --5/(4)
        waist="Embla Sash",
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    -- sets.precast.FC.Impact = set_combine(sets.precast.FC, {
    --     ammo="Sapience Orb", --2
    --     head=empty,
    --     body="Twilight Cloak",
    --     hands="Gende. Gages +1", --7
    --     neck="Orunmila's Torque", --5
    --     ear1="Malignance Earring", --4
    --     ear2="Enchntr. Earring +1", --2
    --     ring1="Kishar Ring", --4
    --     back="Swith Cape +1", --4
    --     waist="Shinjutsu-no-Obi +1", --5
    -- })

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", waist="Shinjutsu-no-Obi +1"})
    sets.precast.Storm = set_combine(sets.precast.FC, {ring1=gear.Stikini_1})
    sets.precast.FC.Utsusemi = sets.precast.FC.Cure


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        body=gear.Relic_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Relic_Legs,
        feet="Jhakri Pigaches +2",
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Metamorph Ring +1",
        ring2="Epaminondas's Ring",
        back=gear.RDM_MND_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Voluspa Tathlum",
        body="Jhakri Robe +2",
        -- neck="Combatant's Torque",
        ear2="Mache Earring +1",
        waist="Grunfeld Rope",
    })

    sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head="Blistering Sallet +1",
        body="Ayanmo Corazza +2",
        hands=gear.Malignance_hands,
        legs="Zoar Subligar +1",
        feet="Thereoid Greaves",
        ear1="Sherida Earring",
        ring1="Begrudging Ring",
        ring2="Ilabrat Ring",
        back=gear.RDM_MND_Cape,
     })

    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS['Chant du Cygne'], {
        ammo="Voluspa Tathlum",
        ear2="Mache Earring +1",
    })

    sets.precast.WS['Evisceration'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Evisceration'].Acc = sets.precast.WS['Chant du Cygne'].Acc

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']
    sets.precast.WS['Vorpal Blade'].Acc = sets.precast.WS['Chant du Cygne'].Acc

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        ring1="Metamorph Ring +1",
        neck="Dls. Torque +2",
        waist="Sailfi Belt +1",
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
        ammo="Voluspa Tathlum",
        -- neck="Combatant's Torque",
        waist="Grunfeld Rope",
    })

    sets.precast.WS['Death Blossom'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Death Blossom'].Acc = sets.precast.WS['Savage Blade'].Acc

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {
        ear2="Sherida Earring",
        ring2="Shukuyu Ring",
    })

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        ammo="Voluspa Tathlum",
        -- neck="Combatant's Torque",
        ear1="Mache Earring +1",
    })

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Amalric_A_body,
        hands="Jhakri Cuffs +2",
        legs=gear.Amalric_A_legs,
        feet=gear.Amalric_D_feet,
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Archon Ring",
        ring2="Epaminondas's Ring",
        back=gear.RDM_MND_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Seraph Blade'] = set_combine(sets.precast.WS['Sanguine Blade'], {
        head=empty,
        body={ name="Cohort Cloak +1", augments={'Path: A',}},
        ear2={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        ring1="Weatherspoon Ring",
    })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Seraph Dlade'], {
        -- head="Merlinic Hood",
        ear2={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        ring1="Shiva Ring +1",
        waist="Orpheus's Sash",
    })

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {
        ear2="Sherida Earring",
        ring1="Rufescent Ring",
    })

    sets.precast.WS['Black Halo'].Acc = set_combine(sets.precast.WS['Black Halo'], {
        ammo="Voluspa Tathlum",
        -- neck="Combatant's Torque",
        ear2="Telos Earring",
        waist="Grunfeld Rope",
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        --body="Ros. Jaseran +1", --25
        -- hands=gear.Chironic_WSD_hands, --20
        legs="Carmine Cuisses +1", --20
        neck="Loricate Torque +1", --5
        -- ear1="Halasz Earring", --5
        -- ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
        -- waist="Rumination Sash", --10
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Sors Shield", --3/(-5)
        -- ammo="Esper Stone +1", --0/(-5)
        ammo="Clarus Stone",
        head=gear.Kaykaus_B_head, --11(+2)/(-6)
        body=gear.Kaykaus_A_body, --(+4)/(-6)
        hands=gear.Kaykaus_D_hands, --11(+2)/(-6)
        legs=gear.Kaykaus_A_legs, --11(+2)/(-6)
        feet=gear.Kaykaus_B_feet, --11(+2)/(-12)
        neck="Incanter's Torque",
        left_ear="Mendi. Earring",
        right_ear="Magnetic Earring",
        left_ring="Stikini Ring +1",
        right_ring="Sirona's Ring",
        back="Fi Follet Cape +1",
        waist={ name="Shinjutsu-no-Obi +1", augments={'Path: A',}},
    }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff",
        sub="Enki Strap",
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        waist="Gishdubar Sash", -- (10)
    })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ammo="Regal Gem",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        waist="Luminary Sash",
       })

    sets.midcast.StatusRemoval = {
        head="Vanya Hood",
        -- body="Vanya Robe",
        legs=gear.Artifact_Legs,
        -- feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear2="Meili Earring",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        -- back="Perimede Cape",
        waist="Bishop's Sash",
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        -- hands="Hieros Mittens",
        body=gear.Relic_Body,
        neck="Debilis Medallion",
        ear1="Beatific Earring",
        ring2="Menelaus's Ring",
        -- back="Oretan. Cape +1",
    })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Colada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Relic_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Empyrean_Feet,
        neck="Dls. Torque +2",
        back=gear.RDM_ENH_Cape,
        waist="Embla Sash",
    }

    sets.midcast.EnhancingDuration = {
        main=gear.Colada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_head,
        body=gear.Relic_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Telchine_ENH_legs,
        feet=gear.Empyrean_Feet,
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        neck="Dls. Torque +2",
        back=gear.RDM_ENH_Cape,
        waist="Embla Sash",
    }

    sets.midcast.EnhancingSkill = set_combine(sets.midcast.EnhancingDuration, {
        main="Pukulatmuj +1",
        sub="Pukulatmuj",
        head=gear.Carmine_D_head,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        hands=gear.Relic_Hands,
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Fi Follet Cape +1",
        wasit="Olympus Sash",
        legs=gear.Artifact_Legs,
        feet=gear.Empyrean_Feet,
    })

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
        head=gear.Amalric_A_head, -- +1
        body=gear.Artifact_Body, -- +3
        legs=gear.Empyrean_Legs, -- +2
    })

    sets.midcast.RefreshSelf = {
        waist="Gishdubar Sash",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast['Phalanx II'] = set_combine(sets.midcast.EnhancingDuration, {
        main="Sakpata's Sword",
        body=gear.Taeon_Phalanx_body, --3(10)
        hands=gear.Taeon_Phalanx_hands, --3(10)
        legs=gear.Taeon_Phalanx_legs, --3(10)
        feet=gear.Taeon_Phalanx_feet, --3(10)
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1",
        head=gear.Amalric_A_head,
        hands="Regal Cuffs",
        ring1="Freke Ring",
    })

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.GainSpell = {hands=gear.Relic_Hands}
    sets.midcast.SpikesSpell = {legs=gear.Relic_Pants}

     -- Custom spell classes

    sets.midcast.MndEnfeebles = {
        main="Contemplator +1",
        sub="Enki Strap",
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands=gear.Kaykaus_D_hands,
        legs=gear.Chironic_ENF_legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",
        waist="Luminary Sash",
    }

    sets.midcast.MndEnfeeblesAcc = set_combine(sets.midcast.MndEnfeebles, {
        main="Contemplator +1",
        sub="Enki Strap",
        range="Ullr",
        ammo=empty,
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Kaykaus_D_hands,
        ring1=gear.Stikini_1,
        waist="Acuity Belt +1",
    })

    sets.midcast.MndEnfeeblesEffect = set_combine(sets.midcast.MndEnfeebles, {
        ammo="Regal Gem",
        body=gear.Empyrean_Body,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
    })

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        sub="Ammurapi Shield",
        main="Contemplator +1",
        sub="Enki Strap",
        waist="Acuity Belt +1",
    })

    sets.midcast.IntEnfeeblesAcc = set_combine(sets.midcast.IntEnfeebles, {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        range="Ullr",
        ammo=empty,
        body=gear.Artifact_Body,
        hands="Kaykaus Cuffs +1",
        ring1=gear.Stikini_1,
        waist="Acuity Belt +1",
    })

    sets.midcast.IntEnfeeblesEffect = set_combine(sets.midcast.IntEnfeebles, {
        ammo="Regal Gem",
        body=gear.Empyrean_Body,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
    })

    sets.midcast.SkillEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Contemplator +1",
        sub="Mephitis Grip",
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        feet=gear.Relic_Feet,
        neck="Incanter's Torque",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        ear1="Vor Earring",
        ear2="Snotra Earring",
        -- waist="Rumination Sash",
    })

    sets.midcast.Sleep = set_combine(sets.midcast.IntEnfeeblesAcc, {
        head=gear.Relic_Head,
        neck="Dls. Torque +2",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
    })

    sets.midcast.SleepMaxDuration = set_combine(sets.midcast.Sleep, {
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands="Regal Cuffs",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
    })

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeeblesAcc, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    sets.midcast['Dark Magic'] = {
        -- main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Artifact_Head,
        body="Carm. Sc. Mail +1",
        hands="Kaykaus Cuffs +1",
        legs="Ea Slops +1",
        -- feet="Merlinic Crackows",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        -- ear2="Mani Earring",
        ring1=gear.Stikini_1,
        ring2="Evanescence Ring",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head="Pixie Hairpin +1",
        ear1="Hirudinea Earring",
        ring1="Archon Ring",
        ring2="Evanescence Ring",
        -- back="Perimede Cape",
        waist="Fucho-no-obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {waist="Luminary Sash"})
    sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], {legs=gear.Relic_Legs})

    sets.midcast['Elemental Magic'] = {
        main="Marin Staff +1",
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head=empty,
        body="Cohort Cloak +1",
        hands=gear.Amalric_D_hands,
        legs=gear.Amalric_A_legs,
        feet=gear.Amalric_D_feet,
        neck="Baetyl Pendant",
        ear1="Malignance Earring",
        -- ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        -- back=gear.RDM_INT_Cape,
        waist="Refoccilation Stone",
        }

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {
        range="Ullr",
        ammo=empty,
        -- legs="Merlinic Shalwar",
        -- feet="Merlinic Crackows",
        neck="Erra Pendant",
        -- waist="Sacro Cord",
    })

    -- sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
    --     head=empty,
    --     body="Twilight Cloak",
    --     ring1="Archon Ring",
    --     waist="Shinjutsu-no-Obi +1",
    -- })

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Initializes trusts at iLvl 119
    sets.midcast.Trust = sets.precast.FC

    -- Job-specific buff sets
    sets.buff.ComposureOther = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Empyrean_Head,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
    });

    sets.buff.Saboteur = {hands=gear.Empyrean_Hands}


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Homiliary",
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Malignance_hands,
        legs="Carmine Cuisses +1",
        feet=gear.Malignance_feet,
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Infused Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        ring2=gear.Stikini_2,
        back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Mag. Evasion+15',}},
        waist="Flume Belt +1",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Malignance_head, --6/6
        body=gear.Malignance_body, --9/9
        hands=gear.Malignance_hands, --5/5
        legs="Nyame Flanchard", --7/7
        feet=gear.Malignance_feet, --4/4
        ring2="Defending Ring", --10/10
        -- Cape = 10% PDT
    })

    sets.idle.Town = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Relic_Body,
        hands="Regal Cuffs",
        legs="Carmine Cuisses +1",
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_MND_Cape,
        waist="Luminary Sash",
    }

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.magic_burst = {
        head="Ea Hat +1", --7/(7)
        body="Ea Houppe. +1", --9/(9)
        hands="Amalric Gages +1", --(6)
        legs="Ea Slops +1", --8/(8)
        -- feet="Ea Pigaches +1", --5/(5)
        -- neck="Mizu. Kubikazari", --10
        ring2="Mujin Band", --(5)
        }

    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=gear.Malignance_head, --6
        body=gear.Malignance_body, --9
        hands=gear.Malignance_hands, --5
        legs=gear.Malignance_legs, --7
        feet=gear.Malignance_feet, --4
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        left_ring=gear.Chirich_1,
        right_ring=gear.Chirich_2,
        back=gear.RDM_DW_Cape,
        waist="Windbuffet Belt +1",
    } --32%

    sets.engaged.MidAcc = set_combine(sets.engaged, {
        -- neck="Combatant's Torque",
        ring1=gear.Chirich_1,
        waist="Kentarch Belt +1",
    })

    sets.engaged.HighAcc = set_combine(sets.engaged, {
        ammo="Voluspa Tathlum",
        head=gear.Carmine_D_head,
        body=gear.Carmine_B_body,
        hands="Gazu Bracelet +1",
        legs="Carmine Cuisses +1",
        ear1="Cessance Earring",
        ear2="Mache Earring +1",
        -- waist="Olseni Belt",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
       neck="Loricate Torque +1", --6/6
       ring2="Defending Ring", --10/10
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.EnSpell = {
        hands="Aya. Manopolas +2",
        neck="Dls. Torque +2",
        waist="Orpheus's Sash",
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        -- neck="Nicander's Necklace", --20
        -- ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        -- ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
    }

    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.TreasureHunter = {
        head="Volte Cap",
        hands=gear.Merl_TH_hands,
        feet=gear.Merl_TH_feet
    }

    sets.Crocea = {main="Crocea Mors",sub="Daybreak"}
    sets.Naegling = {main="Naegling", sub="Ternion Dagger +1"}
    sets.DefaultShield = {sub="Genmei Shield"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
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
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
    -- if spell.english == "Phalanx II" and spell.target.type == 'SELF' then
    --     cancel_spell()
    --     send_command('@input /ma "Phalanx" <me>')
    -- end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
                if spell.target.type == 'SELF' then
                    equip (sets.midcast.RefreshSelf)
              end
            end
        elseif skill_spells:contains(spell.english) then
            equip(sets.midcast.EnhancingSkill)
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            equip(sets.buff.ComposureOther)
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.magic_burst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.skill == 'Elemental Magic' then
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
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Sleep') and not spell.interrupted then
        set_sleep_timer(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
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

    check_weaponset()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end


-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_skill:contains(spell.english) then
                return "SkillEnfeebles"
            elseif spell.type == "WhiteMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "MndEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    return "MndEnfeeblesEffect"
                else
                    return "MndEnfeebles"
              end
            elseif spell.type == "BlackMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "IntEnfeeblesAcc"
                elseif enfeebling_magic_effect:contains(spell.english) then
                    return "IntEnfeeblesEffect"
                elseif enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
                    return "SleepMaxDuration"
                elseif enfeebling_magic_sleep:contains(spell.english) then
                    return "Sleep"
                else
                    return "IntEnfeebles"
                end
            else
                return "MndEnfeebles"
            end
        end
    end
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

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.EnspellMode.value == true then
       
        meleeSet = set_combine(meleeSet, sets.engaged.EnSpell)
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    check_weaponset()

    return meleeSet
end


-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'enspell' then
        send_command('@input /ma '..state.EnSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'gainspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
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

function set_sleep_timer(spell)
    local self = windower.ffxi.get_player()

    if spell.en == "Sleep II" then
        base = 90
    elseif spell.en == "Sleep" or spell.en == "Sleepga" then
        base = 60
    end

    if state.Buff.Saboteur then
        -- if state.NM.value then
            base = base * 1.25
        -- else
            -- base = base * 2
        -- end
    end

    -- Merit Points Duration Bonus
    base = base + self.merits.enfeebling_magic_duration*6

    -- Relic Head Duration Bonus
    if not ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
        base = base + self.merits.enfeebling_magic_duration*3
    end

    -- Job Points Duration Bonus
    base = base + self.job_points.rdm.enfeebling_magic_duration

    --Enfeebling duration non-augmented gear total
    gear_mult = 1.40
    --Enfeebling duration augmented gear total
    aug_mult = 1.25
    --Estoquer/Lethargy Composure set bonus
    --2pc = 1.1 / 3pc = 1.2 / 4pc = 1.35 / 5pc = 1.5
    empy_mult = 1 --from sets.midcast.Sleep

    if ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
        if buffactive.Stymie then
            base = base + self.job_points.rdm.stymie_effect
        end
        empy_mult = 1.35 --from sets.midcast.SleepMaxDuration
    end

    totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)

    -- Create the custom timer
    if spell.english == "Sleep II" then
        send_command('@timers c "Sleep II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then
        send_command('@timers c "Sleep ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00253.png')
    end
    add_to_chat(1, 'Base: ' ..base.. ' Merits: ' ..self.merits.enfeebling_magic_duration.. ' Job Points: ' ..self.job_points.rdm.stymie_effect.. ' Set Bonus: ' ..empy_mult)

end

-- -- Check for various actions that we've specified in user code as being used with TH gear.
-- -- This will only ever be called if TreasureMode is not 'None'.
-- -- Category and Param are as specified in the action event packet.
-- function th_action_check(category, param)

-- end
function check_gear()
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end