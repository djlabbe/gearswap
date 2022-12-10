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

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}

    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
    state.Buff.Doom = false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'HP')

    state.WeaponLock = M(true, 'Weapon Lock')
    state.WeaponSet = M{['description']='Weapon Set', 'Karambit', 'Spharai', 'Xoanon'}

    gear.Artifact_Head = { name="Anchorite's Crown +1" }
    gear.Artifact_Body = { name="Anchorite's Cyclas +1" }
    gear.Artifact_Hands = { name="Anchorite's Gloves +1" }
    gear.Artifact_Legs = { name="Anchorite's Hose +1" }    
    gear.Artifact_Feet = { name="Anchorite's Gaiters +3" }

    gear.Relic_Head = { name="Hesychast's Crown +1" }
    gear.Relic_Body = { name="Hesychast's Cyclas +1" }
    gear.Relic_Hands = { name="Hesychast's Gloves +1" }
    gear.Relic_Legs = { name="Hesychast's Hose +3" }
    gear.Relic_Feet = { name="Hesychast's Gaiters +1" }

    gear.Empyrean_Head = { name="Bhikku Crown +2" }
    gear.Empyrean_Body = { name="Bhikku Cyclas +2" }
    gear.Empyrean_Hands = { name="Bhikku Gloves +1" }
    gear.Empyrean_Legs = { name="Bhikku Hose +2" }
    gear.Empyrean_Feet = { name="Bhikku Gaiters +2" }
    
    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind ^= gs c cycle treasuremode')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    set_macro_page(1, 2)
    send_command('wait 2; input /lockstyleset 2')

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    MA = false
    MA_needed = 0
    moving = false

    determine_haste_group()
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind ^`')
    send_command('unbind !t')
    send_command('unbind ^=')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Hundred Fists'] = { legs=gear.Relic_Legs }
    -- sets.precast.JA['Boost'] = { hands=gear.Artifact_Hands }
    sets.precast.JA['Dodge'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Focus'] = { head=gear.Artifact_Head }
    sets.precast.JA['Counterstance'] = { feet=gear.Relic_Feet }
    sets.precast.JA['Footwork'] = { feet="Shukuyu sune-ate" }
    sets.precast.JA['Formless Strikes'] = { body=gear.Relic_Body }
    sets.precast.JA['Mantra'] = { feet=gear.Relic_Feet }
    sets.precast.JA['Chi Blast'] = {head=gear.Relic_Head}


    sets.precast.JA['Chi Blast'] = {
        head=gear.Artifact_Head,
        hands=gear.Relic_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Artifact_Feet,
    }

    sets.precast.JA['Chakra'] = {
        ammo="Aurgelmir Orb +1",
        head="Genmei Kabuto",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        body=gear.Artifact_Body,
        hands=gear.Relic_Hands,
        ring1="Niqmaddu Ring",
        ring2="Gelatinous Ring +1",
        back=gear.MNK_TP_Cape, -- Should be a VIT Cape
        -- waist="Latria Sash",
        legs=gear.Tatenashi_Legs,
        feet=gear.Tatenashi_Feet
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo="Voluspa Tathlum",
        head="Kendatsuba Jinpachi +1",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        body="Passion Jacket",
        hands=gear.Relic_Hands,
        waist="Gishdubar Sash",
        ring1="Asklepian Ring",
        ring2="Gelatinous Ring +1",
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Herc_MAB_head, --7
        body=gear.Taeon_FC_body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Baetyl Pendant", --4 --"Orunmila's Torque" if available
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Weather. Ring", --4
        ring2="Kishar Ring", --4
    } -- 49%

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads"
    })

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Knobkierrie",
		head=gear.Adhemar_B_Head,
		body="Ken. Samue +1",
		hands=gear.Ryuo_A_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Odr Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_WS_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        -- TODO
    })

    -- Specific weaponskill sets.

    sets.precast.WS["Victory Smite"] = {
        ammo="Knobkierrie",
		head=gear.Adhemar_B_Head,
		body="Ken. Samue +1",
		hands=gear.Ryuo_A_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Odr Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_WS_Cape,
    }

    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], {
        -- TODO
    })

    sets.precast.WS['Raging Fists'] = {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Tatenashi_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_WS_Cape,
    }
    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], {
        -- TODO
    })
   
    sets.precast.WS['Shijin Spiral'] = {
        ammo="Knobkierrie",
		head="Adhemar Bonnet +1",
		body="Ken. Samue +1",
		hands=gear.Malignance_Hands,
		legs=gear.Tatenashi_Legs,
		feet=gear.Tatenashi_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_TP_Cape,
    }

    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], {
        head=gear.Malignance_Head,
        legs=gear.Relic_Legs,
    })

    sets.precast.WS['Howling Fist'] =  {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Tatenashi_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Tatenashi_Legs,
		feet=gear.Tatenashi_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_WS_Cape,
    }

    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], {
        -- TODO
    })

    sets.precast.WS['Final Heaven'] =  {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Empyrean_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Tatenashi_Legs,
		feet=gear.Nyame_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Ishvara Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_WS_Cape,
    }

    sets.precast.WS["Final Heaven"].Acc = set_combine(sets.precast.WS["Final Heaven"], {
        -- TODO
    })

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Tatenashi_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Tatenashi_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_WS_Cape,
    })

    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], {
        -- TODO
    })

    sets.precast.MaxTP = {
		ear2="Odr Earring",
    }

    ---- Fall back to default WS set for Asuran Fists, Ascetic's Fury, Dragon Kick, and Spinning Attack ----
    
    sets.precast.WS['Shell Crusher'] = {
        head=gear.Malignance_Head,
        neck="Moonlight Necklace",
        ear1="Hermetic Earring", -- Should be Dignitary's
        ear2="Crepuscular Earring",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        ring1=gear.Stikini_1,
        ring2="Metamorph Ring +1",
        back=gear.MNK_INT_Cape,
        waist="Acuity Belt +1",
        
    }

    sets.precast.WS['Cataclysm'] = {
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ring1="Archon Ring",
        ring2="Metamorph Ring +1",
        back=gear.MNK_INT_Cape,
        waist="Orpheus's Sash",
    }
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        ammo="Sapience Orb", --2
        head=gear.Herc_MAB_head, --7
        body=gear.Taeon_FC_body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Baetyl Pendant", --4 --"Orunmila's Torque" if available
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Weather. Ring", --4
        ring2="Kishar Ring", --4
    }

    -- Defense sets
    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head,
        neck="Monk's Nodowa +2",
        ear1="Sherida Earring",
        ear2="Schere Earring",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        back=gear.MNK_TP_Cape,
        waist="Moonbow Belt +1",
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    }
    
    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Tuisto Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
        waist="Engraved Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.defense.HP = {
        ammo="Aurgelmir Orb +1",
        head="Genmei Kabuto",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        body=gear.Artifact_Body,
        hands=gear.Relic_Hands,
        ring1="Niqmaddu Ring",
        ring2="Gelatinous Ring +1",
        back=gear.MNK_TP_Cape,
        waist="Eschan Stone",
        legs=gear.Tatenashi_Legs,
        feet=gear.Tatenashi_Feet,
    } 


    -- Engaged sets
    
    -- Normal melee sets
    sets.engaged = {
        ammo="Coiste Bodhar",
		head=gear.Adhemar_A_Head,
		body="Ken. Samue +1",
		hands=gear.Adhemar_A_Hands,
		legs=gear.Empyrean_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_TP_Cape,
    }
    
    sets.engaged.Acc = {
        ammo="Ginsen",
		head =gear.Adhemar_A_Head,
		body=gear.Mpaca_Body,
		hands=gear.Adhemar_A_Hands,
		legs=gear.Tatenashi_Legs,
		feet=gear.Tatenashi_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Telos Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_TP_Cape,
    }

    sets.engaged.MA = set_combine(sets.engaged, {
        ear2="Mache Earring +1",
    })

    sets.engaged.Acc.MA = set_combine(sets.engaged.Acc, {
        ear2="Mache Earring +1",
    })

    -- Defensive melee hybrid sets
    sets.engaged.Hybrid = {
        ear2="Schere Earring",
        body=gear.Mpaca_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
    }
   
    sets.engaged.Counter = {
        ammo="Coiste Bodhar",
		head=gear.Rao_D_Head,
		body=gear.Mpaca_Body,
		hands=gear.Malignance_Hands,
		legs=gear.Empyrean_Legs,
		feet=gear.Empyrean_Feet,
		neck="Bathy Choker +1",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Bhikku Earring",
		ring1="Defending Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_TP_Cape,
    } -- Capped Counter & DT

    sets.engaged.Acc.Counter = set_combine(sets.engaged.Counter, {
        ammo="Ginsen",
    })

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DT.MA = set_combine(sets.engaged.MA, sets.engaged.Hybrid)
    sets.engaged.Acc.DT.MA = set_combine(sets.engaged.Acc.MA, sets.engaged.Hybrid)

     -- Idle sets
    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Rao_D_Head,
        neck="Bathy Choker +1",
        ear1="Infused Earring",
        ear2="Etiolation Earring", -- Could use Dawn Earring for more Regen
        body="Hizamaru Haramaki +2",
        hands=gear.Rao_D_Hands,
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back="Moonlight Cape",
        waist="Moonbow Belt +1",
        legs=gear.Rao_B_Pants,
        feet=gear.Rao_D_Feet,
    }

    sets.idle.Town ={
        ammo="Coiste Bodhar",
		head=gear.Empyrean_Head,
		body=gear.Empyrean_Body,
		hands=gear.Adhemar_A_Hands,
		legs=gear.Empyrean_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_TP_Cape,
    }
        
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Impetus = { body=gear.Empyrean_Body }
	sets.buff.Footwork = { feet=gear.Artifact_Feet }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        hands="Volte Bracers",
        head="Volte Cap", 
        waist="Chaac Belt"
    }

    sets.Kiting = { feet="Hermes' Sandals" }

    sets.Karambit = { main="Karambit" }
    sets.Spharai = { main="Spharai" }
    sets.Xoanon = { main="Xoanon", sub="Flanged Grip" }
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(field, new_value, old_value)
    check_weaponset()
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)

    if spell.type == 'WeaponSkill' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            -- * This was true for the +1... what about +2?? I assume it is always better now, so removing the conditional
            -- if  (info.impetus_hit_count > 8) then
                equip(sets.buff.Impetus)
            -- end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.buff.Footwork)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end

    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
           
        else
            state.Buff.Doom = false
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    determine_haste_group()
    check_moving()
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
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
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
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

    if state.Buff['Impetus'] then
        meleeSet = set_combine(meleeSet, sets.buff.Impetus)
    end

    if buffactive.Footwork then
        meleeSet = set_combine(meleeSet, sets.buff.Footwork)
    end

    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------


function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end


function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    -- When haste capped, this should only be over 12 when using Godhands.
    -- Without haste capped, this will likely always be the case.
    if MA_needed > 12 then
        classes.CustomMeleeGroups:append('MA')
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

-- Normal DW cmdParams is ('gearinfo' <string>, TotalDW <number>, haste <int>, moving <bool>, MA <number>)
-- If not DW then cmdParams is (gearinfo' <string>, DW <bool>, haste <number>, moving <bool> , MA_needed <number>)
function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end

        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end

        if type(tonumber(cmdParams[5])) == 'number' then
            if tonumber(cmdParams[5]) ~= MA_needed then
                MA_needed = tonumber(cmdParams[5])
                MA = true
            end
        elseif type(cmdParams[5]) == 'string' then
            if cmdParams[5] == 'false' then
                MA_needed = 0
                MA = false
            end
        end

        if not midaction() then
            job_update()
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