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
package com.apconsulting.luna.ejb.Rischio;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IRischio extends EJBObject {

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    public long getCOD_RSO();

    public String getNOM_RSO();

    public void setNOM_RSO(String strNOM_RSO);

    public String getDES_RSO();

    public void setDES_RSO(String strDES_RSO);

    public java.sql.Date getDAT_RIL();

    public void setDAT_RIL(java.sql.Date dtDAT_RIL);

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

    public long getRFC_VLU_RSO_MES();

    public void setRFC_VLU_RSO_MES(long lRFC_VLU_RSO_MES);

    public long getCOD_FAT_RSO();

    public void setCOD_FAT_RSO(long lCOD_FAT_RSO);

    public long getCOD_RSO_RPO();

    public void setCOD_RSO_RPO(long lCOD_RSO_RPO);

    public int addCorso(long lCorso, java.util.ArrayList alAziende);

    public void removeCorso(long lCorso, java.util.ArrayList alAziende);

    public void addNormativaSentenza(long lNormativa);

    public void removeNormativaSentenza(long lNormativa);

    public int addDpi(long lDpi, java.util.ArrayList alAziende);

    public void removeDpi(long lDpi, java.util.ArrayList alAziende);

    public int addProtocolloSanitario(long lProtocolloSanitaro, java.util.ArrayList alAziende);

    public void removeProtocolloSanitario(long lProtocolloSanitaro, java.util.ArrayList alAziende);

    public int addMisuraPp(long lMisurePp, java.util.ArrayList alAziende);

    public void removeMisuraPp(long lMisurePp, java.util.ArrayList alAziende);

    public void addDocumento(long l);

    public void removeDocumento(long l);

    public void addART_LEG(long l);

    public void removeART_LEG(long lCOD_ARL);

    public Collection getCorsiView();

    public Collection getNormativeSentenzeView();

    public Collection getDpiView();

    public Collection getProtocolliSanitariView();

    public Collection getMisurePpView();

     public Collection getArt_Legge_View();
    

    public Collection getDocumentiView();

    /*<comment date="17/02/2004" author="Roman Chumachenko">
    External get method for getting of Fattore Rischio Name
    </comment>*/
    public String getFattoreRischio();

    public boolean isMultiple();

    public void store(String strNOM_RSO, String strDES_RSO, java.sql.Date dtDAT_RIL, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, long lRFC_VLU_RSO_MES, long lCOD_FAT_RSO, java.util.ArrayList alAziende);
}
