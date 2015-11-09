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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.SchedeInterventoDPI;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta 
public interface ISchedeInterventoDPIHome extends EJBHome {

    public ISchedeInterventoDPI create(long lCOD_LOT_DPI, long lCOD_TPL_DPI, String strTPL_INR_DPI, String strATI_INR, java.sql.Date dtDAT_PIF_INR) throws CreateException;

    public void remove(Object primaryKey);

    public ISchedeInterventoDPI findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    //--- view
    //--- <comment date="25/01/2004" author="Treskina Maria">
    public Collection getSchedeInterventoDPIByLOTDPIID_View(long LOT_DPI_ID);

    //--//--- <comment date="13/03/2004" author="Podmasteriev Alexander">
    public Collection getSchedeInterventoLOV_View(long COD_AZL);

    public Collection getfindEx(
            long COD_AZL,
            long COD_LOT_DPI,
            java.sql.Date DAT_PIF_INR,
            java.sql.Date DAT_INR,
            String ATI_INR,
            String NOM_RSP_INR,
            String PBM_RSC,
            long iOrderBy);

    //<report>
    public ReportSchedeInterventoDPIView getReportSchedeInterventoDPIView(long lCOD_SCH_INR_DPI);
  //</report>
}
