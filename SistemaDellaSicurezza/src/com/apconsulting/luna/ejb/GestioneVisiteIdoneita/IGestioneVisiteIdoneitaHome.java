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
package com.apconsulting.luna.ejb.GestioneVisiteIdoneita;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IGestioneVisiteIdoneitaHome extends EJBHome {

    public IGestioneVisiteIdoneita create(String strFAT_PER, String strNOM_VST_IDO, long lCOD_AZL) throws CreateException;

    public void remove(Object primaryKey);

    public IGestioneVisiteIdoneita findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public Collection getVisiteIdoneita_All_View(long lCOD_AZL);

    public boolean GestioneDbIdoneita(long P_COD_AZL, long P_COD_VST_IDO);

    public boolean GestioneRbIdoneita(long P_COD_AZL, String P_NOM_VST_IDO);
    // opredelenie view metodov classa

    public Collection getVisiteIdoneita_for_SCHVST_View(long lCOD_AZL, long lCOD_UNI_ORG, String strTPL_ACR_VLU_RSO, String strSTATO, java.sql.Date dDAT_PIF_VST_D, java.sql.Date dDAT_PIF_VST_A, String strSTA_INT, java.sql.Date dDAT_EFT_VST_D, java.sql.Date dDAT_EFT_VST_A, String strRAGGRUPPATI, String strSORT_DAT_PIF, String strSORT_DAT_EFT, String strSORT_TPL_ACC);
//<report>

    public VisitaIdoneitaDipendenteView getVisitaIdoneitaDipendenteView(long lCOD_DPD, long lCOD_CTL_SAN, long lCOD_VST_IDO,java.sql.Date dtDAT_PIF_VST);
                                                                           
    //Podmaster

    public Collection getGestione_CRM_VST_IDO_View(String strNOM, long COD_AZL);
    //

    public Collection findEx(
            long lCOD_AZL,
            String strNOM_VST_IDO,
            String strDES_VST_IDO,
            Long lPER_VST,
            int iOrderParameter);
}
