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
package com.apconsulting.luna.ejb.ContServFluidi;

/**
 *
 * @author Dario
 */
public class ContServFluidiPK {

    public long COD_SRV;
    public long COD_FLU;

    public ContServFluidiPK(long lCOD_SRV, long lCOD_FLU) {
        this.COD_SRV = lCOD_SRV;
        this.COD_FLU = lCOD_FLU;
    }

    @Override
    public int hashCode() {
        return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_FLU)).hashCode();
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof ContServFluidiPK)) {
            return false;
        }
        ContServFluidiPK pk = (ContServFluidiPK) other;
        return (this.COD_SRV == pk.COD_SRV) && (this.COD_FLU == pk.COD_FLU);
    }
}
