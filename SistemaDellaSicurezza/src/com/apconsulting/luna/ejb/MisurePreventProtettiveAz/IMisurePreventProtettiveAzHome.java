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
package com.apconsulting.luna.ejb.MisurePreventProtettiveAz;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IMisurePreventProtettiveAzHome extends EJBHome {

    public IMisurePreventProtettiveAz create(String strNOM_MIS_PET, java.sql.Date dtDAT_CMP, long lVER_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strSTA_MIS_PET, long lCOD_AZL, long lCOD_TPL_MIS_PET) throws CreateException;

    public IMisurePreventProtettiveAz findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll(long lAzienda) throws FinderException;

    public Collection getMisure_Preventive_ByAzienda_View(long lCOD_AZL);

    public void remove(Object primaryKey);
    // views----

    public Collection getMisureByLuoghiAndRischiView(long Azienda, long Luogo, String STA, String RSO);

    public Collection getMisureByAttivitaAndRischiView(long Azienda, long Attivita, String STA, String RSO);

    public Collection getMisureComboView(String strAPL_A);

    public Collection getMisurePreventProtettiveAz_foo_View(
            long lCOD_AZL,
            long lCOD_MIS_PET_LUO_MAN,
            String strAPL_A,
            String strNOM_MIS_PET,
            String strDES_TPL_MIS_PET,
            String strNOM_RSO,
            java.sql.Date dDAT_PNZ_MIS_PET_DAL,
            java.sql.Date dDAT_PNZ_MIS_PET_AL,
            String strGROUP,
            String strVAR_PAR_ADT);

    public Collection findEx(
            long lCOD_AZL,
            Long LCOD_ANA_MAN,
            Long LCOD_LUO_FSC,
            String strSTA,
            String strNOM_RSO,
            String strNOM_MIS_PET,
            String strDES_MIS_PET,
            Long LVER_MIS_PET,
            Long LCOD_TPL_MIS_PET,
            java.sql.Date dtDAT_CMP,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            Long LPNZ_MIS_PET_MES,
            String strTPL_DSI_MIS_PET,
            int iOrderParameter);
}
