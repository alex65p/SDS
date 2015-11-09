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
package com.apconsulting.luna.ejb.AttivaManutenzione;

import java.rmi.RemoteException;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IAttivaManutenzioneHome extends EJBHome {

    public IAttivaManutenzione create(
            String DES_ATI_MNT_MAC,
            long COD_MAC) throws RemoteException, CreateException;

    public void remove(Object primaryKey);

    public IAttivaManutenzione findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;

    public Collection findAll() throws RemoteException, FinderException;
    // opredelenie view metodov

    public Collection getAttivaManutenzione_UserID_View();

    public Collection getAttivaManutenzione_TAB_View(long newCOD_MAC, long newCOD_MNT_MAC);

    public Collection getAttivaManutenzioneByMacchina(long lCOD_MAC);

    public Collection findEx(String strDES_ATI_MNT_MAC,
            Long lCOD_MAC,
            java.sql.Date DAT_PAR_MNT_MAC,
            Long lPER_ATI_MNT_MES,
            String strATI_MNT_PER,
            int iOrderParameter /*not used for now*/);
}
