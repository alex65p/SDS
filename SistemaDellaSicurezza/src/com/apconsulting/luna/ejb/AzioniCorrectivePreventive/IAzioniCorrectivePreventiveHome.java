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
package com.apconsulting.luna.ejb.AzioniCorrectivePreventive;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IAzioniCorrectivePreventiveHome extends EJBHome {

    public IAzioniCorrectivePreventive create(String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, long lCOD_AZL) throws CreateException;

    public IAzioniCorrectivePreventive findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getDocumentByAZN_CRR_ID_View(long COD_AZN_CRR_PET);
    /*<comment date="02/03/2004" author="Roman Chumachenko">
     <description>Remake to new requirements (Home View)</description>
     </comment>*/

    public Collection getAzioniCorrectivePreventive_AZL_View(long lCOD_AZL);

    public Collection getAzioniCorrectivePreventive_View();

    public Collection findEx_AZL(long lCOD_AZL, Long lCOD_INR_ADT, String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, String strTPL_ATT, String strDES_AZN_CRR_PET, String strTPL_AZN, java.sql.Date dtDAT_AZN, int iOrderParameter /*not used for now*/);

    public Collection findEx(long lCOD_AZL, Long lCOD_INR_ADT, String strDES_AZN_RCH, String strRCH_AZN_CRR_PET, java.sql.Date dtDAT_RCH, int iOrderParameter /*not used for now*/);
}
