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
package com.apconsulting.luna.ejb.GestioniSezioni;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IGestioniSezioni extends EJBObject //abstract class IGestioniSezioni extends BMPEntityBean
{
    //   *Require Fields*
    //1 COD_ARE (GestioniSezioni ID)

    public long getCOD_ARE();
    //2 COD_AZL (Aziende ID)

    public long getCOD_AZL();

    public void setNOM_ARE__COD_AZL(String newNOM_ARE, long newCOD_AZL);
    //3 NOM_ARE (name)

    public String getNOM_ARE();

    //   *Not require Fields*
    //4 COD_ARE_R (Repository)
    public long getCOD_ARE_R();

    public void setCOD_ARE_R(long newCOD_ARE_R);

    public void setPriority_ANA_DOC_VLU(long lCOD_ARE, long lCOD_DOC_VLU, long lCOD_AZL, long newPriority);
    //-----------------------------
    // Link Table COR_PCS_FRM_TAB
    // COD_CPL

    public void addCOD_CPL(long newCOD_CPL, String newDES_CPL_ARE, long lPRIORITY);

    public void editCOD_CPL(long newCOD_CPL, String newDES_CPL_ARE, long lPRIORITY);

    public void removeCOD_CPL(long newCOD_CPL);

    public long getARE_DOC_VLU_Priority(long COD_DOC_VLU, long COD_ARE);
}

