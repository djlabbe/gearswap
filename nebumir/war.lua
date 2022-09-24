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
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    -- Additional local binds
    include('Global-Binds.lua')

    
    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind !t input /ja "Provoke" <t>')
    send_command('bind !t input /ja "Provoke" <t>')

    -- Set macros and style
    macroBook = 3
    styleSet = 3
    set_macro_page(1, macroBook)
    send_command('wait 2; input /lockstyleset ' .. styleSet)
end

function user_unload()
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !t')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.engaged = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body="Sakpata's Breastplate", --12
        hands="Sakpata's Gauntlets", --8
        legs={ name="Tatena. Haidate +1", augments={'Path: A',}},
        feet="Flam. Gambieras +2",
        neck={ name="War. Beads +1", augments={'Path: A',}},
        waist="Ioskeha Belt +1",
        left_ear="Cessance Earring",
        right_ear="Brutal Earring",
        left_ring="Flamma Ring",
        right_ring="Petrov Ring",
        back=gear.WAR_TP_Cape,
    }

    sets.engaged.Hybrid = {
        head="Sakpata's Helm", --7
        body="Sakpata's Breastplate", --12
        hands="Sakpata's Gauntlets", --8
        legs="Sakpata's Cuisses", --9
        feet="Sakpata's Leggings", --6
    }

    sets.engaged.Acc = {

    }

    
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.precast.WS = {
        head="Agoge Mask +3",
        ring="Rajas Ring",
        ring2="Petrov Ring",
        ammo="Knobkierrie",
        feet="Sulevia's Leggings +2",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS.Acc = {
        -- TODO
    }

    -- Add custom WSs here
    -- sets.precast.WS['Raging Fists'] = {
        -- TODO
    -- }

    sets.precast.FC = {
         -- TODO
    }

    sets.idle = sets.engaged

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