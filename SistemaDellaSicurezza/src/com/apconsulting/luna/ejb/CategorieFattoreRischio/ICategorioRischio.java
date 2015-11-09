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
package com.apconsulting.luna.ejb.CategorieFattoreRischio;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
//public interface  ICategorioRischio extends EJBObject
public interface ICategorioRischio extends EJBObject {
    // *Require Fields*
    //1 COD_CAG_FAT_RSO (CategorioRischio ID)

    public long getCOD_CAG_FAT_RSO();
    //2 NOM_CAG_FAT_RSO (name)

    public String getNOM_CAG_FAT_RSO();

    public void setNOM_CAG_FAT_RSO(String newNOM_CAG_FAT_RSO);
    // *Not require Fields*
    //3 DES_CAG_FAT_RSO (descr)

    public String getDES_CAG_FAT_RSO();
    //

    public void setDES_CAG_FAT_RSO(String newDES_CAG_FAT_RSO);
}
