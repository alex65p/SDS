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
package com.apconsulting.luna.ejb.CategoriePreside;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta 
//public interface  ICategoriePreside extends EJBObject
public interface ICategoriePreside extends EJBObject {
    //   *require Fields*

    public String getNOM_CAG_PSD_ACD();

    public void setNOM_CAG_PSD_ACD(String newNOM_CAG_PSD_ACD);

    public long getCOD_CAG_PSD_ACD();

    //   *Not require Fields*
    public void setDES_CAG_PSD_ACD(String newDES_CAG_PSD_ACD);

    public String getDES_CAG_PSD_ACD();

    public void setPER_MES_SST(long newPER_MES_SST);

    public long getPER_MES_SST();

    public void setPER_MES_MNT(long newPER_MES_MNT);

    public long getPER_MES_MNT();
//<report>
    //public Collection 	getPresidiByCategoriaView(long lCOD_CAG_PSD_ACD)
}
