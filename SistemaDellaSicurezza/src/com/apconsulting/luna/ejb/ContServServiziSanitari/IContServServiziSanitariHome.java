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
package com.apconsulting.luna.ejb.ContServServiziSanitari;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//  Interfaccia Home.
public interface IContServServiziSanitariHome extends EJBHome {

    public IContServServiziSanitari create(
            long lCOD_SRV, String strDES_SRV_VIT) throws CreateException;

    public void remove(Object primaryKey);

    public IContServServiziSanitari findByPrimaryKey(ContServServiziSanitariPK primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    // Metodi di estrazione dati.
    public boolean getInfoOnDescServiziSanitari(long SRV_ID);

    public Collection findEx_ServiziSanitari(
            long lCOD_SRV,
            long lCOD_SRV_SAN,
            String strDES_SRV_VIT,
            java.sql.Date dtDAT_INI_IMP,
            java.sql.Date dtDAT_FIN_IMP,
            String strORA_IMP,
            int iOrderParameter);
}
