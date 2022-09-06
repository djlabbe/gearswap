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
    no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
              "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring"}
    wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
        'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'AttackCap')
    state.WeaponskillMode:options('Normal', 'Acc', 'AttackCap')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Trishula', 'ShiningOne', 'Naegling' }
    state.WeaponLock = M(false, 'Weapon Lock')

    include('Global-Binds.lua')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')
   
    if player.sub_job == 'SAM' then
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
        set_macro_page(1, 14)
    else
        set_macro_page(2, 14)
    end

    
    send_command('wait 2; input /lockstyleset 14')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @a')
    send_command('unbind !`')
    send_command('unbind ^`')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Spirit Surge'] = { body="Ptero. Mail +3" }
    sets.precast.JA['Call Wyvern'] = { body="Ptero. Mail +3" }
    sets.precast.JA['Ancient Circle'] = { legs="Vishap Brais +3" }

    sets.precast.JA['Spirit Link'] = {
        head="Vishap Armet +3",
        hands="Pel. Vambraces +1",
        feet="Ptero. Greaves +3",
        ear1="Pratik Earring",
    }

    sets.precast.JA['Steady Wing'] = {
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Chanoix's Gorget",
        ear1="Lancer's Earring",
        ear2="Anastasi Earring",
        back="Updraft Mantle",
    }

    sets.precast.JA['Jump'] = {
        ammo="Aurgelmir Orb +1",
        head="Flamma Zucchetto +2",
        neck="Vim Torque +1",
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
    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {
        body="Vishap Mail +3", 
        hands="Emi. Gauntlets +1", 
        legs=gear.Valo_STP_legs
    })
    sets.precast.JA['Super Jump'] = {}

    sets.precast.JA['Angon'] = {ammo="Angon", hands="Ptero. Fin. G. +3"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Carmine_D_head, --14
        -- body="Sacro Breastplate", --10
        hands="Leyline Gloves", --8
        legs="Aya. Cosciales +2", --6
        feet="Carmine Greaves +1", --8
        -- neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Weather. Ring", --6(4)
        }

    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head="Pteroslaver Armet +3",
        body=gear.Gleti_body,
        hands="Sulev. Gauntlets +2",
        legs="Sulev. Cuisses +2",
        feet="Sulevia's Leggings +2",
        neck="Fotia Gorget",
        waist="Sailfi Belt +1",
        left_ear="Sherida Earring",
        right_ear="Moonshade Earring",
        left_ring="Niqmaddu ring",
        right_ring="Epaminondas's Ring",
        back=gear.DRG_WS1_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS.AttackCap = set_combine(sets.precast.WS, {})

    ---------------
    -- Stardiver --
    ---------------
    sets.precast.WS['Stardiver'] = {
        ammo="Coiste Bodhar",
        head="Ptero. Armet +3",
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        body=gear.Gleti_body,
        hands="Sulev. Gauntlets +2",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.DRG_WS1_Cape,
        waist="Fotia Belt",
        legs="Sulev. Cuisses +2",
        feet="Flam. Gambieras +2",
    }

    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {
        ammo="Voluspa Tathlum",
        legs="Vishap Brais +3",
        feet="Vishap Greaves +3",
    })

    sets.precast.WS['Stardiver'].AttackCap = set_combine(sets.precast.WS['Stardiver'], {
        ammo="Crepuscular Pebble",
        head="Flamma Zucchetto +2",
        neck="Dragoon's Collar +2",
        hands=gear.Gleti_hands,
        legs=gear.Gleti_legs,
        feet="Ptero. Greaves +3",
    })

    ---------------
    -- Camlann's --
    ---------------
    sets.precast.WS['Camlann\'s Torment'] = {
        neck="Dgn. Collar +2",
        ear2="Ishvara Earring",
        ring2="Epaminondas's Ring",
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Camlann\'s Torment'].Acc = set_combine(sets.precast.WS['Camlann\'s Torment'], {})

     sets.precast.WS['Camlann\'s Torment'].AttackCap = set_combine(sets.precast.WS['Camlann\'s Torment'], {
        head="Ptero. Armet +3",
        feet="Ptero. Greaves +3",
    })

    ------------
    -- Sonic --
    ------------
    sets.precast.WS['Sonic Thrust'] = {
        neck="Dgn. Collar +2",
        ear2="Ishvara Earring",
        ring2="Epaminondas's Ring",
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS['Sonic Thrust'], {})

    sets.precast.WS['Sonic Thrust'].AttackCap = set_combine(sets.precast.WS['Sonic Thrust'], {
        head="Ptero. Armet +3",
        feet="Ptero. Greaves +3",
    })

    -------------
    -- Impulse --
    -------------
    sets.precast.WS['Impulse Drive'] = {
        head="Blistering Sallet +1",
        body="Hjarrandi Breast.",
        hands="Flamma Manopolas +2",
        legs="Pelt. Cuissots +1",
        neck="Dgn. Collar +2",
        ear2="Moonshade Earring",
        ring1="Begrudging Ring",
        ring2="Epaminondas's Ring",
        back=gear.DRG_WS4_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {
        legs="Vishap Brais +3",
        waist="Ioskeha Belt +1",
    })

    sets.precast.WS['Impulse Drive'].AttackCap = set_combine(sets.precast.WS['Impulse Drive'], {
        head="Ptero. Armet +3",
        feet="Ptero. Greaves +3",
    })

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {
        -- head=gear.Valo_WSD_head,
        -- body=gear.Valo_WSD_body,
        hands="Ptero. Fin. G. +3",
        legs="Vishap Brais +3",
        back=gear.DRG_WS2_Cape,
        ear2="Ishvara Earring",
        ring1="Regal Ring",
    })

    ----------------
    -- Drakesbane --
    ----------------
    sets.precast.WS['Drakesbane'] = {
        head="Blistering Sallet +1",
        body="Hjarrandi Breast.",
        hands="Flamma Manopolas +2",
        legs="Zoar Subligar +1",
        neck="Dgn. Collar +2",
        ear2="Brutal Earring",
        ring1="Begrudging Ring",
        back=gear.DRG_WS4_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS['Drakesbane'], {
        waist="Ioskeha Belt +1",
    })

    sets.precast.WS['Drakesbane'].AttackCap = set_combine(sets.precast.WS['Drakesbane'], {
        head="Ptero. Armet +3",
        feet="Ptero. Greaves +3",
    })

    ----------------
    -- Geirskogul --
    ----------------
    sets.precast.WS['Geirskogul'] = set_combine(sets.precast.WS, {
        head="Lustratio Cap +1",
        legs="Lustr. Subligar +1",
        ear2="Mache Earring +1",
        ring2="Epaminondas's Ring",
        back=gear.DRG_WS3_Cape,
    })

    sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], {})
    sets.precast.WS['Geirskogul'].AttackCap = set_combine(sets.precast.WS['Geirskogul'], {})

    ---------------
    -- Leg Sweep --
    ---------------
    sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head="Blistering Sallet +1",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        ear1="Digni. Earring",
        ring1="Metamor. Ring +1",
        ring2="Weather. Ring",
    })

    sets.precast.WS['Leg Sweep'].Acc = set_combine(sets.precast.WS['Leg Sweep'], {})
    sets.precast.WS['Leg Sweep'].AttackCap = set_combine(sets.precast.WS['Leg Sweep'], {})

    --------------------
    -- Raiden/Thunder --
    --------------------

    sets.precast.WS['Raiden Thrust'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        body="Carm. Sc. Mail +1",
        hands="Carmine Fin. Ga. +1",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1="Shiva Ring +1",
        back="Argocham. Mantle",
    })

    sets.precast.WS['Thunder Thrust'] = sets.precast.WS['Raiden Thrust']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.HealingBreath = {
        head="Ptero. Armet +3",
        body=gear.Acro_Pet_body,
        hands=gear.Acro_Pet_hands,
        legs="Vishap Brais +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +2",
        ear1="Lancer's Earring",
        ear2="Anastasi Earring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
    }

    sets.midcast.ElementalBreath = {
        head="Ptero. Armet +3",
        body=gear.Acro_Pet_body,
        hands=gear.Acro_Pet_hands,
        neck="Lancer's Torque",
        ear1="Enmerkar Earring",
        ear2="Dragoon's Earring",
        ring1="C. Palug Ring",
        back="Updraft Mantle",
        waist="Glassblower's Belt",
    }

    ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1", --3/3
        head="Hjarrandi Helm", --10/10
        body="Hjarrandi Breastplate",
        hands="Sulev. Gauntlets +2", --5/5
        legs=gear.Gleti_legs,
        feet="Ptero. Greaves +3",
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Infused Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back="Moonlight Cape", --6/6
        waist="Flume Belt +1", --4/0
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        body="Hjarrandi Breast.", --12/12
        head="Hjarrandi Helm", --10/10
        hands="Flam. Manopolas +2",
        feet="Ptero. Greaves +3",
        neck="Loricate Torque +1", --6/6
        ear1="Infused Earring",
        ear2="Anastasi Earring",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        waist="Carrier's Sash",
    })

    sets.idle.Pet = set_combine(sets.idle, {
        body="Vishap Mail +3",
        hands="Ptero. Fin. G. +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +2",
        ear1="Enmerkar Earring",
        ear2="Anastasi Earring",
        waist="Isa Belt",
    })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        head="Hjarrandi Helm", --10/10
        body="Emicho Haubert +1",
        legs="Ptero. Brais +3",
        neck="Dgn. Collar +2",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Aurgelmir Orb +1",
        head="Ptero. Armet +3",
        hands="Ptero. Fin. G. +3",
        feet="Ptero. Greaves +3",
        neck="Dgn. Collar +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        back=gear.DRG_TP_Cape,
        waist="Ioskeha Belt +1",
    })

    sets.idle.Weak = sets.idle.DT
    sets.Kiting = { legs=gear.Carmine_D_legs }


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flam. Zucchetto +2",
        body=gear.Gleti_body,
        hands=gear.Gleti_hands,
        legs="Ptero. Brais +3",
        feet="Flam. Gambieras +2",
        neck="Vim Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1=gear.Moonlight_1,
        ring2="Niqmaddu Ring",
        back=gear.DRG_TP_Cape,
        waist="Ioskeha Belt +1",
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        body="Vishap Mail +3",
        head="Vishap Armet +3",
        legs="Ptero. Brais +3",
        feet="Vishap Greaves +3",
        ring1="Regal Ring",
        ear2="Cessance Earring",
    })

    sets.engaged.AttackCap = set_combine(sets.engaged, {
        ear2="Brutal Earring"
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        neck="Loricate Torque +1", --6/6
        body="Vishap Mail +3",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)
    sets.engaged.AttackCap.DT = set_combine(sets.engaged.AttackCap, sets.engaged.Hybrid)

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.Trishula = { main="Trishula", sub="Utu Grip" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }
    sets.Naegling = { main="Naegling", sub=empty }

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
    elseif state.OffenseMode.value == 'AttackCap' then
        wsmode = 'AttackCap'
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