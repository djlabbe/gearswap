-- Original: Motenten / Modified: Arislan

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
--              [ WIN+C ]           Toggle Capacity Points Mode
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

    wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
        'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}

    wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

    weapon_list = S{"Trishula", "ShiningOne", "Naegling"}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Trishula', 'ShiningOne', "Naegling"}
    state.WeaponLock = M(true, 'Weapon Lock')

    include('Global-Binds.lua')
    -- include('Global-WHM-Binds.lua') -- OK to remove this line

    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')


    set_macro_page(1, 14) -- (Set, Book)
    send_command('wait 2; input /lockstyleset 14')
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @w')
    send_command('unbind @e')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Spirit Surge'] = {body="Ptero. Mail +3"}
    sets.precast.JA['Call Wyvern'] = {body="Ptero. Mail +3"}
    -- sets.precast.JA['Ancient Circle'] = {legs="Vishap Brais +3"}

    sets.precast.JA['Spirit Link'] = {
        feet="Ptero. Greaves +3",
    }

    sets.precast.JA['Steady Wing'] = {
        feet="Ptero. Greaves +3",
        back="Updraft Mantle",
    }

    sets.precast.JA['Jump'] = {
        ammo="Aurgelmir Orb +1",
        head="Flamma Zucchetto +2",
        neck={ name="Vim Torque +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Telos Earring",
        body="Ptero. Mail +3",
        hands="Vishap Finger Gauntlets +3",
        legs="Ptero. Brais +3",
        feet="Ostro Greaves",       
        waist="Ioskeha Belt +1",        
        left_ring="Niqmaddu ring",
        right_ring="Petrov Ring",
        back=gear.DRG_TP_Cape,
    }

    sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Spirit Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Soul Jump'] = sets.precast.JA['Jump']

    sets.precast.JA['Angon'] = {
        ammo="Angon"
    }

    -- Fast cast sets for spells
    sets.precast.FC = {
        head="Carmine Mask +1", --10
        legs="Aya. Cosciales +2", --6
        feet="Carmine Greaves +1", --8
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Weather. Ring", --4
    }


    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head="Pteroslaver Armet +3",
        body=gear.Valo_TP_body,
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Sulevia's Leggings +2",
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Niqmaddu ring",
        right_ring="Epaminondas's Ring",
        back=gear.DRG_WS1_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS['Stardiver'] = {
        ammo="Knobkierrie",
        head="Ptero. Armet +3",
        body="Dagon Breastplate",
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Flamma Gambieras +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Niqmaddu ring",
        right_ring="Regal Ring",
        back=gear.DRG_WS2_Cape,
    }

    sets.precast.WS['Camlann\'s Torment'] = {
        ammo="Knobkierrie",
        head=gear.Valo_WSD_head,
        body=gear.Valo_TP_body,
        hands="Pteroslaver finger gauntlets +3",
        legs="Sulevia's Cuisses +2",
        neck="Fotia Gorget",
        feet="Sulevia's Leggings +2",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear="Thrud Earring",
        left_ring="Niqmaddu ring",
        right_ring="Epaminondas's Ring",
        back=gear.DRG_WS1_Cape,
    }

    sets.precast.WS['Sonic Thrust'] = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        body=gear.Valo_TP_body,
        hands="Pteroslaver finger gauntlets +3",
        legs="Sulevia's Cuisses +2",
        neck="Fotia Gorget",
        feet="Sulevia's Leggings +2",
        waist="Fotia Belt",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Niqmaddu ring",
        right_ring="Regal Ring",
        back=gear.DRG_WS1_Cape,
    }

    sets.precast.WS['Impulse Drive'] = {
        ammo="Knobkierrie",
        head="Flamma Zucchetto +2",
        body="Hjarrandi Breastplate",
        hands="Pteroslaver finger gauntlets +3",
        legs="Sulevia's Cuisses +2",
        neck="Dgn. Collar +2",
        feet="Sulevia's Leggings +2",
        waist="Sailfi Belt +1",
        left_ear="Sherida Earring",
        right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
        left_ring="Niqmaddu ring",
        right_ring="Regal Ring",
        back=gear.DRG_WS1_Cape,
    }

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {

    })  

    sets.precast.WS['Drakesbane'] = {
        ammo="Knobkierrie",
        head="Blistering Sallet +1",
        body="Hjarrandi Breastplate",
        hands= gear.Valo_WSD_hands,
        legs="Sulevia's Cuisses +2",
        neck="Fotia Gorget",
        feet="Sulevia's Leggings +2",
        waist="Sailfi Belt +1",
        left_ear="Sherida Earring",
        right_ear="Thrud Earring",
        left_ring="Niqmaddu ring",
        right_ring="Regal Ring",
        back=gear.DRG_WS2_Cape,
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.HealingBreath = {
        head="Ptero. Armet +3",
        -- legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +2",
        back="Updraft Mantle",
    }

    sets.midcast.ElementalBreath = {
        ammo="Voluspa Tathlum",
        head="Ptero. Armet +3",
        neck="Adad Amulet",
        -- ear2="Kyrene's Earring",
        back="Updraft Mantle",
    }

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Hjarrandi Helm", --10/10
        body="Hjarrandi Breastplate",
        hands="Nyame Gauntlets",
        legs=gear.Carmine_D_legs,
        feet="Nyame Sollerets",
        neck={ name="Bathy Choker +1", augments={'Path: A',}},
        waist="Flume Belt +1",
        left_ear="Sherida Earring",
        right_ear="Eabani Earring",
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        back=gear.DRG_TP_Cape,
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        body="Hjarrandi Breast.", --12/12
        head="Hjarrandi Helm", --10/10
        hands="Flamma Manopolas +2",
        feet="Ptero. Greaves +3",
        neck="Loricate Torque +1", --6/6
        -- ear1="Sanare Earring",
        -- ear2="Anastasi Earring",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        waist="Carrier's Sash",
    })


    sets.idle.Town = {
        head={ name="Ptero. Armet +3", augments={'Enhances "Deep Breathing" effect',}},
        body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
        hands="Vishap Finger Gauntlets +3",
        legs=gear.Carmine_D_legs,
        feet={ name="Ptero. Greaves +3", augments={'Enhances "Empathy" effect',}},
        neck={ name="Dgn. Collar +2", augments={'Path: A',}},
        waist="Sailfi Belt +1",
        left_ear="Sherida Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu ring",
        right_ring="Regal Ring",
        back=gear.DRG_TP_Cape,
    }

    sets.Kiting = {
        legs="Carmine Cuisses +1"
    }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.Trishula = {main="Trishula", sub="Utu Grip"}
    sets.ShiningOne = {main="Shining One", sub="Utu Grip"}
    sets.Naegling = {main="Naegling", sub="Demersal Degen"}

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head="Flamma Zucchetto +2",       
        body="Hjarrandi Breastplate",
        hands="Sulev. Gauntlets +2", --5/5
        legs="Ptero. Brais +3",
        feet="Flamma Gambieras +2",
        neck={ name="Vim Torque +1", augments={'Path: A',}},
        -- neck="Dragoon's Collar +2",
        waist="Ioskeha Belt +1",
        left_ear="Sherida Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu ring",
        right_ring="Petrov Ring",
        back=gear.DRG_TP_Cape,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Voluspa Tathlum",
        left_ring=gear.Chirich_1,
        right_ear="Telos Earring",
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head="Hjarrandi Helm", --10/10
        body="Hjarrandi Breastplate", --12/12
        neck="Dragoon's Collar +2",
        hands="Sulev. Gauntlets +2", --5/5
        legs="Sulev. Cuisses +2", --7/7
        right_ring="Moonlight Ring", --5/5
        back=gear.DRG_TP_Cape, --10/0
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    -- Wyvern Commands
    if spell.name == 'Dismiss' and pet.hpp < 100 then
        eventArgs.cancel = true
        add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
    elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
        equip(sets.precast.HealingBreath)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Impulse Drive' and player.tp > 2000 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        end
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
        equip(sets.midcast.HealingBreath)
    elseif wyv_elem_breath:contains(spell.english) then
        equip(sets.midcast.ElementalBreath)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff,gain)
    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
    end
end

function job_state_change(field, new_value, old_value)
    check_weaponset()
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------


function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
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
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if state.WeaponSet.current == "Trishula" then
        send_command('@input /macro set 1')
    elseif state.WeaponSet.current == "ShiningOne" then
        send_command('@input /macro set 1')
    elseif state.WeaponSet.current == "Naegling" then
        send_command('@input /macro set 2')
    end
end


function check_gear()
end

windower.register_event('zone change',
    function()
    end
)