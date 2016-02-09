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
package com.apconsulting.luna.ejb.Dipendente;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IDipendenteHome extends EJBHome {


    public IDipendente create(
            long COD_AZL,
            long COD_FUZ_AZL,
            String STA_DPD,
            String MTR_DPD,
            String COG_DPD,
            String NOM_DPD,
            java.sql.Date DAT_NAS_DPD,
            String RAP_LAV_AZL) throws CreateException;

    public void remove(Object primaryKey);
    
    public void enable(Object primaryKey);

    public IDipendente findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov

    public Collection getDipendentiBySOP_View(long COD_SOP);

    public Collection getDipendentiEstBySOP_View(long COD_SOP);

    public Collection getDipendentiByAZLID_View(long AZL_ID);

    public Collection getDipendentiByAZLID_View_CAN(long AZL_ID,long COD_DTE);
    // - for R.L.S.

    public Collection getDipendentiByAZLID_RLS_View(long AZL_ID);
    // get Dipendeti Names (List for combobox)

    public Collection getDipendenti_Names_View(long AZL_ID);

    public Collection getDipendenti_SCH_DPI_View();//Added by Podmasteriev

    public Collection getDipendenti_Search_View(long AZL_ID);

    public Collection getDipendentePercorsiFormativi_View(long COD_DPD);

    public Collection getDipendente_CORCOM_View();

    public Collection getDipendenti_Lavoratori_View(long lCOD_DPD);
    public Collection getDipendenti_Lavoratori_View(long lCOD_DPD, String columnOrdered, String orderType);

    public Collection getDipendenti_FOD_DBT_View(long lAZL_ID, String newNOM_MAN, boolean orderDesc);

    public Collection getScadenzario_DPI_View(long lCOD_AZL, long lNOM_COR, String lNOM_DCT, java.sql.Date dDAT_PIF_EGZ_COR_DAL, java.sql.Date dDAT_PIF_EGZ_COR_AL, String strSTA_INT, java.sql.Date dEFF_DAT_DAL, java.sql.Date dEFF_DAT_AL, String strRAGGRUPPATI, String strTYPE, String strFROM);//added by Podmasteriev at 9/03/2004
    //<report>

    public DipendenteFunzioneView getDipendenteFunzioneView(long lCOD_DPD);

    public Collection findEx(
            long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            String strSEX_DPD,
            boolean ViewCessati,
            int iOrderParameter /*not used for now*/);

        public Collection findExSOP(long lCOD_AZL,
            String strNOM_DPD,
            String strCOG_DPD,
            String strMTR_DPD,
            Long lCOD_FUZ_AZL,
            java.sql.Date dtDAT_NAS_DPD,
            String strLUO_NAS_DPD,
            String strCIT_DPD,
            String strIDZ_DPD,
            String strNUM_CIC_DPD,
            String strCAP_DPD,
            String strPRV_DPD,
            Long lCOD_DTE,
            java.sql.Date dtDAT_ASS_DPD,
            String strLIV_DPD,
            java.sql.Date dtDAT_CES_DPD,
            String strSEX_DPD,
            boolean ViewCessati,
            String strSubject,
            int iOrderParameter /*not used for now*/);

    public Collection getDipendenteByDitta(long lCOD_AZL, long lCOD_DTE);

    public Collection findUOListToSendMail(long lCOD_AZL, long lCOD_MAN);

    public Collection findDipendentiAttivitaLavorativeByCOD_UNI_ORG(long lCOD_AZL, long lCOD_MAN, long lCOD_UNI_ORG);

    public Collection findDipendenteAttivitaLavorativaByCOD_UNI_ORG(long lCOD_AZL, long lCOD_DPD, long lCOD_MAN, long lCOD_UNI_ORG,java.sql.Date DAT_INZ,boolean activeATT_LAV);

    public boolean CodiceFiscaleExists(String strCOD_FIS_DPD, long lCOD_AZL, String strMTR_DPD, long lCOD_DPD);

    public boolean dipendenteCessato(java.sql.Date dDAT_CES_DPD);

    public Collection getDipendenteByMTR(long lCOD_AZL, String strMTR_DPD);
    public String[]   getCountDipendenteAttiviCessati(long lCOD_AZL);

}