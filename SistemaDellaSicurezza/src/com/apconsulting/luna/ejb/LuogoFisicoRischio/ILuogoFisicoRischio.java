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
package com.apconsulting.luna.ejb.LuogoFisicoRischio;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface ILuogoFisicoRischio extends EJBObject {

    public long getCOD_RSO_LUO_FSC();

    public long getCOD_LUO_FSC();

    public void setCOD_LUO_FSC(long lCOD_LUO_FSC);

    public long getCOD_RSO();

    public void setCOD_RSO(long lCOD_RSO);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    public void setCOD_LUO_FSC__COD_RSO__COD_AZL(long lCOD_LUO_FSC, long lCOD_RSO, long lCOD_AZL);

    public String getPRS_RSO();

    public void setPRS_RSO(String strPRS_RSO);

    public java.sql.Date getDAT_INZ();

    public void setDAT_INZ(java.sql.Date dtDAT_INZ);

    public java.sql.Date getDAT_FIE();

    public void setDAT_FIE(java.sql.Date dtDAT_FIE);

    public String getNOM_RIL_RSO();

    public void setNOM_RIL_RSO(String strNOM_RIL_RSO);

    public String getCLF_RSO();

    public void setCLF_RSO(String strCLF_RSO);

    public long getPRB_EVE_LES();

    public void setPRB_EVE_LES(long lPRB_EVE_LES);

    public long getENT_DAN();

    public void setENT_DAN(long lENT_DAN);

    public long getFRQ_RIP_ATT_DAN();

    public void setFRQ_RIP_ATT_DAN(long lFRQ_RIP_ATT_DAN);

    public long getNUM_INC_INF();

    public void setNUM_INC_INF(long lNUM_INC_INF);

    public float getSTM_NUM_RSO();

    public void setSTM_NUM_RSO(float lSTM_NUM_RSO);

    public java.sql.Date getDAT_RFC_VLU_RSO();

    public void setDAT_RFC_VLU_RSO(java.sql.Date dtDAT_RFC_VLU_RSO);

    public String getSTA_RSO();

    public void setSTA_RSO(String strSTA_RSO);

    //	public void addMisure(long l);
    public void removeMisure(long l);

    public void editDatFine(String strchDatFine);

    public Collection getLuogiFisicoMisureView();

    public Collection getLuogiFisicoDocumentiView();

    public Collection getLuogiFisicoNormativeView();
    //
	/*<comment date="01/03/2004" author="Roman Chumachenko">
    <description>Connection to Rischio Object</description>
    </comment>*/

    public Collection getNotAssMesure_View(long COD_RSO, long COD_LUO_FSC);

    public String addExMesurePreventive(String[] CODS_OF_MESURES);
    //<comment date="29/03/2004" author="Roman Chumachenko">

    public void addRischioAssociations(long lCOD_AZL);

    public void deleteRischioAssociations(long lCOD_AZL);
    //</comment>
}
