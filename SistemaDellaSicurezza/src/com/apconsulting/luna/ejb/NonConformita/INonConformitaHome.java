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
package com.apconsulting.luna.ejb.NonConformita;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta 
public interface INonConformitaHome extends EJBHome //public interface INonConformitaHome extends  INonConformita
{

    public INonConformita create(
            String strDES_NOM_CFO,
            java.sql.Date dtDATI_RIL_NON_CFO,
            String strNOM_RIL_NON_CFO,
            long lCOD_AZL
    ) throws CreateException;

    public void remove(Object primaryKey);

    public INonConformita findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    //  <ALEX>
    public Collection getNonConformita(long lCOD_AZL);

    public Collection getNonConformitaByInterventoAudit(long lCOD_INR_ADT);

    // </ALEX>  
    // opredelenie view metodov
    //public Collection getNonConformita_All_Plus_Description_View() throws FinderException;
    //--- mary for search
    public Collection findEx(
            String strDES_NON_CFO,
            String strOSS_NON_CFO,
            java.sql.Date dtDAT_RIL_NON_CFO,
            String strNOM_RIL_NON_CFO,
            Long lCOD_INR_ADT,
            int iOrderParameter //not used for now
    );
}
