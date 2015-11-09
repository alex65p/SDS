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
package com.apconsulting.luna.ejb.Consulente;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IConsultantHome extends EJBHome {

    public IConsultant create(
            String strUSD_COU,
            String strPSW_COU,
            String strSTA_COU,
            String strNOM_COU) throws CreateException;

    public void remove(Object primaryKey);

    public IConsultant findByPrimaryKey(Long primaryKey) throws FinderException;

    public IConsultant findByPrimaryKey(String strConsultant) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov

    public Collection getConsultantiByAZLID_View(long AZL_ID);
    // --

    public Collection getAziendeAssociateByCOUID_View(String COD_COU);

    public Collection getConsultant_View();

    public long getAZL_COU_TABCount();

    public void removeCOD_AZL(String newCOD_COU, String newCOD_AZL);

    public Collection getConsultantUTN_View();

    public Collection findEx(String strNOM_COU, String strUSD_COU, String strRUO_COU, String strSTA_COU, java.sql.Date dDAT_ATT, java.sql.Date dDAT_DIS, int iOrderParameter);
}
