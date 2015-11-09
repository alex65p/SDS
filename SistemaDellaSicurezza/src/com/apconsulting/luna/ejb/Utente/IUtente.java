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
package com.apconsulting.luna.ejb.Utente;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
//public interface  IUtente extends EJBObject
public interface IUtente extends EJBObject {

//   *require Fields*
    public long getCOD_UTN();
//

    public String getUSD_UTN();

    public void setUSD_UTN(String newUSD_UTN);
//

    public String getPSW_UTN();

    public void setPSW_UTN(String newPSW_UTN);
//

    public String getSTA_UTN();

    public void setSTA_UTN(String newSTA_UTN);
//

    public long getCOD_DPD();

    public void setCOD_DPD(long newCOD_DPD);
//

    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);
//   *Not require Fields*

    public java.sql.Date getDAT_ATT();

    public void setDAT_ATT(java.sql.Date newDAT_ATT);
//

    public java.sql.Date getDAT_DIS();

    public void setDAT_DIS(java.sql.Date newDAT_DIS);
//

    public void addCOD_CAG_DOC(long CAG_DOC_ID);

    public void addCOD_TPL_DOC(long TPL_DOC_ID);

    public void addCOD_RUO(long RUO_ID);

    public void removeCOD_CAG_DOC(long CAG_DOC_ID);

    public void removeCOD_TPL_DOC(long TPL_DOC_ID);

    public void removeCOD_RUO(long RUO_ID);
}
