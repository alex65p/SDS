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

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//  Interfaccia remota.
public interface IContServFluidi extends EJBObject {
    //  Campi obbligatori

    // COD_SRV
    public long getCOD_SRV();

    // COD_FLU
    public long getCOD_FLU();

    //  Campi opzionali
    // TIP_FLU_DIS
    public String getTIP_FLU_DIS();

    public void setTIP_FLU_DIS(String newTIP_FLU_DIS);

    // LUO_COL
    public String getLUO_COL();

    public void setLUO_COL(String newLUO_COL);

    // DAT_INI_CON
    public java.sql.Date getDAT_INI_CON();

    public void setDAT_INI_CON(java.sql.Date newDAT_INI_CON);

    // DAT_FIN_CON
    public java.sql.Date getDAT_FIN_CON();

    public void setDAT_FIN_CON(java.sql.Date newDAT_FIN_CON);
}
