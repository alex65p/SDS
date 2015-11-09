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
package com.apconsulting.luna.ejb.Immobili3lv;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
// BASE TABLE: ANA_IMM_TAB
//     Home Intrface EJB obiekta
public interface IImmobili3lvHome extends EJBHome {

    public IImmobili3lv create
            (long lCOD_AZL,
            long lCOD_SIT_AZL,
            String strNOM_IMM) throws CreateException;

    public void remove(Object primaryKey);

    public IImmobili3lv findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public Collection findEx
            (long lCOD_AZL,
            Long lCOD_SIT_AZL,
            String strNOM_IMM,
            String strDES_IMM,
            String strIND_IMM,
            String strNUM_CIV_IMM,
            String strCIT_IMM,
            String strPRO_IMM,
            String strCAP_IMM,
            int iOrderParameter);
}
