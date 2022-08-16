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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'HP', 'Charm')
    state.MagicalDefenseMode:options('MDT', 'HP', 'Charm')
    
    state.EquipShield = M(true, 'Equip Shield w/Defense')

    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end
    send_command('wait 2; input /lockstyleset 7')
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    -- sets.precast.JA['Invincible'] = {legs="Caballarius Breeches"}
    -- sets.precast.JA['Holy Circle'] = {feet="Reverence Leggings +3"}
    -- sets.precast.JA['Shield Bash'] = {hands="Caballarius Gauntlets +2"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings +3"}
    -- sets.precast.JA['Rampart'] = {head="Caballarius Coronet +1"}
    -- sets.precast.JA['Fealty'] = {body="Caballarius Surcoat +1"}
    -- sets.precast.JA['Divine Emblem'] = {feet="Chevalier's Sabatons +1"}
    -- sets.precast.JA['Cover'] = {head="Reverence Coronet +1"}

    sets.precast.JA['Chivalry'] = { -- Max MND
        ammo="Sapience Orb",
        head="Hjarrandi Helm",
        body=gear.Souveran_C_body,
        hands=gear.Souveran_C_hands,
        legs=gear.Souveran_C_legs,
        feet=gear.Eschite_A_feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        -- right_ear="Cryptic Earring",
        left_ring="Apeile Ring +1",
        right_ring="Eihwaz Ring",
        back=gear.PLD_cape,
    }


    sets.precast.FC = { -- FC/SIRD
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_head, -- 0/20
        -- body="Rev. Surcoat +3", 
        hands="Leyline Gloves", --5/0
        legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}}, -- 0/30
        feet=gear.Ody_CURE_feet, -- 5/20
        neck="Moonlight Necklace", -- 0/15
        waist="Audumbla Sash", -- 0/10
        left_ear="Tuisto Earring",
        -- right_ear="Etiolation Earring",
        left_ring="Weather. Ring", --5/0
        right_ring="Gelatinous Ring +1",
        back=gear.PLD_FC_cape, --8/10
    } -- 23% FC, 112% SIRD

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.WS = {
        ammo="Crepuscular Pebble",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Unmoving Collar +1",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Regal Ring",
        -- back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS.Acc = sets.precast.WS

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ginsen",
        ear1="Friomisi Earring",
        ring1="Shiva Ring +1",
    }
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.Enmity = {
        ammo="Sapience Orb",
        head=gear.Souveran_C_head,
        body=gear.Souveran_C_body,
        hands=gear.Souveran_C_hands,
        legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}},
        feet=gear.Eschite_C_feet,
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        left_ear="Tuisto Earring",
        right_ear="Knightly Earring",
        left_ring="Apeile Ring +1",
        right_ring="Gelatinous Ring +1",
        back=gear.PLD_cape,
    }

    sets.midcast.Flash = set_combine(sets.Enmity, {{
        head="Loess Barbuta +1",
        body=gear.Souveran_C_body,
        hands=gear.Souveran_C_hands,
        legs=gear.Souveran_C_legs,
        feet=gear.Eschite_A_feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        -- right_ear="Cryptic Earring",
        left_ring="Apeile Ring +1",
        right_ring="Eihwaz Ring",
        back=gear.PLD_cape,
    }})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = { -- Cure/SIRD 
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_head, --0/20
        body=gear.Souveran_C_body, --11/0
        hands="Macabre Gaunt. +1", --11/0
        legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}}, --0/30
        feet=gear.Ody_CURE_feet, --13/20
        neck="Unmoving Collar +1",
        waist="Audumbla Sash", --0/10
        left_ear="Nourishing Earring +1", --7/5
        right_ear="Knightly Earring", --0/9
        left_ring="Apeile Ring +1",
        right_ring="Gelatinous Ring +1",
        back=gear.PLD_cape, 
    } -- 42/105

    sets.midcast.Blue = { --Enm/SIRD
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_head, --9/20
        body=gear.Souveran_C_body, --20/0
        hands=gear.Souveran_C_hands, --9/0
        legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}}, --0/30
        feet=gear.Ody_CURE_feet, --0/20
        neck="Moonlight Necklac", --15/15
        waist="Audumbla Sash", --0/10
        left_ear="Tuisto Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Apeile Ring +1", --9/0
        right_ring="Gelatinous Ring +1",
        back=gear.PLD_cape, --10/0
    } --115 sird
        
    
    sets.midcast['Sheep Song'] = sets.midcast.Blue;
    sets.midcast['Geist Wall'] = sets.midcast.Blue;
    sets.midcast['Blank Gaze'] = sets.midcast.Blue;
    sets.midcast['Jettatura'] = sets.midcast.Blue;
    

    sets.midcast['Enhancing Magic'] = {
        ammo="Staunch Tathlum +1",
        head=gear.Souveran_C_head,
        body=gear.Souveran_C_body,
        hands=gear.Souveran_C_hands,
        legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}},
        feet=gear.Eschite_C_feet,
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        left_ear="Tuisto Earring",
        right_ear="Knightly Earring",
        left_ring="Apeile Ring +1",
        right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
        back=gear.PLD_cape,
    }
    
    sets.midcast.Protect = {sub="Priwen"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
	 sets.midcast.Phalanx = {
        main="Sakpata's Sword",
        sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
        ammo="Staunch Tathlum +1",
        head=gear.Yorium_PHLX_head,
        body=gear.Yorium_PHLX_body,
        hands=gear.Souveran_C_hands,
        legs="Sakpata's Cuisses",
        feet=gear.Souveran_D_feet,
        neck="Incanter's Torque",
        waist="Olympus Sash",
        left_ear="Mimir Earring",
        right_ear="Andoaa Earring",
        left_ring=gear.Stikini_1,
        right_ring=gear.Stikini_2,
        -- back={ name="Weard Mantle", augments={'VIT+4','DEX+3','Enmity+3','Phalanx +5',}},
    }

	sets.precast.JA = {
        ammo="Sapience Orb",
        head="Loess Barbuta +1",
        body=gear.Souveran_C_body,
        hands=gear.Souveran_C_hands,
        legs=gear.Souveran_C_legs,
        feet=gear.Eschite_A_feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        -- right_ear="Cryptic Earring",
        left_ring="Apeile Ring +1",
        right_ring="Eihwaz Ring",
        back=gear.PLD_cape,
    }

	sets.midcast.Reprisal = {
        ammo="Staunch Tathlum +1",
        head=gear.Souveran_C_head,
        -- body="Rev. Surcoat +3",
        hands="Leyline Gloves",
        legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+14','Attack+13','Breath dmg. taken -3%',}},
        -- feet={ name="Odyssean Greaves", augments={'"Fast Cast"+6','STR+5','Accuracy+3',}},
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        left_ear="Tuisto Earring",
        -- right_ear="Etiolation Earring",
        left_ring="Weather. Ring",
        right_ring="Gelatinous Ring +1",
        -- back={ name="Rudianos's Mantle", augments={'HP+60','"Fast Cast"+10','Spell interruption rate down-6%',}},
    }

	
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.resting = {
        ring1="Sheltered Ring",
        waist="Austerity Belt +1"
    }

    -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Moonlight Ring",
        right_ring="Moonlight Ring",
        back=gear.PLD_cape,
    }

    sets.idle.Town = {
        ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Carmine Cuisses +1",
        feet="Sakpata's Leggings",
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Moonlight Ring",
        right_ring="Moonlight Ring",
        back=gear.PLD_cape,
    }
    
    
    sets.Kiting = {legs="Carmine Cuisses +1"}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    --------------------------------------
    -- Defense sets
    --------------------------------------
    

    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"} -- Ochain
    sets.MagicalShield = {sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        left_ear="Tuisto Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Eihwaz Ring",
        right_ring="Gelatinous Ring +1",
        back="Moonlight Cape",
    }

    sets.defense.HP = {

    }
 
    sets.defense.Charm = {
        neck="Unmoving Collar +1",
        legs=gear.Souveran_C_legs,
        back="Solemnity Cape", -- Yes
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head="Sakpata's Helm",
        body="Sakpata's Plate",
        hands="Sakpata's Gauntlets",
        legs="Sakpata's Cuisses",
        feet="Sakpata's Leggings",
        neck="Moonlight Necklace",
        ear1="Odnowa Earring +1",
        ear2="Eabani Earring",      
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.PLD_cape,
        waist="Asklepian Belt",
    }


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
        sub="Ochain",
        ammo="Staunch Tathlum +1", --3
        head="Sakpata's Helm", --7
        body="Sakpata's Plate", --10
        hands="Sakpata's Gauntlets", --8
        legs="Sakpata's Cuisses", --9
        feet="Sakpata's Leggings", --6
        neck="Unmoving Collar +1",
        waist="Asklepian Belt",
        left_ear="Tuisto Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Moonlight Ring", --5
        right_ring="Moonlight Ring",--5
        back=gear.PLD_cape,
    } --53 + (5 cape)


    sets.engaged.Acc =  sets.engaged
    sets.engaged.PDT = sets.engaged
    sets.engaged.Acc.PDT = sets.engaged
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    sets.buff.Doom = {ring2="Saida Ring"}
    -- sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomMeleeGroups:clear()
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------



-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end