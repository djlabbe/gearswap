-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    -- Malignance
    gear.Malignance_head = {name="Malignance Chapeau"}
    gear.Malignance_body = {name="Malignance Tabard"}
    gear.Malignance_hands = {name="Malignance Gloves"}
    gear.Malignance_legs= {name="Malignance Tights"}
    gear.Malignance_feet = {name="Malignance Boots"}

    -- Odyssey
    gear.Nyame_head = {name="Nyame Helm"}
    gear.Nyame_body = {name="Nyame Mail"}
    gear.Nyame_hands = {name="Nyame Gauntlets"}
    gear.Nyame_legs= {name="Nyame Flanchard"}
    gear.Nyame_feet = {name="Nyame Sollerets"}

    gear.Sakpata_head = {name="Sakpata's Helm"}
    gear.Sakpata_body = {name="Sakpata's Breastplate"}
    gear.Sakpata_hands = {name="Sakpata's Gauntlets"}
    gear.Sakpata_legs= {name="Sakpata's Cuisses"}
    gear.Sakpata_feet = {name="Sakpata's Leggings"}

    gear.Gleti_head = {name="Gleti's Mask"}
    gear.Gleti_body = {name="Gleti's Cuirass"}
    gear.Gleti_hands = {name="Gleti's Gauntlets"}
    gear.Gleti_legs= {name="Gleti's Breeches"}
    gear.Gleti_feet = {name="Gleti's Boots"}

    gear.Mpaca_head = {name="Mpaca's Cap"}
    gear.Mpaca_body = {name="Mpaca's Doublet"}
    gear.Mpaca_hands = {name="Mpaca's Gloves"}
    gear.Mpaca_legs= {name="Mpaca's Hose"}
    gear.Mpaca_feet = {name="Mpaca's Boots"}

    gear.Ikenga_head = {name="Ikenga's Hat"}
    gear.Ikenga_body = {name="Ikenga's Vest"}
    gear.Ikenga_hands = {name="Ikenga's Gloves"}
    gear.Ikenga_legs= {name="Ikenga's Trousers"}
    gear.Ikenga_feet = {name="Ikenga's Clogs"}

    -- Duplicate Items
    gear.Stikini_1 = {name="Stikini Ring +1", bag="wardrobe7"}
    gear.Stikini_2 = {name="Stikini Ring +1", bag="wardrobe8"}
    gear.Chirich_1 = {name="Chirich Ring +1", bag="wardrobe7"}
    gear.Chirich_2 = {name="Chirich Ring +1", bag="wardrobe8"}
    gear.Moonlight_1 = {name="Moonlight Ring", bag="wardrobe7"}
    gear.Moonlight_2 = {name="Moonlight Ring", bag="wardrobe8"}
    gear.Varar_1 = {name="Varar Ring +1", bag="wardrobe7"}
    gear.Varar_2 = {name="Varar Ring +1", bag="wardrobe8"}

    -- Augmented Weapons
    gear.Colada_ENH = { name="Colada", augments={'Enh. Mag. eff. dur. +3','INT+5','Mag. Acc.+12','"Mag.Atk.Bns."+16',}}

    -- gear.Gada_ENF = {name="Gada", augments={'"Conserve MP"+2','MND+14','Mag. Acc.+20','"Mag.Atk.Bns."+2','DMG:+7',}}
    gear.Gada_ENH = { name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+16',}}

    gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
    gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}

    gear.Lathi_MAB = {name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}
    -- gear.Lathi_ENF = {name="Lathi", augments={'Mag. Acc.+20','Enfb.mag. skill +15','Dark magic skill +15',}}

    gear.Linos_TP = {name="Linos", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +3',}}
    gear.Linos_STP = {name="Linos", augments={'Accuracy +16','Store TP +4','Quadruple Attack +3',}}
    gear.Linos_WS = {name="Linos", augments={'Accuracy+15 Attack+15','Weapon skill damage +3%','STR+6'}}

    -- gear.Grioavolr_MND = {name="Grioavolr", augments={'Enfb.mag. skill +10','MND+18','Mag. Acc.+20','"Mag.Atk.Bns."+11',}}
    -- gear.Grioavolr_MP = {name="Grioavolr", augments={'"Fast Cast"+5','MP+97','Mag. Acc.+28','"Mag.Atk.Bns."+29',}}
    -- gear.Grioavolr_MB = {name="Grioavolr", augments={'Magic burst dmg.+5%','INT+9','Mag. Acc.+27','"Mag.Atk.Bns."+27',}}

    -- -- Acro
    gear.Acro_STP_hands = {name="Acro Gauntlets", augments={'Accuracy+25','"Store TP"+6','STR+6 DEX+6',}}

    -- -- Taeon

    gear.Taeon_SNAP_head = {name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
    gear.Taeon_FC_body = {name="Taeon Tabard", augments={'"Fast Cast"+5',}}
    gear.Taeon_Phalanx_body ={ name="Taeon Tabard", augments={'Mag. Evasion+15','Spell interruption rate down -10%','Phalanx +3',}}
    gear.Taeon_Phalanx_hands ={ name="Taeon Gloves", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}
    gear.Taeon_Phalanx_legs = { name="Taeon Tights", augments={'Mag. Evasion+16','Spell interruption rate down -8%','Phalanx +3',}}
    gear.Taeon_Phalanx_feet ={ name="Taeon Boots", augments={'Mag. Evasion+15','Spell interruption rate down -9%','Phalanx +3',}}

    gear.Taeon_Pet_head = { name="Taeon Chapeau", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_hands = { name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_legs = { name="Taeon Tights", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_feet = { name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}

    gear.Telchine_ENH_head = { name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_body = { name="Telchine Chas.", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_hands= { name="Telchine Gloves", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_legs = { name="Telchine Braconi", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_feet = { name="Telchine Pigaches", augments={'Mag. Evasion+19','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_SONG_feet = { name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -6%','Enh. Mag. eff. dur. +10',}}

    -- -- Yorium
    gear.Yorium_PHLX_head = { name="Yorium Barbuta", augments={'Phalanx +3',}}
    gear.Yorium_PHLX_body = { name="Yorium Cuirass", augments={'Phalanx +3',}}
    gear.Yorium_PHLX_legs = { name="Yorium Cuisses", augments={'Phalanx +3',}}

    -- -- Eschite
    gear.Eschite_A_feet = { name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}}
    gear.Eschite_C_feet = { name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}}

    -- -- Adhemar
    gear.Adhemar_B_head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}

    gear.Adhemar_A_body = {name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}

    gear.Adhemar_A_hands = {name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_hands = {name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}
    
    gear.Adhemar_D_legs = {name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}
    gear.Adhemar_D_feet = {name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

    -- -- Apogee
    gear.Apogee_A_head = { name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_A_body = { name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_D_legs = { name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}}
    gear.Apogee_A_feet = { name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}

    -- -- Carmine
    gear.Carmine_D_head = { name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
    gear.Carmine_B_body = { name="Carm. Sc. Mail +1", augments={'Accuracy+12','DEX+12','MND+20',}}
    gear.Carmine_D_hands ={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
    gear.Carmine_D_legs = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
    gear.Carmine_B_feet = { name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}

    -- -- Kaykaus
    gear.Kaykaus_B_head = { name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_A_body = { name="Kaykaus Bliaut +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
    gear.Kaykaus_D_hands = { name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}}
    gear.Kaykaus_A_legs = { name="Kaykaus Tights +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
    gear.Kaykaus_B_feet = { name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}

    -- -- Amalric
    gear.Amalric_A_head = { name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_body = { name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_hands = { name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_legs = { name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_feet = { name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}

    -- -- Souveran
    gear.Souveran_C_head = { name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_body = { name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_hands = { name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_legs = { name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_D_feet = { name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}}

    -- -- Ryuo
    gear.Ryuo_A_hands = { name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
    gear.Ryuo_C_head = { name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_C_feet = { name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_D_legs = { name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}}

    -- -- Rao
    gear.Rao_B_pants = { name="Rao Haidate +1", augments={'STR+12','DEX+12','Attack+20',}}

    -- -- Lustratio
    gear.Lustratio_D_feet = { name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}

    -- -- Chironic
    -- gear.Chironic_MAB_hands = {name="Chironic Gloves", augments={'"Mag.Atk.Bns."+27','Accuracy+9 Attack+9','Weapon skill damage +7%','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
    -- gear.Chironic_QA_hands = {name="Chironic Gloves", augments={'Pet: "Mag.Atk.Bns."+4','Accuracy+2 Attack+2','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    -- gear.Chironic_QA_feet = {name="Chironic Slippers", augments={'AGI+5','Pet: Mag. Acc.+11','Quadruple Attack +3',}}

    gear.Chironic_ENF_legs = { name="Chironic Hose", augments={'Mag. Acc.+29','"Cure" spellcasting time -9%','MND+10','"Mag.Atk.Bns."+15',}}
    -- gear.Chironic_WSD_head = {name="Chironic Hat", augments={'CHR+6','Accuracy+5','Weapon skill damage +8%','Accuracy+13 Attack+13','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
    -- gear.Chironic_WSD_hands = {name="Chironic Gloves", augments={'MND+11','Pet: STR+8','Weapon skill damage +10%','Accuracy+16 Attack+16','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}

    -- -- Herculean
    gear.Herc_TA_legs = { name="Herculean Trousers", augments={'Accuracy+22 Attack+22','"Triple Atk."+4','Attack+3',}}
    gear.Herc_TA_feet = { name="Herculean Boots", augments={'Attack+14','"Triple Atk."+4','AGI+8','Accuracy+13',}}

    gear.Herc_MAB_head = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +1%','Mag. Acc.+5 "Mag.Atk.Bns."+5',}}
    gear.Herc_MAB_body = { name="Herculean Vest", augments={'"Mag.Atk.Bns."+23','Weapon skill damage +4%','DEX+2','Mag. Acc.+10',}}
    gear.Herc_MAB_hands = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Mag.Atk.Bns."+15',}}
    gear.Herc_MAB_legs = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +5%','DEX+7','Mag. Acc.+7',}}
    gear.Herc_MAB_feet = { name="Herculean Boots", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','INT+9',}}

    gear.Herc_WSD_head ={ name="Herculean Helm", augments={'Accuracy+14','Weapon skill damage +3%','STR+7','Attack+10',}}
    gear.Herc_WSD_hands = { name="Herculean Gloves", augments={'Weapon skill damage +3%','INT+14','Mag. Acc.+3','"Mag.Atk.Bns."+6',}}
    gear.Herc_WSD_legs = { name="Herculean Trousers", augments={'Attack+18','Weapon skill damage +5%','AGI+4','Accuracy+7',}}
    gear.Herc_WSD_feet = { name="Herculean Boots", augments={'Pet: INT+2','Enmity-4','Weapon skill damage +6%',}}

    -- -- Valorous
    gear.Valo_TP_body = { name="Valorous Mail", augments={'Accuracy+27','"Dbl.Atk."+5',}}
    gear.Valo_WSD_head = { name="Valorous Mask", augments={'Attack+18','Sklchn.dmg.+5%','STR+12','Accuracy+13',}}
    gear.Valo_WSD_body = { name="Valorous Mail", augments={'AGI+8','Weapon Skill Acc.+9','Weapon skill damage +5%','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    gear.Valo_WSD_hands ={ name="Valorous Mitts", augments={'Weapon skill damage +3%','STR+10','Accuracy+7','Attack+13',}}
    gear.Valo_WSD_feet = { name="Valorous Greaves", augments={'Attack+15','Weapon skill damage +4%','STR+4','Accuracy+4',}}

    -- -- Odyssean
    gear.Ody_WS_hands = { name="Odyssean Gauntlets", augments={'Weapon skill damage +4%','VIT+7','Accuracy+9','Attack+10',}}
    gear.Ody_CURE_feet = { name="Odyssean Greaves", augments={'Accuracy+29','"Cure" potency +6%','STR+5','Attack+1',}}

    -- -- Merlinic
    gear.Merl_FC_body = { name="Merlinic Jubbah", augments={'"Fast Cast"+7','MND+6',}}
    -- gear.Merl_MB_body = {name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','VIT+5','"Mag.Atk.Bns."+12',}}
    gear.Merl_TH_feet = { name="Merlinic Crackows", augments={'Weapon skill damage +2%','"Waltz" potency +3%','"Treasure Hunter"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
    gear.Merl_TH_hands = { name="Merlinic Dastanas", augments={'MND+10','"Treasure Hunter"+1',}}
  

    -- -- Ambuscade Capes

    gear.WHM_Cure_Cape = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%','Spell interruption rate down-10%',}}

    gear.THF_TP_Cape ={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}}

    gear.RDM_DW_Cape = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.RDM_MND_Cape = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Mag. Evasion+15',}} --*
    gear.RDM_ENH_Cape = { name="Ghostfyre Cape", augments={'Enfb.mag. skill +8','Enha.mag. skill +1','Mag. Acc.+1','Enh. Mag. eff. dur. +18',}}

    gear.PLD_cape = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}}
    gear.PLD_FC_cape = { name="Rudianos's Mantle", augments={'"Fast Cast"+8','Spell interruption rate down-10%',}}

    gear.BRD_Song_Cape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}} --*
    gear.BRD_TP_Cape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.BRD_WS1_Cape = { name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*
    gear.BRD_WS2_Cape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*

    gear.COR_TP_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.COR_WS_Cape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

    gear.DRG_TP_Cape = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}-- *
    gear.DRG_WS1_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} -- *
    gear.DRG_WS2_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}} -- *
   
    gear.DRK_TP_Cape = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --*
    gear.DRK_WS1_Cape = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.DRK_WS2_Cape = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}} --*
    gear.DRK_DRK_Cape = { name="Niht Mantle", augments={'Attack+15','Dark magic skill +10','"Drain" and "Aspir" potency +23',}}

    gear.SAM_TP_Cape = { name="Takaha Mantle", augments={'STR+3','"Zanshin"+3','"Store TP"+3',}}
    gear.SAM_WS_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*

    gear.NIN_TP_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}}
    gear.NIN_WS_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.NIN_MEVA_Cape = { name="Andartia's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Mag. Evasion+15',}} --*

    gear.SCH_MAB_Cape = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Mag. Evasion+15',}}

    gear.SMN_Cape = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20',}}

    gear.BLU_TP_Cape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.BLU_CDC_Cape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --*
    gear.BLU_BLUSKILL_Cape = { name="Cornflower Cape", augments={'MP+29','DEX+3','Accuracy+4','Blue Magic skill +7',}}

    gear.RNG_DW_Cape = {name="Lutian Cape"}
    gear.RNG_RA_Cape = {name="Lutian Cape"}
    gear.RNG_SNP_Cape = {name="Lutian Cape"}
    gear.RNG_TP_Cape = {name="Lutian Cape"}
    gear.RNG_WS1_Cape = {name="Lutian Cape"}
    gear.RNG_WS2_Cape = {name="Lutian Cape"}
end

-- function define_war_sets()
-- end

-- function define_mnk_sets()
-- end

-- function define_blm_sets()
-- end

-- function define_whm_sets()
--     gear.Artifact.Head = { name= "Theophany Cap" }
--     gear.Artifact.Body = { name= "Theophany Bliaut" }
--     gear.Artifact.Hands = { name= "Theophany Mitts" }
--     gear.Artifact.Legs = { name= "Theophany Pantaloons" }
--     -- gear.Artifact.Feet = { name= "Theophany Duckbills" }

--     gear.Relic.Head = { name= "Piety Cap" }
--     gear.Relic.Body = { name= "Piety Bliaut" }
--     gear.Relic.Hands = { name= "Piety Mitts" }
--     gear.Relic.Legs = { name= "Piety Pantaloons" }
--     gear.Relic.Feet = { name= "Piety Duckbills" }

--     gear.Empyrean.Head = { name= "Ebers Cap" }
--     gear.Empyrean.Body = { name= "Ebers Bliaut" }
--     gear.Empyrean.Hands = { name= "Ebers Mitts" }
--     gear.Empyrean.Legs = { name= "Ebers Pantaloons" }
--     gear.Empyrean.Feet = { name= "Ebers Duckbills" }
-- end

-- function define_rdm_sets()

--     gear.Artifact.Head = { name= "Atrophy Chapeau +1" }
--     gear.Artifact.Body = { name= "Atrophy Tabard +3" }
--     gear.Artifact.Hands = { name= "Atrophy Gloves +2" }
--     gear.Artifact.Legs = { name= "Atrophy Tights +2" }
--     -- gear.Artifact.Feet = { name= "" }


--     gear.Relic.Head = { name= "Vitiation Chapeau +3" }
--     gear.Relic.Body = { name= "Vitiation Tabard +3" }
--     gear.Relic.Hands = { name= "Vitiation Gloves +3" }
--     gear.Relic.Legs = { name= "Vitiation Tights +3" }
--     gear.Relic.Feet = { name= "Vitiation Boots +3" }

--     gear.Empyrean.Head = { name= "Lethargy Chappel +1" }
--     gear.Empyrean.Body = { name= "Lethargy Sayon +1" }
--     gear.Empyrean.Hands = { name= "Lethargy Gantherots +1" }
--     gear.Empyrean.Legs = { name= "Lethargy Fuseau +1" }
--     gear.Empyrean.Feet = { name= "Lethargy Houseaux +1" }
-- end

