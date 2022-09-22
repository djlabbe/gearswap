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
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
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

    -- gear.Artifact_Head = { name= "Wakido Kabuto +3" }
    -- gear.Artifact_Body = { name= "Wakido Domaru +3" }
    gear.Artifact_Hands = { name= "Wakido Kote +3" }
    gear.Artifact_Legs = { name= "Wakido Haidate +3" }
    -- gear.Artifact_Feet = { name= "Wakido Sune-Ate +3" }

    gear.Relic_Head = { name= "Sakonji Kabuto +3" }
    gear.Relic_Body = { name= "Sakonji Domaru +3" }
    gear.Relic_Hands = { name= "Sakonji Kote +3" }
    gear.Relic_Legs = { name= "Sakonji Haidate +3" }
    gear.Relic_Feet = { name= "Sakonji Sune-Ate +3" }

    -- gear.Empyrean_Head = { name= "Kasuga Kabuto +1" }
    gear.Empyrean_Body = { name= "Kasuga Domaru +2" }
    gear.Empyrean_Hands = { name= "Kasuga Kote +1" }
    gear.Empyrean_Legs = { name= "Kasuga Haidate +2" }
    -- gear.Empyrean_Feet = { name= "Kasuga Sune-Ate +1" }

    -- Additional local binds
    include('Global-Binds.lua')

    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    if player.sub_job == 'DRG' then
        set_macro_page(2, 12)
    else
        set_macro_page(1, 12)
    end
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
        head=gear.Artifact_Head,
        hands=gear.Relic_Hands,
        back=gear.SAM_WS_Cape,
    }

    sets.buff['Meikyo Shisui'] = {feet=gear.Relic_Feet}
    sets.precast.JA.Sekkanoki = { hands=gear.Empyrean_Hands }
    sets.precast.JA.Sengikori = { feet=gear.Empyrean_Feet }
    sets.precast.JA['Warding Circle'] = {head=gear.Artifact_Helm}
    -- sets.precast.JA['Third Eye'] = {legs=gear.Relic_Legs}


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Masamune = { main="Masamune", sub="Utu Grip" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body=gear.Empyrean_Body,
        hands="Tatenashi Gote +1",
        legs=gear.Empyrean_Legs,
        feet=gear.Ryuo_C_Feet,
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
        -- head=gear.Mpaca_Head, --7/0
        body=gear.Empyrean_Body, --13/13
        -- hands=gear.Mpaca_Hands, --8/0
        legs=gear.Mpaca_Legs, --9/0
        feet=gear.Mpaca_Feet, --6/0
        ring2="Defending Ring", --10/10
    }

    sets.engaged.Subtle = {
        ammo="Aurgelmir Orb +1",
        head="Ken. Jinpachi +1", --8
        body="Dagon Breastplate", --(10)
        hands=gear.Artifact_Hands,
        legs=gear.Mpaca_Legs, --(5)
        feet=gear.Ryuo_C_Feet, --8
        neck="Bathy Choker +1", --11
        ear1="Schere Earring", --3
        -- ear2="Digni. Earring",
        ring1="Niqmaddu Ring", --(5)
        ring2="Chirich Ring +1", --10
        waist="Sarissapho. Belt", --5
        back=gear.SAM_TP_Cape,
    } --45/20

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    
    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Knobkierrie", --6
        head=gear.Mpaca_Head,
        body=gear.Relic_Body, --10
        hands=gear.Valo_WSD_Hands, --3
        legs= gear.Artifact_Legs, --10
        feet=gear.Valo_WSD_Feet, --4
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        left_ear="Thrud Earring", --3
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Epaminondas's Ring", --5
        back=gear.SAM_WS_Cape, --10
    } --48

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.HighTP = set_combine(sets.precast.WS, {
        head=gear.Valo_WSD_Head,
        ear2="Lugra Earring +1",
    })

    sets.precast.WS['Impulse Drive'] = {
        head=gear.Mpaca_Head,
        body="Tatena. Harama. +1",
        hands=gear.Ryuo_A_Hands,
        legs="Tatena. Haidate +1",
        neck="Sam. Nodowa +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Tachi: Jinpu'] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sam. Nodowa +2",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Orpheus's Sash",
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

     sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Legs,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Metamor. Ring +1",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Orpheus's Sash",
    })

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Flamma Zucchetto +2",
        body=gear.Empyrean_Body,
        hands=gear.Rao_D_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Rao_D_Feet,
        neck="Loricate Torque +1",
        waist="Flume Belt +1",
        ear1="Eabani Earring",
        ear2="Infused Earring",
        left_ring=gear.Chirich_1,
        right_ring=gear.Chirich_2,
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Mpaca_Head, --7/0
        body=gear.Mpaca_Body, --10/0
        hands=gear.Mpaca_Hands, --8/0
        legs=gear.Mpaca_Legs, --9/0
        feet=gear.Mpaca_Feet, --6/0
        ring2="Defending Ring", --10/10
    })

    sets.idle.Town =  {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body=gear.Empyrean_Body,
        hands="Tatenashi Gote +1",
        legs=gear.Empyrean_Legs,
        feet=gear.Ryuo_C_Feet,
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Niqmaddu Ring",
        ring2=gear.Chirich_2,
        back=gear.SAM_TP_Cape,
    }

    sets.idle.Weak = sets.idle.DT

    sets.Kiting = {
        feet="Danzo Sune-Ate"
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = {
        -- ammo="Staunch Tathlum +1", --3
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        neck="Sam. Nodowa +2",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        body=gear.Empyrean_Body, --13
        hands=gear.Artifact_Hands,
        ring1="Niqmaddu Ring",
        ring2="Defending Ring", --10
        back=gear.SAM_TP_Cape, --10/0
        waist="Sailfi Belt +1",
        legs=gear.Mpaca_Legs, --9
        feet=gear.Mpaca_Feet, --6
    } --48/23

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1", --3
        head=gear.Nyame_Head,
        neck="Warder's Charm +1",
        ear1="Flashward Earring",
        ear2="Eabani Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Purity Ring",
        ring2="Defending Ring",
        back=gear.SAM_TP_Cape, 
        waist="Carrier's Sash",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.buff.ThirdEye = {
        -- head=gear.Empyrean_Head,
        legs=gear.Relic_Legs,
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
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
        elseif player.tp == 3000 then
            equip(sets.precast.WS.HighTP)
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
    elseif buff == "Third Eye" then
        if gain and state.Buff.Seigan then
            equip(sets.buff.ThirdEye)
            disable('legs')
        else
            enable('legs')
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