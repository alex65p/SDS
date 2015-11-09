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
package com.apconsulting.luna.ejb.SchedeInterventoPSD;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta 
public interface ISchedeInterventoPSDHome extends EJBHome {

    public ISchedeInterventoPSD create(
            long lCOD_PSD_ACD,
            String strTPL_INR_PSD,
            java.sql.Date dtDAT_PIF_INR) throws CreateException;

    public void remove(Object primaryKey);

    public ISchedeInterventoPSD findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    //--- view

    public Collection getSchedeInterventoPSD_SelectData_View();

    public Collection getSchedeInterventoPSD_ForTab_View(long SCH_PSD_ID);

    public Collection getSchedeInterventoPSD_ForPresidi_View(long SCH_PSD_ID);

    public Collection getSchedeInterventoPSD_ForView_View();

    public Collection getSchedeInterventoPSD_Responsabile_View(long COD_PSD_ACD, String WHE_IN_AZL);

    public Collection findEx(
            String strTPL_INR_PSD,
            Long lCOD_PSD_ACD,
            String strATI_SVO,
            java.sql.Date dtDAT_INR,
            java.sql.Date dtDAT_PIF_INR,
            String strNOM_RSP_INR,
            int iOrderParameter);
}
