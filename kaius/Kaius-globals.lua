-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    -- Malignance
    gear.Malignance_Head = {name="Malignance Chapeau"}
    gear.Malignance_Body = {name="Malignance Tabard"}
    gear.Malignance_Hands = {name="Malignance Gloves"}
    gear.Malignance_Legs= {name="Malignance Tights"}
    gear.Malignance_Feet = {name="Malignance Boots"}

    -- Tatenashi
    gear.Tatenashi_Body = {name="Tatenashi Haramaki +1"}
    gear.Tatenashi_Hands = {name="Tatenashi Gote +1"}
    gear.Tatenashi_Legs = {name="Tatenashi Haidate +1"}
    gear.Tatenashi_Feet = {name="Tatenashi Sune-Ate +1"}

    -- Odyssey
    gear.Nyame_Head = {name="Nyame Helm"}
    gear.Nyame_Body = {name="Nyame Mail"}
    gear.Nyame_Hands = {name="Nyame Gauntlets"}
    gear.Nyame_Legs= {name="Nyame Flanchard"}
    gear.Nyame_Feet = {name="Nyame Sollerets"}

    gear.Sakpata_Head = {name="Sakpata's Helm"}
    gear.Sakpata_Body = {name="Sakpata's Breastplate"}
    gear.Sakpata_Hands = {name="Sakpata's Gauntlets"}
    gear.Sakpata_Legs= {name="Sakpata's Cuisses"}
    gear.Sakpata_Feet = {name="Sakpata's Leggings"}

    gear.Gleti_Head = {name="Gleti's Mask"}
    gear.Gleti_Body = {name="Gleti's Cuirass"}
    gear.Gleti_Hands = {name="Gleti's Gauntlets"}
    gear.Gleti_Legs= {name="Gleti's Breeches"}
    gear.Gleti_Feet = {name="Gleti's Boots"}

    gear.Mpaca_Head = {name="Mpaca's Cap"}
    gear.Mpaca_Body = {name="Mpaca's Doublet"}
    gear.Mpaca_Hands = {name="Mpaca's Gloves"}
    gear.Mpaca_Legs= {name="Mpaca's Hose"}
    gear.Mpaca_Feet = {name="Mpaca's Boots"}

    gear.Ikenga_Head = {name="Ikenga's Hat"}
    gear.Ikenga_Body = {name="Ikenga's Vest"}
    gear.Ikenga_Hands = {name="Ikenga's Gloves"}
    gear.Ikenga_Legs= {name="Ikenga's Trousers"}
    gear.Ikenga_Feet = {name="Ikenga's Clogs"}

    gear.Bunzi_Head = {name="Bunzi's Hat"}
    gear.Bunzi_Body = {name="Bunzi's Robe"}
    gear.Bunzi_Hands = {name="Bunzi's Gloves"}
    gear.Bunzi_Legs= {name="Bunzi's Pants"}
    gear.Bunzi_Feet = {name="Bunzi's Sabots"}

    gear.Agwu_Head = {name="Agwu's Cap"}
    gear.Agwu_Body = {name="Agwu's Robe"}
    gear.Agwu_Hands = {name="Agwu's Gages"}
    gear.Agwu_Legs= {name="Agwu's Slops"}
    gear.Agwu_Feet = {name="Agwu's Pigaches"}

    -- Duplicate Items
    gear.Stikini_1 = {name="Stikini Ring +1", bag="wardrobe7"}
    gear.Stikini_2 = {name="Stikini Ring +1", bag="wardrobe8"}
    gear.Chirich_1 = {name="Chirich Ring +1", bag="wardrobe7"}
    gear.Chirich_2 = {name="Chirich Ring +1", bag="wardrobe8"}
    gear.Moonlight_1 = {name="Moonlight Ring", bag="wardrobe7"}
    gear.Moonlight_2 = {name="Moonlight Ring", bag="wardrobe8"}
    gear.Varar_1 = {name="Varar Ring +1", bag="wardrobe7"}
    gear.Varar_2 = {name="Varar Ring +1", bag="wardrobe8"}
    gear.Eshmun_1 = {name="Eshmun's Ring", bag="wardrobe7"}
    gear.Eshmun_2 = {name="Eshmun's Ring", bag="wardrobe8"}

    -- Augmented Weapons
    gear.Colada_ENH = { name="Colada", augments={'Enh. Mag. eff. dur. +4','STR+5','Mag. Acc.+18',}}

    -- gear.Gada_ENF = {name="Gada", augments={'"Conserve MP"+2','MND+14','Mag. Acc.+20','"Mag.Atk.Bns."+2','DMG:+7',}}
    gear.Gada_ENH = { name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+16',}}

    gear.Lathi_MAB = {name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}}

    -- -- Acro
    gear.Acro_STP_Hands = {name="Acro Gauntlets", augments={'Accuracy+25','"Store TP"+6','STR+6 DEX+6',}}

    -- -- Taeon

    gear.Taeon_SNAP_Head = {name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
    gear.Taeon_FC_Body = {name="Taeon Tabard", augments={'"Fast Cast"+5',}}
    gear.Taeon_Phalanx_Body ={ name="Taeon Tabard", augments={'Mag. Evasion+15','Spell interruption rate down -10%','Phalanx +3',}}
    gear.Taeon_Phalanx_Hands ={ name="Taeon Gloves", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}
    gear.Taeon_Phalanx_Legs = { name="Taeon Tights", augments={'Mag. Evasion+16','Spell interruption rate down -8%','Phalanx +3',}}
    gear.Taeon_Phalanx_Feet ={ name="Taeon Boots", augments={'Mag. Evasion+15','Spell interruption rate down -9%','Phalanx +3',}}

    gear.Taeon_Pet_Head = { name="Taeon Chapeau", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_Hands = { name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_Legs = { name="Taeon Tights", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_Feet = { name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}

    gear.Taeon_DW_Feet = { name="Taeon Boots", augments={'Accuracy+19 Attack+19','"Dual Wield"+5','STR+7 DEX+7',}}

    gear.Telchine_ENH_Head = { name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Body = { name="Telchine Chas.", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Hands= { name="Telchine Gloves", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Legs = { name="Telchine Braconi", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Feet = { name="Telchine Pigaches", augments={'Mag. Evasion+19','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_SONG_Feet = { name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -6%','Enh. Mag. eff. dur. +10',}}

    -- -- Yorium
    gear.Yorium_PHLX_Head = { name="Yorium Barbuta", augments={'Phalanx +3',}}
    gear.Yorium_PHLX_Body = { name="Yorium Cuirass", augments={'Phalanx +3',}}
    gear.Yorium_PHLX_Legs = { name="Yorium Cuisses", augments={'Phalanx +3',}}

    -- -- Eschite
    gear.Eschite_A_Feet = { name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}}
    gear.Eschite_C_Feet = { name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}}

    -- -- Adhemar
    gear.Adhemar_A_Head = {name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_Head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Body = {name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_Body = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Hands = {name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_Hands = {name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}    
    gear.Adhemar_D_Legs = {name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}
    gear.Adhemar_D_Feet = {name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

    -- -- Apogee
    gear.Apogee_A_Head = { name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_A_Body = { name="Apo. Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_D_Legs = { name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}}
    gear.Apogee_A_Feet = { name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}

    -- -- Carmine
    gear.Carmine_D_Head = { name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
    gear.Carmine_B_Body = { name="Carm. Sc. Mail +1", augments={'Accuracy+12','DEX+12','MND+20',}}
    gear.Carmine_D_Hands ={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
    gear.Carmine_D_Legs = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
    gear.Carmine_B_Feet = { name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}

    -- -- Emicho
    gear.Emicho_C_Head = { name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}
    gear.Emicho_C_Hands = { name="Emi. Gauntlets +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}
    gear.Emicho_D_Hands = { name="Emi. Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}}

    -- -- Kaykaus
    gear.Kaykaus_B_Head = { name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_A_Body = { name="Kaykaus Bliaut +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
    gear.Kaykaus_D_Hands = { name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}}
    gear.Kaykaus_A_Legs = { name="Kaykaus Tights +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
    gear.Kaykaus_B_Feet = { name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}

    -- -- Amalric
    gear.Amalric_A_Head = { name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Body = { name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Hands = { name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Legs = { name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Feet = { name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}

    -- -- Souveran
    gear.Souveran_C_Head = { name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_Body = { name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_Hands = { name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_Legs = { name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_D_Feet = { name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}}

    -- -- Ryuo
    gear.Ryuo_A_Hands = { name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
    gear.Ryuo_C_Head = { name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_C_Feet = { name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_D_Legs = { name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}}

    -- -- Rao
    gear.Rao_D_Head = { name="Rao Kabuto +1", augments={'VIT+12','Attack+25','"Counter"+4',}}
    gear.Rao_D_Hands = { name="Rao Kote +1", augments={'MND+12','Mag. Evasion+20','Magic dmg. taken -5',}}
    gear.Rao_D_Feet = { name="Rao Sune-Ate +1", augments={'HP+65','Crit. hit rate+4%','"Dbl.Atk."+4',}}
    gear.Rao_B_Pants = { name="Rao Haidate +1", augments={'STR+12','DEX+12','Attack+20',}}

    -- -- Lustratio
    gear.Lustratio_D_Feet = { name="Lustra. Leggings +1", augments={'HP+65','STR+15','DEX+15',}}

    -- -- Chironic
    -- gear.Chironic_MAB_Hands = {name="Chironic Gloves", augments={'"Mag.Atk.Bns."+27','Accuracy+9 Attack+9','Weapon skill damage +7%','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
    -- gear.Chironic_QA_Hands = {name="Chironic Gloves", augments={'Pet: "Mag.Atk.Bns."+4','Accuracy+2 Attack+2','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    -- gear.Chironic_QA_Feet = {name="Chironic Slippers", augments={'AGI+5','Pet: Mag. Acc.+11','Quadruple Attack +3',}}

    gear.Chironic_ENF_Legs = { name="Chironic Hose", augments={'Mag. Acc.+29','"Cure" spellcasting time -9%','MND+10','"Mag.Atk.Bns."+15',}}
    -- gear.Chironic_WSD_Head = {name="Chironic Hat", augments={'CHR+6','Accuracy+5','Weapon skill damage +8%','Accuracy+13 Attack+13','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}
    -- gear.Chironic_WSD_Hands = {name="Chironic Gloves", augments={'MND+11','Pet: STR+8','Weapon skill damage +10%','Accuracy+16 Attack+16','Mag. Acc.+6 "Mag.Atk.Bns."+6',}}

    -- -- Herculean
    gear.Herc_TA_Legs = { name="Herculean Trousers", augments={'Accuracy+22 Attack+22','"Triple Atk."+4','Attack+3',}}
    gear.Herc_TA_Feet = { name="Herculean Boots", augments={'Attack+14','"Triple Atk."+4','AGI+8','Accuracy+13',}}

    gear.Herc_MAB_Head = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+25','Weapon skill damage +1%','Mag. Acc.+5 "Mag.Atk.Bns."+5',}}
    gear.Herc_MAB_Body = { name="Herculean Vest", augments={'"Mag.Atk.Bns."+23','Weapon skill damage +4%','DEX+2','Mag. Acc.+10',}}
    gear.Herc_MAB_Hands = { name="Herculean Gloves", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Mag.Atk.Bns."+15',}}
    gear.Herc_MAB_Legs = { name="Herculean Trousers", augments={'"Mag.Atk.Bns."+15','Weapon skill damage +5%','DEX+7','Mag. Acc.+7',}}
    gear.Herc_MAB_Feet = { name="Herculean Boots", augments={'"Mag.Atk.Bns."+21','Weapon skill damage +3%','INT+9',}}

    gear.Herc_WSD_Head ={ name="Herculean Helm", augments={'Accuracy+14','Weapon skill damage +3%','STR+7','Attack+10',}}
    -- gear.Herc_WSD_Hands = { name="Herculean Gloves", augments={'Weapon skill damage +3%','INT+14','Mag. Acc.+3','"Mag.Atk.Bns."+6',}}
    gear.Herc_WSD_Body = { name="Herculean Vest", augments={'Accuracy+14 Attack+14','Weapon skill damage +4%','STR+9','Accuracy+5','Attack+5',}}
    gear.Herc_WSD_Legs = { name="Herculean Trousers", augments={'Attack+18','Weapon skill damage +5%','AGI+4','Accuracy+7',}}
    gear.Herc_WSD_Feet = { name="Herculean Boots", augments={'Pet: INT+2','Enmity-4','Weapon skill damage +6%',}}

    -- -- Valorous
    gear.Valo_QA_Body = { name="Valorous Mail", augments={'Crit.hit rate+5','STR+8','Quadruple Attack +2','Accuracy+19 Attack+19',}}
    gear.Valo_PET_Body = { name="Valorous Mail", augments={'Pet: Mag. Acc.+24','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: MND+8','Pet: Accuracy+12 Pet: Rng. Acc.+12',}}
   
    gear.Valo_WSD_Head = { name="Valorous Mask", augments={'Attack+18','Sklchn.dmg.+5%','STR+12','Accuracy+13',}}
    gear.Valo_WSD_Body = { name="Valorous Mail", augments={'AGI+8','Weapon Skill Acc.+9','Weapon skill damage +5%','Accuracy+4 Attack+4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}}
    gear.Valo_WSD_Hands ={ name="Valorous Mitts", augments={'Weapon skill damage +3%','STR+10','Accuracy+7','Attack+13',}}
    -- gear.Valo_WSD_Feet = { name="Valorous Greaves", augments={'Attack+15','Weapon skill damage +4%','STR+4','Accuracy+4',}}

    -- -- Odyssean
    gear.Ody_CURE_Feet = { name="Odyssean Greaves", augments={'Accuracy+29','"Cure" potency +6%','STR+5','Attack+1',}}

    -- gear.Merl_MB_Body = {name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','VIT+5','"Mag.Atk.Bns."+12',}}
    gear.Merl_TH_Feet = { name="Merlinic Crackows", augments={'Weapon skill damage +2%','"Waltz" potency +3%','"Treasure Hunter"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}}
    gear.Merl_TH_Hands = { name="Merlinic Dastanas", augments={'MND+10','"Treasure Hunter"+1',}}
    gear.Merl_MB_Feet = { name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}}
  

    -- -- Ambuscade Capes
  

    gear.BLM_MAB_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    gear.BLM_Death_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}

    gear.WHM_Cure_Cape = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','"Cure" potency +10%','Spell interruption rate down-10%',}}

    gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.THF_WS_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*

    gear.RDM_DW_Cape = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.RDM_MND_Cape = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Mag. Evasion+15',}} --*
    gear.RDM_ENH_Cape = { name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enha.mag. skill +10','Mag. Acc.+7','Enh. Mag. eff. dur. +20',}}

    gear.PLD_Cape = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}}
    gear.PLD_FC_Cape = { name="Rudianos's Mantle", augments={'"Fast Cast"+8','Spell interruption rate down -10%',}}

    gear.COR_SNP_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.COR_RA_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.COR_DW_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.COR_TP_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.COR_WS1_Cape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*
    gear.COR_WS2_Cape = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}} --*
    gear.COR_WS3_Cape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    gear.DRG_TP_Cape = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Haste"+10','Damage taken-5%',}} --*
    gear.DRG_WS1_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*
    gear.DRG_WS2_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}} -- *
   
    gear.DRK_TP_Cape = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --*
    gear.DRK_WS1_Cape = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.DRK_WS2_Cape = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%',}} --*
    gear.DRK_DRK_Cape = { name="Niht Mantle", augments={'Attack+15','Dark magic skill +10','"Drain" and "Aspir" potency +23',}}

    -- gear.SAM_TP_Cape = { name="Takaha Mantle", augments={'STR+3','"Zanshin"+3','"Store TP"+3',}}
    gear.SAM_TP_Cape = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.SAM_WS_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*

    gear.NIN_TP_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}}
    gear.NIN_WS_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.NIN_MEVA_Cape = { name="Andartia's Mantle", augments={'DEX+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Store TP"+10','Mag. Evasion+15',}} --*

    gear.SCH_MAB_Cape = { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Mag. Evasion+15',}}
    gear.SCH_REG_Cape = { name="Bookworm's Cape", augments={'INT+1','MND+3','Helix eff. dur. +13','"Regen" potency+10',}}

    gear.SMN_Cape = { name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20',}}

    gear.BLU_TP_Cape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.BLU_CDC_Cape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}} --*
    gear.BLU_BLUSKILL_Cape = { name="Cornflower Cape", augments={'MP+29','DEX+3','Accuracy+4','Blue Magic skill +7',}}

    gear.RNG_DW_Cape ={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.RNG_RA_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RNG_SNP_Cape = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
    gear.RNG_TP_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RNG_LS_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.RNG_TF_Cape = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}

    -- gear.MNK_Tp_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    -- gear.MNK_INT_Cape = { name="Segomo's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','INT+10','Weapon skill damage +10%',}}
    -- gear.MNK_WS_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}}

    gear.MNK_TP_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.MNK_INT_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.MNK_WS_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}

    gear.RUN_HPD_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_HPP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_TP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_WS1_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
    gear.RUN_WS2_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}}
end