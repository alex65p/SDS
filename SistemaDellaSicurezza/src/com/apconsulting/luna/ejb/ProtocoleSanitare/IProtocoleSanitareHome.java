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
package com.apconsulting.luna.ejb.ProtocoleSanitare;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
//public interface IProtocoleSanitareHome extends EJBHome
public interface IProtocoleSanitareHome extends EJBHome {

    public IProtocoleSanitare create(
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            long lCOD_AZL,
            java.util.ArrayList alAziende) throws CreateException;

    public void remove(Object primaryKey);

    public void remove(Object primaryKey, java.util.ArrayList alAziende);

    public IProtocoleSanitare findByPrimaryKey(ProtocoleSanitarePK primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov classa

    public Collection getProtocoleSanitare_Name_Address_View(long lCOD_AZL) throws FinderException;

    public Collection getDocumenteSanitareByPROSANID_View(long lCOD_AZL, long PRO_SAN_ID);

    public Collection getVisiteIdoneiteByPROSANID_View(long lCOD_AZL, long PRO_SAN_ID);

    public Collection getVisiteMedicheByPROSANID_View(long lCOD_AZL, long PRO_SAN_ID);

    public Collection getProtocoleSanitare_CRM_PRO_SAN_View(String strNOM, long lCOD_AZL);
    //juli

    public boolean caricaDbProtocolli(long P_COD_AZL, long P_COD_PRO_SAN);

    public boolean caricaRpProtocolli(long P_COD_AZL, String P_NOM_PRO_SAN);

    public Collection findEx(
            long lCOD_AZL,
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            int iOrderParameter);
}
