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
package com.apconsulting.luna.ejb.SubAppAnalisiRischi;

/**
 *
 * @author Dario
 */
public class SubAppAnalisiRischiPK {

    public long COD_SUB_APP;
    public long COD_RSO;
    public String FAS_LAV;
    public String MOD_OPE;
    public String MAT_PRO_IMP;
    public String RIS;
    public String MIS_PRE_PRO;

    public SubAppAnalisiRischiPK(long lCOD_SUB_APP, long lCOD_RSO) {
        this.COD_SUB_APP = lCOD_SUB_APP;
        this.COD_RSO = lCOD_RSO;
    }

    @Override
    public int hashCode() {
        return (new Long(COD_SUB_APP)).hashCode() ^ (new Long(COD_RSO)).hashCode();
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof SubAppAnalisiRischiPK)) {
            return false;
        }
        SubAppAnalisiRischiPK pk = (SubAppAnalisiRischiPK) other;
        return (this.COD_SUB_APP == pk.COD_SUB_APP) && (this.COD_RSO == pk.COD_RSO);
    }
}
