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
package com.apconsulting.luna.ejb.AnaContServ;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IAnaContServ extends EJBObject {
    /* - - - - - Get e Set dei campi obbligatori - - - - - */

    public long getCOD_SRV();

    public long getCOD_AZL();

    public String getPRO_CON();

    public void setPRO_CON(String newPRO_CON);

    public long getAPP_COD_DTE();

    public void setAPP_COD_DTE(long newAPP_COD_DTE);

    /* - - - - - Get e Set dei campi non obbligatori - - - - - */
    public String getDES_CON();

    public void setDES_CON(String newDES_CON);

    public String getRIF_CON();

    public void setRIF_CON(String newRIF_CON);

    public long getCOD_UNI_ORG();

    public void setCOD_UNI_ORG(long newCOD_UNI_ORG);

    public java.sql.Date getDAT_INI_LAV();

    public void setDAT_INI_LAV(java.sql.Date newDAT_INI_LAV);

    public java.sql.Date getDAT_FIN_LAV();

    public void setDAT_FIN_LAV(java.sql.Date newDAT_FIN_LAV);

    public String getORA_LAV();

    public void setORA_LAV(String newORA_LAV);

    public String getLAV_NOT();

    public void setLAV_NOT(String newORA_LAV);

    public int getNUM_LAV_PRE();

    public void setNUM_LAV_PRE(int newNUM_LAV_PRE);

    public long getCOM_COD_DPD();

    public void setCOM_COD_DPD(long newCOM_COD_DPD);

    public String getCOM_RES_TEL();

    public void setCOM_RES_TEL(String newCOM_RES_TEL);

    public long getCOD_DPD();

    public void setCOD_DPD(long newCOD_DPD);

    public String getNOM_FUZ_AZL();

    public void setNOM_FUZ_AZL(String newNOM_FUZ_AZL);

    public String getAPP_TEL();

    public void setAPP_TEL(String newAPP_TEL);

    public String getAPP_FAX();

    public void setAPP_FAX(String newAPP_FAX);

    public String getAPP_EMAIL();

    public void setAPP_EMAIL(String newAPP_EMAIL);

    public String getAPP_RES_NOM();

    public void setAPP_RES_NOM(String newAPP_RES_NOM);

    public String getAPP_RES_QUA();

    public void setAPP_RES_QUA(String newAPP_RES_QUA);

    public String getAPP_RES_TEL();

    public void setAPP_RES_TEL(String newAPP_RES_TEL);

    public String getAPP_INT_ASS_DES();

    public void setAPP_INT_ASS_DES(String newAPP_INT_ASS_DES);

    public String getAPP_INT_ASS_ORA_LAV();

    public void setAPP_INT_ASS_ORA_LAV(String newAPP_INT_ASS_ORA_LAV);

    public int getAPP_INT_ASS_COD_CON();

    public void setAPP_INT_ASS_COD_CON(int newAPP_INT_ASS_COD_CON);

    public String getAPP_INT_ASS_CON_DES();

    public void setAPP_INT_ASS_CON_DES(String newAPP_INT_ASS_CON_DES);

    public String getRAG_SCL_DTE();

    public String getIDZ_DTE();

    public String getCEN_EME_DES();

    public void setCEN_EME_DES(String newCEN_EME_DES);

    public String getSER_SAN_DES_1();

    public void setSER_SAN_DES_1(String newSER_SAN_DES_1);

    public String getSER_SAN_DES_2();

    public void setSER_SAN_DES_2(String newSER_SAN_DES_2);

    public String getSER_SAN_DES_3();

    public void setSER_SAN_DES_3(String newSER_SAN_DES_3);

    public String getFLU_DES_1();

    public void setFLU_DES_1(String newFLU_DES_1);

    public String getFLU_DES_2();

    public void setFLU_DES_2(String newFLU_DES_2);

    public String getPRE_MAT_DES_1();

    public void setPRE_MAT_DES_1(String newPRE_MAT_DES_1);

    public String getPRE_MAT_DES_2();

    public void setPRE_MAT_DES_2(String newPRE_MAT_DES_2);

    public String getPRE_MAT_ASS_APP_RAD();

    public void setPRE_MAT_ASS_APP_RAD(String newPRE_MAT_ASS_APP_RAD);

    public String getPRE_MAT_ASS_TEL_CEL();

    public void setPRE_MAT_ASS_TEL_CEL(String newPRE_MAT_ASS_TEL_CEL);

    public String getPRO_SOS_DES();

    public void setPRO_SOS_DES(String newPRO_SOS_DES);

    public String getPRO_SOS_SUB_APP_DES();

    public void setPRO_SOS_SUB_APP_DES(String newPRO_SOS_SUB_APP_DES);
}
