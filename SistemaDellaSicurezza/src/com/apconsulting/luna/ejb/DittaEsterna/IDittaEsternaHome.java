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
package com.apconsulting.luna.ejb.DittaEsterna;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IDittaEsternaHome extends EJBHome {

    public IDittaEsterna create(
            long lCOD_AZL,
            String strRAG_SCL_DTE,
            String strCAG_DTE,
            String strIDZ_DTE,
            String strCIT_DTE,
            String strQLF_RSP_DTE,
            String strNOM_RSP_DTE,
            String strNOM_RSP_SPP_DTE,
            java.sql.Date dtDAT_CAT_DTE,
            long lCOD_STA) throws CreateException;

    public void remove(Object primaryKey);

    public IDittaEsterna findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov

    public Collection getDittaEsterneByAZLID_View(long AZL_ID);

    public Collection findEx(long AZL_ID, String strRAG_SCL_DTE, String strCAG_DTE, String strIDZ_DTE, String strNUM_CIC_DTE, String strCIT_DTE, String strPRV_DTE, Long lCOD_STA, String strCAP_DTE, String strQLF_RSP_DTE, String strNOM_RSP_DTE, String strNOM_RSP_SPP_DTE, java.sql.Date dtDAT_INZ_LAV, java.sql.Date dtDAT_FIE_LAV, int iOrderParameter);

    public Collection getRagSclDteByCodDte(long AZL_ID);

    public Collection getIdzDteOnRagSclDte(long AZL_ID);
}
