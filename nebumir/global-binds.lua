-------------------------------------------------------------------------------------------------------------------
--  Global Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Spells:     
--              [ ALT+, ]           Spectral Jig/Monomi/Sneak/Silent Oil
--              [ ALT+. ]           Tonko/Invisible/Prism Powder
--              [ ALT+Numpad7 ]     Paralyna
--              [ ALT+Numpad8 ]     Silena
--              [ ALT+Numpad9 ]     Blindna
--              [ ALT+Numpad4 ]     Poisona
--              [ ALT+Numpad5 ]     Stona
--              [ ALT+Numpad6 ]     Viruna
--              [ ALT+Numpad1 ]     Cursna
--              [ ALT+Numpad+ ]     Erase
--              [ ALT+Numpad0 ]     Sacrifice
--
--  Items:      
--              [ CTRL+Numpad7 ]     Remedy
--              [ CTRL+Numpad8 ]     Echo Drops
--              [ CTRL+Numpad9 ]     Eye Drops
--              [ CTRL+Numpad4 ]     Antidote
--              [ CTRL+Numpad5 ]     Remedy
--              [ CTRL+Numpad6 ]     Holy Water
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------

    -- Default Spell HotKeys
    if player.main_job == 'DNC' or player.sub_job == 'DNC' then
        send_command('bind !, input /ja "Spectral Jig" <me>')
        send_command('unbind !.')
    elseif player.main_job == 'RDM' or player.sub_job == 'RDM'
        or player.main_job == 'SCH' or player.sub_job == 'SCH'
        or player.main_job == 'WHM' or player.sub_job == 'WHM' then
        send_command('bind !, input /ma "Sneak" <me>')
        send_command('bind !. input /ma "Invisible" <me>')
    else
        send_command('bind !, input /item "Silent Oil" <me>')
        send_command('bind !. input /item "Prism Powder" <me>')
    end


    -- Default Status Cure HotKeys (SHIFT + Numpad)
    send_command('bind ~numpad7 input /ma "Paralyna" <stpc>')
    send_command('bind ~numpad8 input /ma "Blindna" <stpc>')
    send_command('bind ~numpad9 input /ma "Silena" <stpc>')
  
    send_command('bind ~numpad4 input /ma "Poisona" <stpc>')
    send_command('bind ~numpad5 input /ma "Stona" <stpc>')
    send_command('bind ~numpad6 input /ma "Viruna" <stpc>')
    send_command('bind ~numpad1 input /ma "Cursna" <stpc>')
    send_command('bind ~numpad0 input /ma "Erase" <stpc>')

    -- Default Item HotKeys (CTRL + Numpad)
    send_command('bind ^numpad7 input /item "Remedy" <me>')
    send_command('bind ^numpad8 input /item "Echo Drops" <me>')
    send_command('bind ^numpad9 input /item "Holy Water" <me>')
    send_command('bind ^numpad4 input /item "Antidote" <me>')
    send_command('bind ^numpad5 input /item "Remedy" <me>')
    send_command('bind ^numpad6 input /item "Eye Drops" <me>')

    -- Trust Hotkeys (Windows Key)
    send_command('bind @numpad7 input /ma "Valaineral" <me>')
    send_command('bind @numpad8 input /ma "AAEV" <me>')
    send_command('bind @numpad9 input /ma "Selh\'teus" <me>')

    send_command('bind @numpad4 input /ma "Ulmia" <me>')
    send_command('bind @numpad5 input /ma "Joachim" <me>')
    send_command('bind @numpad6 input /ma "Qultada" <me>')
    
    send_command('bind @numpad1 input /ma "Koru-Moru" <me>')
    send_command('bind @numpad2 input /ma "Sylvie (UC)" <me>')
    send_command('bind @numpad3 input /ma "Cornelia" <me>')

    send_command('bind @numpad0 input /ma "Yoran-Oran (UC)" <me>')