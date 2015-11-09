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

package com.apconsulting.luna.ejb.Rischio;

import java.util.Comparator;

/**
 *
 * @author Alessandro
 */
public class Rischio_foo_SCHRIVRSO_Comparator_UP implements Comparator {
    public int compare(Object o1,Object o2){

        Rischio_foo_SCHRIVRSO_View obj1 = (Rischio_foo_SCHRIVRSO_View)o1;
        Rischio_foo_SCHRIVRSO_View obj2 = (Rischio_foo_SCHRIVRSO_View)o2;

        return obj1.dtDAT_RFS_VLU_RSO.compareTo(obj2.dtDAT_RFS_VLU_RSO);
    }

    public boolean equals(Object obj){
        return true;
    }
}
