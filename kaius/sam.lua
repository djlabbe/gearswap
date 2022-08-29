-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+A ]           AttackMode: Capped/Uncapped WS Modifier
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
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false

    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Subtle')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')
    
    state.WeaponSet = M{['description']='Weapon Set', 'Masamune', 'ShiningOne'}
    state.WeaponLock = M(true, 'Weapon Lock')

    -- Additional local binds
    include('Global-Binds.lua')

    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    set_macro_page(1, 12)
    send_command('wait 2; input /lockstyleset 12')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !t')
    send_command('unbind @w')
    send_command('unbind @e')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    
    -- Fast cast sets for spells
    sets.precast.FC = {
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Weather. Ring", --6(4)
    }

    sets.precast.JA.Meditate = {
        -- head="Wakido Kabuto +2",
        hands="Sakonji Kote +3",
        back=gear.SAM_WS_Cape,
    }

    sets.precast.JA.Sekkanoki = { hands="Kasuga Kote +1" }
    sets.precast.JA.Sengikori = { hands="Kasuga Sune-Ate +1" }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Masamune = { main="Masamune", sub="Utu Grip" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body="Tatenashi Haramaki +1",
        hands="Wakido Kote +3",
        legs="Tatena. Haidate +1",
        feet=gear.Ryuo_C_feet,
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        left_ring="Niqmaddu Ring",
        right_ring=gear.Chirich_2,
        back=gear.SAM_TP_Cape,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Aurgelmir Orb +1",
        head="Ken. Jinpachi +1",
        ear2="Schere Earring",
        waist="Ioskeha Belt +1",
        left_ring="Regal Ring",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head=gear.Mpaca_head, --7/0
        body=gear.Mpaca_body, --10/0
        hands=gear.Mpaca_hands, --8/0
        legs=gear.Mpaca_legs, --9/0
        feet=gear.Mpaca_feet, --6/0
        ring2="Defending Ring", --10/10
    }

    sets.engaged.Subtle = {
        ammo="Aurgelmir Orb +1",
        head="Ken. Jinpachi +1",
        body="Dagon Breastplate",
        hands="Wakido Kote +3",
        legs="Mpaca's Hose",
        feet=gear.Ryuo_C_feet,
        neck="Bathy Choker +1",
        ear1="Schere Earring",
        -- ear2="Digni. Earring",
        ring1="Niqmaddu Ring",
        ring2="Chirich Ring +1",
        waist="Sarissapho. Belt",
        back=gear.SAM_TP_Cape,
        
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Mpaca_head,
        body=gear.Valo_WSD_body,
        hands=gear.Valo_WSD_hands,
        legs="Hiza. Hizayoroi +2",
        feet=gear.Valo_WSD_feet,
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Impulse Drive'] = {
        head=gear.Mpaca_head,
        body="Tatena. Harama. +1",
        hands=gear.Ryuo_A_hands,
        legs="Tatena. Haidate +1",
        neck="Sam. Nodowa +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {
        waist="Ioskeha Belt +1",
    })

    sets.precast.WS['Impulse Drive'].AttackCap = sets.precast.WS['Impulse Drive']

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {
        head="Blistering Sallet +1",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
    })

    sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Impulse Drive']

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body="Tatenashi Haramaki +1",
        hands="Wakido Kote +3",
        legs="Tatena. Haidate +1",
        feet="Tatena. Sune. +1",
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        left_ring="Niqmaddu Ring",
        right_ring=gear.Chirich_2,
        back=gear.SAM_TP_Cape,
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Mpaca_head, --7/0
        body=gear.Mpaca_body, --10/0
        hands=gear.Mpaca_hands, --8/0
        legs=gear.Mpaca_legs, --9/0
        feet=gear.Mpaca_feet, --6/0
        ring2="Defending Ring", --10/10
    })

    sets.idle.Town =  {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body="Tatenashi Haramaki +1",
        hands="Wakido Kote +3",
        legs="Tatena. Haidate +1",
        feet="Tatena. Sune. +1",
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        left_ring="Niqmaddu Ring",
        right_ring=gear.Chirich_2,
        back=gear.SAM_TP_Cape,
    }

    sets.idle.Weak = sets.idle.DT

    sets.Kiting = {
        feet="Danzo Sune-Ate"
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.buff.Doom = {
        -- neck="Nicander's Necklace", --20
        -- ring1={name="Eshmun's Ring", bag="wardrobe3"}, --20
        -- ring2={name="Eshmun's Ring", bag="wardrobe4"}, --20
        waist="Gishdubar Sash", --10
    }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Impulse Drive' and player.tp > 2000 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
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

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    check_weaponset()
    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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

function check_weaponset()
    equip(sets[state.WeaponSet.current])

    if state.WeaponSet.current == "Masamune" then
        send_command('@input /macro set 1')
    elseif state.WeaponSet.current == "ShiningOne" then
        send_command('@input /macro set 2')
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