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
package com.apconsulting.luna.ejb.AziendaTelefono;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IAziendaTelefono extends EJBObject {
    //   *Require Fields*
    //1 COD_NUM_TEL_ID (AziendaTelefono ID)

    public long getCOD_NUM_TEL_AZL();
    //2 TPL_NUM_TEL ()

    public String getTPL_NUM_TEL();

    public void setTPL_NUM_TEL__NUM_TEL__COD_AZL(String newTPL_NUM_TEL, String newNUM_TEL, long lCOD_AZL);
    //3 NUM_TEL (phone number)

    public String getNUM_TEL();
    //public  void setNUM_TEL (String newNUM_TEL);
    //4 COD_AZL (reference to ANA_AZL_TAB)

    public long getCOD_AZL();
    //public  void setCOD_AZL (long newCOD_AZL);
}
