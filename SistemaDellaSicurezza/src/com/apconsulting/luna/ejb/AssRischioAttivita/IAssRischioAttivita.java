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
package com.apconsulting.luna.ejb.AssRischioAttivita;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IAssRischioAttivita extends EJBObject {
    //*Require Fields* 
    //--1
    public long getCOD_RSO_MAN();
    //--2
    public long getCOD_RSO();

    public void setCOD_RSO__COD_MAN__COD_AZL(long lCOD_RSO, long lCOD_MAN, long lCOD_AZL);
    //--3
    public long getCOD_AZL();
    //--4
    public java.sql.Date getDAT_INZ();

    public void setDAT_INZ(java.sql.Date dtDAT_INZ);
    //--5
    public String getPRS_RSO();

    public void setPRS_RSO(String strPRS_RSO);
    //--6
    public String getNOM_RIL_RSO();

    public void setNOM_RIL_RSO(String strNOM_RIL_RSO);
    //--7
    public String getCLF_RSO();

    public void setCLF_RSO(String strCLF_RSO);
    //--8
    public long getPRB_EVE_LES();

    public void setPRB_EVE_LES(long lPRB_EVE_LES);
    //--9
    public long getENT_DAN();

    public void setENT_DAN(long lENT_DAN);
    //--10
    public float getSTM_NUM_RSO();

    public void setSTM_NUM_RSO(float lSTM_NUM_RSO);
    //--11
    public java.sql.Date getDAT_RFC_VLU_RSO();

    public void setDAT_RFC_VLU_RSO(java.sql.Date dtDAT_RFC_VLU_RSO);
    //--12
    public String getSTA_RSO();

    public void setSTA_RSO(String strSTA_RSO);
    //--13
    public long getCOD_MAN();
    // * Not require Fields *
    //--14
    public java.sql.Date getDAT_FIE();

    public void setDAT_FIE(java.sql.Date dtDAT_FIE);
    
    public long getFRQ_RIP_ATT_DAN();
    public void setFRQ_RIP_ATT_DAN(long lFRQ_RIP_ATT_DAN);

    public long getNUM_INC_INF();
    public void setNUM_INC_INF(long lNUM_INC_INF);
    
    //--views for RSO_MAN_Form Tabs       
    public Collection getMisurePreventive_View();

    public Collection getDocumenti_View();

    public Collection getNormativeSentenze_View();

    //---------------------------------------------
    public int removeAssociatedMisurePreventive();
    //---------------------------------------------
    public Collection getNotAssMesure_View(long COD_RSO, long COD_MAN);

    public String addExMesurePreventive(String[] CODS_OF_MESURES);
}
