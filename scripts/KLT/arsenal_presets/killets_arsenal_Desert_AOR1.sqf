[KLT_arsenal_item, "initPost", {
    params ["_box"];
    [_box, [ 
	
	// ==================== ITEMS =====================

	//Uniforms==============================================
	
	//Pilot stuff
	"U_B_HeliPilotCoveralls",
	"U_B_PilotCoveralls",
	
	//BDU
	"rhs_uniform_FROG01_d",
	"AOR1_Camo",
	"AOR1_Camo_Cyre_Tee",
	"AOR1_Camo_Cyre",
	"AOR1_Camo_SS",
	"AOR1_Camo_BDU",

	//Ghillie 
	"U_B_FullGhillie_ard",


	//Vests==================================================
	"rhs_uniform_FROG01_d",
	"VSM_FAPC_MG_AOR1",
	"VSM_FAPC_Operator_AOR1",
	"AOR1_Vest_5",
	"AOR1_Vest_4",
	"VSM_CarrierRig_Breacher_AOR1",
	"VSM_CarrierRig_Gunner_AOR1",
	"VSM_CarrierRig_Operator_AOR1",
	"VSM_LBT6094_breacher_AOR1",
	"VSM_LBT6094_MG_AOR1",
	"VSM_LBT6094_operator_AOR1",
	"VSM_RAV_Breacher_AOR1",
	"VSM_RAV_MG_AOR1",
	"VSM_RAV_operator_AOR1",
	"AOR1_Vest_1",
	"AOR1_Vest_3",
	"AOR1_Vest_2",
	"V_Rangemaster_belt",
	"V_BandollierB_khk",
	"rhsusf_spc",
	"rhsusf_spc_crewman",
	"rhsusf_spc_corpsman",
	"rhsusf_spc_iar",
	"rhsusf_spc_light",
	"rhsusf_spc_mg",
	"rhsusf_spc_marksman",
	"rhsusf_spc_patchless",
	"rhsusf_spc_patchless_radio",
	"rhsusf_spc_rifleman",
	"rhsusf_spc_squadleader",
	"rhsusf_spc_teamleader",



	//Headgear=============================================		
	//HELMETS		
	"H_HelmetB",
	"H_HelmetB_black",
	"H_HelmetB_camo",
	"H_HelmetB_desert",
	"H_HelmetB_grass",
	"H_HelmetB_sand",
	"H_HelmetB_snakeskin",
	"H_HelmetSpecB",
	"H_HelmetSpecB_blk",
	"H_HelmetSpecB_paint2",
	"H_HelmetSpecB_paint1",
	"H_HelmetSpecB_sand",
	"H_HelmetSpecB_snakeskin",
	"H_HelmetB_light",
	"H_HelmetB_light_black",
	"H_HelmetB_light_desert",
	"H_HelmetB_light_grass",
	"H_HelmetB_light_sand",
	"H_HelmetB_light_snakeskin",

	"rhsusf_bowman_cap",
	"rhsusf_mich_bare",
	"rhsusf_mich_bare_alt",
	"rhsusf_mich_bare_alt_semi",
	"rhsusf_mich_bare_alt_tan",
	"rhsusf_mich_bare_headset",
	"rhsusf_mich_bare_norotos",
	"rhsusf_mich_bare_norotos_alt",
	"rhsusf_mich_bare_norotos_alt_headset",
	"rhsusf_mich_bare_norotos_alt_semi",
	"rhsusf_mich_bare_norotos_alt_semi_headset",
	"rhsusf_mich_bare_norotos_alt_tan",
	"rhsusf_mich_bare_norotos_alt_tan_headset",
	"rhsusf_mich_bare_norotos_arc",
	"rhsusf_mich_bare_norotos_arc_alt",
	"rhsusf_mich_bare_norotos_arc_alt_headset",
	"rhsusf_mich_bare_norotos_arc_alt_semi",
	"rhsusf_mich_bare_norotos_arc_alt_semi_headset",
	"rhsusf_mich_bare_norotos_arc_alt_tan",
	"rhsusf_mich_bare_norotos_arc_alt_tan_headset",
	"rhsusf_mich_bare_norotos_arc_headset",
	"rhsusf_mich_bare_norotos_arc_semi",
	"rhsusf_mich_bare_norotos_arc_semi_headset",
	"rhsusf_mich_bare_norotos_arc_tan",
	"rhsusf_mich_bare_norotos_headset",
	"rhsusf_mich_bare_norotos_semi",
	"rhsusf_mich_bare_norotos_semi_headset",
	"rhsusf_mich_bare_norotos_tan",
	"rhsusf_mich_bare_norotos_tan_headset",
	"rhsusf_mich_bare_semi",
	"rhsusf_mich_bare_semi_headset",
	"rhsusf_mich_bare_tan",
	"rhsusf_mich_bare_tan_headset",
	"rhsusf_opscore_coy_cover",
	"rhsusf_opscore_coy_cover_pelt",
	"rhsusf_mich_helmet_marpatd",
	"rhsusf_mich_helmet_marpatd_alt",
	"rhsusf_mich_helmet_marpatd_alt_headset",
	"rhsusf_mich_helmet_marpatd_headset",
	"rhsusf_mich_helmet_marpatd_norotos",
	"rhsusf_mich_helmet_marpatd_norotos_arc",
	"rhsusf_mich_helmet_marpatd_norotos_arc_headset",
	"rhsusf_mich_helmet_marpatd_norotos_headset",
	"rhsusf_cvc_helmet",
	"rhsusf_cvc_alt_helmet",
	"rhsusf_cvc_ess",

	//Pilot 
	"H_HelmetCrew_B",
	"H_PilotHelmetFighter_B",
	"H_PilotHelmetHeli_B",
	"H_CrewHelmetHeli_B",

	//Crewman
	"H_CrewHelmetHeli_B",
	
	//Only officer
	"H_Beret_Colonel",

	
	//Light Headgear
	"H_Bandanna_mcamo",
	"H_Bandanna_sand",
	"H_Watchcap_blk",
	"H_Watchcap_cbr",
	"H_Watchcap_camo",
	"H_Watchcap_khk",
	"H_Booniehat_khk_hs",
	"H_Booniehat_khk",
	"H_Booniehat_mcamo",
	"H_Booniehat_oli",
	"H_Booniehat_tan",
	"H_Cap_blk",
	"H_Cap_blk_CMMG",
	"H_Cap_oli",
	"H_Cap_oli_hs",
	"H_Cap_tan",
	"H_Cap_tan_specops_US",
	"H_Cap_usblack",
	"H_Cap_headphones",

	"rhsusf_Bowman",
	"rhsusf_bowman_cap",
	"AOR1_Boonie",
	"AOR1_Cap",
	"AOR1_Helmet1",
	"AOR1_Helmet2",
	

	//Facewear=====================================
	"G_Bandanna_blk",
	"G_Bandanna_beast",
	"G_Bandanna_beast",
	"G_Bandanna_khk",
	"G_Bandanna_blk",	
	"G_Bandanna_oli",	
	"G_Bandanna_shades",
	"G_Aviator",
	"G_Bandanna_aviator",
	"G_Bandanna_sport",
	"G_Bandanna_tan",
	"G_Combat",
	"G_Combat_Goggles_tna_F",
	"G_B_Diving",
	"G_Lowprofile",
	"G_Shades_Black",
	"G_Shades_Blue",
	"G_Shades_Green",
	"G_Shades_Red",
	"G_Balaclava_TI_blk_F",
	"G_Balaclava_TI_G_blk_F",
	
	"VSM_balaclava_Black_Skull",
	"VSM_balaclava_Black",
	"VSM_balaclava_olive",
	"VSM_Balaclava_OD_glasses",
	"VSM_Balaclava_black_Goggles",
	"VSM_Balaclava_OD_Goggles",
	"VSM_Balaclava_black_Peltor",
	"VSM_Balaclava_OD_Peltor",
	"VSM_Balaclava2_OD_Peltor",
	"VSM_Balaclava2_OD_Peltor_Goggles",
	"VSM_FaceMask_olive",
	"VSM_Facemask_OD_glasses",
	"VSM_Facemask_OD_Goggles",
	"VSM_Facemask_black_Peltor",
	"VSM_Facemask_OD_Peltor",
	"VSM_Facemask_OD_Peltor_glasses",
	"VSM_Facemask_black_Peltor_Goggles",
	"VSM_Facemask_OD_Peltor_Goggles",
	"VSM_Peltor_OD_glasses",
	"VSM_Shemagh_OD",
	"VSM_Shemagh_tan",
	"VSM_Shemagh_Balaclava_OD",
	"VSM_Shemagh_Balaclava_OD_Glasses",
	"VSM_Shemagh_Balaclava_tan_Glasses",
	"VSM_Shemagh_Balaclava_OD_Goggles",
	"VSM_Shemagh_Balaclava_tan_Goggles",
	"VSM_Shemagh_Balaclava_OD_Peltor",
	"VSM_Shemagh_Balaclava_OD_Peltor_Glasses",
	"VSM_Shemagh_Balaclava_OD_Peltor_Goggles",
	"VSM_Shemagh_Balaclava2_OD",
	"VSM_Shemagh_Balaclava2_tan",
	"VSM_Shemagh_Balaclava2_OD_Goggles",
	"VSM_Shemagh_Balaclava2_tan_Goggles",
	"VSM_Shemagh_Balaclava2_OD_Peltor",
	"VSM_Shemagh_Balaclava2_tan_Peltor",
	"VSM_Shemagh_Balaclava2_OD_Peltor_Glasses",
	"VSM_Shemagh_Facemask_OD_Peltor_Glasses",
	"VSM_Shemagh_Facemask_OD_Peltor_Goggles",
	
	"rhs_googles_black",
	"rhs_googles_clear",
	"rhs_googles_yellow",
	"rhs_googles_orange",
	"rhs_ess_black",
	"rhsusf_shemagh_grn",
	"rhsusf_shemagh2_grn",
	"rhsusf_shemagh_od",
	"rhsusf_shemagh_tan",
	"rhsusf_shemagh2_od",
	"rhsusf_shemagh_white",
	"rhsusf_shemagh2_tan",
	"rhsusf_shemagh2_white",
	"rhsusf_shemagh_gogg_grn",
	"rhsusf_shemagh2_gogg_grn",
	"rhsusf_shemagh_gogg_od",
	"rhsusf_shemagh2_gogg_od",
	"rhsusf_shemagh_gogg_tan",
	"rhsusf_shemagh2_gogg_tan",
	"rhsusf_oakley_goggles_blk",
	"rhsusf_oakley_goggles_clr",
	"rhsusf_oakley_goggles_ylw",

	//NVG==============================================
	"NVGoggles",
	"NVGoggles_INDEP",
	"NVGoggles_OPFOR",
	"A3_GPNVG18_TI",
	"A3_GPNVG18_BLK_F",

	//Radio============================================
	"TFAR_anprc152",

	//Items ===========================================
	"B_UavTerminal",
	"Binocular",
	"ItemCompass",
	"ItemGPS",
	"ItemMap",
	"Laserdesignator",	
	"Rangefinder",	
	"ToolKit",
	"ItemWatch",
	"MineDetector",
	"tf_microdagr",
	"MineDetector",

	//MRH 
	"MRH_AAD_Item",
	"MRH_FiberScope",
	"MRH_HackingTool",
	"MRH_Map",
	"MRH_SoldierTab",



	//Ace stuff
	
	//Medical 
	"ACE_bloodIV",
	"ACE_bloodIV_250",
	"ACE_bloodIV_500",
	"ACE_bodyBag",
	"ACE_epinephrine",
	"ACE_morphine",
	"ACE_fieldDressing",

	//ACE OTHER
	"ACE_ATragMX",
	"ACE_Altimeter",
	"ACE_CableTie",
	"ACE_Cellphone",
	"ACE_Clacker",
	"ACE_DAGR",
	"ACE_DefusalKit",
	"ACE_EarPlugs",
	"ACE_EntrenchingTool",
	"ACE_Flashlight_KSF1",
	"ACE_Flashlight_MX991",
	"ACE_Flashlight_XL50",
	"ACE_HuntIR_monitor",
	"ACE_IR_Strobe_Item",
	"ACE_Kestrel4500",
	"ACE_M26_Clacker",
	"ACE_MX2A",
	"ACE_MapTools",
	"ACE_RangeCard",
	"ACE_RangeTable_82mm",
	"ACE_SpottingScope",
	"ACE_SpraypaintBlack",
	"ACE_SpraypaintBlue",
	"ACE_SpraypaintGreen",
	"ACE_SpraypaintRed",
	"ACE_Tripod",
	"ACE_UAVBattery",
	"ACE_Vector",
	"ACE_VectorDay",
	"ACE_Yardage450",
	"ACE_microDAGR",
	"ACE_muzzle_mzls_338",
	"ACE_muzzle_mzls_93mmg",
	"ACE_muzzle_mzls_B",
	"ACE_muzzle_mzls_H",
	"ACE_muzzle_mzls_L",
	"ACE_muzzle_mzls_smg_01",
	"ACE_muzzle_mzls_smg_02",
	"ACE_optic_Hamr_PIP",
	"ACE_wirecutter",
	

	//Attachments=====================================
	
	//Sniper sights
	"optic_SOS",
	"optic_LRPS",
	"optic_KHS_tan",
	"optic_KHS_blk",
	"optic_DMS",
	"optic_AMS_snd",
	"optic_AMS",
	"optic_NVS",

	//Sniper sights
	"optic_SOS",
	"optic_LRPS",
	"optic_KHS_tan",
	"optic_KHS_blk",
	"optic_DMS",
	"optic_AMS_snd",
	"optic_AMS",
	"optic_NVS",
	"sfp_optic_kikarsikte90b_10x",
	"rhsusf_acc_LEUPOLDMK4",
	"rhsusf_acc_LEUPOLDMK4_2",
	"rhsusf_acc_M8541",
	"rhsusf_acc_M8541_low",
	"rhsusf_acc_M8541_low_wd",
	"rhsusf_acc_premier",
	"rhsusf_acc_premier_anpvs27",
	"rhsusf_acc_premier_low",
	
	"muzzle_snds_H",
	"muzzle_snds_H_snd_F",
	"muzzle_snds_M",
	"muzzle_snds_m_snd_F",
	"muzzle_snds_B",
	"muzzle_snds_B_snd_F",
	"muzzle_snds_338_sand",
	"muzzle_snds_338_black",
	"muzzle_snds_acp",
	"muzzle_snds_L",
	
	
	
	
	//Suppresssors
	"muzzle_snds_H",
	"muzzle_snds_H_snd_F",
	"muzzle_snds_H_khk_F",
	"muzzle_snds_M",
	"muzzle_snds_m_snd_F",
	"muzzle_snds_B",
	"muzzle_snds_B_snd_F",
	"muzzle_snds_338_sand",
	"muzzle_snds_338_black",
	"muzzle_snds_acp",
	"muzzle_snds_L",
	"muzzle_snds_570",
	"muzzle_snds_65_TI_blk_F",
	"muzzle_snds_B_khk_F",


	
	//Sights
	"optic_Hamr",
	"optic_MRCO",
	"optic_Holosight_smg_blk_F",
	"optic_Holosight_smg",
	"optic_Holosight_blk_F",
	"optic_Holosight",
	"optic_ERCO_snd_F",
	"optic_ERCO_blk_F",
	"optic_Arco_blk_F",
	"optic_Arco",
	"optic_Aco_smg",
	"optic_Aco",
	"optic_ACO_grn",
	"optic_ACO_grn_smg",
	"optic_MRD",
	"optic_Yorris",
	

	
	//Bipods
	"bipod_01_F_blk",
	"bipod_01_F_mtp",
	"bipod_01_F_snd",
	
	//PEQ
	"acc_pointer_IR",
	"acc_flashlight",
	"acc_flashlight_pistol",



	//RHS stuff
	
	
	
	"rhsusf_acc_ACOG",
	"rhsusf_acc_ACOG2",
	"rhsusf_acc_ACOG2_USMC",
	"rhsusf_acc_ACOG3",
	"rhsusf_acc_ACOG3_USMC",
	"rhsusf_acc_ACOG_MDO",
	"rhsusf_acc_ACOG_RMR",
	"rhsusf_acc_ACOG_USMC",
	"rhsusf_acc_ACOG_anpvs27",
	"rhsusf_acc_ACOG_wd",
	"rhsusf_acc_ARDEC_M240",
	"rhsusf_acc_ELCAN",
	"rhsusf_acc_ELCAN_ard",
	"rhsusf_acc_EOTECH",
	"rhsusf_acc_M2010S",
	"rhsusf_acc_M2A1",
	"rhsusf_acc_M952V",
	"rhsusf_acc_SF3P556",
	"rhsusf_acc_SFMB556",
	"rhsusf_acc_SR25S",
	"rhsusf_acc_SpecterDR",
	"rhsusf_acc_SpecterDR_A",
	"rhsusf_acc_SpecterDR_OD",
	"rhsusf_acc_anpeq15",
	"rhsusf_acc_anpeq15A",
	"rhsusf_acc_anpeq15_bk",
	"rhsusf_acc_anpeq15_bk_light",
	"rhsusf_acc_anpeq15_bk_top",
	"rhsusf_acc_anpeq15_light",
	"rhsusf_acc_anpeq15_top",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_anpeq15_wmx_light",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_anpeq15side_bk",
	"rhsusf_acc_anpvs27",
	"rhsusf_acc_compm4",
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_eotech_552_d",
	"rhsusf_acc_eotech_xps3",
	"rhsusf_acc_grip1",
	"rhsusf_acc_grip2",
	"rhsusf_acc_grip2_tan",
	"rhsusf_acc_grip3",
	"rhsusf_acc_grip3_tan",
	"rhsusf_acc_grip4",
	"rhsusf_acc_harris_bipod",
	"rhsusf_acc_harris_swivel",
	"rhsusf_acc_muzzleFlash_SF3P556",
	"rhsusf_acc_muzzleFlash_SFMB556",
	"rhsusf_acc_muzzleFlash_ardec_m240",
	"rhsusf_acc_nt4_black",
	"rhsusf_acc_nt4_tan",
	"rhsusf_acc_omega9k",
	"rhsusf_acc_rotex5_grey",
	"rhsusf_acc_rotex5_tan",
	"rhsusf_acc_rotex_mp7",
	"rhsusf_acc_rotex_mp7_aor1",
	"rhsusf_acc_rotex_mp7_desert",
	"rhsusf_acc_wmx",
	"rhs_acc_at4_handler",

		
	
	
	"rhsusf_acc_ACOG",
	"rhsusf_acc_ACOG2",
	"rhsusf_acc_ACOG2_USMC",
	"rhsusf_acc_ACOG3",
	"rhsusf_acc_ACOG3_USMC",
	"rhsusf_acc_ACOG_MDO",
	"rhsusf_acc_ACOG_RMR",
	"rhsusf_acc_ACOG_USMC",
	"rhsusf_acc_ACOG_anpvs27",
	"rhsusf_acc_ACOG_wd",
	"rhsusf_acc_ARDEC_M240",
	"rhsusf_acc_ELCAN",
	"rhsusf_acc_ELCAN_ard",
	"rhsusf_acc_EOTECH",
	"rhsusf_acc_M2010S",
	"rhsusf_acc_M2A1",
	"rhsusf_acc_M952V",
	"rhsusf_acc_SF3P556",
	"rhsusf_acc_SFMB556",
	"rhsusf_acc_SR25S",
	"rhsusf_acc_SpecterDR",
	"rhsusf_acc_SpecterDR_A",
	"rhsusf_acc_SpecterDR_OD",
	"rhsusf_acc_anpeq15",
	"rhsusf_acc_anpeq15A",
	"rhsusf_acc_anpeq15_bk",
	"rhsusf_acc_anpeq15_bk_light",
	"rhsusf_acc_anpeq15_bk_top",
	"rhsusf_acc_anpeq15_light",
	"rhsusf_acc_anpeq15_top",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_anpeq15_wmx_light",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_anpeq15side_bk",
	"rhsusf_acc_anpvs27",
	"rhsusf_acc_compm4",
	"rhsusf_acc_eotech_552",
	"rhsusf_acc_eotech_552_d",
	"rhsusf_acc_eotech_xps3",
	"rhsusf_acc_grip1",
	"rhsusf_acc_grip2",
	"rhsusf_acc_grip2_tan",
	"rhsusf_acc_grip3",
	"rhsusf_acc_grip3_tan",
	"rhsusf_acc_grip4",
	"rhsusf_acc_harris_bipod",
	"rhsusf_acc_harris_swivel",
	"rhsusf_acc_muzzleFlash_SF3P556",
	"rhsusf_acc_muzzleFlash_SFMB556",
	"rhsusf_acc_muzzleFlash_ardec_m240",
	"rhsusf_acc_nt4_black",
	"rhsusf_acc_nt4_tan",
	"rhsusf_acc_omega9k",
	"rhsusf_acc_rotex5_grey",
	"rhsusf_acc_rotex5_tan",
	"rhsusf_acc_rotex_mp7",
	"rhsusf_acc_rotex_mp7_aor1",
	"rhsusf_acc_rotex_mp7_desert",
	"rhsusf_acc_wmx",
	"rhs_acc_at4_handler",


	"rhsusf_acc_harris_bipod",
	"ACE_muzzle_mzls_338",
	"muzzle_snds_338_black",
	"rhsusf_acc_anpeq15side",
	"rhsusf_acc_anpeq15_top",
	"rhsusf_acc_anpeq15_wmx",
	"rhsusf_acc_anpeq15_wmx_light",
	"rhsusf_acc_anpeq15side_bk",
	"rhsusf_acc_anpeq15_bk_top",
	"rhsusf_acc_anpeq15",
	"rhsusf_acc_anpeq15_light",
	"rhsusf_acc_anpeq15_bk",
	"rhsusf_acc_anpeq15_bk_light",
	"rhsusf_acc_anpeq15A",
	"rhsusf_acc_anpeq16a",
	"rhsusf_acc_anpeq16a_light",
	"rhsusf_acc_anpeq16a_top",
	"rhsusf_acc_anpeq16a_light_top",
	"rhsusf_acc_M952V",
	"rhsusf_acc_wmx_bk",
	"rhsusf_acc_grip2",
	"rhsusf_acc_grip2_tan",
	"rhsusf_acc_grip2_wd",
	"bipod_01_F_blk",
	"bipod_01_F_khk",
	"bipod_01_F_snd",
	"rhsusf_acc_harris_bipod",
	"rhsusf_acc_grip1",
	"rhsusf_acc_rvg_blk",
	"rhsusf_acc_rvg_de",
	"rhsusf_acc_tdstubby_blk",
	"rhsusf_acc_tdstubby_tan",
	"rhsusf_acc_grip3",
	"rhsusf_acc_grip3_tan",
	"ACE_muzzle_mzls_L",
	"rhsusf_acc_nt4_black",
	"rhsusf_acc_nt4_tan",
	"rhsusf_acc_SF3P556",
	"rhs_weap_hk416d145_wd",
	"muzzle_snds_m_snd_F",
	"rhsusf_acc_M2010S_d",
	"rhsusf_acc_M2010S_wd",
	"rhsusf_acc_m24_muzzlehider_black",
	"rhsusf_acc_m24_silencer_black",
	"rhsusf_acc_ARDEC_M240",
	
	"ACE_muzzle_mzls_B",
	"muzzle_snds_H_MG_blk_F",
	"rhsusf_acc_SR25S",
	"rhsusf_acc_rotex_mp7_winter",
	"rhsusf_acc_rotex_mp7",
	"muzzle_snds_B",
	"acc_flashlight_pistol",
	"muzzle_snds_acp",
	"optic_MRD",
	"ACE_muzzle_mzls_smg_02",

	"hlc_muzzle_300blk_KAC",
	"hlc_muzzle_556NATO_KAC",



	//Vanilla=============================
	//Other 
	
	"ACE_VMH3",
	"ACE_VMM3",
	
	"lerca_1200_black",
	"lerca_1200_tan",
	"Leupold_Mk4",

	//Marksman
	"rhs_weap_M107",
	"rhs_weap_XM2010",
	"rhs_weap_XM2010_wd",
	"rhs_weap_m24sws",
	"rhs_weap_m24sws_blk",
	"rhs_weap_m24sws_ghillie",
	"rhs_weap_m40a5_wd",
	"rhs_weap_sr25",


	//SMG 
	"SMG_03C_camo",
	"SMG_03C_TR_camo",
	"SMG_03_camo",
	
	//Machineguns
	"rhs_weap_m249",
	"rhs_weap_m249_pip_L",
	"rhs_weap_m249_pip_L_para",
	"rhs_weap_m249_pip_L_vfg",
	"rhs_weap_m249_pip_S",
	"rhs_weap_m249_pip_S_para",
	"rhs_weap_m249_pip_S_vfg",
	"rhs_weap_m249_pip",

	//Guns
	"rhs_weap_hk416d10",
	"rhs_weap_hk416d10_m320",
	"rhs_weap_hk416d10_LMT",
	"rhs_weap_hk416d10_LMT_wd",
	"rhs_weap_hk416d10_LMT_d",
	"rhs_weap_hk416d145",
	"rhs_weap_hk416d145_m320",
	"rhs_weap_hk416d145_wd",
	"rhs_weap_m14ebrri",
	"rhs_weap_m16a4",
	"rhs_weap_m16a4_pmag",
	"rhs_weap_m27iar",
	"rhs_weap_m27iar_grip",
	"rhs_weap_m4_m203",
	"rhs_weap_m4_m203S",
	"rhs_weap_m4a1_blockII",
	"rhs_weap_m4a1_blockII_bk",
	"rhs_weap_m4a1_blockII_M203_bk",
	"rhs_weap_m4a1_blockII_KAC_bk",
	"rhs_weap_m4a1_blockII_M203",
	"rhs_weap_m4a1_blockII_KAC",
	"rhs_weap_m4a1",
	"rhs_weap_m4a1_m203",
	"rhs_weap_m4a1_m203s",
	"rhs_weap_m4a1_mstock",
	"rhs_weap_mk18_bk",
	"rhs_weap_mk18",
	"rhs_weap_mk18_KAC_bk",
	"rhs_weap_mk18_KAC",
	"rhsusf_weap_MP7A2",
	
	//Pistols
	"hgun_Pistol_heavy_01_F",
	"hgun_ACPC2_F",
	"hgun_P07_khk_F",
	"hgun_P07_F",
	"hgun_Rook40_F",
	"hgun_Pistol_heavy_02_F",
	"rhsusf_weap_glock17g4",
	"rhsusf_weap_m1911a1",
	"rhsusf_weap_m9",
	
	// Launchers
	"launch_MRAWS_green_F",
	"launch_MRAWS_green_rail_F",
	"launch_NLAW_F",
	"launch_RPG32_F",
	"launch_B_Titan_F",
	"launch_I_Titan_short_F",
	"launch_O_Vorona_green_F",

	//RHS  Launchers
	"rhs_weap_fim92",
	"rhs_weap_fgm148",
	"rhs_weap_M136",
	
	
	

	

	//Magazines============================================================
	"ClaymoreDirectionalMine_Remote_Mag",
	"SLAMDirectionalMine_Wire_Mag",
 	"DemoCharge_Remote_Mag",
	"APERSBoundingMine_Range_Mag",
	"Laserbatteries",
	"rhsusf_m112_mag",
 	"rhsusf_m112x4_mag",

	
	"6Rnd_45ACP_Cylinder",
 	"9Rnd_45ACP_Mag",
	"11Rnd_45ACP_Mag",
	"10Rnd_9x21_Mag",
	"16Rnd_9x21_Mag",
	"16Rnd_9x21_Mag",
	"6Rnd_GreenSignal_F",
 	"200Rnd_65x39_cased_Box",
	"200Rnd_65x39_cased_Box_Tracer",
 	"20Rnd_762x51_Mag",
 	"20Rnd_762x51_Mag",
 	"10Rnd_338_Mag",
 	"10Rnd_338_Mag",
 	"150Rnd_762x54_Box",
 	"150Rnd_762x54_Box_Tracer",
	"7Rnd_408_Mag",
	"130Rnd_338_Mag",
	"150Rnd_556x45_Drum_Mag_F",
	"150Rnd_93x64_Mag",
	"10Rnd_93x64_DMR_05_Mag",
	"200Rnd_65x39_cased_Box",
	"30Rnd_65x39_caseless_mag",
	"30Rnd_65x39_caseless_mag_Tracer",
 	"30Rnd_65x39_caseless_green",
 	"30Rnd_65x39_caseless_green_mag_Tracer",
 	"30Rnd_9x21_Mag_SMG_02_Tracer_Red",
 	"30Rnd_9x21_Mag_SMG_02_Tracer_Green",
 	"30Rnd_9x21_Mag_SMG_02_Tracer_Yellow",
 	"30Rnd_9x21_Mag_SMG_02",
 	"30Rnd_65x39_caseless_green",
 	"30Rnd_65x39_caseless_green_mag_Tracer",
 	"30Rnd_556x45_Stanag_Tracer_Red",
 	"30Rnd_556x45_Stanag_Tracer_Green",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"30Rnd_556x45_Stanag_red",
	"30Rnd_556x45_Stanag_green",
	"30Rnd_556x45_Stanag",
	"30Rnd_556x45_Stanag_Tracer_Green",
	"30Rnd_556x45_Stanag_Tracer_Red",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"100Rnd_65x39_caseless_mag_Tracer",
	"100Rnd_65x39_caseless_mag",
	"30Rnd_556x45_Stanag",
	"30Rnd_556x45_Stanag_Tracer_Green",
	"30Rnd_556x45_Stanag_Tracer_Red",
	"30Rnd_556x45_Stanag_Tracer_Yellow",
	"50Rnd_570x28_SMG_03",
	"UGL_FlareWhite_F",
	"UGL_FlareGreen_F",
	"UGL_FlareRed_F",
	"UGL_FlareCIR_F",
	"1Rnd_Smoke_Grenade_shell",
	"1Rnd_SmokeRed_Grenade_shell",
	"1Rnd_SmokeGreen_Grenade_shell",
	"1Rnd_SmokeYellow_Grenade_shell",
	"1Rnd_SmokePurple_Grenade_shell",
	"1Rnd_SmokeBlue_Grenade_shell",
	"1Rnd_SmokeOrange_Grenade_shell",
	"1Rnd_HE_Grenade_shell",
	"200Rnd_556x45_Box_F",
	"200Rnd_556x45_Box_Red_F",
	"200Rnd_556x45_Box_Tracer_F",
	"200Rnd_556x45_Box_Tracer_Red_F",

	"rhs_mag_m67",
	"RHS_Ammo_DAGR",
	"RHS_LWIRCM_Ammo_MELB",
	"RHS_ammo_AGM_114K",
	"RHS_ammo_AGM_114L",
	"RHS_ammo_AGM_114M",
	"RHS_ammo_AGM_114N",
	"RHS_ammo_BGM109",
	"RHS_ammo_M792_HEI",
	"RHS_ammo_M919_APFSDS",
	"rhs_40mm_smoke_green",
	"rhs_40mm_smoke_red",
	"rhs_40mm_smoke_white",
	"rhs_40mm_smoke_yellow",
	"rhs_Laserbeam",
	"rhs_ammo_127x99_Ball",
	"rhs_ammo_127x99_Ball_Tracer_Green",
	"rhs_ammo_127x99_Ball_Tracer_Red",
	"rhs_ammo_127x99_Ball_Tracer_Yellow",
	"rhs_ammo_127x99_SLAP",
	"rhs_ammo_127x99_SLAP_Tracer_Green",
	"rhs_ammo_127x99_SLAP_Tracer_Red",
	"rhs_ammo_127x99_SLAP_Tracer_Yellow",
	"rhs_ammo_12gHEAP_penetrator",
	"rhs_ammo_12g_00buckshot",
	"rhs_ammo_12g_FRAG",
	"rhs_ammo_12g_HE",
	"rhs_ammo_12g_slug",
	"rhs_ammo_20mm_AP",
	"rhs_ammo_30x113mm_M789_HEDP",
	"rhs_ammo_30x113mm_M789_HEDP_laser",
	"rhs_ammo_30x113mm_M789_HEDP_penetrator",
	"rhs_ammo_30x173mm_GAU8_mixed",
	"rhs_ammo_40mmHEDP_penetrator",
	"rhs_ammo_45ACP_MHP",
	"rhs_ammo_46x30_AP",
	"rhs_ammo_46x30_FMJ",
	"rhs_ammo_46x30_JHP",
	"rhs_ammo_556x45_M855A1_Ball",
	"rhs_ammo_556x45_M855A1_Ball_Green",
	"rhs_ammo_556x45_M855A1_Ball_Orange",
	"rhs_ammo_556x45_M855A1_Ball_Red",
	"rhs_ammo_556x45_M855A1_Ball_Yellow",
	"rhs_ammo_556x45_M855_Ball",
	"rhs_ammo_556x45_M855_Ball_Green",
	"rhs_ammo_556x45_M855_Ball_Orange",
	"rhs_ammo_556x45_M855_Ball_Red",
	"rhs_ammo_556x45_M855_Ball_Yellow",
	"rhs_ammo_556x45_Mk262_Ball",
	"rhs_ammo_556x45_Mk318_Ball",
	"rhs_ammo_556x45_blank",
	"rhs_ammo_762x51_M118_Special_Ball",
	"rhs_ammo_762x51_M61_AP",
	"rhs_ammo_762x51_M62_tracer",
	"rhs_ammo_762x51_M80A1EPR_Ball",
	"rhs_ammo_762x51_M80_Ball",
	"rhs_ammo_762x51_M82_blank",
	"rhs_ammo_762x51_M993_Ball",
	"rhs_ammo_9x19_FMJ",
	"rhs_ammo_9x19_JHP",
	"rhs_ammo_ANALQ131",
	"rhs_ammo_Hellfire_AT",
	"rhs_ammo_Hellfire_AT_penetrator",
	"rhs_ammo_Hydra_HE_Heli",
	"rhs_ammo_Hydra_M151",
	"rhs_ammo_Hydra_M229",
	"rhs_ammo_ITOW_AT",
	"rhs_ammo_ITOW_AT_penetrator",
	"rhs_ammo_M1028",
	"rhs_ammo_M1069",
	"rhs_ammo_M1147",
	"rhs_ammo_M136_hedp_penetrator",
	"rhs_ammo_M136_hedp_rocket",
	"rhs_ammo_M136_hp_penetrator",
	"rhs_ammo_M136_hp_rocket",
	"rhs_ammo_M136_penetrator",
	"rhs_ammo_M136_rocket",
	"rhs_ammo_M416",
	"rhs_ammo_M829",
	"rhs_ammo_M829A1",
	"rhs_ammo_M829A2",
	"rhs_ammo_M829A3",
	"rhs_ammo_M830",
	"rhs_ammo_M830A1",
	"rhs_ammo_M830A1_penetrator",
	"rhs_ammo_M830_penetrator",
	"rhs_ammo_M_fgm148_AT",
	"rhs_ammo_M_fgm148_AT_penetrator",
	"rhs_ammo_M_fgm172a_AT",
	"rhs_ammo_M_fgm172b_MPV",
	"rhs_ammo_PGU13B_HE",
	"rhs_ammo_PGU14B_API",
	"rhs_ammo_Sidewinder_AA",
	"rhs_ammo_Stinger_AA",
	"rhs_ammo_TOW2A_AT",
	"rhs_ammo_TOW2B_AERO_AT",
	"rhs_ammo_TOW2B_AT",
	"rhs_ammo_TOW2B_AT_penetrator",
	"rhs_ammo_TOW2_AT",
	"rhs_ammo_TOW2_AT_penetrator",
	"rhs_ammo_TOW2_AT_static",
	"rhs_ammo_TOW2_BB",
	"rhs_ammo_TOWB_AT",
	"rhs_ammo_TOW_AT",
	"rhs_ammo_TOW_AT_penetrator",
	"rhs_ammo_agm65",
	"rhs_ammo_agm65_penetrator",
	"rhs_ammo_agm65b",
	"rhs_ammo_agm65d",
	"rhs_ammo_agm65e",
	"rhs_ammo_agm65f",
	"rhs_ammo_agm65h",
	"rhs_ammo_aim120",
	"rhs_ammo_aim120d",
	"rhs_ammo_an_m14_th3",
	"rhs_ammo_an_m14_th3_droplet",
	"rhs_ammo_an_m8hc",
	"rhs_ammo_cbu100",
	"rhs_ammo_cbu87",
	"rhs_ammo_cbu_base",
	"rhs_ammo_doomsday_buckshot",
	"rhs_ammo_fim92_missile",
	"rhs_ammo_flechettes",
	"rhs_ammo_flechettes_m1028",
	"rhs_ammo_gbu12",
	"rhs_ammo_m18_green",
	"rhs_ammo_m18_purple",
	"rhs_ammo_m18_red",
	"rhs_ammo_m18_yellow",
	"rhs_ammo_m1_he",
	"rhs_ammo_m314_ilum",
	"rhs_ammo_m397",
	"rhs_ammo_m576_buckshot",
	"rhs_ammo_m60a2_smoke",
	"rhs_ammo_m67",
	"rhs_ammo_m69",
	"rhs_ammo_m72a7_rocket",
	"rhs_ammo_m7a3_cs",
	"rhs_ammo_m84",
	"rhs_ammo_maaws_HE",
	"rhs_ammo_maaws_HEAT",
	"rhs_ammo_maaws_HEAT_penetrator",
	"rhs_ammo_maaws_HEDP",
	"rhs_ammo_maaws_HEDP_penetrator",
	"rhs_ammo_maaws_ILLUM",
	"rhs_ammo_maaws_SMOKE",
	"rhs_ammo_mk19m3_M1001",
	"rhs_ammo_mk19m3_M384",
	"rhs_ammo_mk19m3_M430I",
	"rhs_ammo_mk19m3_M430I_penetrator",
	"rhs_ammo_mk3a2","rhs_ammo_mk82",
	"rhs_ammo_smaw_HEAA",
	"rhs_ammo_smaw_HEAA_penetrator",
	"rhs_ammo_smaw_HEDP",
	"rhs_ammo_smaw_HEDP_penetrator",
	"rhs_ammo_smaw_SR",
	"rhs_ammo_smokegen",
	"rhs_ammo_spall",
	"rhs_ammo_sub_blu97",
	"rhs_ammo_sub_blu97_penetrator",
	"rhs_ammo_sub_mk118",
	"rhs_ammo_sub_mk118_penetrator",
	"rhs_laserbeam_fcs",
	"rhs_m821_he",
	"rhsusf_40mm_HE",
	"rhsusf_40mm_HEDP",
	"rhsusf_40mm_Practice",
	"rhsusf_40mm_green",
	"rhsusf_40mm_red",
	"rhsusf_40mm_white",
	"rhsusf_B_300winmag",
	"rhsusf_M61A2",
	"rhsusf_ammo_127x99_M33_Ball",
	"rhsusf_ammo_127x99_mk211",
	"rhsusf_ammo_L8A3",
	"rhsusf_ammo_L8A3_shell",
	"rhsusf_ammo_basic_penetrator",
	"rhsusf_ammo_basic_penetrator_base",
	"rhsusf_ammo_duke",
	"rhsusf_m112_ammo",
	"rhsusf_m112_ammo_scripted",
	"rhsusf_m112x4_ammo",
	"rhsusf_m112x4_ammo_scripted",
	"rhsusf_mine_m14_ammo",
	"rhsusf_mine_m19_ammo",
	"rhsusf_20Rnd_762x51_m118_special_Mag",
	"rhsusf_20Rnd_762x51_m993_Mag",
	"rhs_mag_30Rnd_556x45_M200_Stanag",
	"rhs_mag_30Rnd_556x45_Mk262_Stanag",
	"rhs_mag_30Rnd_556x45_Mk318_Stanag",
	"rhs_mag_30Rnd_556x45_M855_Stanag",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Orange",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Yellow",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Green",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_No_Tracer",
	"rhs_mag_30Rnd_556x45_M855A1_Stanag_Tracer_Red",
	"rhs_mag_rdg2_white",
	"rhs_mag_an_m8hc",
	"rhs_mag_m67",
	"rhsusf_5Rnd_300winmag_xm2010",
	"rhsusf_10Rnd_STD_50BMG_M107",
	"rhs_200rnd_556x45_M_SAW",
	"rhs_200rnd_556x45_T_SAW",
	"rhs_200rnd_556x45_B_SAW",
	"rhsusf_50Rnd_762x51",
	"rhsusf_50Rnd_762x51_m61_ap",
	"rhsusf_50Rnd_762x51_m62_tracer",
	"rhsusf_50Rnd_762x51_m80a1epr",
	"rhsusf_100Rnd_762x51",
	"rhsusf_100Rnd_762x51_m61_ap",
	"rhsusf_100Rnd_762x51_m62_tracer",
	"rhsusf_100Rnd_762x51_m80a1epr",
	"rhsusf_50Rnd_762x51_m993",
	"rhsusf_100Rnd_762x51_m993",
	"rhsusf_mag_6Rnd_M441_HE",
	"rhsusf_mag_6Rnd_M433_HEDP",
	"rhsusf_mag_6Rnd_M714_white",
	"rhsusf_mag_6Rnd_M576_Buckshot",
	"rhsusf_m112_mag",
	"rhsusf_m112x4_mag",
	"rhs_mag_m18_green",
	"rhs_mag_m18_purple",
	"rhs_mag_m18_red",
	"rhs_mag_m18_yellow",
	"rhsusf_5Rnd_00Buck",
	"rhsusf_8Rnd_00Buck",
	"rhsusf_5Rnd_Slug",
	"rhsusf_8Rnd_Slug",
	"rhs_m136_mag",
	"rhs_m136_hedp_mag",
	"rhs_m136_hp_mag",
	"rhs_fim92_mag",
	"rhs_fgm148_magazine_AT",
	"rhs_mag_smaw_HEAA",
	"rhs_mag_smaw_HEDP",
	"rhs_mag_smaw_SR",
	"rhsusf_mag_7x45acp_MHP",
	"rhsusf_mag_17Rnd_9x19_FMJ",
	"rhsusf_mag_17Rnd_9x19_JHP",
	"rhsusf_mag_15Rnd_9x19_FMJ",
	"rhsusf_mag_15Rnd_9x19_JHP",
	"rhs_mag_m713_Red",
	"rhs_mag_M433_HEDP",
	"rhs_mag_M397_HET",
	"rhs_mag_m4009",
	"rhs_mag_M585_white",
	"rhs_mag_m661_green",
	"rhs_mag_m662_red",
	"rhs_mag_m713_Red",
	"rhs_mag_m714_White",
	"rhs_mag_m715_Green",
	"rhs_mag_m716_yellow",

 	//AT Ammo
	"MRAWS_HEAT_F",
	"MRAWS_HE_F",
	"RPG32_F",
	"RPG32_HE_F",
	"Titan_AT",
	"Titan_AP",
	"Titan_AA",
	"M_Titan_AA",
	"Vorona_HEAT",
	"Vorona_HE",
	"MissileBase",
	"Missile_AA_04_F",
	"Missile_AGM_02_F",
	
	//Granades
	"HandGrenade",
	"Chemlight_blue",
	"Chemlight_green",
	"Chemlight_red",
	"Chemlight_yellow",
	"B_IR_Grenade",
	"SmokeShellBlue",
	"SmokeShellGreen",
	"SmokeShellOrange",
	"SmokeShellPurple",
	"SmokeShellRed",
	"SmokeShellYellow",
	"SmokeShell",
	"HandGrenade",
	
	//ACE
	"ACE_Chemlight_HiOrange",
	"ACE_Chemlight_HiRed",
	"ACE_Chemlight_HiWhite",
	"ACE_Chemlight_HiYellow",
	"ACE_Chemlight_IR",
	"ACE_Chemlight_Orange",
	"ACE_Chemlight_White",
	"ACE_M84",
	"ACE_HandFlare_White",
	"ACE_HandFlare_Red",
	"ACE_HandFlare_Green",
	"ACE_100Rnd_65x39_caseless_mag_Tracer_Dim",
	"ACE_30Rnd_65x39_caseless_mag_Tracer_Dim",
	"ACE_30Rnd_556x45_Stanag_M995_AP_mag",
	"ACE_30Rnd_556x45_Stanag_Mk262_mag",
	"ACE_30Rnd_556x45_Stanag_Mk318_mag",
	"ACE_30Rnd_556x45_Stanag_Tracer_Dim",
	"ACE_20Rnd_762x51_Mag_Tracer",
	"ACE_20Rnd_762x51_Mag_Tracer_Dim",
	"ACE_20Rnd_762x51_Mk316_Mod_0_Mag",
 	"ACE_20Rnd_762x51_M118LR_Mag",
 	"ACE_20Rnd_762x51_Mk319_Mod_0_Mag",
 	"ACE_20Rnd_762x51_M993_AP_Mag",
 	"ACE_20Rnd_762x51_Mag_SD",
	"ACE_200Rnd_65x39_cased_Box_Tracer_Dim",
	"ACE_20Rnd_762x67_Berger_Hybrid_OTM_Mag",
	"ACE_20Rnd_762x67_Mk248_Mod_1_Mag",
	"ACE_20Rnd_762x67_Mk248_Mod_0_Mag",
	"ACE_10Rnd_338_API526_Mag",
	"ACE_10Rnd_338_300gr_HPBT_Mag",
	"ACE_7Rnd_408_305gr_Mag",
	"ACE_30Rnd_65x39_caseless_mag_Tracer_Dim",
	"ACE_30Rnd_65x39_caseless_green_mag_Tracer_Dim",
	"ACE_30Rnd_65x39_caseless_green_mag_Tracer_Dim",
	"ACE_HuntIR_M203",


	// ==================Backpacks====================

	"B_Parachute",
	"B_AssaultPack_blk",
	"B_AssaultPack_rgr",
	"B_AssaultPack_mcamo",
	"B_AssaultPack_Kerry",
	"B_AssaultPack_sgg",
	"B_Kitbag_rgr",
	"B_Kitbag_mcamo",
	"B_Kitbag_cbr",
	"B_Kitbag_sgg",
	"B_Kitbag_tan",
	"B_Carryall_oli",
	"B_Carryall_khk",
	"B_Carryall_mcamo",
	"B_TacticalPack_blk",
	"B_TacticalPack_rgr",
	"B_TacticalPack_mcamo",
	"B_TacticalPack_oli",


	//RHS 
	"rhsusf_assault_eagleaiii_coy",
	"rhsusf_assault_eagleaiii_ocp",
	"rhsusf_falconii",
	"rhsusf_falconii_coy",
	"rhsusf_falconii_mc",

	//VSM 
	"VSM_AOR1_carryall",
	"AOR1_Backpack_Compact",
	"VSM_AOR1_Backpack_Kitbag",

	//ACE
	"ACE_NonSteerableParachute",
	"ace_gunbag",
	"ace_gunbag_Tan",
	
	//Long Range Radios
	"TFAR_rt1523g",
	"TFAR_rt1523g_big",
	"TFAR_rt1523g_big_rhs",
	"TFAR_rt1523g_black",
	"TFAR_rt1523g_green",
	"TFAR_rt1523g_rhs",
	"FRXA_tf_rt1523g_MARPAT_Desert",
	"FRXA_tf_rt1523g_Ranger_Green",
	"FRXA_tf_rt1523g_big_MARPAT_Desert",
	"FRXA_tf_rt1523g_big_Ranger_Green",
	"FRXA_tf_rt1523g_big_Black",
	"FRXA_tf_rt1523g_Black",

	"TFAR_rt1523g_sage"



	]] call ace_arsenal_fnc_initBox;
}, false, [], true] call CBA_fnc_addClassEventHandler; 
