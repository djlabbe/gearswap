-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('Mote-TreasureHunter')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false

    weapon_list = S{"Apocalypse", "Caladbolg", "Loxotic"}

    elemental_ws = S{'Dark Harvest','Shadow of Death','Infernal Scythe','Frostbite','Freezebite',
              'Burning Blade','Red Lotus Blade','Shining Blade','Seraph Blade','Sanguine Blade'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Caladbolg', 'Apocalypse', 'Loxotic'}

    state.Critical = M(false, 'Critical Aftermath TP')
    state.WeaponLock = M(true, 'Weapon Lock')

    gear.Artifact_Head = { name= "Ignominy Burgeonet +1" }
    gear.Artifact_Body = { name= "Ignominy Cuirass +3" }
    -- gear.Artifact_Hands = { name= "Ignominy Gauntlets" }
    gear.Artifact_Legs = { name= "Ignominy Flanchard +3" }
    gear.Artifact_Feet = { name= "Ignominy Sollerets +3" }

    gear.Relic_Head = { name= "Fallen's Burgeonet +3" }
    gear.Relic_Body = { name= "Fallen's Cuirass +1" }
    gear.Relic_Hands = { name= "Fallen's Gauntlets +1" }
    gear.Relic_Legs = { name= "Fallen's Flanchard +3" }
    gear.Relic_Feet = { name= "Fallen's Sollerets +1" }

    -- gear.Empyrean_Head = { name= "Heathen's Burgeonet +1" }
    gear.Empyrean_Body = { name= "Heathen's Cuirass +1" }
    gear.Empyrean_Hands = { name= "Heathen's Gauntlets +1" }
    -- gear.Empyrean_Legs = { name= "Heathen's Flanchard +1" }
    -- gear.Empyrean_Feet = { name= "Heathen's Sollerets +1" }

    include('Global-Binds.lua')    
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind !t input /ma "Stun" <t>')
    send_command('bind !y input /ja "Weapon Bash" <t>')
    send_command('bind !d input /ja "Scarlet Delirium" <me>')
    send_command('bind !m input /ja "Consume Mana" <me>')
    send_command('bind !a input /ja "Arcane Crest" <t>')
    send_command('bind !c input /ja "Arcane Circle" <me>')
    send_command('bind ^c input /ja "Warding Circle" <me>')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @a gs c toggle Critical')
    send_command('bind @e gs c cycle WeaponSet')

    set_macro_page(1, 8)
    send_command('wait 2; input /lockstyleset 8')
    get_combat_weapon()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !t')
    send_command('unbind !y')
    send_command('unbind !d')
    send_command('unbind !m')
    send_command('unbind !a')
    send_command('unbind !c')
    send_command('unbind ^c')
    send_command('unbind @a')
    send_command('unbind @e')
    send_command('unbind @r')
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    ---- Precast Sets ----

    -- Enmity set
    sets.Enmity = {}

    -- Precast sets to enhance JAs
    sets.precast.JA['Arcane Circle'] = {feet=gear.Artifact_Feet}
    sets.precast.JA['Blood Weapon'] = {body=gear.Relic_Body}
    sets.precast.JA['Dark Seal'] = {head=gear.Relic_Head}
    sets.precast.JA['Diabolic Eye'] = {hands=gear.Relic_Hands}
    sets.precast.JA['Last Resort'] = {
        feet=gear.Relic_Feet,
        back=gear.DRK_TP_Cape,
    }
    -- sets.precast.JA['Nether Void'] = {legs="Heath. Flanchard +1"}
    sets.precast.JA['Souleater'] = {head=gear.Artifact_Head}
    sets.precast.JA['Weapon Bash'] = {hands=gear.Artifact_Hands}

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Carmine_D_head, --10
        hands="Leyline Gloves", --8
        -- legs=gear.Ody_FC_legs, -- 5
        feet=gear.Carmine_B_feet, -- 8
        neck="Baetyl Pendant", --4
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --4
        ring1="Kishar Ring", --4
        ring2="Weather. Ring", --4
        -- back=gear.DRK_FC_Cape, --10
    }

    sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, {
        head=gear.Relic_Head,
    })


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        body=gear.Artifact_Body,
        hands= gear.Valo_WSD_hands,
        legs=gear.Relic_Legs,
        feet="Sulev. Leggings +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Catastrophe'] = {
        ammo="Crepuscular Pebble",
        head="Ratri Sallet +1",
        body=gear.Artifact_Body,
        hands="Rat. Gadlings +1",
        legs=gear.Relic_Legs,
        feet="Sulev. Leggings +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Lugra Earring +1",
        left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Torcleaver'] = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body=gear.Artifact_Body,
        hands=gear.Ody_WS_hands,
        legs=gear.Relic_Legs,
        feet="Sulev. Leggings +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back= gear.DRK_WS2_Cape,
    }

    sets.precast.WS['Cross Reaper'] = {
        ammo="Knobkierrie",
        head="Ratri Sallet +1",
        body=gear.Artifact_Body,
        hands="Ratri Gadlings +1",
        legs=gear.Relic_Legs,
        feet="Sulev. Leggings +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Regal Ring",
        right_ring="Epaminondas's Ring",
        back= gear.DRK_WS2_Cape,
    }


    
    sets.precast.WS['Shockwave'] = {
        ammo="Knobkierrie",
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands= gear.Valo_WSD_hands,
        legs=gear.Relic_Legs,
        feet="Sulev. Leggings +2",
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        back= gear.DRK_WS1_Cape,
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast['Enfeebling Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Carmine_D_head,
        body="Hjarrandi Breast.",
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        feet=gear.Artifact_Feet,
        neck="Erra Pendant",
        -- ear1="Digni. Earring",
        ear2="Malignance Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        waist="Skrymir Cord +1",
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Carmine_D_head,
        body=gear.Carmine_B_body,
        hands="Ratri Gadlings +1",
        legs=gear.Relic_Legs,
        feet="Rat. Sollerets +1",
        neck="Erra Pendant",
        -- ear1="Mani Earring",
        ear2="Malignance Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.DRK_DRK_Cape,
        waist="Skrymir Cord +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        hands=gear.Relic_Hands,
        feet=gear.Artifact_Hands,
        head="Pixie Hairpin +1",        
        ear1="Hirudinea Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back=gear.DRK_DRK_Cape,
        waist="Austerity Belt +1",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {
        head=gear.Artifact_Head,
        hands="Pavor Gauntlets",
        ring1="Kishar Ring",
        back="Chuparrosa Mantle",
        waist="Casso Sash",
    })

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {hands=gear.Empyrean_Hands})

    sets.midcast.Stun = sets.midcast['Dark Magic']

    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        head="Ratri Sallet +1",
        neck="Unmoving Collar +1",
        body=gear.Empyrean_Body,
        hands="Rat. Gadlings +1",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1",
        ear1="Odnowa Earring +1",
        ear2="Tuisto Earring",
        ring1=gear.Moonlight_1,
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
    })


    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_head,
        body=gear.Sakpata_body,
        hands=gear.Sakpata_hands,
        legs=gear.Carmine_D_legs,
        feet=gear.Sakpata_feet,
        neck="Sibyl Scarf",
        ear1="Infused Earring",
        ear2="Eabani Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.DRK_TP_Cape,
        waist="Flume Belt +1",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3
        head=gear.Sakpata_head, --10
        body=gear.Sakpata_body, --12
        hands=gear.Sakpata_hands, --8
        legs=gear.Sakpata_legs, --9
        feet=gear.Sakpata_feet, --6
        neck="Loricate Torque +1", --6/6
        ear1="Odnowa Earring +1", --3/5a
        back="Moonlight Cape", --6/6
    })


    sets.idle.Weak = set_combine(sets.idle, {})

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = {
        head="Hjarrandi Helm", --10
        body="Hjarrandi Breastplate", --12
        hands=gear.Sakpata_hands, --8
        legs=gear.Sakpata_legs, --9
        feet=gear.Sakpata_feet, --6
        ring2=gear.Moonlight_2, --5
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1", --3
        head=gear.Sakpata_head, --10
        body=gear.Sakpata_body, --12
        hands=gear.Sakpata_hands, --8
        legs=gear.Sakpata_legs, --9
        feet=gear.Sakpata_feet, --6
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1", --3/5a
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body=gear.Sakpata_body,
        hands=gear.Sakpata_hands,
        legs=gear.Artifact_Legs,
        feet="Flamma Gambieras +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Brutal Earring",
        ear2="Cessance Earring",
        ring1="Niqmaddu ring",
        ring2="Hetairoi Ring",
        back= gear.DRK_TP_Cape,
    }

    sets.engaged.Aftermath = {
        ammo="Yetshila +1", --2/6
        body="Hjarrandi Breast.", --13/0
        hands="Flam. Manopolas +2", --8/0,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Seeth. Bomblet +1",
        hands="Gazu Bracelet +1",
    })

    sets.idle.Town = set_combine(sets.idle.DT, {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Sakpata_hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Niqmaddu ring",
        right_ring="Hetairoi Ring",
        back= gear.DRK_TP_Cape,
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head=gear.Sakpata_head, --7
        body="Hjarrandi Breast.", --12
        hands=gear.Sakpata_hands, --8
        legs=gear.Sakpata_legs, --9
        feet=gear.Sakpata_feet, --6
        right_ring=gear.Moonlight_2,
    } --47

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.Caladbolg = {main="Caladbolg", sub="Utu Grip"}
    sets.Apocalypse = {main="Apocalypse", sub="Utu Grip"}
    sets.Loxotic = {main="Loxotic Mace +1", sub="Blurred Shield +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_precast(spell, action, spellMap, eventArgs)
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(field, new_value, old_value)
    check_weaponset()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    get_combat_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Caladbolg" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end

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

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''

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

function get_combat_weapon()
    state.CombatWeapon:reset()
    if weapon_list:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
end

function job_self_command(cmdParams, eventArgs)
end


function check_weaponset()
    equip(sets[state.WeaponSet.current])

    if state.WeaponSet.current == "Caladbolg" then
        send_command('@input /macro set 1')
    elseif state.WeaponSet.current == "Apocalypse" then
        send_command('@input /macro set 2')
    elseif state.WeaponSet.current == "Loxotic" then
        send_command('@input /macro set 3')
    end
end
