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
 * ContainerSQL_DB2.java
 *
 * Created on 21 marzo 2007, 15.14
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package s2s.SQLConfigurator.sqlContainer;

/**
 *
 * @author dario.massaroni
 */
public class ContainerSQL_DB2 extends ContainerSQL {
    
    private String isDeletableRiscFromAttLavorativaQUERY = 
		    "SELECT H.COD_RSO, H.COD_AZL "+
			"FROM RSO_MAN_TAB H "+
			"WHERE ( "+
			"H.COD_MAN=? "+
			"AND H.COD_RSO=? "+
			"AND H.COD_AZL=?) "+
			"AND CHAR(H.COD_RSO) || ' ' || CHAR(H.COD_AZL) NOT IN "+
			"(SELECT CHAR(C.COD_RSO)||' '||CHAR(C.COD_AZL) FROM "+
			"ANA_MAN_TAB A, OPE_SVO_MAN_TAB B, RSO_OPE_SVO_TAB C "+
			"WHERE "+
			"A.COD_MAN=? "+
			"AND A.COD_MAN=B.COD_MAN "+
			"AND B.COD_OPE_SVO=C.COD_OPE_SVO "+
			"AND B.COD_OPE_SVO!=? "+
			"AND C.COD_RSO=? "+
			"AND C.COD_AZL=?)";

    private String anagraficaDocumentoQUERY =
	  	"SELECT "+
	  	"LST.cod_doc, "+
	  	"'AZIENDA'||' - '||AZL.RAG_SCL_AZL||' - '||AZL.NOM_RSP_AZL, "+
	  	"' - DITTA'||' - '||DTE.RAG_SCL_DTE ||' - '||DTE.NOM_RSP_DTE, "+
	  	"'', '', '', "+ 
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
		"'', "+
		"' - DIPENDENTE'||' - '||DPD.COG_DPD||' '||DPD.NOM_DPD, "+
		"'', '', "+
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
		"'', '', "+
       	"' - UNITA'' ORGANIZZATIVA'||' - '||UNI.NOM_UNI_ORG ||' - '||DPD.COG_DPD||' '||DPD.NOM_DPD, "+
 		"'', LST.dat_csg_doc_dsi "+
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
	    "'', '', '', "+
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
        "'', '', '', '', "+
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
                    "CHAR(D.DES_RSO) AS DES_RSO, " +
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
                    "CHAR(A.DES_RSO) AS DES_RSO, "+
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
                        " CHAR(F.des_rso) AS DES_RSO, "+
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
                    "MAX(CAST(SUBSTR(pro_con, 1, LENGTH(pro_con)-5) AS NUMERIC))+1 AS pro_con " +
                "from " +
                    "ana_con_ser " +
                "where " +
                    "cod_azl = ? " +
                    "and SUBSTR(pro_con, LENGTH(pro_con)-3) = ?";
    
    private String progressivoDUVRI =
            "SELECT " +
                    "(MAX(CAST(SUBSTR(b.pro_duv, (LENGTH(a.pro_con) + 4), (LENGTH(b.pro_duv) + 1 - (LENGTH(a.pro_con) + 4))) AS NUMERIC)) + 1) AS pro_duv " +
            "FROM " +
                    "ana_con_ser a, " +
                    "con_ser_duvri b " +
            "WHERE " +
                    "a.cod_srv = b.cod_srv " +
            "AND " +
                    "a.cod_azl = ? " +
            "AND " +
                    "a.cod_srv = ?";

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
                    "AND cod_mnt_mac=? ";


    private String ejbGetScadenzario_Corsi_View =
            " SELECT * FROM( SELECT a.cod_sch_egz_cor, " +
                    " a.cod_cor, " +
                    " a.dat_pif_egz_cor, " +
                    " a.dat_eft_egz_cor, " +
                    " b.nom_cor, " +
                    " (select " +
                    "  nom_dct " +
                    "  from  " +
                    "  dct_cor_tab " +
                    "  where  " +
                    "  cod_cor = a.cod_cor " +
                    "  and cod_azl = a.cod_azl " +
                    "  FETCH FIRST 1 ROWS ONLY) as nom_dct, " +
                    "  c.rag_scl_azl, " +
                    "  a.cod_azl " +
            " FROM  " +
                    "  sch_egz_cor_tab a, " +
		            "  ana_cor_tab b, " +
                    "  ana_azl_tab c  " +
            " WHERE " +
                    "  a.cod_cor = b.cod_cor " +
                    "  AND a.cod_azl= c.cod_azl " +
                    "  AND a.cod_azl=?) as tab_ric_formazione_pers ";


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


    @Override
   public String getEjbGetRiapertura_Infortuni_View(String DAT_EVE_INO) {
        return ejbGetRiapertura_Infortuni_View +
                //((DAT_EVE_INO != "") ? " and (a.DAT_EVE_INO <= to_date('" + DAT_EVE_INO + "','dd-mm-yyyy') OR a.DAT_EVE_INO IS NULL)" : "and ((a.DAT_EVE_INO <= current_date)OR a.DAT_EVE_INO IS NULL)order by a.DAT_EVE_INO DESC");
                ((DAT_EVE_INO != "") ? " and (a.DAT_EVE_INO <= date('" + DAT_EVE_INO + "') OR a.DAT_EVE_INO IS NULL)" : "and ((a.DAT_EVE_INO <= current_date)OR a.DAT_EVE_INO IS NULL)order by a.DAT_EVE_INO DESC");
   }

    
    @Override
    public String getIsDeletableRiscFromAttLavorativaQUERY(){
        return isDeletableRiscFromAttLavorativaQUERY;
    }
    
    @Override
    public String getAnagraficaDocumentoQUERY(){
        return anagraficaDocumentoQUERY;
    }
    
    @Override
    public String getReport_RischioFattore_RischioView_OPE_SVO_QUERY(){
        return report_RischioFattore_RischioView_OPE_SVO_QUERY;
    }

    @Override
    public String getReport_RischioFattore_RischioView_CAG_FAT_RSO_QUERY(){
        return report_RischioFattore_RischioView_CAG_FAT_RSO_QUERY;
    }

    @Override
    public String getReport_RischioFattore_RischioView_UO_QUERY(){
        return report_RischioFattore_RischioView_UO_QUERY;
    }
    
    @Override
    public String getProgressivoContratto(){
        return progressivoContratto;
    }
    
    @Override
    public String getProgressivoDUVRI(){
        return progressivoDUVRI;
    }

    @Override
    public String getEjbGetAttivaManutenzione_TAB_View(){
        return ejbGetAttivaManutenzione_TAB_View;
    }

    @Override
    public String getEjbGetScadenzario_Corsi_View() {
        return ejbGetScadenzario_Corsi_View;
    }
    
    /** Creates a new instance of ContainerSQL_DB2 */
    ContainerSQL_DB2() {
    }
    
}
