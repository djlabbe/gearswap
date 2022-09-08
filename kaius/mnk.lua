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
    weapon_list = S{"Karambit"}
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Karambit'}

    -- Additional local binds
    include('Global-Binds.lua')

    send_command('bind !t input /ja "Provoke" <t>')

    set_macro_page(1, 2)
    send_command('wait 2; input /lockstyleset 2')
    get_combat_weapon()
end

function user_unload()
    send_command('unbind !t')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.Karambit = {main="Karambit"}

    sets.engaged = {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_B_Head,
        body=gear.Adhemar_A_Body,
        hands=gear.Adhemar_A_Hands,
        legs="Mpaca's Hose",
        feet={ name="Tatena. Sune. +1", augments={'Path: A',}},
        neck="Anu Torque",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Schere Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back="Relucent Cape",
    }

    sets.engaged.Hybrid = {
        ammo="Coiste Bodhar",
        head="Kendatsuba Jinpachi +1",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet="Kendatsuba Sune-Ate +1",
        neck="Mnk. Nodowa +2",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Schere Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back="Relucent Cape",
    }
    

    sets.engaged.Acc = {
        ammo="Ginsen",
        head="Kendatsuba Jinpachi +1",
        body="Bhikku Cyclas +1",
        hands="Mpaca's Gloves",
        legs="Ken. Hakama +1",
        feet="Ken. Sune-Ate +1",
        neck="Mnk. Nodowa +2",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back="Relucent Cape",
    }

    sets.precast.WS = {
        ammo="Knobkierre",
        head="Mpaca's Cap",
        body="Tatena. Harama. +1",
        hands=gear.Adhemar_A_Hands,
        legs="Mpaca's Hose",
        feet=gear.Herc_TA_Feet,
        neck="Fotia Gorget",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Ishvara Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Niqmaddu Ring",
        back="Relucent Cape",
    }

    sets.precast.WS.Acc = {
        -- TODO
    }

    -- Add custom WSs here
    -- sets.precast.WS['Raging Fists'] = {
        -- TODO
    -- }

    sets.precast.WS['Final Heaven'] = {
        ammo="Knobkierre",
        head="Mpaca's Cap",
        body="Tatena. Harama. +1",
        hands=gear.Adhemar_A_Hands,
        legs="Mpaca's Hose",
        feet=gear.Herc_TA_Feet,
        neck="Fotia Gorget",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Ishvara Earring",
        left_ring="Gelatinous Ring +1",
        right_ring="Niqmaddu Ring",
        back="Relucent Cape",
    }

    sets.precast.FC = {
         -- TODO
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.idle = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head, --6/6
        legs=gear.Malignance_Legs, --8/8
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        feet=gear.Malignance_Feet, --4/4
        neck="Mnk. Nodowa +2",
        waist="Moonbow Belt +1",
        left_ear="Sherida Earring",
        right_ear="Schere Earring",
        left_ring="Gere Ring",
        right_ring="Niqmaddu Ring",
        back="Moonlight Cape",
    }

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

function check_weaponset()
    equip(sets[state.WeaponSet.current])

    -- if state.WeaponSet.current == "Caladbolg" then
    --     send_command('@input /macro set 1')
    -- elseif state.WeaponSet.current == "Apocalypse" then
    --     send_command('@input /macro set 2')
    -- end
end

function get_combat_weapon()
    state.CombatWeapon:reset()
    if weapon_list:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
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