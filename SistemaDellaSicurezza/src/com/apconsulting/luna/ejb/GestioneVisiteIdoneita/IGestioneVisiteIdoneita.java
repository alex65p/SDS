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
package com.apconsulting.luna.ejb.GestioneVisiteIdoneita;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IGestioneVisiteIdoneita extends EJBObject {
    // COD_VST_IDO

    public long getCOD_VST_IDO();

    public void setCOD_VST_IDO(long newCOD_VST_IDO);

    // FAT_PER
    public String getFAT_PER();

    public void setFAT_PER(String newFAT_PER);

    // PER_VST
    public long getPER_VST();

    public void setPER_VST(long newPER_VST);

    // NOM_VST_IDO
    public void setNOM_VST_IDO__COD_AZL(String newNOM_VST_IDO, long newCOD_AZL);

    public String getNOM_VST_IDO();

    // DES_VST_IDO
    public String getDES_VST_IDO();

    public void setDES_VST_IDO(String newDES_VST_IDO);

    // COD_AZL
    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);

    // COD_VST_IDO_RPO
    public long getCOD_VST_IDO_RPO();

    public void setCOD_VST_IDO_RPO(long newCOD_VST_IDO_RPO);
}
