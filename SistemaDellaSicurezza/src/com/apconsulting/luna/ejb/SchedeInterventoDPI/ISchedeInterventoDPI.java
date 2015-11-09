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
package com.apconsulting.luna.ejb.SchedeInterventoDPI;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta 
public interface ISchedeInterventoDPI extends EJBObject {

    //   *Require Fields*
    //1
    public long getCOD_SCH_INR_DPI();

    //2
    public void setCOD_LOT_DPI(long newCOD_LOT_DPI);

    public long getCOD_LOT_DPI();

    //3
    public void setCOD_TPL_DPI(long newCOD_TPL_DPI);

    public long getCOD_TPL_DPI();

    //4
    public void setTPL_INR_DPI(String newTPL_INR_DPI);

    public String getTPL_INR_DPI();

    //5
    public void setATI_INR(String newATI_INR);

    public String getATI_INR();

    //6
    public void setDAT_PIF_INR(java.sql.Date newDAT_PIF_INR);

    public java.sql.Date getDAT_PIF_INR();

    //============================================
    // not required field
    //7
    public void setDAT_INR(java.sql.Date newDAT_INR);

    public java.sql.Date getDAT_INR();

    //8
    public void setESI_INR(String newESI_INR);

    public String getESI_INR();

    //9
    public void setPBM_RSC(String newPBM_RSC);

    public String getPBM_RSC();

    //10
    public void setNOM_RSP_INR(String newNOM_RSP_INR);

    public String getNOM_RSP_INR();
}
