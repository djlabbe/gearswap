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
    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT', 'Counter')
    state.PhysicalDefenseMode:options('DT', 'HP')

    state.WeaponLock = M(true, 'Weapon Lock')
    state.WeaponSet = M{['description']='Weapon Set', 'Karambit', 'Spharai'}

    gear.Artifact_Head = { name="Anchorite's Crown +2" }
    gear.Artifact_Body = { name="Anchorite's Cyclas +3" }
    gear.Artifact_Hands = { name="Anchorite's Gloves +3" }
    gear.Artifact_Legs = { name="Anchorite's Hose +2" }    
    gear.Artifact_Feet = { name="Anchorite's Gaiters +2" }

    gear.Relic_Head = { name="Hesychast's Crown +3" }
    gear.Relic_Body = { name="Hesychast's Cyclas +3" }
    gear.Relic_Hands = { name="Hesychast's Gloves +3" }
    gear.Relic_Legs = { name="Hesychast's Hose +3" }
    gear.Relic_Feet = { name="Hesychast's Gaiters +3" }

    gear.Empyrean_Head = { name="Bhikku Crown +2" }
    gear.Empyrean_Body = { name="Bhikku Cyclas +2" }
    gear.Empyrean_Hands = { name="Bhikku Gloves +2" }
    gear.Empyrean_Legs = { name="Bhikku Hose +2" }
    gear.Empyrean_Feet = { name="Bhikku Gaiters +2" }
    
    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind ^` gs c cycle treasuremode')
    send_command('bind !t input /ja "Provoke" <t>')

    set_macro_page(1, 2)
    send_command('wait 2; input /lockstyleset 2')

    update_combat_form()
    update_melee_groups()

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    
    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
    sets.precast.JA['Boost'] = {hands="Anchorite's Gloves +1"}
    sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
    sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
    sets.precast.JA['Counterstance'] = {feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = {feet="Tantra Gaiters +2"}
    sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
    sets.precast.JA['Mantra'] = {feet="Hesychast's Gaiters +1"}

    sets.precast.JA['Chi Blast'] = {
        head="Melee Crown +2",
        body="Otronif Harness +1",
        hands="Hesychast's Gloves +1",
        back="Tuilha Cape",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }

    sets.precast.JA['Chakra'] = {
        ammo="Iron Gobbet",
        head="Felistris Mask",
        body="Anchorite's Cyclas +1",
        hands="Hesychast's Gloves +1",
        ring1="Spiral Ring",
        back="Iximulew Cape",
        waist="Caudata Belt",
        legs="Qaaxo Tights",
        feet="Thurandaut Boots +1"
    }

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        ammo="Sonia's Plectrum",
        head="Felistris Mask",
        body="Otronif Harness +1",
        hands="Hesychast's Gloves +1",
        ring1="Spiral Ring",
        back="Iximulew Cape",
        waist="Caudata Belt",
        legs="Qaaxo Tights",
        feet="Otronif Boots +1"
    }
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Herc_MAB_head, --7
        body=gear.Taeon_FC_body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet=gear.Herc_MAB_feet, --2
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Weather. Ring +1", --6(4)
        ring2="Kishar Ring", --4
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        ammo="Thew Bomblet",
        head="Whirlpool Mask",
        neck=gear.ElementalGorget,
        ear1="Brutal Earring",
        ear2="Moonshade Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Caudata Belt",
        legs="Quiahuiz Trousers",
        feet="Manibozho Boots"
    }

    sets.precast.WSAcc = {
        ammo="Honed Tathlum",
        body="Manibozho Jerkin",
        back="Letalis Mantle",
        feet="Qaaxo Leggings"
    }

    sets.precast.MaxTP = {
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring"
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)

    -- Specific weaponskill sets.

    sets.precast.WS['Raging Fists'] = set_combine(sets.precast.WS, {})

    sets.precast.WS['Howling Fist'] = set_combine(sets.precast.WS, {
        legs="Manibozho Brais",
        feet="Daihanshi Habaki"
    })

    sets.precast.WS['Asuran Fists'] = set_combine(sets.precast.WS, {
        ear1="Bladeborn Earring",
        ear2="Moonshade Earring",
        ring2="Spiral Ring",
        back="Buquwik Cape"
    })

    sets.precast.WS["Ascetic's Fury"] = set_combine(sets.precast.WS, {
        ammo="Tantra Tathlum",
        ring1="Spiral Ring",
        back="Buquwik Cape",
        feet="Qaaxo Leggings"
    })

    sets.precast.WS["Victory Smite"] = set_combine(sets.precast.WS, {
        neck="Rancor Collar",
        back="Buquwik Cape",
        feet="Qaaxo Leggings"
    })

    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        legs="Manibozho Brais",
        feet="Daihanshi Habaki"
    })

    sets.precast.WS['Dragon Kick'] = set_combine(sets.precast.WS, {
        feet="Daihanshi Habaki"
    })

    sets.precast.WS['Tornado Kick'] = set_combine(sets.precast.WS, {
        ammo="Tantra Tathlum",
        ring1="Spiral Ring"
    })

    sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {
        head="Felistris Mask",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring"
    })

    sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

    sets.precast.WS['Cataclysm'] = {
        head="Wayfarer Circlet",
        neck="Stoicheion Medal",
        ear1="Friomisi Earring",
        ear2="Hecate's Earring",
        body="Wayfarer Robe",
        hands="Otronif Gloves",
        ring1="Acumen Ring",
        ring2="Demon's Ring",
        back="Toro Cape",
        waist="Thunder Belt",
        legs="Nahtirah Trousers",
        feet="Qaaxo Leggings"
    }
    
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Whirlpool Mask",
        ear2="Loquacious Earring",
        body="Otronif Harness +1",
        hands="Thaumas Gloves",
        waist="Black Belt",
        feet="Otronif Boots +1"
    }
        
    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Whirlpool Mask",
        ear2="Loquacious Earring",
        body="Otronif Harness +1",
        hands="Thaumas Gloves",
        waist="Black Belt",
        legs="Qaaxo Tights",
        feet="Otronif Boots +1"
    }

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
        head="Ocelomeh Headpiece +1",
        neck="Wiglen Gorget",
        body="Hesychast's Cyclas",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring"
    }
    
    -- Idle sets
    sets.idle = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Wiglen Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Hesychast's Cyclas",
        hands="Hesychast's Gloves +1",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring",
        back="Iximulew Cape",
        waist="Black Belt",
        legs="Qaaxo Tights",
        feet="Herald's Gaiters"
    }

    sets.idle.Town = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Wiglen Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Hesychast's Cyclas",
        hands="Hesychast's Gloves +1",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring",
        back="Iximulew Cape",
        waist="Black Belt",
        legs="Qaaxo Tights",
        feet="Herald's Gaiters"
    }

    -- Defense sets
    sets.defense.PDT = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Wiglen Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Hesychast's Cyclas",
        hands="Hesychast's Gloves +1",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring",
        back="Iximulew Cape",
        waist="Black Belt",
        legs="Qaaxo Tights",
        feet="Herald's Gaiters"
    }

    sets.defense.HP = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Wiglen Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Hesychast's Cyclas",
        hands="Hesychast's Gloves +1",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring",
        back="Iximulew Cape",
        waist="Black Belt",
        legs="Qaaxo Tights",
        feet="Herald's Gaiters"
    }

    sets.defense.MDT = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Wiglen Gorget",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Hesychast's Cyclas",
        hands="Hesychast's Gloves +1",
        ring1="Sheltered Ring",
        ring2="Paguroidea Ring",
        back="Iximulew Cape",
        waist="Black Belt",
        legs="Qaaxo Tights",
        feet="Herald's Gaiters"
    }

    sets.Kiting = { feet="Herald's Gaiters" }

    sets.ExtraRegen = { head="Ocelomeh Headpiece +1" }

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }
    
    sets.engaged.Acc = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }


    -- Defensive melee hybrid sets
    sets.engaged.PDT = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }
   
    sets.engaged.Acc.PDT = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }

    sets.engaged.Counter = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }

    sets.engaged.Acc.Counter = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = set_combine(sets.engaged)
    sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Tantra Cyclas +2"})
    sets.engaged.Acc.HF = set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Tantra Cyclas +2"})
    sets.engaged.Counter.HF = set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Tantra Cyclas +2"})
    sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Tantra Cyclas +2"})


    -- Footwork combat form
    sets.engaged.Footwork = {
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }

    sets.engaged.Footwork.Acc ={
        ammo="Thew Bomblet",
        head="Felistris Mask",
        neck="Asperity Necklace",
        ear1="Bladeborn Earring",
        ear2="Steelflash Earring",
        body="Qaaxo Harness",
        hands="Hesychast's Gloves +1",
        ring1="Rajas Ring",
        ring2="Epona's Ring",
        back="Atheling Mantle",
        waist="Windbuffet Belt",
        legs="Hesychast's Hose +1",
        feet="Anchorite's Gaiters +1"
    }
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Tantra Cyclas +2"}
    sets.footwork_kick_feet = {feet="Anchorite's Gaiters +1"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1=gear.Eshmun_1, --20
        ring2=gear.Eshmun_2, --20
        waist="Gishdubar Sash", --10
    }

    sets.TreasureHunter = {
        head="Volte Cap", 
        waist="Chaac Belt"
    }

    sets.Kiting = { feet="Hermes' Sandals" }

    sets.Karambit = { main="Karambit" }
    sets.Spharai = { main="Spharai" }

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(field, new_value, old_value)
    check_weaponset()
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if  (info.impetus_hit_count > 8) then
                equip(sets.impetus_body)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)

     -- Set Footwork as combat form any time it's active and Hundred Fists is not.
     if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
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


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
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
    update_combat_form()
    update_melee_groups()
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end

    if state.Auto_Kite.value == true then
        idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end


function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
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
    -- if DW == true then
    --     if DW_needed <= 1 then
    --         classes.CustomMeleeGroups:append('MaxHaste')
    --     elseif DW_needed > 1 and DW_needed <= 16 then
    --         classes.CustomMeleeGroups:append('HighHaste')
    --     elseif DW_needed > 16 and DW_needed <= 21 then
    --         classes.CustomMeleeGroups:append('MidHaste')
    --     elseif DW_needed > 21 and DW_needed <= 34 then
    --         classes.CustomMeleeGroups:append('LowHaste')
    --     elseif DW_needed > 34 then
    --         classes.CustomMeleeGroups:append('')
    --     end
    -- end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        -- if type(tonumber(cmdParams[2])) == 'number' then
        --     if tonumber(cmdParams[2]) ~= DW_needed then
        --     DW_needed = tonumber(cmdParams[2])
        --     DW = true
        --     end
        -- elseif type(cmdParams[2]) == 'string' then
        --     if cmdParams[2] == 'false' then
        --         DW_needed = 0
        --         DW = false
        --     end
        -- end
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
        if not midaction() then
            job_update()
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

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
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