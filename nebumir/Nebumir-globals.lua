-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
    
    -- Duplicate Items
    gear.Stikini_1 = {name="Stikini Ring +1", bag="wardrobe4"}
    gear.Stikini_2 = {name="Stikini Ring +1", bag="wardrobe5"}

    gear.Chirich_1 = {name="Chirich Ring +1", bag="wardrobe4"}
    gear.Chirich_2 = {name="Chirich Ring +1", bag="wardrobe5"}

    ----Weapons
    gear.Gada_FC = { name="Gada", augments={'"Fast Cast"+6','DMG:+5',}}
    gear.Gada_ENH = { name="Gada", augments={'Enh. Mag. eff. dur. +6','"Mag.Atk.Bns."+15',}}

    -- Malignance
    -- gear.Malignance_Head = {name="Malignance Chapeau"}
    -- gear.Malignance_Body = {name="Malignance Tabard"}
    gear.Malignance_Hands = {name="Malignance Gloves"}
    gear.Malignance_Legs= {name="Malignance Tights"}
    gear.Malignance_Feet = {name="Malignance Boots"}

    gear.Telchine_ENH_Head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Body = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Hands = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}}
    gear.Telchine_ENH_Legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}}
    gear.Telchine_ENH_Feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

    -- -- Kaykaus
    gear.Kaykaus_B_Head = { name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_B_Feet = { name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_D_Hands = { name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}}

    gear.Amalric_D_Hands = { name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}

    gear.Carmine_D_Head = { name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
    gear.Carmine_B_Body = { name="Carm. Sc. Mail +1", augments={'Accuracy+12','DEX+12','MND+20',}}
    gear.Carmine_D_Hands ={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
    gear.Carmine_D_Legs = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
    gear.Carmine_B_Feet = { name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}

    gear.Adhemar_A_Head = {name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar_B_Head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Body = {name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar_B_Body = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Hands = {name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar_B_Hands = {name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}    
    -- gear.Adhemar_D_Legs = {name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}
    -- gear.Adhemar_D_Feet = {name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

    gear.Herc_WSD_Head = { name="Herculean Helm", augments={'Attack+23','Weapon skill damage +4%','STR+7',}}
    gear.Herc_WSD_Legs = { name="Herculean Trousers", augments={'Attack+18','Weapon skill damage +4%','STR+5',}}

    -- -- Ambuscade Capes

    gear.WHM_Cure_Cape = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Cure" potency +10%',}}
    
    gear.BLM_MAB_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}
    gear.BLM_Death_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}}

    gear.WAR_TP_Cape = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.WAR_WS1_Cape = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}

    gear.GEO_Pet_Cape = { name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}}
    gear.GEO_MB_Cape = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}

    gear.COR_SNP_Cape = { name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}} --Done
    gear.COR_RA_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}} --TODO
    gear.COR_DW_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-8%',}} -- 1 Resin
    gear.COR_TP_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10',}} -- TODO

    gear.COR_WS1_Cape ={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} -- Savage
    gear.COR_WS2_Cape ={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+2','Weapon skill damage +10%',}} --Leaden
    gear.COR_WS3_Cape ={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}} -- LS/WF

end