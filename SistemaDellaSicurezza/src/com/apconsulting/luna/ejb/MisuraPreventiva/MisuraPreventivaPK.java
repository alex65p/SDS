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
package com.apconsulting.luna.ejb.MisuraPreventiva;

/**
 *
 * @author Dario
 */

// PK definition -------
public class MisuraPreventivaPK {

    public long lCOD_AZL;
    public long lCOD_MIS_PET;

    public MisuraPreventivaPK(long lCOD_AZL, long lCOD_MIS_PET) {
        this.lCOD_AZL = lCOD_AZL;
        this.lCOD_MIS_PET = lCOD_MIS_PET;
    }

    @Override
    public int hashCode() {
        return (new Long(lCOD_AZL)).hashCode() ^ (new Long(lCOD_MIS_PET)).hashCode();
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof MisuraPreventivaPK)) {
            return false;
        }
        MisuraPreventivaPK pk = (MisuraPreventivaPK) other;
        return (this.lCOD_AZL == pk.lCOD_AZL) && (this.lCOD_MIS_PET == pk.lCOD_MIS_PET);
    }
}
