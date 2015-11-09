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
package com.apconsulting.luna.ejb.AssMisuraAttivita;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IAssMisuraAttivitaHome extends EJBHome {

    public IAssMisuraAttivita create(
            long lCOD_MIS_PET,
            String strPRS_MIS_PET,
            long lVER_MIS_PET,
            String strADT_MIS_PET,
            String strPER_MIS_PET,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            String strTPL_DSI_MIS_PET,
            String strDSI_AZL_MIS_PET,
            String strSTA_MIS_PET,
            long lCOD_RSO_MAN,
            long lCOD_MAN,
            long lCOD_TPL_MIS_PET) throws CreateException;

    public IAssMisuraAttivita findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);
    
    //--Vievs methods of Home Interface
    public Collection getAssMisuraAttivita_View(long COD_AZL);

    public Collection getAssMP_Man_View(String WHE_IN_AZL);
}
