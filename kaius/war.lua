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

-- Setup vars that are user-independent.
function job_setup()
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
    "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Naegling', 'Loxotic', 'ShiningOne' }
    state.WeaponLock = M(false, 'Weapon Lock')

    -- Additional local binds
    include('Global-Binds.lua')

    -- gear.Artifact_Head = { name= "Pummeler's Mask +1" }
    gear.Artifact_Body = { name= "Pummeler's Lorica +1" }
    -- gear.Artifact_Hands = { name= "Pummeler's Mufflers +1" }
    -- gear.Artifact_Legs = { name= "Pummeler's Cuisses +1" }
    -- gear.Artifact_Feet = { name= "Pummeler's Calligae +1" }

    gear.Relic_Head = { name= "Agoge Mask +3" }
    gear.Relic_Body = { name= "Agoge Lorica +1" }
    -- gear.Relic_Hands = { name= "Agoge Mufflers +1" }
    -- gear.Relic_Legs = { name= "Agoge Cuisses +1" }
    gear.Relic_Feet = { name= "Agoge Calligae +3" }

    -- gear.Empyrean_Head = { name= "Boii Mask +1" }
    gear.Empyrean_Body = { name= "Boii Lorica +1" }
    gear.Empyrean_Hands = { name= "Boii Mufflers +1" }
    -- gear.Empyrean_Legs = { name= "Boii Cuisses +1" }
    -- gear.Empyrean_Feet = { name= "Boii Calligae +1" }

    gear.WAR_TP_Cape = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.WAR_WS1_Cape = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')
    
    if player.sub_job == 'SAM' then
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
    end
    send_command('bind !t input /ja "Provoke" <t>')

    -- Set macros and style
    set_macro_page(1, 1)
    send_command('wait 2; input /lockstyleset 1' )

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !t')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.precast.JA["Berserk"] = {
        body=gear.Artifact_Body,
        feet=gear.Relic_Feet,
    }

    sets.precast.JA["Warcry"] = {
        head=gear.Relic_Head
    }

    sets.precast.JA['Restraint'] = {
        hands=gear.Empyrean_Hands,
    }

    sets.precast.JA['Blood Rage'] = {
        body=gear.Empyrean_Body,
    }
    
    sets.precast.JA['Aggressor'] = {
        body=gear.Relic_Body,
        head=gear.Relic_Head,
    }

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Sakpata_Head, --8
        hands="Leyline Gloves", --8
        neck="Baetyl Pendant", --4
        ear1="Etiolation Earring", --1
        ear2="Enchanter's Earring +1", --2
        ring2="Weather. Ring",
    }

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2", --STP6 TA5
        body=gear.Sakpata_Body,
        hands="Tatena. Gote +1",
        legs="Tatena. Haidate +1",
        feet="Tatena. Sune. +1",
        neck="Vim Torque +1",
        waist="Sailfi Belt +1",
        ear1="Schere Earring",
        ear2="Telos Earring",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
        back=gear.WAR_TP_Cape,
    }

    sets.engaged.Acc = {
        -- TODO
    }

    sets.engaged.Hybrid = {
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
    }

   
    
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.precast.WS = {
        head=gear.Relic_Head, --WSD10
        body=gear.Nyame_Body,
        neck="Fotia Gorget",
        ring1="Niqmaddu Ring",
        ring2="Epaminondas's Ring",
        legs=gear.Nyame_Legs,
        hands=gear.Nyame_Hands,
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        waist="Sailfi Belt +1",
        ammo="Knobkierrie",
        feet=gear.Nyame_Feet,
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        -- TODO
    })

    sets.precast.WS['Savage Blade'] = { --OH WSD7
        ammo="Knobkierrie", --WSD6
        head=gear.Relic_Head, --WSD10
        body=gear.Relic_Head, --WSD10
        -- hands="Boii Mufflers +3",  --WSD12
        hands=gear.Nyame_Hands,
        -- legs="Boii cuisses +3", --PDL10
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet, --WSD8
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring", 
        ear2="Thrud Earring", --WSD3
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",       
        back=gear.WAR_WS1_Cape, --WSD10
    }    --Fencer3(TPB+1210) WSD66 PDL10

    sets.precast.WS['Upheaval'] = { --TPB500
        ammo="Knobkierrie", --WSD6
        head=gear.Relic_Head, --WSD10
        neck="Warrior's bead necklace +2",  --DA6
        ear1="Moonshade Earring", --TPB250
        ear2="Thrud Earring", --WSD3
        body=gear.Nyame_Body, --WSD10 DA2
        hands=gear.Nyame_Hands,  --TPB100 WSD12
        ring1="Niqmaddu Ring", --QA3
        ring2="Gelatinous Ring +1",
        back=gear.WAR_WS1_Cape, --WSD10
        waist="Sailfi Belt +1", --TA2 DA5
        legs=gear.Nyame_Legs, --PDL10 DA8
        feet=gear.Nyame_Feet, --WSD8 DA2
    } --TPB850 - WSD59 - PDL10 - QA3 - TA2 - DA56

    sets.precast.WS['Cataclysm'] = {
        ammo="Knobkierrie",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Legs,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        waist="Eschan Stone",
        left_ear="Moonshade Earring",
        right_ear="Friomisi Earring",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=gear.WAR_WS1_Cape,
    }

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Bathy Choker +1",
        ear1="Odnowa Earring +1",
        ear2="Etiolation Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.WAR_TP_Cape,
        waist="Flume Belt +1"
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.Naegling = { main="Naegling", sub="Blurred Shield +1" }
    sets.Loxotic = { main="Loxotic Mace +1", sub="Blurred Shield +1" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }
    sets.Chango = { main="Chango", sub="Utu Grip" }
    sets.Kiting = { feet="Hermes' Sandals" }

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end


function job_buff_change(buff,gain)
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

    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
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

