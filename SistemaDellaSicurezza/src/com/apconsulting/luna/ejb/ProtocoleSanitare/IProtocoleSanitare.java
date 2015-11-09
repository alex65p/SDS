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
package com.apconsulting.luna.ejb.ProtocoleSanitare;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
//public interface  IProtocoleSanitare extends EJBObject
public interface IProtocoleSanitare extends EJBObject {
    // COD_PRO_SAN

    public long getCOD_PRO_SAN();

    public void setCOD_PRO_SAN(long newCOD_PRO_SAN);
    // NOM_PRO_SAN

    public void setNOM_PRO_SAN__COD_AZL(String newNOM_PRO_SAN, long newCOD_AZL);

    public String getNOM_PRO_SAN();
    // DES_PRO_SAN

    public String getDES_PRO_SAN();

    public void setDES_PRO_SAN(String newDES_PRO_SAN);
    // COD_AZL

    public long getCOD_AZL();
    // COD_PRO_SAN_RPO

    public long getCOD_PRO_SAN_RPO();

    public void setCOD_PRO_SAN_RPO(long newCOD_PRO_SAN_RPO);
    //

    public void removeLUO_FSC_PRO_SAN();

    public void removeGEST_MAN_PRO_SAN();
    //

    public void addDocumento(long l);

    public void removeDocumento(long l);
    //

    public void addIdoneta(long l);

    public void removeIdoneta(long l);
    //

    public void addMediche(long l);

    public void removeMediche(long l);
    // multi mode

    public boolean isMultiple();

    public void store(
            String strNOM_PRO_SAN,
            String strDES_PRO_SAN,
            long lCOD_PRO_SAN_RPO,
            java.util.ArrayList alAziende);
}
