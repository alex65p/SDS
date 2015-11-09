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
package com.apconsulting.luna.ejb.Utente;

import java.rmi.RemoteException;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
//public interface IUtenteHome extends EJBHome
public interface IUtenteHome extends IUtente {

    public IUtente create(
            String USD_UTN,
            String PSW_UTN,
            String STA_UTN,
            long COD_DPD,
            long COD_AZL) throws RemoteException, CreateException;

    public IUtente create(
            String USD_UTN,
            String PSW_UTN,
            String STA_UTN,
            long COD_DPD,
            long COD_AZL,
            boolean simpleID) throws RemoteException, CreateException;

    public void remove(Object primaryKey);

    public IUtente findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;

    public Collection findAll() throws RemoteException, FinderException;
// opredelenie view metodov

    public Collection getUtente_DPD_View(long AZL_ID);

    public Collection getUtente_CAG_DOC_TAB_View(long UTN_ID);

    public Collection getUtente_TPL_DOC_TAB_View(long UTN_ID);

// Start Aggiunta metodo per gestione utenza su ldap
    public Collection getUserS2S(String user);

    public Collection getUserS2S(String user, String password);

    public int deleteUserS2S(String user);

    public int deleteUserS2S(String user, String password);
// Fine aggiunta metodo per gestione utenza su ldap

    public Collection getUtente_RUO_TAB_View(long UTN_ID);
//---- by Juli

    // Metodo Aggiunto per la gestione degli accessi con WAS
    // (WebSphere Application Server)
    public Collection getUserSecurityRoles(String user);

    public Collection getUtente_View(long COD_AZL);

    public Collection findEx(
            long COD_AZL,
            long lCOD_DPD,
            String USD_UTN,
            String STA_UTN,
            java.sql.Date DAT_ATT,
            java.sql.Date DAT_DIS,
            long iOrderBy);
}
