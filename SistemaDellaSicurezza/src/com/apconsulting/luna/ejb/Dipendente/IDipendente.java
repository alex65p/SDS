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
package com.apconsulting.luna.ejb.Dipendente;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IDipendente extends EJBObject {
    // COD_DPD

    public long getCOD_DPD();
    // COD_AZL

    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);
    // COD_DTE

    public long getCOD_DTE();

    public void setCOD_DTE(long newCOD_DTE);
    // COD_FUZ_AZL

    public long getCOD_FUZ_AZL();

    public void setCOD_FUZ_AZL(long newCOD_FUZ_AZL);
    // STA_DPD

    public String getSTA_DPD();

    public void setSTA_DPD(String newSTA_DPD);
    // MTR_DPD

    public String getMTR_DPD();

    public void setMTR_DPD(String newMTR_DPD);
    // COG_DPD

    public String getCOG_DPD();

    public void setCOG_DPD(String newCOG_DPD);
    // NOM_DPD

    public String getNOM_DPD();

    public void setNOM_DPD(String newNOM_DPD);
    // COD_FIS_DPD

    public String getCOD_FIS_DPD();

    public void setCOD_FIS_DPD(String newCOD_FIS_DPD);
    // COD_STA

    public long getCOD_STA();

    public String getsCOD_STA();

    public void setCOD_STA(long newCOD_STA);
    // LUO_NAS_DPD

    public String getLUO_NAS_DPD();

    public void setLUO_NAS_DPD(String newLUO_NAS_DPD);
    // DAT_NAS_DPD

    public java.sql.Date getDAT_NAS_DPD();

    public String getsDAT_NAS_DPD();

    public void setDAT_NAS_DPD(java.sql.Date newDAT_NAS_DPD);
    // IDZ_DPD

    public String getIDZ_DPD();

    public void setIDZ_DPD(String newIDZ_DPD);
    // NUM_CIC_DPD

    public String getNUM_CIC_DPD();

    public void setNUM_CIC_DPD(String newNUM_CIC_DPD);
    // CAP_DPD

    public String getCAP_DPD();

    public void setCAP_DPD(String newCAP_DPD);
    // CIT_DPD

    public String getCIT_DPD();

    public void setCIT_DPD(String newCIT_DPD);
    // PRV_DPD

    public String getPRV_DPD();

    public void setPRV_DPD(String newPRV_DPD);
    // IDZ_PSA_ELT_DPD

    public String getIDZ_PSA_ELT_DPD();

    public void setIDZ_PSA_ELT_DPD(String newIDZ_PSA_ELT_DPD);
    // RAP_LAV_AZL

    public String getRAP_LAV_AZL();

    public void setRAP_LAV_AZL(String newRAP_LAV_AZL);
    // DAT_ASS_DPD

    public java.sql.Date getDAT_ASS_DPD();

    public void setDAT_ASS_DPD(java.sql.Date newDAT_ASS_DPD);
    // LIV_DPD

    public String getLIV_DPD();

    public void setLIV_DPD(String newLIV_DPD);
    // DAT_CES_DPD

    public java.sql.Date getDAT_CES_DPD();

    public void setDAT_CES_DPD(java.sql.Date newDAT_CES_DPD);
    // NOT_DPD

    public String getNOT_DPD();

    public void setNOT_DPD(String newNOT_DPD);

    // NOM_AZL
    public String getNOM_AZL();
    // NOM_DTE

    public String getNOM_DTE();
    // NOM_FUZ_AZL

    public String getNOM_FUZ_AZL();

    public java.sql.Date getDAT_INZ(long MAN_ID, long UNI_ORG_ID,java.sql.Date nwDAT_INZ);

    public java.sql.Date getDAT_FIE(long MAN_ID, long UNI_ORG_ID,java.sql.Date nwDAT_INZ);

    public void addCOD_PCS_FRM(long newCOD_PCS_FRM);
    
    public void removeCOD_PCS_FRM(long newCOD_PCS_FRM);

    public void addCOD_MAN(long newCOD_UNI_ORG, long newCOD_MAN, java.sql.Date newDAT_INZ, java.sql.Date newDAT_FIE, long lCOD_TPL_CON);

    public void removeCOD_MAN(long newCOD_MAN, long newCOD_UNI_ORG,java.sql.Date DAT_INZ);

    public void addCOR_DPD(String sATE_FRE_DPD, String sESI_TES_VRF, String sMAT_CSG, long lCOD_COR, java.sql.Date sDAT_EFT_COR);

    public void editCOR_DPD(long COR_ID,String sMAT_CSG, String sESI_TES_VRF, String sATE_FRE_DPD,
                            java.sql.Date dDAT_CSG_MAT,java.sql.Date sDAT_EFT_COR,java.sql.Date dDAT_EFT_TES_VRF,
                            long lPTG_OTT_DPD,java.sql.Date oldDAT_EFT_COR);

    public void removeCOR_DPD(long lCOD_COR_DPD,java.sql.Date sDAT_EFT_COR); //--- mary 06/04/2004

        // SEX_DPD

    public String getSEX_DPD();

    public void setSEX_DPD(String newSEX_DPD);

}