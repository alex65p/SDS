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
 * ContainerSQL_Oracle.java
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
public class ContainerSQL_Oracle extends ContainerSQL {
    
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
                    "(MAX(CAST(SUBSTR(pro_duv, (LENGTH(a.pro_con) + 4), LENGTH(b.pro_duv)) AS NUMERIC)) + 1) AS pro_duv " +
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
            "MINUS " +
            "(SELECT C.COD_RSO, G.NOM_RSO, G.COD_FAT_RSO, Z.NOM_FAT_RSO, " +
            "G.NOM_RIL_RSO, G.PRB_EVE_LES, G.ENT_DAN, G.STM_NUM_RSO, G.RFC_VLU_RSO_MES " +
            "FROM RSO_MAN_TAB C, ANA_RSO_TAB G, ANA_FAT_RSO_TAB Z " +
            "WHERE C.COD_MAN = ? " +
            "AND G.COD_RSO     = C.COD_RSO " +
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
                "MINUS " +
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
                "MINUS " +
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
                "MINUS " +
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
                "UPPER(RTRIM(LTRIM(nom_vst_ido))) = UPPER(RTRIM(LTRIM(?)))";

    private String carica_rp_vis_med_cnt =
            "SELECT " +
                "COUNT(*) " +
            "FROM " +
                "ana_vst_med_tab_r " +
            "WHERE " +
                "UPPER(RTRIM(LTRIM(nom_vst_med))) = UPPER(RTRIM(LTRIM(?)))";

    private String carica_rp_rischi_cnt =
            "SELECT " +
                "COUNT(*) " +
            "FROM " +
                "ana_rso_tab_r " +
            "WHERE " +
                "UPPER(RTRIM(LTRIM(nom_rso))) = UPPER(RTRIM(LTRIM(?)))";

    private String ejbGetAzioniCorrectivePreventive_View = 
            "SELECT  " +
                "azn_crr_pet_tab.cod_azn_crr_pet, " +
                "azn_crr_pet_tab.rch_azn_crr_pet, " +
                "azn_crr_pet_tab.tpl_att, " +
                "azn_crr_pet_tab.tpl_azn, " +
                "ana_inr_adt_tab.des_inr_adt, " +
                "azn_crr_pet_tab.dat_rch, " +
                "azn_crr_pet_tab.dat_azn " +
            "FROM   " +
                "azn_crr_pet_tab , " +
                "ana_inr_adt_tab  " +
            "WHERE  " +
                "azn_crr_pet_tab.cod_inr_adt = ana_inr_adt_tab.cod_inr_adt(+)";

    private String ejbGetAzioniCorrectivePreventive_AZL_View =
            "SELECT  " +
                "azn_crr_pet_tab.cod_azn_crr_pet, " +
                "azn_crr_pet_tab.rch_azn_crr_pet, " +
                "azn_crr_pet_tab.tpl_att, " +
                "azn_crr_pet_tab.tpl_azn, " +
                "ana_inr_adt_tab.des_inr_adt, " +
                "azn_crr_pet_tab.dat_rch, " +
                "azn_crr_pet_tab.dat_azn " +
            "FROM   " +
                "azn_crr_pet_tab , " +
                "ana_inr_adt_tab  " +
            "WHERE  " +
                "azn_crr_pet_tab.cod_inr_adt = ana_inr_adt_tab.cod_inr_adt(+) " +
                "AND  azn_crr_pet_tab.cod_azl =? ";

    private String ejbGetMaterialeCorso_View = 
            "SELECT   " +
                "ana_doc_tab.cod_doc, " +
                "rsp_doc, dat_rev_doc, " +
                "tit_doc, " +
                "documents.NAME " +
            "FROM " +
                "ana_doc_tab, " +
                "documents, " +
                "mat_cor_tab " +
            "WHERE " +
                "ana_doc_tab.cod_doc = documents.cod_doc(+) " +
                "AND ana_doc_tab.cod_doc = mat_cor_tab.cod_doc " +
                "AND ana_doc_tab.cod_azl = documents.cod_azl(+) " +
                "AND mat_cor_tab.cod_cor = ? " +
            "ORDER BY " +
                "tit_doc";

    private String ejbGetNonConformitaByInterventoAudit =
            "SELECT " +
                "ana_non_cfo_tab.cod_non_cfo, " +
                "ana_non_cfo_tab.des_non_cfo, " +
                "ana_non_cfo_tab.cod_mis_pet, " +
                "dat_ril_non_cfo, " +
                "ana_non_cfo_tab.nom_ril_non_cfo, " +
                "ana_non_cfo_tab.cod_inr_adt, " +
                "ana_non_cfo_tab.oss_non_cfo, " +
                "ana_inr_adt_tab.des_inr_adt " +
            "FROM " +
                "ana_non_cfo_tab, " +
                "ana_inr_adt_tab " +
            "WHERE " +
                "ana_non_cfo_tab.cod_inr_adt(+) = ana_inr_adt_tab.cod_inr_adt " +
                "AND ana_non_cfo_tab.cod_inr_adt = ? " +
            "ORDER BY " +
                "ana_non_cfo_tab.des_non_cfo";

    private String ejbGetNonConformita = 
            "SELECT " +
                "ana_non_cfo_tab.cod_non_cfo, " +
                "ana_non_cfo_tab.des_non_cfo, " +
                "ana_non_cfo_tab.cod_mis_pet, " +
                "dat_ril_non_cfo, " +
                "ana_non_cfo_tab.nom_ril_non_cfo, " +
                "ana_non_cfo_tab.cod_inr_adt, " +
                "ana_non_cfo_tab.oss_non_cfo, " +
                "ana_inr_adt_tab.des_inr_adt " +
            "FROM " +
                "ana_non_cfo_tab, " +
                "ana_inr_adt_tab " +
            "WHERE " +
                "ana_non_cfo_tab.cod_inr_adt = ana_inr_adt_tab.cod_inr_adt (+) " +
                "AND ana_non_cfo_tab.cod_azl = ? " +
            "ORDER BY " +
                "ana_non_cfo_tab.des_non_cfo";

    private String ejbGetScadenzario_Corsi_View =
                 " SELECT * FROM( SELECT "+
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
                            "and rownum = 1) as nom_dct, " +
                        "c.rag_scl_azl, " +
                        "a.cod_azl " +
                    "FROM " +
                        "sch_egz_cor_tab a, " +
                        "ana_cor_tab b, " +
                        "ana_azl_tab c " +
                    "WHERE " +
                        "a.cod_cor = b.cod_cor " +
                        "AND a.cod_azl= c.cod_azl " +
                        "AND a.cod_azl=?" +
                        ")";

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
        return ejbGetRiapertura_Infortuni_View + ((DAT_EVE_INO != "") ? " and (a.DAT_EVE_INO <= to_date('" + DAT_EVE_INO + "','dd-mm-yyyy') OR a.DAT_EVE_INO IS NULL)" : "and ((a.DAT_EVE_INO <= SYSDATE)OR a.DAT_EVE_INO IS NULL)order by a.DAT_EVE_INO DESC");
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
    public String getNotAssRischi_ViewQUERY(){
        return notAssRischi_View;
    }

    @Override
    public String getNotAssCorsi_View(){
        return notAssCorsi_View;
    }

    @Override
    public String getNotAssProtocoli_View(){
        return notAssProtocoli_View;
    }

    @Override
    public String getNotAssDPI_View(){
        return notAssDPI_View;
    }

    @Override
    public String getCarica_rp_vis_ido_cnt(){
        return carica_rp_vis_ido_cnt;
    }

    @Override
    public String getCarica_rp_vis_med_cnt(){
        return carica_rp_vis_med_cnt;
    }

    @Override
    public String getCarica_rp_rischi_cnt(){
        return carica_rp_rischi_cnt;
    }

    @Override
    public String getEjbGetAzioniCorrectivePreventive_View(){
        return ejbGetAzioniCorrectivePreventive_View;
    }

    @Override
    public String getEjbGetAzioniCorrectivePreventive_AZL_View(){
        return ejbGetAzioniCorrectivePreventive_AZL_View;
    }

    @Override
    public String getEjbGetMaterialeCorso_View(){
        return ejbGetMaterialeCorso_View;
    }

    @Override
    public String getEjbGetNonConformitaByInterventoAudit(){
        return ejbGetNonConformitaByInterventoAudit;
    }

    @Override
    public String getEjbGetNonConformita(){
        return ejbGetNonConformita;
    }

    @Override
    public String getEjbGetScadenzario_Corsi_View() {
        return ejbGetScadenzario_Corsi_View;
    }

    /** Creates a new instance of ContainerSQL_Oracle */
    ContainerSQL_Oracle() {
    }
    
}
