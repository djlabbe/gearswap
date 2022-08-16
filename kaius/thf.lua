-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    gs c cycle treasuremode (set on ctrl-= by default): Cycles through the available treasure hunter modes.
    
    Treasure hunter modes:
        None - Will never equip TH gear
        Tag - Will equip TH gear sufficient for initial contact with a mob (either melee, ranged hit, or Aeolian Edge AOE)
        SATA - Will equip TH gear sufficient for initial contact with a mob, and when using SATA
        Fulltime - Will keep TH gear equipped fulltime
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    
    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    include('global-binds.lua')
    
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')

    -- Additional local binds
    send_command('bind !` input /ja "Flee" <me>')
    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind !t input /ja "Provoke" <t>')

      -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 6)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 6)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 6)
    else
        set_macro_page(1, 6)
    end

    send_command('wait 2; input /lockstyleset 6')
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind !`')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !t')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        hands="Plunderer's Armlets +3",
    }
    
    sets.Kiting = {
        feet="Jute Boots +1"
    }

    -- Actions we want to use to tag TH.
    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter


    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +3"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        body="Passion Jacket",
        hands="Plunderer's Armlets +3",
    }

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}


    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb",
        hands="Leyline Gloves",
        ear1="Enchanter's Earring +1",
        ear2="Loquacious Earring",
        ring2="Weatherspoon Ring",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, { 
        body="Passion Jacket",
        neck="Magoraga Beads"
    })

    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}
    sets.precast.WS.Acc = sets.precast.WS

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Evisceration'] = 
    {
        ammo="Yetshila +1",
        head=gear.Adhemar_B_head,
        body="Gleti's Cuirass",
        hands="Meg. Gloves +2",
        legs={ name="Zoar Subligar +1", augments={'Path: A',}},
        feet={ name="Herculean Boots", augments={'Attack+14','"Triple Atk."+4','AGI+8','Accuracy+13',}},
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Moonshade Earring",
        right_ear="Odr Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        back=gear.THF_TP_Cape,
    }

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS,
    {
        ammo="Seething Bomblet +1",
        head=gear.Adhemar_B_head,
        body=gear.Adhemar_A_body,
        hands="Meg. Gloves +2",
        legs=gear.Herc_TA_legs,
        feet=gear.Lustratio_D_feet,
        neck={ name="Asn. Gorget +2", augments={'Path: A',}},
        waist="Grunfeld Rope",
        left_ear="Moonshade Earring",
        right_ear="Odr Earring",
        left_ring="Ilabrat Ring",
        right_ring="Regal Ring",
        back=gear.THF_TP_Cape,
    })

    sets.precast.WS['Aeolian Edge'] = {
        ammo={ name="Seething Bomblet +1", augments={'Path: A',}},
        head={ name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +1%','Mag. Acc.+5 "Mag.Atk.Bns."+5',}},
        body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+23','Weapon skill damage +4%','DEX+2','Mag. Acc.+10',}},
        hands={ name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Mag.Atk.Bns."+15',}},
        legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +5%','DEX+7','Mag. Acc.+7',}},
        feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','INT+9',}},
        neck="Baetyl Pendant",
        waist="Orpheus's Sash",
        left_ear="Moonshade Earring",
        right_ear="Friomisi Earring",
        left_ring="Shiva Ring +1",
        right_ring="Epaminondas's Ring",
        back=gear.THF_TP_Cape,
    }

    sets.precast.WS['Cyclone'] = sets.precast.WS["Aeolian Edge"]


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
    
    }

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        feet="Jute Boots +1",
        neck={ name="Bathy Choker +1", augments={'Path: A',}},
        waist="Flume Belt +1",        
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        right_ear="Eabani Earring",
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        back=gear.THF_TP_Cape,
    }

    sets.idle.Town = {
        ammo="Aurgelmir Orb +1",
        head=gear.Malignance_head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        feet="Jute Boots +1",
        neck={ name="Asn. Gorget +2", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Hetairoi Ring",
        right_ring="Gere Ring",
        back=gear.THF_TP_Cape,
    }


    -- Defense sets
    sets.defense.Evasion = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        feet=gear.Malignance_feet,
        neck={ name="Asn. Gorget +2", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Sherida Earring",
        right_ear="Eabani Earring",
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        back=gear.THF_TP_Cape,
    }

    sets.defense.PDT = sets.defense.Evasion -- TODO

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_head,
        body=gear.Malignance_body,
        hands=gear.Malignance_hands,
        legs=gear.Malignance_legs,
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
        feet=gear.Malignance_feet,
    } 
    


    --------------------------------------
    -- Melee sets
    --------------------------------------

    -- Normal melee group
    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=gear.Adhemar_B_head,
        body=gear.Adhemar_A_body,
        hands=gear.Adhemar_B_hands,
        legs=gear.Herc_TA_legs,
        feet=gear.Herc_TA_feet,
        neck={ name="Asn. Gorget +2", augments={'Path: A',}},
        waist="Reiki Yotai",
        left_ear="Sherida Earring",
        right_ear="Dedition Earring",
        left_ring="Hetairoi Ring",
        right_ring="Gere Ring",
        back=gear.THF_TP_Cape,
    }

    sets.engaged.Hybrid = {
        head=gear.Malignance_head, --6/6
        body=gear.Malignance_body,
        legs=gear.Malignance_legs, --7/7
        hands=gear.Malignance_hands, --7/7
        feet=gear.Malignance_feet, --4/4    
        ring2="Defending Ring", --10/10
    }

    sets.engaged.Acc = set_combine(sets.engaged,
    {
        left_ring=gear.Chirich_1,
        right_ring="Moonlight Ring",
    })
        
    sets.engaged.Evasion = set_combine(sets.engaged,
    {
        ammo="Ginsen",
        left_ring=gear.Chirich_1,
        right_ring="Moonlight Ring",
    })

    sets.engaged.Acc.Evasion = sets.engaged
    sets.engaged.PDT = sets.engaged
    sets.engaged.Acc.PDT =sets.engaged

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    -- if spell.english == 'Aeolian Edge' and state.TreasureMode.value ~= 'None' then
    --     equip(sets.TreasureHunter)
    if spell.english=='Sneak Attack' or spell.english=='Trick Attack' or spell.type == 'WeaponSkill' then
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
    end
end

-- Run after the general midcast() set is constructed.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if state.TreasureMode.value ~= 'None' and spell.action_type == 'Ranged Attack' then
        equip(sets.TreasureHunter)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if state.Buff[buff] ~= nil then
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function get_custom_wsmode(spell, spellMap, defaut_wsmode)
    local wsmode

    if state.Buff['Sneak Attack'] then
        wsmode = 'SA'
    end
    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end


-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    -- Check that ranged slot is locked, if necessary
    check_range_lock()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end


-- function customize_idle_set(idleSet)
--     if player.hpp < 80 then
--         idleSet = set_combine(idleSet, sets.ExtraRegen)
--     end

--     return idleSet
-- end


function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    return meleeSet
end


-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    th_update(cmdParams, eventArgs)
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end
    
    msg = msg .. ', TH: ' .. state.TreasureMode.value

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
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


-- -- Function to lock the ranged slot if we have a ranged weapon equipped.
function check_range_lock()
    if player.equipment.range ~= 'empty' then
        disable('range', 'ammo')
    else
        enable('range', 'ammo')
    end
end