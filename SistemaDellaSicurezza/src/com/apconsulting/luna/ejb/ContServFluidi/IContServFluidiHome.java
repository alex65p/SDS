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
package com.apconsulting.luna.ejb.ContServFluidi;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//  Interfaccia Home.
public interface IContServFluidiHome extends EJBHome {

    public IContServFluidi create(
            long lCOD_SRV,
            String strTIP_FLU_DIS) throws CreateException;

    public void remove(Object primaryKey);

    public IContServFluidi findByPrimaryKey(ContServFluidiPK primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    // Metodi di estrazione dati.
    public boolean getInfoOnDescFluidi(long SRV_ID);

    public Collection findEx_Fluidi(
            long lCOD_SRV,
            long lCOD_FLU,
            String strTIP_FLU_DIS,
            String strLUO_COL,
            java.sql.Date dtDAT_INI_CON,
            java.sql.Date dtDAT_FIN_CON,
            int iOrderParameter);
}
