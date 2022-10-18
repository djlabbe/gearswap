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

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
        "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
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

    state.WeaponSet = M{['description']='Weapon Set', 'Sakpata', 'Naegling'}
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name="Reverence Coronet +1" }
    gear.Artifact_Body = { name="Reverence Surcoat +1" }
    gear.Artifact_Hands = { name="Reverence Gauntlets +1" }
    gear.Artifact_Legs = { name="Reverence Breeches +1" }    
    gear.Artifact_Feet = { name="Reverence Leggings +1" }

    gear.Relic_Head = { name="Caballarius Coronet +1" }
    gear.Relic_Body = { name="Caballarius Surcoat +1" }
    gear.Relic_Hands = { name="Caballarius Gauntlets +1" }
    gear.Relic_Legs = { name="Caballarius Breeches +1" }
    gear.Relic_Feet = { name="Caballarius Leggings +3" }

    gear.Empyrean_Head = { name="Chevalier's Armet +1" }
    gear.Empyrean_Body = { name="Chevalier's Cuirass +1" }
    gear.Empyrean_Hands = { name="Chevalier's Gauntlets +1" }
    gear.Empyrean_Legs = { name="Chevalier's Cuisses +1" }
    gear.Empyrean_Feet = { name="Chevalier's Sabatons +1" }

    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'BLU' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end
    send_command('wait 2; input /lockstyleset 7')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
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
    sets.precast.JA['Invincible'] = {legs=gear.Relic_Legs}
    sets.precast.JA['Holy Circle'] = {feet=gear.Artifact_Feet}
    sets.precast.JA['Shield Bash'] = {hands=gear.Relic_Hands}
    sets.precast.JA['Sentinel'] = {feet=gear.Relic_Feet}
    sets.precast.JA['Rampart'] = {head=gear.Relic_Head}
    sets.precast.JA['Fealty'] = {body=gear.Relic_Body}
    sets.precast.JA['Divine Emblem'] = {feet=gear.Empyrean_Feet}
    sets.precast.JA['Cover'] = {head=gear.Artifact_Head}

    sets.precast.JA['Chivalry'] = { -- Max MND
        ammo="Sapience Orb",
        head="Hjarrandi Helm",
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Souveran_C_Legs,
        feet=gear.Eschite_A_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        -- ear2="Cryptic Earring",
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
        back=gear.PLD_Cape,
    }


    sets.precast.FC = { -- FC/SIRD
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_Head, -- 0/20
        -- body="Rev. Surcoat +3", 
        hands="Leyline Gloves", --5/0
        legs="Founder's Hose",--0/30
        feet=gear.Ody_CURE_Feet, -- 5/20
        neck="Moonlight Necklace", -- 0/15
        waist="Audumbla Sash", -- 0/10
        ear1="Tuisto Earring",
        ear2="Etiolation Earring",
        ring1="Weather. Ring", --5/0
        ring2="Gelatinous Ring +1",
        back=gear.PLD_FC_Cape, --8/10
    } -- 23% FC, 112% SIRD

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.WS = {
        ammo="Crepuscular Pebble",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Regal Ring",
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
        head=gear.Souveran_C_Head,
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs="Founder's Hose",--0/30
        feet=gear.Eschite_C_Feet,
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        ear1="Tuisto Earring",
        ear2="Knightly Earring",
        ring1="Apeile Ring +1",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape,
    }

    sets.midcast.Flash = set_combine(sets.Enmity, {{
        head="Loess Barbuta +1",
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Souveran_C_Legs,
        feet=gear.Eschite_A_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        -- ear2="Cryptic Earring",
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
        back=gear.PLD_Cape,
    }})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = { -- Cure/SIRD 
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_Head, --0/20
        body=gear.Souveran_C_Body, --11/0
        hands="Macabre Gaunt. +1", --11/0
        legs="Founder's Hose",--0/30
        feet=gear.Ody_CURE_Feet, --13/20
        neck="Unmoving Collar +1",
        waist="Audumbla Sash", --0/10
        ear1="Nourishing Earring +1", --7/5
        ear2="Knightly Earring", --0/9
        ring1="Apeile Ring +1",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape, 
    } -- 42/105

    sets.midcast.Blue = { --Enm/SIRD
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_Head, --9/20
        body=gear.Souveran_C_Body, --20/0
        hands=gear.Souveran_C_Hands, --9/0
        legs="Founder's Hose",--0/30
        feet=gear.Ody_CURE_Feet, --0/20
        neck="Moonlight Necklace", --15/15
        waist="Audumbla Sash", --0/10
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Apeile Ring +1", --9/0
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape, --10/0
    } --115 sird
        
    
    sets.midcast['Sheep Song'] = sets.midcast.Blue;
    sets.midcast['Geist Wall'] = sets.midcast.Blue;
    sets.midcast['Blank Gaze'] = sets.midcast.Blue;
    sets.midcast['Jettatura'] = sets.midcast.Blue;
    

    sets.midcast['Enhancing Magic'] = {
        ammo="Staunch Tathlum +1",
        head=gear.Souveran_C_Head,
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs="Founder's Hose",--0/30
        feet=gear.Eschite_C_Feet,
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        ear1="Tuisto Earring",
        ear2="Knightly Earring",
        ring1="Apeile Ring +1",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape,
    }
    
    sets.midcast.Protect = {sub="Priwen"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
	
	 sets.midcast.Phalanx = {
        main="Sakpata's Sword",
        sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
        ammo="Staunch Tathlum +1",
        head=gear.Yorium_PHLX_Head,
        body=gear.Yorium_PHLX_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Souveran_D_Feet,
        neck="Incanter's Torque",
        waist="Olympus Sash",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back={ name="Weard Mantle", augments={'VIT+4','DEX+3','Enmity+3','Phalanx +5',}},
    }

	sets.precast.JA = {
        ammo="Sapience Orb",
        head="Loess Barbuta +1",
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Souveran_C_Legs,
        feet=gear.Eschite_A_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        -- ear2="Cryptic Earring",
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
        back=gear.PLD_Cape,
    }

	sets.midcast.Reprisal = {
        ammo="Staunch Tathlum +1",
        head=gear.Souveran_C_Head,
        -- body="Rev. Surcoat +3",
        hands="Leyline Gloves",
        legs="Founder's Hose",--0/30
        -- feet={ name="Odyssean Greaves", augments={'"Fast Cast"+6','STR+5','Accuracy+3',}},
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        ear1="Tuisto Earring",
        ear2="Etiolation Earring",
        ring1="Weather. Ring",
        ring2="Gelatinous Ring +1",
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
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Moonlight Ring",
        back=gear.PLD_Cape,
    }

    sets.idle.Town = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring",
        ring2="Moonlight Ring",
        back=gear.PLD_Cape,
    }
    
    
    sets.Kiting = {legs=gear.Carmine_D_Legs}
    sets.latent_refresh = {waist="Fucho-no-obi"}
    --------------------------------------
    -- Defense sets
    --------------------------------------
    

    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"}
    sets.MagicalShield = {sub="Aegis"}

    -- Basic defense sets.
        
    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Eihwaz Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
    }

    sets.defense.HP = {

    }
 
    sets.defense.Charm = {
        neck="Unmoving Collar +1",
        legs=gear.Souveran_C_Legs,
        back="Solemnity Cape", -- Yes
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Moonlight Necklace",
        ear1="Odnowa Earring +1",
        ear2="Eabani Earring",      
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.PLD_Cape,
        waist="Asklepian Belt",
    }


    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {
        ammo="Staunch Tathlum +1", --3
        head=gear.Sakpata_Head, --7
        body=gear.Sakpata_Body, --10
        hands=gear.Sakpata_Hands, --8
        legs=gear.Sakpata_Legs, --9
        feet=gear.Sakpata_Feet, --6
        neck="Unmoving Collar +1",
        waist="Asklepian Belt",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Moonlight Ring", --5
        ring2="Moonlight Ring",--5
        back=gear.PLD_Cape,
    } --53 + (5 cape)


    sets.engaged.Acc =  sets.engaged
    sets.engaged.PDT = sets.engaged
    sets.engaged.Acc.PDT = sets.engaged
    
    --------------------------------------
    -- Custom buff sets
    --------------------------------------
    -- sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.Sakpata = { main="Sakpata's Sword", sub="Srivatsa" }
    sets.Naegling = { main="Naegling", sub="Srivatsa"}

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

function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)

    
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
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()
    
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

------------------------------------------------------------------------------------------------------------------
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
    if no_swap_gear:contains(player.equipment.ring1) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.ring2) then
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
        if no_swap_gear:contains(player.equipment.ring1) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.ring2) then
            enable("ring2")
            equip(sets.idle)
        end
    end
)
