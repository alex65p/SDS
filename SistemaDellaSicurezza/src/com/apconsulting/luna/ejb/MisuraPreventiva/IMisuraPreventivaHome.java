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
package com.apconsulting.luna.ejb.MisuraPreventiva;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IMisuraPreventivaHome extends EJBHome {

    public IMisuraPreventiva create(
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            long lVER_MIS_PET,
            String strIST_OPE_COR,
            String strADT_MIS_PET,
            java.sql.Date dtDAT_PAR_ADT,
            String strPER_MIS_PET,
            long lPNZ_MIS_PET_MES,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            String strDSI_AZL_MIS_PET,
            long lCOD_TPL_MIS_PET,
            long lCOD_MIS_PET_RPO,
            long lCOD_AZL,
            java.util.ArrayList alAziende) throws CreateException;

    public IMisuraPreventiva findByPrimaryKey(MisuraPreventivaPK primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public void remove(Object primaryKey, java.util.ArrayList alAziende);

    public Collection getMisure_Preventive_ByAzienda_View(long lCOD_AZL);

    public Collection getMisure_Preventive_LUO_ByAzienda_View(long lCOD_AZL);

    public Collection getMisure_Preventive_MAN_ByAzienda_View(long lCOD_AZL);

    public Collection getMisureComboView(long lCOD_AZL);

    public Collection getMisureLuoManComboView(String strTYPE, String strCOD_AZL);

    public Collection getRischiComboView(String strTYPE, String strCOD_AZL);
// ----- by Juli

    public Collection getMisuraPreventiva_to_SCH_MIS_PET_View(long lCOD_AZL, String strNB_APL_A, String strNB_NOM_RSO, long lNB_COD_MIS_PET_LUO_MAN, String strNB_NOM_MIS_PET, String strNB_DES_TPL_MIS_PET, java.sql.Date dNB_DAT_CMP_DAL, java.sql.Date dNB_DAT_CMP_AL, java.sql.Date dNB_DAT_PNZ_MIS_PET_DAL, java.sql.Date dNB_DAT_PNZ_MIS_PET_AL, String strRAGGRUPPATI, String strNB_DAT_PAR_ADT);

    public Collection findEx(
            long lCOD_AZL,
            String strPER_MIS_PET,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strNOM_MIS_PET,
            java.sql.Date dtDAT_CMP,
            Long lVER_MIS_PET,
            String strIST_OPE_COR,
            java.sql.Date dtDAT_PAR_ADT,
            Long lPNZ_MIS_PET_MES,
            String strDES_MIS_PET,
            String strTPL_DSI_MIS_PET,
            int iOrderParameter);
}
