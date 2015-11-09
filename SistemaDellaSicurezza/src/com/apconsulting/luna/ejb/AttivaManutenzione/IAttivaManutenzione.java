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
package com.apconsulting.luna.ejb.AttivaManutenzione;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//public interface  IAttivaManutenzione extends EJBObject
public interface IAttivaManutenzione extends EJBObject {
    //   *require Fields*

    public long getCOD_MNT_MAC();

    public String getDES_ATI_MNT_MAC();

    public void setDES_ATI_MNT_MAC(String newDES_ATI_MNT_MAC);
//-----3

    public void setATI_MNT_PER(String newATI_MNT_PER);

    public String getATI_MNT_PER();
//-----4

    public void setCOD_MAC(long newCOD_MAC);

    public long getCOD_MAC();
//-----5

    public void setPER_ATI_MNT_MES(long newPER_ATI_MNT_MES);

    public long getPER_ATI_MNT_MES();
//-----6

    public void setDAT_PAR_MNT_MAC(java.sql.Date newDAT_PAR_MNT_MAC);

    public java.sql.Date getDAT_PAR_MNT_MAC();
}
