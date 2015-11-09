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

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//  Interfaccia remota.
public interface ISubAppAnalisiRischi extends EJBObject {
    //  Campi obbligatori
    // COD_SUB_APP

    public long getCOD_SUB_APP();

    public void setCOD_SUB_APP(long newCOD_SUB_APP);

    // COD_RSO
    public long getCOD_RSO();

    //  Campi opzionali
    // FAS_LAV
    public String getFAS_LAV();

    public void setFAS_LAV(String newFAS_LAV);

    // MOD_OPE
    public String getMOD_OPE();

    public void setMOD_OPE(String newMOD_OPE);

    // MAT_PRO_IMP
    public String getMAT_PRO_IMP();

    public void setMAT_PRO_IMP(String newMAT_PRO_IMP);

    // RIS
    public String getRIS();

    public void setRIS(String newRIS);

    // MIS_PRE_PRO
    public String getMIS_PRE_PRO();

    public void setMIS_PRE_PRO(String newMIS_PRE_PRO);
}
