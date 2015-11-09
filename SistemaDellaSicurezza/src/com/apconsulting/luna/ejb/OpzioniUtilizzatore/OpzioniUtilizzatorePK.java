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
package com.apconsulting.luna.ejb.OpzioniUtilizzatore;

/**
 *
 * @author Dario
 */
public class OpzioniUtilizzatorePK {

    public long COD_USR;
    public String OPZ_NOM;

    public OpzioniUtilizzatorePK(long lCOD_USR, String strOPZ_NOM) {
        this.COD_USR = lCOD_USR;
        this.OPZ_NOM = strOPZ_NOM;
    }

    @Override
    public int hashCode() {
        return (new Long(COD_USR)).hashCode() ^ (new String(OPZ_NOM)).hashCode();
    }

    @Override
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof OpzioniUtilizzatorePK)) {
            return false;
        }
        OpzioniUtilizzatorePK pk = (OpzioniUtilizzatorePK) other;
        return (this.COD_USR == pk.COD_USR) && (this.OPZ_NOM.equals(pk.OPZ_NOM));
    }
}
