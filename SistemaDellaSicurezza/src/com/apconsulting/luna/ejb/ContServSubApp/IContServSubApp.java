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
package com.apconsulting.luna.ejb.ContServSubApp;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IContServSubApp extends EJBObject {
    /* - - - - - Get e Set dei campi obbligatori */

    public long getCOD_SUB_APP();

    public long getCOD_SRV();

    public long getCOD_DTE();

    /* - - - - - Get e Set dei campi non obbligatori */
    public String getTEL();

    public void setTEL(String newTEL);

    public String getFAX();

    public void setFAX(String newFAX);

    public String getEMAIL();

    public void setEMAIL(String newEMAIL);

    public String getRES_LOC_NOM();

    public void setRES_LOC_NOM(String newRES_LOC_NOM);

    public String getRES_LOC_QUA();

    public void setRES_LOC_QUA(String newRES_LOC_QUA);

    public String getRES_LOC_TEL();

    public void setRES_LOC_TEL(String newRES_LOC_TEL);

    public String getINT_ASS_DES();

    public void setINT_ASS_DES(String newINT_ASS_DES);

    public String getORA_LAV();

    public void setORA_LAV(String newORA_LAV);

    public java.sql.Date getDAT_INI_LAV();

    public void setDAT_INI_LAV(java.sql.Date newDAT_INI_LAV);

    public java.sql.Date getDAT_FIN_LAV();

    public void setDAT_FIN_LAV(java.sql.Date newDAT_FIN_LAV);

    public String getLAV_NOT();

    public void setLAV_NOT(String newLAV_NOT);

    public int getCOD_CON();

    public void setCOD_CON(int newCOD_CON);

    public String getCON_DES();

    public void setCON_DES(String newCON_DES);

    public String getDES_CON();

    public String getPRO_CON();

    public String getRAG_SCL_DTE();

    public String getIDZ_DTE();
}
