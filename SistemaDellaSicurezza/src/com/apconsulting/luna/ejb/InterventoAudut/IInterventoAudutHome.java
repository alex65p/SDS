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
package com.apconsulting.luna.ejb.InterventoAudut;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IInterventoAudutHome extends EJBHome {

    public IInterventoAudut create(java.sql.Date dtDAT_PIF_INR, long lCOD_AZL) throws CreateException;

    public IInterventoAudut findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getInterventoAudut_Combo_View();

    public Collection getGestioneInterventoAudit_ForSelectDPI_View(long lCOD_AZL);

    public Collection getInterventoAuditView(long lCOD_AZL);
    //--<ALEX>--

    public MisuraPreventivaView getMisuraPreventivaByAttivita(long lCOD_MIS_PET_MAN, long lCOD_AZL);

    public MisuraPreventivaView getMisuraPreventivaByLuogo(long lCOD_MIS_RSO_LUO, long lCOD_AZL);

    public Collection getMisurePreventiveAllByAttivita(long lCOD_AZL, String strMisura);

    public Collection getMisurePreventiveAllByLuogo(long lCOD_AZL, String strMisura);
    //--</ALEX>--

    public Collection getGestioneInterventoAudit_SCH_View(long lCOD_AZL, String strNOM_MIS_PET_LUO_MAN, java.sql.Date dtDAT_PIF_INR_DAL, java.sql.Date dtDAT_PIF_INR_AL, java.sql.Date dtDAT_EFT_DAL, java.sql.Date dtDAT_EFT_AL, String strNOM_MIS_PET, String strNOM_RSP_INR, String strNOM_LUO_FSC, String strDES_INTERVENTO, String strSTA_INT, String strRG_GROUP, String strINR_ADT_AZL, String strNB_APL_A, String strSORT);

    public Collection getInterventoAuditFORLUOView(long lCOD_AZL, long lCOD_MIS_RSO_LUO);
    //--- mary for search

    public Collection findEx(
            long lCOD_AZL,
            Long lCOD_LUO_FSC,
            String strDES_INR_ADT,
            Long lPNG_TEO,
            Long lPNG_RIL,
            Long lNUM_VIS_ISP,
            java.sql.Date dtDAT_ADT,
            java.sql.Date dtDAT_PIF_INR,
            Long lPNG_PCT,
            Long lCOD_DPD,
            String strCOG_DPD,
            String strNOM_DPD,
            String strMTR_DPD,
            String strINR_ADT_AZL,
            String strNOM_MIS_PET,
            String strRB_LUO_FSC_MAN,
            int iOrderParameter //not used for now
            );
}
