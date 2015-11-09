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
package com.apconsulting.luna.ejb.Consulente;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IConsultant extends EJBObject {
    //   *Require Fields*
    //1 COD_COU (Consultant ID)

    public long getCOD_COU();
    //2 USD_COU ()

    public String getUSD_COU();

    public void setUSD_COU(String newUSD_COU);
    //3 PSW_COU ()

    public String getPSW_COU();

    public void setPSW_COU(String newPSW_COU);
    //4 STA_COU ()

    public String getSTA_COU();

    public void setSTA_COU(String newSTA_COU);
    //5 NOM_COU ()

    public String getNOM_COU();

    public void setNOM_COU(String newNOM_COU);
    //   *Not require Fields*
    //6 RUO_COU ()

    public String getRUO_COU();

    public void setRUO_COU(String newRUO_COU);
    //7 DAT_ATT ()

    public java.sql.Date getDAT_ATT();

    public void setDAT_ATT(java.sql.Date newDAT_ATT);
    //8 DAT_STA ()

    public java.sql.Date getDAT_DIS();

    public void setDAT_DIS(java.sql.Date newDAT_DIS);

    public Collection getAziende();

    public Collection getAziendeMOD_CLC_RSO(short sMOD_CLC_RSO);

    // Link Table ANA_AZL_TAB
    //4 COD_AZL
    public void addCOD_AZL(long newCOD_AZL);

    public void removeCOD_AZL(String newCOD_COU, String newCOD_AZL);
}
