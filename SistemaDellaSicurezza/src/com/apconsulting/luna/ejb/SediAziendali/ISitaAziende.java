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
package com.apconsulting.luna.ejb.SediAziendali;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface ISitaAziende extends EJBObject {
//   *Require Fields*
//1 COD_SIT_AZL (SitaAziende ID)

    public long getCOD_SIT_AZL();
//2 COD_AZL (reference to Azienda)

    public long getCOD_AZL();

    public void setCOD_AZL_NOM_SIT_AZL(long newCOD_AZL, String newNOM_SIT_AZL);
//3 NOM_SIT_AZL (name)

    public String getNOM_SIT_AZL();
//public  void setNOM_SIT_AZL (String newNOM_SIT_AZL);
//4 IDZ_SIT_AZL (address)

    public String getIDZ_SIT_AZL();

    public void setIDZ_SIT_AZL(String newIDZ_SIT_AZL);
//5 CIT_SIT_AZL ()

    public String getCIT_SIT_AZL();

    public void setCIT_SIT_AZL(String newCIT_SIT_AZL);

//   *Not require Fields*
//6 NUM_CIC_SIT_AZL ()
    public String getNUM_CIC_SIT_AZL();

    public void setNUM_CIC_SIT_AZL(String newNUM_CIC_SIT_AZL);
//7 PRV_SIT_AZL (province)

    public String getPRV_SIT_AZL();

    public void setPRV_SIT_AZL(String newPRV_SIT_AZL);
//8 CAP_SIT_AZL (cap cod)

    public String getCAP_SIT_AZL();

    public void setCAP_SIT_AZL(String newCAP_SIT_AZL);
}
