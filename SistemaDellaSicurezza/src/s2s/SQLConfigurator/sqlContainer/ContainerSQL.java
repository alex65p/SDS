/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

/*
 * ContainerSQL.java
 *
 * Created on 21 marzo 2007, 15.13
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package s2s.SQLConfigurator.sqlContainer;

/**
 *
 * @author dario.massaroni
 */
public class ContainerSQL {
    
    private String isDeletableRiscFromAttLavorativaQUERY = 
                    "SELECT H.COD_RSO, H.COD_AZL "+
			"FROM RSO_MAN_TAB H "+
			"WHERE ( "+
			"H.COD_MAN=? "+
			"AND H.COD_RSO=? "+
			"AND H.COD_AZL=?) "+
			"AND H.COD_RSO || ' ' || H.COD_AZL NOT IN "+
			"(SELECT C.COD_RSO||' '||C.COD_AZL FROM "+
			"ANA_MAN_TAB A, OPE_SVO_MAN_TAB B, RSO_OPE_SVO_TAB C "+
			"WHERE "+
			"A.COD_MAN=? "+
			"AND A.COD_MAN=B.COD_MAN "+
			"AND B.COD_OPE_SVO=C.COD_OPE_SVO "+
			"AND B.COD_OPE_SVO!=? "+
			"AND C.COD_RSO=? "+
			"AND C.COD_AZL=?)";

    private String removeDpiQUERY_STEP1 =
        "DELETE FROM dpi_man_tab " +
        "WHERE COD_TPL_DPI = ? " +
                "AND cod_man in " +
                        "(select distinct a.cod_man " +
                         "from dpi_man_tab a, dpi_rso_tab b, rso_man_tab c " +
                         "where a.cod_tpl_dpi = ? " +
                                "and b.cod_rso     = ? " +
                                "and b.cod_rso     = c.cod_rso " +
                                "and c.cod_man     = a.cod_man " +
                                "and b.cod_azl = ? " +
                        ") " +
                        "AND cod_man NOT in " +
                        "( select distinct v.cod_man " +
                        "from rso_man_tab v " +
                        "where v.cod_rso in ( " +
                                "select b.cod_rso " +
                                "from dpi_rso_tab b " +
                                "where b.cod_tpl_dpi =? " +
                                "and b.cod_rso    != ? " +
                                "and b.cod_azl = ? " +
                                ") " +
                        ")";
    
    private String removeDpiQUERY_STEP2 = 
        "DELETE FROM dpi_luo_fsc_tab " +
        "WHERE COD_TPL_DPI = ? " +
                "AND cod_luo_fsc in " +
                        "(select distinct a.cod_luo_fsc " +
                         "from " +
                         "dpi_luo_fsc_tab a, dpi_rso_tab b, rso_luo_fsc_tab c "+
                         "where a.cod_tpl_dpi = ? " +
                                "and b.cod_rso     = ? " +
                                "and b.cod_rso     = c.cod_rso " +
                                "and c.cod_luo_fsc = a.cod_luo_fsc " +
                                "and b.cod_azl = ? " +
                        ") " +
        "AND cod_luo_fsc NOT IN ( " +
                        "select distinct v.cod_luo_fsc " +
                        "from rso_luo_fsc_tab v " +
                        "where v.cod_rso in " +
                            "(select b.cod_rso " +
                            "from dpi_rso_tab b " +
                            "where b.cod_tpl_dpi = ? " +
                            "and b.cod_rso    != ? " +
                            "and b.cod_azl = ? " +
                            ") " +
                        ")";
    
    private String removeDpiQUERY_STEP3 = 
     "DELETE FROM dpi_rso_tab WHERE cod_rso=? AND cod_tpl_dpi=? and cod_azl = ?";

    private String removeCorsoQUERY_STEP1 = 
        "DELETE FROM cor_man_tab " +
            "WHERE COD_COR = ? " +
                "AND cod_man in " +
                    "(select distinct a.cod_man " +
                            "from cor_man_tab a, cor_rso_tab b, rso_man_tab c " +
                    "where a.cod_cor = ? " +
                            "and b.cod_rso = ? " +
                            "and b.cod_rso = c.cod_rso " +
                            "and c.cod_man = a.cod_man " +
                            "and b.cod_azl = ? " +
                    ") " +
                "AND cod_man NOT IN " +
                    "(select distinct v.cod_man " +
                            "from rso_man_tab v " +
                    "where v.cod_rso in (select b.cod_rso " +
                                        "from cor_rso_tab b " +
                                        "where b.cod_cor = ? " +
                                        "and b.cod_rso != ? " +
                                        "and b.cod_azl = ? " +
                                        ") " +
                    ")";
    
    private String removeCorsoQUERY_STEP2 = 
        "DELETE FROM cor_luo_fsc_tab " +
            "WHERE COD_COR =? " +
            "AND cod_luo_fsc in " + 
                "(select distinct a.cod_luo_fsc " +
                    "from cor_luo_fsc_tab a, cor_rso_tab b, rso_luo_fsc_tab c " +
                "where a.cod_cor =? " +
                        "and b.cod_rso = ? " +
                        "and b.cod_rso = c.cod_rso " +
                        "and c.cod_luo_fsc = a.cod_luo_fsc " +
                        "and b.cod_azl = ? " +
                ") " +
                "AND cod_luo_fsc NOT in ( " +
                "select distinct v.cod_luo_fsc " +
                        "from rso_luo_fsc_tab v " +
                "where v.cod_rso in (select b.cod_rso " +
                                "from cor_rso_tab b " +
                                "where b.cod_cor  = ? " +
                                "and b.cod_rso != ? " +
                                "and b.cod_azl = ? " +
                                ") " +
        ")";

    private String removeCorsoQUERY_STEP3 = 
       "DELETE FROM cor_rso_tab WHERE cod_rso=? AND  cod_cor=? and cod_azl = ?";
    
    private String removeProtocolloSanitarioQUERY_STEP1 =
        "DELETE FROM pro_san_man_tab " +
            "WHERE COD_PRO_SAN =? " +
            "AND cod_man in " +
                "(select distinct a.cod_man " +
                    "from pro_san_man_tab a, pro_san_rso_tab b, rso_man_tab c " +
                "where a.cod_pro_san  = ? " +
                        "and b.cod_rso      = ? " +
                        "and b.cod_rso      = c.cod_rso " +
                        "and c.cod_man      = a.cod_man " +
                        "and b.cod_azl = ? " +
                ") AND cod_man NOT in ( " +
                "select distinct v.cod_man " +
                "from rso_man_tab v " +
                "where v.cod_rso in (select b.cod_rso " +
                                "from pro_san_rso_tab b " +
                                "where b.cod_pro_san =? " +
                                "and b.cod_rso    != ? " +
                                "and b.cod_azl = ? " +
                                ") " +
                ")";
    
    private String removeProtocolloSanitarioQUERY_STEP2 = 
        "DELETE FROM pro_SAN_LUO_FSC_tab " +
        "WHERE COD_PRO_SAN = ? " +
            "AND cod_LUO_FSC in " +
                "(select distinct a.cod_LUO_FSC " +
                    "from pro_san_LUO_FSC_tab a, pro_san_rso_tab b, " +
                         "rso_LUO_FSC_tab c " +
                "where a.cod_pro_san  = ? " +
                        "and b.cod_rso       = ? " +
                        "and b.cod_rso      = c.cod_rso " +
                        "and c.cod_LUO_FSC      = a.cod_LUO_FSC " +
                        "and b.cod_azl = ? " +
                ") " +
            "AND cod_LUO_FSC NOT IN( " +
                    "select distinct v.cod_LUO_FSC " +
                    "from rso_LUO_FSC_tab v " +
                        "where v.cod_rso in (select b.cod_rso " +
                                        "from pro_san_rso_tab b " +
                                        "where b.cod_pro_san = ? " +
                                        "and b.cod_rso   != ? " +
                                        "and b.cod_azl = ? " +
                    ") " +
                ")";
    
    private String removeProtocolloSanitarioQUERY_STEP3 = 
        "DELETE FROM pro_san_rso_tab " +
            "WHERE cod_rso= ? AND cod_pro_san=? and cod_azl = ?";
    
    private String removeMisuraPpQUERY_STEP1 = 
        "DELETE FROM mis_pet_man_tab " +
        "WHERE COD_MIS_PET =? " +
            "AND cod_man in " +
                "(select distinct a.cod_man " +
                    "from mis_pet_man_tab a, rso_mis_pet_tab b, rso_man_tab c " +
                "where a.cod_mis_pet  = ? " +
                        "and b.cod_rso      = ? " +
                        "and b.cod_rso      = c.cod_rso " +
                        "and c.cod_man      = a.cod_man " +
                        "and b.cod_azl = ? " +
                ") AND cod_man NOT in ( " +
                "select distinct v.cod_man " +
                "from rso_man_tab v " +
                "where v.cod_rso in (select b.cod_rso " +
                                "from rso_mis_pet_tab b " + 
                                "where b.cod_mis_pet =? " +
                                        "and b.cod_rso    != ? " +
                                        "and b.cod_azl = ? " +
                                        ") " +
                    ")";
    
    private String removeMisuraPpQUERY_STEP2 = 
        "DELETE FROM mis_pet_LUO_FSC_tab " +
        "WHERE COD_MIS_PET = ? " +
            "AND cod_LUO_FSC in " +
                "(select distinct a.cod_LUO_FSC " +
                        "from mis_pet_LUO_FSC_tab a, rso_mis_pet_tab b, " +
                        "rso_LUO_FSC_tab c " +
                "where a.cod_mis_pet  = ? " +
                        "and b.cod_rso      = ? " +
                        "and b.cod_rso      = c.cod_rso " +
                        "and c.cod_LUO_FSC      = a.cod_LUO_FSC " +
                        "and b.cod_azl = ? " +
                ") " +
            "AND cod_LUO_FSC NOT IN( " +
                    "select distinct v.cod_LUO_FSC " +
                    "from rso_LUO_FSC_tab v " +
                            "where v.cod_rso in (select b.cod_rso " +
                                            "from rso_mis_pet_tab b " +
                                            "where b.cod_mis_pet = ? " +
                                                    "and b.cod_rso   != ? " +
                                                    "and b.cod_azl = ? " +
                    ") " +
        ")";
    
    private String removeMisuraPpQUERY_STEP3 = 
        "DELETE FROM rso_mis_pet_tab " +
            "WHERE cod_rso=? AND cod_mis_pet=? and cod_azl = ?";
            
    private String anagraficaDocumentoQUERY =
	  	"SELECT "+
	  	"LST.cod_doc, "+
	  	"'AZIENDA'||' - '||AZL.RAG_SCL_AZL||' - '||AZL.NOM_RSP_AZL, "+
	  	"' - DITTA'||' - '||DTE.RAG_SCL_DTE ||' - '||DTE.NOM_RSP_DTE, "+
	  	"NULL, NULL, NULL, "+ 
	  	"LST.dat_csg_doc_dsi "+
  		"FROM LST_DSI_DOC_TAB LST, ANA_DTE_TAB DTE, ANA_AZL_TAB AZL "+
		"WHERE ( "+
		"LST.COD_DTE IS NOT NULL "+
		"AND LST.COD_DTE = DTE.COD_DTE "+
		"AND DTE.COD_AZL = AZL.COD_AZL "+
		"AND LST.COD_DOC = ? )"+
		"UNION "+
		"SELECT "+
		"LST.cod_doc, "+
		"'AZIENDA'||' - '||AZL.RAG_SCL_AZL||' - '||AZL.NOM_RSP_AZL, "+
		"NULL, "+
		"' - DIPENDENTE'||' - '||DPD.COG_DPD||' '||DPD.NOM_DPD, "+
		"NULL, NULL, "+
		"LST.dat_csg_doc_dsi "+
		"FROM LST_DSI_DOC_TAB LST, ANA_DPD_TAB DPD, ANA_AZL_TAB AZL "+
		"WHERE ( "+
		"LST.COD_DPD IS NOT NULL "+
  		"AND DPD.COD_DPD = LST.COD_DPD "+
  		"AND AZL.COD_AZL = LST.COD_AZL "+
  		"AND LST.COD_DOC = ? ) "+
		"UNION	"+
		"SELECT "+
		"LST.cod_doc, "+
		"'AZIENDA'||' - '||AZL.RAG_SCL_AZL||' - '||AZL.NOM_RSP_AZL, "+
		"NULL, NULL, "+
       	"' - UNITA'' ORGANIZZATIVA'||' - '||UNI.NOM_UNI_ORG ||' - '||DPD.COG_DPD||' '||DPD.NOM_DPD, "+
 		"NULL, LST.dat_csg_doc_dsi "+
		"FROM  LST_DSI_DOC_TAB LST, ANA_DPD_TAB DPD, ANA_UNI_ORG_TAB UNI, ANA_AZL_TAB AZL "+
		"WHERE ( "+
		"LST.COD_UNI_ORG IS NOT NULL "+
		"AND DPD.COD_DPD = UNI.COD_DPD "+
		"AND UNI.COD_UNI_ORG = LST.COD_UNI_ORG "+
		"AND UNI.COD_AZL = LST.COD_AZL "+
		"AND AZL.COD_AZL = LST.COD_AZL "+
   		"AND LST.COD_DOC = ? )"+
  		"UNION "+
		"SELECT "+
		"LST.cod_doc, "+
		"'AZIENDA'||' - '||AZL.RAG_SCL_AZL||' - '||AZL.NOM_RSP_AZL, "+
	    "NULL, NULL, NULL, "+
	    "' - DESTINATARIO ESTERNO'||' - '||LST.NOM_DSI_ESR, "+
		"LST.dat_csg_doc_dsi "+
  		"FROM LST_DSI_DOC_TAB LST, ANA_AZL_TAB AZL "+
		"WHERE( "+
		"LST.NOM_DSI_ESR IS NOT NULL "+
  		"AND AZL.COD_AZL = LST.COD_AZL "+
  		"AND LST.COD_DOC = ? )"+
  		"UNION "+
  		"SELECT "+
		"LST.cod_doc, "+
		"'AZIENDA'||' - '||AZL.RAG_SCL_AZL||' - '||AZL.NOM_RSP_AZL, "+
        "NULL, NULL, NULL, NULL, "+
		"LST.dat_csg_doc_dsi "+
  		"FROM LST_DSI_DOC_TAB LST, ANA_AZL_TAB AZL "+
		"WHERE ( "+
		"AZL.COD_AZL = LST.COD_AZL "+
  		"AND LST.COD_DTE IS NULL "+
  		"AND LST.COD_UNI_ORG IS NULL "+
  		"AND LST.NOM_DSI_ESR IS NULL "+
  		"AND LST.COD_DPD IS NULL "+
  		"AND LST.COD_DOC =? )";
    
    private String report_RischioFattore_RischioView_OPE_SVO_QUERY =
                /*
                 Estrae e raggruppa i rischi per operazioni svolte,
                 a loro volta associate all'attività lavorativa.

                 Questo comportamento è stato modificato su richiesta di milano serravelle,
                 ed esteso a tutti perchè ritenuto valido.
                */
                "SELECT DISTINCT " +
                    "D.COD_RSO, " +
                    "D.NOM_RSO, " +
                    "D.DES_RSO, " +
                    "C.PRB_EVE_LES, " +
                    "C.ENT_DAN, " +
                    "C.STM_NUM_RSO, " +
                    "C.FRQ_RIP_ATT_DAN, " +
                    "C.NUM_INC_INF " +
                "FROM " +
                    "OPE_SVO_MAN_TAB A, " +
                    "RSO_OPE_SVO_TAB B, " +
                    "RSO_MAN_TAB C, " +
                    "ANA_RSO_TAB D " +
                "WHERE " +
                    "A.COD_OPE_SVO = B.COD_OPE_SVO " +
                    "AND A.COD_MAN = C.COD_MAN " +
                    "AND B.COD_RSO = C.COD_RSO " +
                    "AND B.COD_AZL = C.COD_AZL " +
                    "AND C.COD_RSO = D.COD_RSO " +
                    "AND C.COD_AZL = D.COD_AZL " +
                    "AND C.PRS_RSO = 'S' " +
                    "AND D.COD_FAT_RSO = ? " +
                    "AND B.COD_OPE_SVO = ? " +
                    "AND C.COD_MAN = ? " +
                    "AND C.COD_AZL = ? " +
                "ORDER BY " +
                    "D.NOM_RSO ";

    private String report_RischioFattore_RischioView_CAG_FAT_RSO_QUERY =
                /*
                 Estrae i rischi associati all'attività lavorativa,
                 distinti e raggruppati per categoria del fattore di rischio.

                 Questo comportamento è stato mantenuto su richiesta specifica,
                 solo per GSE.
                */
                "SELECT DISTINCT "+
                    "A.COD_RSO, "+
                    "A.NOM_RSO, "+
                    "A.DES_RSO, "+
                    "B.PRB_EVE_LES, "+
                    "B.ENT_DAN, "+
                    "B.STM_NUM_RSO, " +
                    "B.FRQ_RIP_ATT_DAN, " +
                    "B.NUM_INC_INF "+
                "FROM " +
                    "ANA_RSO_TAB A, " +
                    "RSO_MAN_TAB B "+
                "WHERE " +
                    "A.COD_RSO = B.COD_RSO " +
                    "AND A.COD_AZL = B.COD_AZL "+
                    "AND B.PRS_RSO = 'S' "+
                    "AND B.COD_MAN = ? "+
                    "AND A.COD_FAT_RSO = ? "+
                    "AND A.COD_AZL = ? " +
                "ORDER BY " +
                        "A.NOM_RSO";

    private String report_RischioFattore_RischioView_UO_QUERY =
                "SELECT DISTINCT "+
                        " F.cod_rso, "+
                        " F.nom_rso, "+
                        " F.des_rso, "+
                        " C.PRB_EVE_LES,"+
                        " C.ENT_DAN,"+
                        " C.STM_NUM_RSO," +
                        " C.FRQ_RIP_ATT_DAN," +
                        " C.NUM_INC_INF"+
                " FROM  "+
                        " RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B, UNI_ORG_LUO_FSC_TAB A,  ANA_RSO_TAB F "+
                " WHERE  "+
                        " C.PRS_RSO = 'S' "+
                        " AND C.COD_LUO_FSC = B.COD_LUO_FSC "+
                        " AND A.COD_LUO_FSC = B.COD_LUO_FSC "+
                        " AND F.cod_rso=C.COD_RSO "+
                        " AND F.cod_azl=C.COD_azl "+
                        " AND C.COD_AZL =? "+
                        " AND F.cod_fat_rso=? "+
                        " AND A.cod_uni_org=? "+
                " ORDER BY F.nom_rso ";
    
    private String progressivoContratto =
                "select " +
                    "MAX(CAST(SUBSTRING(pro_con FROM 1 FOR CHARACTER_LENGTH(pro_con)-5) AS NUMERIC))+1 AS pro_con " +
                "from " +
                    "ana_con_ser " +
                "where " +
                    "cod_azl = ? " +
                    "and SUBSTRING(pro_con FROM CHARACTER_LENGTH(pro_con)-3) = ?";
    
    private String progressivoDUVRI =
            "SELECT " +
                    "(MAX(CAST(SUBSTRING(pro_duv FROM (CHARACTER_LENGTH(a.pro_con) + 4) FOR CHARACTER_LENGTH(b.pro_duv)) AS NUMERIC)) + 1) AS pro_duv " +
            "FROM " +
                    "ana_con_ser a, " +
                    "con_ser_duvri b " +
            "WHERE " +
                    "a.cod_srv = b.cod_srv " +
            "AND " +
                    "a.cod_azl = ? " +
            "AND " +
                    "a.cod_srv = ?";

    private String notAssRischi_View =
                "SELECT B.COD_RSO, G.NOM_RSO, G.COD_FAT_RSO, Z.NOM_FAT_RSO,G.NOM_RIL_RSO, G.PRB_EVE_LES, " +
                "G.ENT_DAN, G.STM_NUM_RSO, G.RFC_VLU_RSO_MES " +
                "FROM OPE_SVO_MAN_TAB A, RSO_OPE_SVO_TAB B, ANA_RSO_TAB G, ANA_FAT_RSO_TAB Z " +
                "WHERE A.COD_MAN = ? " +
                "AND B.COD_OPE_SVO = A.COD_OPE_SVO " +
                "AND G.COD_RSO     = B.COD_RSO " +
                "AND G.COD_AZL     = B.COD_AZL " +
                "AND G.COD_FAT_RSO = Z.COD_FAT_RSO " +
                "AND G.COD_AZL     = ? " +
                "AND B.COD_AZL     = ? " +
                "EXCEPT " +
                "(SELECT C.COD_RSO, G.NOM_RSO, G.COD_FAT_RSO, Z.NOM_FAT_RSO, " +
                "G.NOM_RIL_RSO, G.PRB_EVE_LES, G.ENT_DAN, G.STM_NUM_RSO, G.RFC_VLU_RSO_MES " +
                "FROM RSO_MAN_TAB C, ANA_RSO_TAB G, ANA_FAT_RSO_TAB Z " +
                "WHERE C.COD_MAN = ? " +
                "AND G.COD_RSO     = C.COD_RSO " +
                "AND G.COD_AZL     = C.COD_AZL " +
                "AND G.COD_FAT_RSO = Z.COD_FAT_RSO " +
                "AND G.COD_AZL     = ? " +
                "AND C.COD_AZL     = ? )";
            
    private String notAssCorsi_View =
            "SELECT DISTINCT " +
                "A.COD_COR, " +
                "G.DUR_COR_GOR, " +
                "G.NOM_COR, " +
                "H.NOM_TPL_COR " +
            "FROM " +
                "COR_RSO_TAB A, " +
                "RSO_MAN_TAB B, " +
                "ANA_COR_TAB G, " +
                "TPL_COR_TAB H " +
            "WHERE " +
                "A.COD_RSO = B.COD_RSO " +
                "AND B.COD_MAN = ? " +
                "AND H.COD_TPL_COR = G.COD_TPL_COR " +
                "AND A.COD_COR = G.COD_COR " +
                "EXCEPT " +
                    "(SELECT DISTINCT " +
                        "F.COD_COR, " +
                        "G.DUR_COR_GOR, " +
                        "G.NOM_COR, " +
                        "H.NOM_TPL_COR " +
                    "FROM " +
                        "COR_MAN_TAB F, " +
                        "ANA_COR_TAB G, " +
                        "TPL_COR_TAB H " +
                    "WHERE " +
                    "F.COD_MAN = ? " +
                    "AND H.COD_TPL_COR = G.COD_TPL_COR " +
                    "AND F.COD_COR = G.COD_COR)";

    private String notAssProtocoli_View =
            "SELECT DISTINCT " +
                "A.COD_PRO_SAN, " +
                "G.NOM_PRO_SAN " +
            "FROM " +
                "PRO_SAN_RSO_TAB A, " +
                "RSO_MAN_TAB B, " +
                "ANA_PRO_SAN_TAB G " +
            "WHERE " +
                "A.COD_RSO     = B.COD_RSO " +
                "AND A.COD_PRO_SAN = G.COD_PRO_SAN " +
                "AND B.COD_MAN     = ? " +
                "AND A.COD_AZL     = ? " +
                "EXCEPT " +
                "(SELECT DISTINCT " +
                    "F.COD_PRO_SAN, " +
                    "G.NOM_PRO_SAN " +
                "FROM " +
                    "PRO_SAN_MAN_TAB F, " +
                    "ANA_PRO_SAN_TAB G, " +
                    "ANA_MAN_TAB J " +
                "WHERE " +
                    "F.COD_MAN     = ? " +
                    "AND F.COD_PRO_SAN = G.COD_PRO_SAN " +
                    "AND J.COD_MAN     = F.COD_MAN " +
                    "AND J.COD_AZL     = ? )";

    private String notAssDPI_View =
            "SELECT DISTINCT " +
                "A.COD_TPL_DPI, " +
                "G.PER_MES_SST, " +
                "G.PER_MES_MNT, " +
                "G.NOM_TPL_DPI " +
            "FROM " +
                "DPI_RSO_TAB A, " +
                "RSO_MAN_TAB B, " +
                "TPL_DPI_TAB G " +
            "WHERE " +
                "A.COD_RSO     = B.COD_RSO " +
                "AND A.COD_TPL_DPI = G.COD_TPL_DPI " +
                "AND B.COD_MAN     = ? " +
                "AND A.COD_AZL     = ? " +
                "EXCEPT " +
                "(SELECT DISTINCT " +
                    "F.COD_TPL_DPI, " +
                    "G.PER_MES_SST, " +
                    "G.PER_MES_MNT, " +
                    "G.NOM_TPL_DPI " +
                "FROM " +
                    "DPI_MAN_TAB F, " +
                    "TPL_DPI_TAB G, " +
                    "ANA_MAN_TAB J " +
                "WHERE " +
                    "F.COD_MAN     = ? " +
                    "AND F.COD_TPL_DPI = G.COD_TPL_DPI " +
                    "AND J.COD_MAN     = F.COD_MAN " +
                    "AND J.COD_AZL     = ? )";

    private String carica_rp_vis_ido_cnt =
            "SELECT " +
                "COUNT(*) " +
            "FROM " +
                "ana_vst_ido_tab_r " +
            "WHERE " +
                "UPPER(TRIM(BOTH FROM nom_vst_ido)) = UPPER(TRIM(BOTH FROM ?))";

    private String carica_rp_vis_med_cnt =
            "SELECT " +
                "COUNT(*) " +
            "FROM " +
                "ana_vst_med_tab_r " +
            "WHERE " +
                "UPPER(TRIM(BOTH FROM nom_vst_med)) = UPPER(TRIM(BOTH FROM ?))";

    private String addCorso =
            "SELECT " +
                "COUNT(A.COD_MAN) " +
            "FROM " +
                "RSO_MAN_TAB A " +
            "WHERE " +
                "A.COD_RSO = ? " +
                "AND A.COD_MAN NOT IN ( " +
                    "SELECT " +
                        "D.COD_MAN " +
                    "FROM " +
                        "cor_man_tab d, " +
                        "ana_man_tab c " +
                    "WHERE " +
                        "d.cod_cor = ? " +
                        "and d.cod_man = c.cod_man) " +
            "UNION ALL " +
            "SELECT " +
                "COUNT(A.COD_LUO_FSC) " +
            "FROM " +
                "RSO_LUO_FSC_TAB A " +
            "WHERE " +
                "A.COD_RSO = ? " +
                "AND A.COD_LUO_FSC NOT IN ( " +
                    "SELECT " +
                        "D.COD_LUO_FSC " +
                    "FROM " +
                        "cor_LUO_FSC_tab d, " +
                        "ana_LUO_FSC_tab c " +
                    "WHERE " +
                        "d.cod_cor =? " +
                        "and d.cod_LUO_FSC = c.cod_LUO_FSC)";

    private String addDpi = 
            "SELECT " +
                "COUNT(A.COD_MAN) " +
            "FROM " +
                "RSO_MAN_TAB A " +
            "WHERE " +
                "A.COD_RSO = ? " +
                "AND A.COD_MAN NOT IN ( " +
                    "SELECT " +
                        "COUNT(D.COD_MAN) " +
                    "FROM " +
                        "DPI_MAN_TAB D, " +
                        "ANA_MAN_TAB V " +
                    "where " +
                        "D.COD_TPL_DPI = ? " +
                        "AND D.COD_MAN     = V.COD_MAN) " +
            "UNION ALL " +
            "SELECT " +
                "COUNT(A.COD_LUO_FSC) " +
            "FROM " +
                "RSO_LUO_FSC_TAB A " +
            "WHERE " +
                "A.COD_RSO = ? " +
                "AND A.COD_LUO_FSC NOT IN ( " +
                    "SELECT " +
                        "D.COD_LUO_FSC " +
                    "FROM " +
                        "DPI_LUO_FSC_TAB D, " +
                        "ANA_LUO_FSC_TAB V " +
                    "WHERE " +
                        "D.COD_TPL_DPI = ? " +
                        "AND D.COD_LUO_FSC  = V.COD_LUO_FSC)";

    private String addProtocolloSanitario = 
            "SELECT " +
                "COUNT(A.COD_MAN) " +
            "FROM " +
                "RSO_MAN_TAB A " +
            "WHERE " +
                "A.COD_RSO = ? " +
                "AND A.COD_MAN NOT IN ( " +
                    "SELECT " +
                        "D.COD_MAN " +
                    "FROM " +
                        "PRO_SAN_MAN_TAB D, " +
                        "ANA_MAN_TAB V " +
                    "WHERE " +
                        "(d.cod_pro_san=? OR d.cod_pro_san IN (?)) " +
                        "AND V.COD_MAN     = D.COD_MAN) " +
            "UNION ALL " +
                "SELECT " +
                    "COUNT(A.COD_LUO_FSC) " +
                "FROM " +
                    "RSO_LUO_FSC_TAB A " +
                "WHERE " +
                    "A.COD_RSO = ? " +
                    "AND A.COD_LUO_FSC  NOT IN ( " +
                        "SELECT " +
                            "D.COD_LUO_FSC " +
                        "FROM " +
                            "PRO_SAN_LUO_FSC_TAB D, " +
                            "ANA_LUO_FSC_TAB V " +
                        "WHERE " +
                            "(d.cod_pro_san=? OR d.cod_pro_san IN (?)) " +
                            "AND V.COD_LUO_FSC     = D.COD_LUO_FSC)";

    private String addMisuraPp =
            "SELECT " +
                "COUNT(A.COD_MAN) " +
            "FROM " +
                "RSO_MAN_TAB A " +
            "WHERE " +
                "A.COD_RSO = ? " +
                "AND A.COD_MAN NOT IN ( " +
                    "SELECT " +
                        "D.COD_MAN " +
                    "FROM " +
                        "MIS_PET_MAN_TAB D, " +
                        "ANA_MAN_TAB V " +
                    "WHERE " +
                        "(d.cod_mis_pet = ? OR d.cod_mis_pet IN(?)) " +
                        "AND V.COD_MAN     = D.COD_MAN) " +
            "UNION ALL " +
                "SELECT " +
                    "COUNT(A.COD_LUO_FSC) " +
                "FROM " +
                    "RSO_LUO_FSC_TAB A " +
                "WHERE " +
                    "A.COD_RSO = ? " +
                    "AND A.COD_LUO_FSC  NOT IN ( " +
                        "SELECT " +
                            "D.COD_LUO_FSC " +
                        "FROM " +
                            "MIS_PET_LUO_FSC_TAB D, " +
                            "ANA_LUO_FSC_TAB V " +
                        "WHERE " +
                            "(d.cod_mis_pet = ? OR d.cod_mis_pet IN(?)) " +
                            "AND V.COD_LUO_FSC     = D.COD_LUO_FSC)";

    private String carica_rp_rischi_cnt =
            "SELECT " +
                "COUNT(*) " +
            "FROM " +
                "ana_rso_tab_r " +
            "WHERE " +
                "UPPER(TRIM(BOTH FROM nom_rso)) = UPPER(TRIM(BOTH FROM ?))";

    private String ejbGetAzioniCorrectivePreventive_View =
            "SELECT " +
                "azn_crr_pet_tab.cod_azn_crr_pet, " +
                "azn_crr_pet_tab.rch_azn_crr_pet, " +
                "azn_crr_pet_tab.tpl_att, " +
                "azn_crr_pet_tab.tpl_azn, " +
                "ana_inr_adt_tab.des_inr_adt, " +
                "azn_crr_pet_tab.dat_rch, " +
                "azn_crr_pet_tab.dat_azn " +
            "FROM   " +
                "azn_crr_pet_tab LEFT OUTER JOIN " +
                "ana_inr_adt_tab ON " +
                    "( azn_crr_pet_tab.cod_inr_adt = ana_inr_adt_tab.cod_inr_adt) " +
            "WHERE 1 = 1";

    private String ejbGetAzioniCorrectivePreventive_AZL_View = 
            "SELECT " +
                "azn_crr_pet_tab.cod_azn_crr_pet, " +
                "azn_crr_pet_tab.rch_azn_crr_pet, " +
                "azn_crr_pet_tab.tpl_att, " +
                "azn_crr_pet_tab.tpl_azn, " +
                "ana_inr_adt_tab.des_inr_adt, " +
                "azn_crr_pet_tab.dat_rch, " +
                "azn_crr_pet_tab.dat_azn " +
            "FROM  " +
                "azn_crr_pet_tab  LEFT OUTER JOIN " +
                "ana_inr_adt_tab  ON " +
                    "( azn_crr_pet_tab.cod_inr_adt =ana_inr_adt_tab.cod_inr_adt) " +
            "WHERE  " +
                "azn_crr_pet_tab.cod_azl =?";

    private String ejbGetMaterialeCorso_View = 
            "SELECT " +
                "ana_doc_tab.cod_doc, " +
                "rsp_doc, dat_rev_doc, " +
                "tit_doc, " +
                "documents.NAME " +
            "FROM " +
                "ana_doc_tab LEFT OUTER JOIN documents ON " +
                    "(ana_doc_tab.cod_doc = documents.cod_doc " +
                    "AND documents.cod_azl = ana_doc_tab.cod_azl) " +
                ", mat_cor_tab " +
            "WHERE " +
                "ana_doc_tab.cod_doc = mat_cor_tab.cod_doc " +
                "AND mat_cor_tab.cod_cor = ? " +
            "ORDER BY " +
                "tit_doc";

    private String ejbGetNonConformitaByInterventoAudit =
            "SELECT " +
                "a.cod_non_cfo, " +
                "a.des_non_cfo, " +
                "a.cod_mis_pet, " +
                "dat_ril_non_cfo, " +
                "a.nom_ril_non_cfo, " +
                "a.cod_inr_adt, " +
                "a.oss_non_cfo, " +
                "b.des_inr_adt " +
            "FROM " +
                "ana_non_cfo_tab AS a LEFT OUTER JOIN ana_inr_adt_tab AS b ON " +
                    "a.cod_inr_adt = b.cod_inr_adt " +
            "WHERE " +
                "a.cod_inr_adt = ? " +
            "ORDER BY " +
                "a.des_non_cfo";

    private String ejbGetNonConformita =
            "SELECT " +
                "a.cod_non_cfo, " +
                "a.des_non_cfo, " +
                "a.cod_mis_pet, " +
                "dat_ril_non_cfo, " +
                "a.nom_ril_non_cfo, " +
                "a.cod_inr_adt, " +
                "a.oss_non_cfo, " +
                "b.des_inr_adt " +
            "FROM " +
                "ana_non_cfo_tab as a left outer join ana_inr_adt_tab as b on " +
                    "a.cod_inr_adt = b.cod_inr_adt " +
            "WHERE " +
                "a.cod_azl = ? " +
            "ORDER BY " +
                "a.des_non_cfo";

    private String ejbGetReport_RischioFattore_ComboView =
            /* 
             Estrae e raggruppa i fattori di rischio per operazioni svolte,
             a loro volta associate all'attività lavorativa.
             
             Questo comportamento è stato implementato su richiesta di milano serravalle,
             ed esteso a tutti perchè ritenuto valido.
            */
            "SELECT " +
                "A.COD_FAT_RSO, " +
                "A.NOM_FAT_RSO " +
            "FROM " +
                "ANA_FAT_RSO_TAB A " +
            "WHERE " +
                "A.COD_FAT_RSO IN ( " +
                    "SELECT DISTINCT " +
                        "D.COD_FAT_RSO " +
                    "FROM " +
                        "OPE_SVO_MAN_TAB A, " +
                        "RSO_OPE_SVO_TAB B, " +
                        "RSO_MAN_TAB C, " +
                        "ANA_RSO_TAB D " +
                    "WHERE " +
                        "A.COD_OPE_SVO = B.COD_OPE_SVO " +
                        "AND A.COD_MAN = C.COD_MAN " +
                        "AND B.COD_RSO = C.COD_RSO " +
                        "AND B.COD_AZL = C.COD_AZL " +
                        "AND C.COD_RSO = D.COD_RSO " +
                        "AND C.COD_AZL = D.COD_AZL " +
                        "AND C.PRS_RSO = 'S' " +
                        "AND B.COD_OPE_SVO = ? " +
                        "AND C.COD_MAN = ? " +
                        "AND C.COD_AZL = ?) " +
                "OR A.COD_FAT_RSO IN ( " +
                    "SELECT DISTINCT " +
                        "A.COD_FAT_RSO " +
                    "FROM " +
                        "ANA_MAN_FAT_RSO_TAB A, " +
                        "OPE_SVO_MAN_TAB B " +
                    "WHERE " +
                        "A.COD_MAN = B.COD_MAN " +
                        "AND B.COD_OPE_SVO = ? " +
                        "AND B.COD_MAN = ? " +
                        "AND A.COD_AZL = ?) " +
                "ORDER BY " +
                    "A.NOM_FAT_RSO";

    private String ejbGetReport_RischioFattore_ComboView_CAG_FAT_RSO =
            /*
             Estrae i fattori di rischio associati all'attività lavorativa,
             distinti e raggruppati per categoria del fattore di rischio stesso.

             Questo comportamento è stato mantenuto su richiesta specifica,
             solo per GSE. 
            */
            "SELECT " +
                "cod_fat_rso, " +
                "nom_fat_rso, " +
                "num_fat_rso " +
            "FROM " +
                "ANA_FAT_RSO_TAB " +
            "WHERE " +
                "cod_cag_fat_rso=? " +
                "AND ( cod_fat_rso IN ( " +
                    "SELECT DISTINCT	 " +
                        "A.COD_FAT_RSO " +
                    "FROM " +
                        "ANA_RSO_TAB A, " +
                        "RSO_MAN_TAB B " +
                    "WHERE  " +
                        "A.COD_RSO = B.COD_RSO " +
                        "AND B.PRS_RSO = 'S' " +
                        "AND B.COD_MAN = ? " +
                        "AND A.COD_AZL = ?) " +
                    "OR cod_fat_rso IN ( " +
                        "SELECT DISTINCT " +
                            "G.COD_FAT_RSO " +
                        "FROM " +
                            "ANA_MAN_FAT_RSO_TAB G " +
                        "WHERE 	" +
                            "G.COD_MAN = ? " +
                            "AND G.COD_AZL = ?)) " +
            "ORDER BY 3";

    private String ejbGetComboView =
            "SELECT " +
                "cod_fat_rso, " +
                "nom_fat_rso, " +
                "num_fat_rso " +
            "FROM " +
                "ANA_FAT_RSO_TAB " +
            "WHERE " +
                "cod_cag_fat_rso=? " +
                "AND (cod_fat_rso IN ( " +
                    "SELECT DISTINCT " +
                        "R.cod_fat_rso " +
                    "FROM " +
                        "RSO_LUO_FSC_TAB C, " +
                        "ANA_LUO_FSC_TAB B, " +
                        "UNI_ORG_LUO_FSC_TAB A, " +
                        "ANA_FAT_RSO_TAB D, " +
                        "ANA_RSO_TAB R " +
                    "WHERE " +
                        "C.PRS_RSO = 'S' " +
                        "AND C.COD_LUO_FSC = B.COD_LUO_FSC " +
                        "AND A.COD_LUO_FSC = B.COD_LUO_FSC " +
                        "AND R.COD_RSO = C.COD_RSO " +
                        "AND R.COD_AZL = C.COD_AZL " +
                        "AND cod_uni_org= ? " +
                        "AND C.COD_AZL =?) " +
                    "OR cod_fat_rso IN ( " +
                        "SELECT DISTINCT " +
                            "G.COD_FAT_RSO " +
                        "FROM " +
                            "ANA_UNI_ORG_FAT_RSO_TAB G " +
                        "WHERE " +
                            "G.cod_uni_org = ? " +
                            "AND G.COD_AZL = ?)) " +
            "ORDER BY 3";

    private String ejbGetAttivaManutenzione_TAB_View =
                "SELECT " +
                    "cod_sch_ati_mnt, " +
                    "ati_svo, " +
                    "esi_ati_mnt, " +
                    "dat_ati_mnt, " +
                    "dat_pif_inr, " +
                    "dat_pif_inr " +
                "FROM " +
                    "sch_ati_mnt_tab " +
                "WHERE " +
                    "cod_mac=? " +
                    "AND cod_mnt_mac=? " +
                "order by " +
                    "ati_svo ";


private String ejbGetScadenzario_Corsi_View =
                    " SELECT * FROM" +
                    " (SELECT "+
                        "a.cod_sch_egz_cor, " +
                        "a.cod_cor, " +
                        "a.dat_pif_egz_cor, " +
                        "a.dat_eft_egz_cor, " +
                        "b.nom_cor, " +
                        "(select " +
                            "nom_dct " +
                        "from " +
                            "dct_cor_tab " +
                        "where " +
                            "cod_cor = a.cod_cor " +
                            "and cod_azl = a.cod_azl " +
                            "limit 1) as nom_dct, " +
                        "c.rag_scl_azl, " +
                        "a.cod_azl " +
                    " FROM " +
                        "sch_egz_cor_tab a, " +
                        "ana_cor_tab b, " +
                        "ana_azl_tab c " +
                    " WHERE " +
                        "a.cod_cor = b.cod_cor " +
                        "AND a.cod_azl= c.cod_azl " +
                        "AND a.cod_azl=?" +
                        ")as tab_ric_formazione_pers ";


private String ejbGetRiapertura_Infortuni_View = "select distinct "
                    + "a.DAT_EVE_INO ,"
                    + "a.DAT_COM_INO ,"
                    + "d.nom_luo_fsc,"
                    + "a.COD_INO_REL ,"
                    + "b.nom_sed_les,"
                    + "e.NOM_TPL_FRM_INO, "
                    + "a.COD_INO "
                    + "from "
                    + "ana_ino_tab a, "
                    + "tpl_frm_ino_tab e, "
                    + "ana_sed_les_tab b, "
                    + "ana_nat_les_tab c, "
                    + "ana_luo_fsc_tab d "
                    + "where "
                    + "a.COD_TPL_FRM_INO=e.COD_TPL_FRM_INO "
                    + "and a.cod_sed_les = b.cod_sed_les "
                    + "and a.cod_luo_fsc = d.cod_luo_fsc "
                    + "and a.COD_DPD=? "
                    + " and a.COD_INO <> ? ";


private String ejbGetRiapertura_Infortuni_Cantieri_View = "select distinct "
                    + "a.DAT_EVE_INO ,"
                    + "a.DAT_COM_INO ,"
                    + "d.nom_can,"
                    + "a.COD_INO_REL ,"
                    + "e.NOM_TPL_FRM_INO, "
                    + "a.COD_INO, "
                    + "b.nom_sed_les "
                    + "from "
                    + "ana_ino_can_tab a "
                        + "left outer join cau_inf_can_tab e "
                        + "on (a.COD_TPL_FRM_INO=e.COD_TPL_FRM_INO) "
                        + "left outer join ana_sed_les_can_tab b "
                        + "on (a.cod_sed_les = b.cod_sed_les), "
                    + "ana_can_tab d "
                    + "where "
                    + "a.cod_can = d.cod_can "
                    + "and a.COD_DPD=? "
                    + "and a.COD_INO <> ? ";

    private String reportRischio4LuoghiFisici_View =
                    "SELECT "
                        + "imm.cod_imm, "
                        + "imm.nom_imm, " 
                        + "luo_fsc.cod_luo_fsc, "
                        + "luo_fsc.nom_luo_fsc, "
                        + "rso.cod_azl, "
                        + "rso.cod_rso, "
                        + "rso.nom_rso, "
                        + "mis_pet.cod_mis_pet, "
                        + "mis_pet.nom_mis_pet, "
                        + "rso_luo_fsc.prb_eve_les, "
                        + "rso_luo_fsc.ent_dan, "
                        + "rso_luo_fsc.frq_rip_att_dan, "
                        + "rso.num_inc_inf, "
                        + "rso_luo_fsc.stm_num_rso "
                    + "FROM "
                        + "ana_imm_tab imm, "
                        + "ana_luo_fsc_tab luo_fsc, "
                        + "rso_luo_fsc_tab rso_luo_fsc "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_luo_fsc_tab mis_pet_luo_fsc "
                        + "ON "
                            + "(rso_luo_fsc.cod_luo_fsc = mis_pet_luo_fsc.cod_luo_fsc "
                            + "AND rso_luo_fsc.cod_rso_luo_fsc = mis_pet_luo_fsc.cod_rso_luo_fsc) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_luo_fsc.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "imm.cod_imm = luo_fsc.cod_imm_3lv "
                        + "AND imm.cod_azl = luo_fsc.cod_azl "
                        + "AND luo_fsc.cod_luo_fsc = rso_luo_fsc.cod_luo_fsc "
                        + "AND luo_fsc.cod_azl = rso_luo_fsc.cod_azl "
                        + "AND rso_luo_fsc.cod_rso = rso.cod_rso "
                        + "AND rso_luo_fsc.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
                    + "ORDER BY "
                        + "imm.nom_imm ASC, "
                        + "luo_fsc.nom_luo_fsc ASC, "
                        + "mis_pet.nom_mis_pet ASC";
    
    private String reportRischio4LuoghiFisici_IMMOBILI_View =
    		    "SELECT "
                        + "distinct "
			+ "imm.cod_imm, "
                        + "imm.nom_imm "
                    + "FROM "
                        + "ana_imm_tab imm, "
                        + "ana_luo_fsc_tab luo_fsc, "
                        + "rso_luo_fsc_tab rso_luo_fsc "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_luo_fsc_tab mis_pet_luo_fsc "
                        + "ON "
                            + "(rso_luo_fsc.cod_luo_fsc = mis_pet_luo_fsc.cod_luo_fsc "
                            + "AND rso_luo_fsc.cod_rso_luo_fsc = mis_pet_luo_fsc.cod_rso_luo_fsc) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_luo_fsc.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "imm.cod_imm = luo_fsc.cod_imm_3lv "
                        + "AND imm.cod_azl = luo_fsc.cod_azl "
                        + "AND luo_fsc.cod_luo_fsc = rso_luo_fsc.cod_luo_fsc "
                        + "AND luo_fsc.cod_azl = rso_luo_fsc.cod_azl "
                        + "AND rso_luo_fsc.cod_rso = rso.cod_rso "
                        + "AND rso_luo_fsc.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
                    + "ORDER BY "
                        + "imm.nom_imm ASC";

    private String reportRischio4LuoghiFisici_LUOGHI_FISICI_View =
		    "SELECT "
			+ "distinct "
                        + "luo_fsc.cod_luo_fsc, "
                        + "luo_fsc.nom_luo_fsc, "
                        + "rso.cod_azl, "
                        + "rso.cod_rso, "
                        + "rso.nom_rso, "
                        + "rso_luo_fsc.prb_eve_les, "
                        + "rso_luo_fsc.ent_dan, "
                        + "rso_luo_fsc.frq_rip_att_dan, "
                        + "rso.num_inc_inf, "
                        + "rso_luo_fsc.stm_num_rso "
                    + "FROM "
                        + "ana_imm_tab imm, "
                        + "ana_luo_fsc_tab luo_fsc, "
                        + "rso_luo_fsc_tab rso_luo_fsc "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_luo_fsc_tab mis_pet_luo_fsc "
                        + "ON "
                            + "(rso_luo_fsc.cod_luo_fsc = mis_pet_luo_fsc.cod_luo_fsc "
                            + "AND rso_luo_fsc.cod_rso_luo_fsc = mis_pet_luo_fsc.cod_rso_luo_fsc) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_luo_fsc.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "imm.cod_imm = luo_fsc.cod_imm_3lv "
                        + "AND imm.cod_azl = luo_fsc.cod_azl "
                        + "AND luo_fsc.cod_luo_fsc = rso_luo_fsc.cod_luo_fsc "
                        + "AND luo_fsc.cod_azl = rso_luo_fsc.cod_azl "
                        + "AND rso_luo_fsc.cod_rso = rso.cod_rso "
                        + "AND rso_luo_fsc.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
			+ "AND imm.cod_imm = ? "
                    + "ORDER BY "
                        + "luo_fsc.nom_luo_fsc ASC";

    private String reportRischio4LuoghiFisici_MISURE_View =
		     "SELECT "
                        + "mis_pet.cod_mis_pet, "
                        + "mis_pet.nom_mis_pet "
                    + "FROM "
                        + "ana_imm_tab imm, "
                        + "ana_luo_fsc_tab luo_fsc, "
                        + "rso_luo_fsc_tab rso_luo_fsc "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_luo_fsc_tab mis_pet_luo_fsc "
                        + "ON "
                            + "(rso_luo_fsc.cod_luo_fsc = mis_pet_luo_fsc.cod_luo_fsc "
                            + "AND rso_luo_fsc.cod_rso_luo_fsc = mis_pet_luo_fsc.cod_rso_luo_fsc) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_luo_fsc.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "imm.cod_imm = luo_fsc.cod_imm_3lv "
                        + "AND imm.cod_azl = luo_fsc.cod_azl "
                        + "AND luo_fsc.cod_luo_fsc = rso_luo_fsc.cod_luo_fsc "
                        + "AND luo_fsc.cod_azl = rso_luo_fsc.cod_azl "
                        + "AND rso_luo_fsc.cod_rso = rso.cod_rso "
                        + "AND rso_luo_fsc.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
			+ "AND imm.cod_imm = ? "
			+ "AND luo_fsc.cod_luo_fsc = ? "
                    + "ORDER BY "
                        + "mis_pet.nom_mis_pet ASC";
    
    private String reportRischio4AttivitaLavorative_View =
                    "SELECT "
                        + "man.cod_man, "
                        + "man.nom_man, "
                        + "rso.cod_azl, "
                        + "rso.cod_rso, "
                        + "rso.nom_rso, "
                        + "mis_pet.cod_mis_pet, "
                        + "mis_pet.nom_mis_pet, "
                        + "rso_man.prb_eve_les, "
                        + "rso_man.ent_dan, "
                        + "rso_man.frq_rip_att_dan, "
                        + "rso.num_inc_inf, "
                        + "rso_man.stm_num_rso "
                    + "FROM "
                        + "ana_man_tab man, "
                        + "rso_man_tab rso_man "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_man_tab mis_pet_man "
                        + "ON "
                            + "(rso_man.cod_rso_man = mis_pet_man.cod_rso_man "
                            + "AND rso_man.cod_man = mis_pet_man.cod_man) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_man.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "man.cod_man = rso_man.cod_man "
                        + "AND man.cod_azl = rso_man.cod_azl "
                        + "AND rso_man.cod_rso = rso.cod_rso "
                        + "AND rso_man.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
                    + "ORDER BY "
                        + "man.nom_man ASC, "
                        + "mis_pet.nom_mis_pet ASC";            

    private String reportRischio4AttivitaLavorative_ATTIVITA_View =
                    "SELECT "
			+ "distinct "
                        + "man.cod_man, "
                        + "man.nom_man, "
                        + "rso.cod_azl, "
                        + "rso.cod_rso, "
                        + "rso.nom_rso, "
                        + "rso_man.prb_eve_les, "
                        + "rso_man.ent_dan, "
                        + "rso_man.frq_rip_att_dan, "
                        + "rso.num_inc_inf, "
                        + "rso_man.stm_num_rso "
                    + "FROM "
                        + "ana_man_tab man, "
                        + "rso_man_tab rso_man "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_man_tab mis_pet_man "
                        + "ON "
                            + "(rso_man.cod_rso_man = mis_pet_man.cod_rso_man "
                            + "AND rso_man.cod_man = mis_pet_man.cod_man) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_man.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "man.cod_man = rso_man.cod_man "
                        + "AND man.cod_azl = rso_man.cod_azl "
                        + "AND rso_man.cod_rso = rso.cod_rso "
                        + "AND rso_man.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
                    + "ORDER BY "
                        + "man.nom_man ASC";
    
    private String reportRischio4AttivitaLavorative_MISURE_View =
                    "SELECT "
			+ "distinct "
                        + "mis_pet.cod_mis_pet, "
                        + "mis_pet.nom_mis_pet "
                    + "FROM "
                        + "ana_man_tab man, "
                        + "rso_man_tab rso_man "
                        + "LEFT OUTER JOIN "
                            + "mis_pet_man_tab mis_pet_man "
                        + "ON "
                            + "(rso_man.cod_rso_man = mis_pet_man.cod_rso_man "
                            + "AND rso_man.cod_man = mis_pet_man.cod_man) "
                        + "LEFT OUTER JOIN "
                            + "ana_mis_pet_tab mis_pet "
                        + "ON "
                            + "(mis_pet_man.cod_mis_pet = mis_pet.cod_mis_pet), "
                        + "ana_rso_tab rso "
                    + "WHERE "
                        + "man.cod_man = rso_man.cod_man "
                        + "AND man.cod_azl = rso_man.cod_azl "
                        + "AND rso_man.cod_rso = rso.cod_rso "
                        + "AND rso_man.cod_azl = rso.cod_azl "
                        + "AND rso.cod_rso = ? "
                        + "AND rso.cod_azl = ? "
			+ "AND man.cod_man = ? "
                    + "ORDER BY "
                        + "mis_pet.nom_mis_pet ASC";

    public String getIsDeletableRiscFromAttLavorativaQUERY(){
        return isDeletableRiscFromAttLavorativaQUERY;
    }

    public String getEjbGetRiapertura_Infortuni_View(String DAT_EVE_INO) {
        return ejbGetRiapertura_Infortuni_View + ((DAT_EVE_INO != "") 
                ? " and (a.DAT_EVE_INO <= to_date('" + DAT_EVE_INO + "','dd-mm-yyyy') OR a.DAT_EVE_INO IS NULL)" 
                : "and ((a.DAT_EVE_INO <= now())OR a.DAT_EVE_INO IS NULL)order by a.DAT_EVE_INO DESC");
    }
    public String getEjbGetRiapertura_Infortuni_Cantiere_View(String DAT_EVE_INO) {
        return ejbGetRiapertura_Infortuni_Cantieri_View + ((DAT_EVE_INO != "")
                ? " and (a.DAT_EVE_INO <= to_date('" + DAT_EVE_INO + "','dd-mm-yyyy') OR a.DAT_EVE_INO IS NULL)"
                : "and ((a.DAT_EVE_INO <= now())OR a.DAT_EVE_INO IS NULL)order by a.DAT_EVE_INO DESC");
    }
    
    public String getRemoveDpiQUERY_STEP1(){
        return removeDpiQUERY_STEP1;
    }

    public String getRemoveDpiQUERY_STEP2(){
        return removeDpiQUERY_STEP2;
    }

    public String getRemoveDpiQUERY_STEP3(){
        return removeDpiQUERY_STEP3;
    }

    public String getRemoveCorsoQUERY_STEP1(){
        return removeCorsoQUERY_STEP1;
    }
    
    public String getRemoveCorsoQUERY_STEP2(){
        return removeCorsoQUERY_STEP2;
    }

    public String getRemoveCorsoQUERY_STEP3(){
        return removeCorsoQUERY_STEP3;
    }
    
    public String getRemoveProtocolloSanitarioQUERY_STEP1(){
        return removeProtocolloSanitarioQUERY_STEP1;
    }

    public String getRemoveProtocolloSanitarioQUERY_STEP2(){
        return removeProtocolloSanitarioQUERY_STEP2;
    }

    public String getRemoveProtocolloSanitarioQUERY_STEP3(){
        return removeProtocolloSanitarioQUERY_STEP3;
    }
    
    public String getRemoveMisuraPpQUERY_STEP1(){
        return removeMisuraPpQUERY_STEP1;
    }
    
    public String getRemoveMisuraPpQUERY_STEP2(){
        return removeMisuraPpQUERY_STEP2;
    }

    public String getRemoveMisuraPpQUERY_STEP3(){
        return removeMisuraPpQUERY_STEP3;
    }
    
    public String getAnagraficaDocumentoQUERY(){
        return anagraficaDocumentoQUERY;
    }
    
    public String getReport_RischioFattore_RischioView_OPE_SVO_QUERY(){
        return report_RischioFattore_RischioView_OPE_SVO_QUERY;
    }
    
    public String getReport_RischioFattore_RischioView_CAG_FAT_RSO_QUERY(){
        return report_RischioFattore_RischioView_CAG_FAT_RSO_QUERY;
    }

    public String getReport_RischioFattore_RischioView_UO_QUERY(){
        return report_RischioFattore_RischioView_UO_QUERY;
    }
    
    public String getProgressivoContratto(){
        return progressivoContratto;
    }
    
    public String getProgressivoDUVRI(){
        return progressivoDUVRI;
    }
    
    public String getNotAssRischi_ViewQUERY(){
        return notAssRischi_View;
    }

    public String getNotAssCorsi_View(){
        return notAssCorsi_View;
    }

    public String getNotAssProtocoli_View(){
        return notAssProtocoli_View;
    }

    public String getNotAssDPI_View(){
        return notAssDPI_View;
    }

    public String getCarica_rp_vis_ido_cnt(){
        return carica_rp_vis_ido_cnt;
    }

    public String getCarica_rp_vis_med_cnt(){
        return carica_rp_vis_med_cnt;
    }

    public String getAddCorso(){
        return addCorso;
    }

    public String getAddDpi(){
        return addDpi;
    }

    public String getAddProtocolloSanitario(){
        return addProtocolloSanitario;
    }

    public String getAddMisuraPp(){
        return addMisuraPp;
    }

    public String getCarica_rp_rischi_cnt(){
        return carica_rp_rischi_cnt;
    }

    public String getEjbGetAzioniCorrectivePreventive_View(){
        return ejbGetAzioniCorrectivePreventive_View;
    }

    public String getEjbGetAzioniCorrectivePreventive_AZL_View(){
        return ejbGetAzioniCorrectivePreventive_AZL_View;
    }

    public String getEjbGetMaterialeCorso_View(){
        return ejbGetMaterialeCorso_View;
    }

    public String getEjbGetNonConformitaByInterventoAudit(){
        return ejbGetNonConformitaByInterventoAudit;
    }

    public String getEjbGetNonConformita(){
        return ejbGetNonConformita;
    }

    public String getEjbGetReport_RischioFattore_ComboView(){
        return ejbGetReport_RischioFattore_ComboView;
    }

    public String getEjbGetReport_RischioFattore_ComboView_CAG_FAT_RSO(){
        return ejbGetReport_RischioFattore_ComboView_CAG_FAT_RSO;
    }

    public String getEjbGetComboView(){
        return ejbGetComboView;
    }

    public String getEjbGetAttivaManutenzione_TAB_View(){
        return ejbGetAttivaManutenzione_TAB_View;
    }

    public String getEjbGetScadenzario_Corsi_View() {
        return ejbGetScadenzario_Corsi_View;
    }
    
    public String getReportRischio4LuoghiFisici_View(){
        return reportRischio4LuoghiFisici_View;
    }
    
    public String getReportRischio4LuoghiFisici_IMMOBILI_View(){
        return reportRischio4LuoghiFisici_IMMOBILI_View;
    }

    public String getReportRischio4LuoghiFisici_LUOGHI_FISICI_View(){
        return reportRischio4LuoghiFisici_LUOGHI_FISICI_View;
    }
            
    public String getReportRischio4LuoghiFisici_MISURE_View(){
        return reportRischio4LuoghiFisici_MISURE_View;
    }

    public String getReportRischio4AttivitaLavorative_View(){
        return reportRischio4AttivitaLavorative_View;
    }
            
    public String getReportRischio4AttivitaLavorative_ATTIVITA_View(){
        return reportRischio4AttivitaLavorative_ATTIVITA_View;
    }
    
    public String getReportRischio4AttivitaLavorative_MISURE_View(){
        return reportRischio4AttivitaLavorative_MISURE_View;
    }

    /** Creates a new instance of ContainerSQL */
    ContainerSQL() {
    }
    
}
