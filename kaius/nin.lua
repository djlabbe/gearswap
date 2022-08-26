-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ CTRL+` ]          Toggle Treasure Hunter Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Yonin
--              [ CTRL+= ]          Innin
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--              [ ALT+, ]           Monomi: Ichi
--              [ ALT+. ]           Tonko: Ni
--
--  WS:         [ CTRL+Numpad7 ]    Blade: Kamu
--              [ CTRL+Numpad8 ]    Blade: Shun
--              [ CTRL+Numpad4 ]    Blade: Ten
--              [ CTRL+Numpad6 ]    Blade: Hi
--              [ CTRL+Numpad1 ]    Blade: Yu
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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
    state.Buff.Sange = buffactive.Sange or false

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}

    lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}

    lockstyleset = 1
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc', 'Kei')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    state.WeaponSet = M{['description']='Weapon Set', 'Heishi', 'Kikoku', 'Naegling', 'Tanking'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.CombatForm:set('DW')

    options.ninja_tool_warning_limit = 10

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    gear.Artifact = { }
    gear.Artifact.Head = { name= "Hachiya Hatsu. +3" }
    gear.Artifact.Feet = { name= "Hachiya Kyahan +3" }

    gear.Relic = { }
    gear.Relic.Head = { name= "Mochizuki Hatsuburi +3" }
    gear.Relic.Body = { name= "Mochizuki Chainmail +3" }
    gear.Relic.Legs = { name= "Mochizuki Hakama +3" }
    gear.Relic.Hands = { name = "Mochizuki Tekko +3" }
    gear.Relic.Feet = { name = "Mochizuki Kyahan +3" }

    gear.Empyrean = { }
    gear.Empyrean.Body = { name = "Hattori Ningi" }
    gear.Empyrean.Body = { name = "Hattori Tekko +1" }
    gear.Empyrean.Feet = { name = "Hattori Kyahan +1" }

    gear.MovementFeet = { name="Danzo Sune-ate" }
    gear.DayFeetName = "Danzo Sune-ate"
    gear.NightFeetName = gear.Artifact.Feet.name

    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !` input /ja "Innin" <me>')
    send_command('bind ^` input /ja "Yonin" <me>')
    send_command('bind !t input /ja "Provoke" <t>')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @r gs c cycle MagicBurst')

    -- ALT + Numpad ===> Enfeebles --
    send_command('bind !numpad7 input /ma "Jubaku: Ichi" <t>')
    send_command('bind !numpad8 input /ma "Hojo: Ni" <t>')
    send_command('bind !numpad9 input /ma "Aisha: Ichi" <t>')  
    send_command('bind !numpad1 input /ma "Yurin Ichi" <t>')
    send_command('bind !numpad2 input /ma "Kurayami: Ni" <t>')
    send_command('bind !numpad3 input /ma "Dokumori: Ichi" <t>')    

    -- Whether a warning has been given for low ninja tools
    state.warned = M(false)

    select_movement_feet()

    set_macro_page(1, 13)
    send_command('wait 2; input /lockstyleset 13')

    determine_haste_group()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^=')
    send_command('unbind !`')
    send_command('unbind ^`>')
    send_command('unbind !t')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')  
    send_command('unbind !numpad4')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')    
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Enmity set
    sets.Enmity = {
        -- ammo="Sapience Orb", --2
        body="Emet Harness +1", --10
        -- hands="Kurys Gloves", --9
        feet=gear.Relic.Feet, --8
        neck="Moonlight Necklace", --15
        -- ear1="Cryptic Earring", --4  
        -- ear2="Trux Earring", --5
        -- ring1="Pernicious Ring", --5
        ring2="Eihwaz Ring", --5
        -- waist="Kasiri Belt", --3
    }

    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['Mijin Gakure'] = { legs=gear.Relic.Legs }
    sets.precast.JA['Futae'] = {hands="Hattori Tekko +1"}
    sets.precast.JA['Sange'] = { body=gear.Relic.Body }
    sets.precast.JA['Innin'] = { head=gear.Relic.Head }
    sets.precast.JA['Yonin'] = { head=gear.Relic.Head }

    sets.precast.Waltz = {
        ammo="Yamarang",
        body="Passion Jacket",
        -- legs="Dashing Subligar",
        -- ring1="Asklepian Ring",
        waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells

    sets.precast.FC = {
        -- ammo="Sapience Orb", --2
        neck="Baetyl Pendant", --4
        body=gear.Taeon_FC_body, --9
        hands="Leyline Gloves", --5
        ear1="Enchanter's Earring +1", --2
        ear2="Loquacious Earring", --2
        ring1="Kishar Ring", --4
        ring2="Weatherspoon Ring", --5
    } --33

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body=gear.Relic.Body,
        neck="Magoraga Beads",
    })

    sets.precast.RA = {}

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Seeth. Bomblet +1",
        head=gear.Artifact.Head,
        body="Ken. Samue +1",
        hands=gear.Relic.Hands,
        legs=gear.Herc_WS_legs,
        feet=gear.Relic.Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Odr Earring",
        ring1="Gere Ring",
        ring2="Epaminondas's Ring",
        back=gear.NIN_WS_Cape,
        waist="Fotia Belt",
    } -- default set

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
    })

    sets.precast.WS['Blade: Ku'] = {
        ammo="Seeth. Bomblet +1",
        head=gear.Adhemar_B_head,
        body="Agony Jerkin +1",
        hands=gear.Relic.Hands,
        legs="Tatena. Haidate +1",
        feet=gear.Relic.Feet,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Mache Earring +1",
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        back=gear.NIN_TP_Cape,
    }

    sets.precast.WS['Blade: Ku'].Acc = set_combine(sets.precast.WS['Blade: Ku'], {})

    sets.precast.WS['Blade: Kamu'] = {
        ammo="Seeth. Bomblet +1",
        head=gear.Artifact.Head,
        body="Tatena. Harama. +1",
        hands=gear.Relic.Hands,
        legs="Tatena. Haidate +1",
        feet="Tatena. Sune. +1",
        neck="Ninja Nodowa +2",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Odr Earring",
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Epona's Ring",
        back=gear.NIN_TP_Cape,
    }

    sets.precast.WS['Blade: Kamu'].Acc = set_combine(sets.precast.WS['Blade: Kamu'], {})

    sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {
        ammo="Yetshila +1",
        head=gear.Adhemar_B_head,
        body="Ken. Samue +1",
        hands=gear.Ryuo_A_hands,
        legs=gear.Relic.Legs,
        feet=gear.Adhemar_D_feet,
        neck="Ninja Nodowa +2",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Odr Earring",
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        back=gear.NIN_WS_Cape,
    })

    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS['Blade: Hi'], {})

    sets.precast.WS['Blade: Metsu'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        head=gear.Artifact.Head,
        body="Agony Jerkin +1",
        hands=gear.Relic.Hands,
        legs="Jokushu Haidate",
        feet=gear.Relic.Feet,
        neck="Rep. Plat. Medal",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Odr Earring",
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        back=gear.NIN_WS_Cape,
    })

    sets.precast.WS['Blade: Metsu'].Acc = set_combine(sets.precast.WS['Blade: Metsu'], {})

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        head=gear.Artifact.Head,
        body="Agony Jerkin +1",
        hands=gear.Relic.Hands,
        legs=gear.Relic.Legs,
        feet=gear.Relic.Feet,
        neck="Rep. Plat. Medal",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        back=gear.NIN_WS_Cape,
    })

    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS['Blade: Ten'], {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
    })

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {
        ammo="Aurgelmir Orb +1",
        head="Mpaca's Cap",
        body="Agony Jerkin +1",
        hands=gear.Adhemar_B_hands,
        legs=gear.Rao_B_pants,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Regal Ring",
        back=gear.NIN_TP_Cape,
    })

    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS['Blade: Shun'], {
        ammo="Voluspa Tathlum",
        legs="Ken. Hakama +1",
    })

    sets.precast.Hybrid = {
        ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
        head=gear.Relic.Head,
        neck="Fotia Gorget",
        body=gear.Nyame_body,
        hands=gear.Nyame_hands,
        feet=gear.Nyame_feet,
        legs=gear.Nyame_legs,        
        left_ear="Moonshade Earring",
        right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
        left_ring="Gere Ring",
        right_ring="Epaminondas's Ring",
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
    }

    sets.precast.WS['Blade: Teki'] = sets.precast.Hybrid
    sets.precast.WS['Blade: To'] = sets.precast.Hybrid
    sets.precast.WS['Blade: Chi'] = sets.precast.Hybrid

    sets.precast.WS['Savage Blade'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Artifact.Head,
        body="Agony Jerkin +1",
        hands=gear.Relic.Hands,
        legs=gear.Relic.Legs,
        feet=gear.Herc_WS_feet,
        neck="Ninja Nodowa +2",
        waist="Sailfi Belt +1",
        left_ear="Moonshade Earring",
        right_ear="Lugra Earring +1",
        left_ring="Gere Ring",
        right_ring="Epaminondas's Ring",
        back=gear.NIN_WS_Cape,
    } 

    sets.Lugra = {ear2="Lugra Earring +1"}

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        body=gear.Taeon_Phalanx_body, --10
        -- hands="Rawhide Gloves", --15
        legs=gear.Taeon_Phalanx_legs, --10
        feet=gear.Taeon_Phalanx_feet, --10
        neck="Moonlight Necklace", --15
        -- ear1="Halasz Earring", --5
        -- ear2="Magnetic Earring", --8
        ring1="Evanescence Ring", --5
        -- back=gear.NIN_FC_Cape, --10
        waist="Audumbla Sash", --10
    }

    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {
        feet=gear.Empyrean.Feet,
        ear1="Eabani Earring",
        ear2="Odnowa Earring +1",
        ring2="Defending Ring",
        -- back=gear.NIN_FC_Cape,
    })

    sets.midcast.Migawari = set_combine(sets.midcast.SpellInterrupt, {
        feet=gear.Empyrean.Body,
        -- back=gear.NIN_FC_Cape,
    })

    sets.midcast.ElementalNinjutsu = {
        ammo="Ghastly Tathlum +1",
        head=gear.Relic.Head,
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet=gear.Relic.Feet,
        neck="Warder's Charm +1",
        waist="Orpheus's Sash",
        left_ear="Hermetic Earring",
        right_ear="Friomisi Earring",
        left_ring="Metamorph Ring +1",
        right_ring="Mujin Band",
        back=gear.NIN_TP_Cape,
    }

    sets.midcast.EnfeeblingNinjutsu = {
        ammo="Yamarang",
        head=gear.Artifact.Head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        feet=gear.Artifact.Feet,
        neck="Sanctity Necklace",
        ear1="Enchntr. Earring +1",
        ear2="Hermetic Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back=gear.NIN_MAB_Cape,
        waist="Skrymir Cord +1",
    }

    sets.midcast.EnhancingNinjutsu = {
        head=gear.Artifact.Head,
        feet=gear.Relic.Feet,
        neck="Incanter's Torque",
        -- ear1="Stealth Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back="Astute Cape",
        -- waist="Cimmerian Sash",
    }

    sets.midcast.Stun = sets.midcast.EnfeeblingNinjutsu

    sets.midcast.RA = {
        head=gear.Malignance_head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        feet=gear.Malignance_feet,
        neck="Iskur Gorget",
        ear1="Enervating Earring",
        ear2="Telos Earring",
        ring1="Dingir Ring",
        ring2="Hajduk Ring +1",
        back=gear.NIN_TP_Cape,
        waist="Yemaya Belt",
    }

    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    -- * NIN Native DW Trait: 35% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged = {
        ammo="Date Shuriken",
        head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --9
        body=gear.Relic.Body, --10
        hands=gear.Malignance_hands,
        legs="Ken. Hakama +1",
        feet="Tatena. Sune. +1",
        neck="Ninja Nodowa +2",
        waist="Reiki Yotai", --7
        left_ear="Eabani Earring", --5
        right_ear="Suppanomimi", --5
        left_ring="Gere Ring",
        right_ring="Epona's Ring",
        back=gear.NIN_TP_Cape,
      } -- 38%

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        hands=gear.Adhemar_A_hands,
    })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ring2="Ilabrat Ring",
        ring1=gear.Chirich_1,
    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        ring2=gear.Chirich_2,
    })

    -- 21 DW
    sets.engaged.MidHaste = {
        ammo="Date Shuriken",
        head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
        body=gear.Adhemar_A_body,
        hands=gear.Malignance_hands,
        legs="Ken. Hakama +1",
        feet="Tatena. Sune. +1",
        neck="Ninja Nodowa +2",
        waist="Reiki Yotai",
        left_ear="Telos Earring",
        right_ear="Crep. Earring",
        left_ring="Gere Ring",
        right_ring="Epona's Ring",
        back=gear.NIN_TP_Cape,
      }

    sets.engaged.LowAcc.MidHaste = set_combine(sets.engaged.MidHaste, {
        hands=gear.Adhemar_A_hands,
    })

    sets.engaged.MidAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
        ring1=gear.Chirich_1,
        ring2="Ilabrat Ring",
    })

    sets.engaged.HighAcc.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, {
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
    })


    -- (0-1 DW)
    sets.engaged.MaxHaste = {
        ammo="Date Shuriken",
        head=gear.Malignance_head,
        body="Tatena. Harama. +1",
        hands=gear.Adhemar_A_hands,
        legs="Ken. Hakama +1",
        feet=gear.Herc_TA_feet,
        neck="Ninja Nodowa +2",
        waist="Sailfi Belt +1",
        left_ear="Telos Earring",
        right_ear="Dedition Earring",
        left_ring="Gere Ring",
        right_ring="Epona's Ring",
        back=gear.NIN_TP_Cape,
    } -- 0%

    sets.engaged.LowAcc.MaxHaste = set_combine(sets.engaged.MaxHaste, {
        waist="Kentarch Belt +1",
    })

    sets.engaged.MidAcc.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, {
        right_ear="Cessance Earring",
        left_ring=gear.Chirich_1,
        right_ring="Ilabrat Ring",
    })

    sets.engaged.HighAcc.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, {
        left_ring="Regal Ring",
        right_ring=gear.Chirich_2,
        -- waist="Olseni Belt",
    })

    sets.engaged.Hybrid = {
        head=gear.Malignance_head, --6/6
        legs=gear.Malignance_legs, --8/8
        body=gear.Malignance_body, --9/9
        hands=gear.Malignance_hands, --5/5
        feet=gear.Malignance_feet, --4/4
        -- right_ring="Defending Ring", --10/10
        -- waist="Engraved Belt",
        -- ear2="Eabani Earring",
        -- back = 5%
    } --47%

    sets.engaged.Kei = {
        ammo="Date Shuriken",
        head=gear.Malignance_head, --6/6
        legs=gear.Malignance_legs, --8/8
        body=gear.Malignance_body, --9/9
        hands=gear.Malignance_hands, --5/5
        feet=gear.Malignance_feet, --4/4
        neck="Ninja Nodowa +2",
        ear1="Eabani Earring",
        ear2="Odnowa Earring +1",
        waist="Engraved Belt",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring",
        back=gear.NIN_MEVA_Cape,
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MidHaste = set_combine(sets.engaged.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MidHaste = set_combine(sets.engaged.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MidHaste = set_combine(sets.engaged.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT.MaxHaste = set_combine(sets.engaged.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT.MaxHaste = set_combine(sets.engaged.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT.MaxHaste = set_combine(sets.engaged.HighAcc.MaxHaste, sets.engaged.Hybrid)

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    -- Resting sets
--    sets.resting = {}

    -- Idle sets
    sets.idle = {
        ammo="Date Shuriken",
        head=gear.Malignance_head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        feet=gear.MovementFeet,
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Cessance Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.NIN_TP_Cape,
        waist="Reiki Yotai",
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Malignance_head, --6/6
        body=gear.Malignance_body, --9/9
        hands=gear.Malignance_hands, --5/5
        legs=gear.Malignance_legs, --7/7
        feet=gear.Malignance_feet, --4/4
        neck="Loricate Torque +1",
        -- ear1="Sanare Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = set_combine(sets.engaged.MaxHaste, {
        feet=gear.MovementFeet,
    })

    -- Defense sets
    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {
        feet="Danzo sune-ate"
    }

    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {}
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
    -- sets.buff.Sange = {ammo="Hachiya Shuriken"}

    sets.magic_burst = {
        feet="Hachiya Kyahan +3",
        -- ring1="Locus Ring",
        ring2="Mujin Band", --(5)
    }

--    sets.buff.Migawari = {body="Iga Ningi +2"}

    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        head="Volte Cap", 
        -- hands=gear.Herc_TH_hands, 
        waist="Chaac Belt"
    }

    sets.Kikoku = {main="Kikoku", sub="Kunimitsu"}
    sets.Heishi = {main="Heishi Shorinken", sub="Ternion Dagger +1"}
    sets.Naegling = {main="Naegling", sub="Uzura +2"}
    sets.Tanking = {main="Fudo Masamune", sub="Kunimitsu"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == "Ninjutsu" then
        do_ninja_tool_checks(spell, spellMap, eventArgs)
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
        if lugra_ws:contains(spell.english) and (world.time >= (17*60) or world.time <= (7*60)) then
            equip(sets.Lugra)
        end
        if spell.english == 'Blade: Yu' and (world.weather_element == 'Water' or world.day_element == 'Water') then
            equip(sets.Obi)
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
        if state.Buff.Futae then
            equip(sets.precast.JA['Futae'])
        end
    end
    if state.Buff.Doom then
        equip(sets.buff.Doom)
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
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

    if buff == "Migawari" and not gain then
        add_to_chat(61, "*** MIGAWARI DOWN ***")
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

    if new_status == 'Idle' then
        select_movement_feet()
    end

    check_weaponset()
end

function job_status_change(new_status, old_status)
    if new_status == 'Idle' then
        select_movement_feet()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    determine_haste_group()
end

function job_update(cmdParams, eventArgs)
    select_movement_feet()
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
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
    if state.Buff.Migawari then
       idleSet = set_combine(idleSet, sets.buff.Migawari)
    end
    return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Sange then
        meleeSet = set_combine(meleeSet, sets.buff.Sange)
    end

    check_weaponset()

    return meleeSet
end


-- Function to display the current relevant user state when doing an update.
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
    if state.TreasureMode.value == 'Tag' then
        msg = msg .. ' TH: Tag |'
    end
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


function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    haste = 0

    if (buffactive.haste) then 
        haste = haste + 30 -- 30% -- Assume Haste II (No way to differentiate 1 vs 2, same ID)
    end
    
    if (buffactive.march) then
        if (buffactive.march > 0) then
            haste = haste + 20 -- Victory March (15.9-28.6) or Honor March (12.3-17.0)
        end
    
        if (buffactive.march > 1) then
            haste = haste + 23 -- Victory March (15.9-28.6) or Advancing March (10.5 - 19.0)
        end
    
        if (buffactive.march > 2) then
            haste = haste + 19 --Advancing March (10.5 -  19.0)
        end
    end   

    if (buffactive[580]) then -- Geo-Haste
        haste = haste + 20
    end

    if (buffactive['haste samba']) then
        haste = haste + 5
    end

    if (haste >= 43) then
        classes.CustomMeleeGroups:append('MaxHaste') -- 1 (or 0?) DW needed
    elseif (haste >= 30) then
        classes.CustomMeleeGroups:append('MidHaste') -- 21 DW needed
    end
        -- Else assume just a bit of haste (~15?), and 32 DW needed
end

function job_self_command(cmdParams, eventArgs)
end


-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
    local ninja_tool_name
    local ninja_tool_min_count = 1

    -- Only checks for universal tools and shihei
    if spell.skill == "Ninjutsu" then
        if spellMap == 'Utsusemi' then
            ninja_tool_name = "Shihei"
        elseif spellMap == 'ElementalNinjutsu' then
            ninja_tool_name = "Inoshishinofuda"
        elseif spellMap == 'EnfeeblingNinjutsu' then
            ninja_tool_name = "Chonofuda"
        elseif spellMap == 'EnhancingNinjutsu' then
            ninja_tool_name = "Shikanofuda"
        else
            return
        end
    end

    local available_ninja_tools = player.inventory[ninja_tool_name] or player.wardrobe[ninja_tool_name]

    -- If no tools are available, end.
    if not available_ninja_tools then
        if spell.skill == "Ninjutsu" then
            return
        end
    end

    -- Low ninja tools warning.
    if spell.skill == "Ninjutsu" and state.warned.value == false
        and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
        local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
        state.warned:reset()
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

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end

windower.register_event('zone change',
    function()
        select_movement_feet()
    end
)


function select_movement_feet()
    if world.time >= 17*60 or world.time < 7*60 then
        gear.MovementFeet.name = gear.NightFeetName
    else
        gear.MovementFeet.name = gear.DayFeetName
    end
end
