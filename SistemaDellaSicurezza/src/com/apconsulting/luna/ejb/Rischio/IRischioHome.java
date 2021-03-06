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
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.Rischio;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.EJBLocalHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IRischioHome extends EJBHome, EJBLocalHome {

    public IRischio create(long lCOD_AZL, String strNOM_RSO, String strDES_RSO, java.sql.Date dtDAT_RIL, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, long lRFC_VLU_RSO_MES, long lCOD_FAT_RSO, long lCOD_RSO_RPO, java.util.ArrayList alAziende) throws CreateException;

    public void remove(Object primaryKey, java.util.ArrayList alAziende);

    public IRischio findByPrimaryKey(RischioPK primaryKey) throws FinderException;
    // -- A.Kolesnik
    public Collection findAll(long lAzienda) throws FinderException;

    public Collection getRischio_Nome_Fattore_View(long lAzienda);

    public Collection getRischio_Nome_Fattore_ComboBox(long lAzienda);

    public Collection getRischio_ComboBox(long lAzienda, long lCOD_FAT_RSO);
    //
    public Collection getRischio_MAN_ComboBox(long lAzienda, String strNOM, String strCLF);

    public Collection getRischio_LUO_FSC_ComboBox(long lAzienda, String strNOM, String strCLF);

    public Collection getRischio_MAN_LUO_FSC_ComboBox(long lAzienda);
    
    public Collection getRischio4CAG_FAT_RSO_View(long lCOD_AZL, long lCOD_CAG_FAT_RSO);

    public Collection getRischio_foo_SCHRIVRSO_View(long lCOD_AZL, long lCOD_RSO, long lCOD_FAT_RSO, String strSTA_RSO, java.sql.Date dtDAT_RFC_VLU_RSO_DAL, java.sql.Date dtDAT_RFC_VLU_RSO_AL, String strTIP_RSO, String strRG_GROUP, String strVAR_RIV);

    public Collection getRischio_collection_SCHRIVRSO_View(long lCOD_AZL, long lCOD_RSO, long lCOD_FAT_RSO, String strSTA_RSO, java.sql.Date dtDAT_RFC_VLU_RSO_DAL, java.sql.Date dtDAT_RFC_VLU_RSO_AL, String strTIP_RSO, String strRG_GROUP, String strVAR_RIV);

    public Collection getRischio_Elenco_View(long lCOD_AZL, String strAPL_A, long lCOD_MIS_PET_LUO_MAN);
    //
    public void remove(Object primaryKey);

    public boolean caricaDbRischi(long P_COD_AZL, long P_COD_RSO);

    public boolean caricaRpRischi(long P_COD_AZL, String P_NOM_RSO);
    //<report>
    public Collection getReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(long lCOD_AZL, long lCOD_OPE_SVO, long lCOD_RSO);

    public Collection getReportRischioMachineAttrezzature_Numero_Modelo_Descr_View(long lCOD_AZL, long lCOD_RSO);

    public Collection getReportRischioSostanzeChimiche_View(long lCOD_RSO, long lCOD_OPE_SVO, long lCOD_MON, long lCOD_AZL);

    public Collection getReportRischioSostanzeChimiche_View(long lCOD_RSO, long lCOD_MON);

    public Collection getMisurePpView(long lCOD_RSO, long lCOD_AZL);
      // bug 2015.02.20 MSR
    public Collection getMisurePpView(long lCOD_RSO, long lCOD_AZL,long lCOD_RSO_LUO_FSC);
      // bug 2015.02.20 MSR
    public Collection getReportRischioByMAN_Name_View(long lCOD_AZL, long lCOD_MAN);
    
    public Collection getReportRischio4LuoghiFisici_View(long lCOD_RSO, long lCOD_AZL);
    public Collection getReportRischio4LuoghiFisici_IMMOBILI_View(long lCOD_RSO, long lCOD_AZL);
    public Collection getReportRischio4LuoghiFisici_LUOGHI_FISICI_View(long lCOD_RSO, long lCOD_AZL, long lCOD_IMM);
    public Collection getReportRischio4LuoghiFisici_MISURE_View(long lCOD_RSO, long lCOD_AZL, long lCOD_IMM, long lCOD_LUO_FSC);
    
    public Collection getReportRischio4AttivitaLavorative_View(long lCOD_RSO, long lCOD_AZL);
    public Collection getReportRischio4AttivitaLavorative_ATTIVITA_View(long lCOD_RSO, long lCOD_AZL);
    public Collection getReportRischio4AttivitaLavorative_MISURE_View(long lCOD_RSO, long lCOD_AZL, long lCOD_MAN);

    public Collection getRischio_CRM_RSO_View(String strNOM, long lCOD_AZL);
    //<alex>
    public Collection getRischiRepositoryView(long lCOD_FAT_RSO);
    //</report>
    
    public boolean checkRischio_ByName(String strNOM, long lCOD_AZL);
    
    public Collection findEx(long lCOD_AZL,
            String strNOM_RSO,
            String strDES_RSO,
            java.sql.Date dtDAT_RIL,
            String strNOM_RIL_RSO,
            String strCLF_RSO,
            Long lPRB_EVE_LES,
            Long lENT_DAN,
            Long lFRQ_RIP_ATT_DAN,
            Long lNUM_INC_INF,
            Float lSTM_NUM_RSO,
            Long lRFC_VLU_RSO_MES,
            Long lCOD_FAT_RSO,
            int iOrderParameter /*not used for now*/);
}
