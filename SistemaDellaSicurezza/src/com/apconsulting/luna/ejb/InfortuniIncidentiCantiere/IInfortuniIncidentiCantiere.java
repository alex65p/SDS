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

package com.apconsulting.luna.ejb.InfortuniIncidentiCantiere;

import java.util.Collection;
import javax.ejb.EJBObject;

public interface IInfortuniIncidentiCantiere extends EJBObject {

    public long getCOD_INO();

    public String getNOM_COM_INO();

    public void setNOM_COM_INO(String strNOM_COM_INO);

    public java.sql.Date getDAT_COM_INO();

    public void setDAT_COM_INO(java.sql.Date dtDAT_COM_INO);

    public java.sql.Date getDAT_EVE_INO();

    public void setDAT_EVE_INO(java.sql.Date dtDAT_EVE_INO);

    public String getORA_EVE_INO();

    public void setORA_EVE_INO(String strORA_EVE_INO);

    public String getGOR_LAV_INO();

    public void setGOR_LAV_INO(String strGOR_LAV_INO);

    public String getORA_LAV_INO();

    public void setORA_LAV_INO(String strORA_LAV_INO);

    public String getORA_LAV_TUN_INO();

    public void setORA_LAV_TUN_INO(String strORA_LAV_TUN_INO);

    public String getTPL_TRA_EVE_INO();

    public void setTPL_TRA_EVE_INO(String strTPL_TRA_EVE_INO);

    public String getIDZ_TRA_EVE_INO();

    public void setIDZ_TRA_EVE_INO(String strIDZ_TRA_EVE_INO);

    public java.sql.Date getDAT_TRA_EVE_INO();

    public void setDAT_TRA_EVE_INO(java.sql.Date dtDAT_TRA_EVE_INO);

    public java.sql.Date getDAT_INZ_ASZ_LAV();

    public void setDAT_INZ_ASZ_LAV(java.sql.Date dtDAT_INZ_ASZ_LAV);

    public java.sql.Date getDAT_FIE_ASZ_LAV();

    public void setDAT_FIE_ASZ_LAV(java.sql.Date dtDAT_FIE_ASZ_LAV);

    public long getGOR_ASZ();

    public void setGOR_ASZ(long lGOR_ASZ);

    public long getPRG_INI();

    public void setPRG_INI(long lPRG_INI);

    // IN_ITI
    public String getIN_ITI();

    public void setIN_ITI(String newIN_ITI);

    public String getNON_IND();

    public void setNON_IND(String newNON_IND);

    public String getINT_TRA_DIT();

    public void setINT_TRA_DIT(String newINT_TRA_DIT);
    
    public String getMEZ_TRA();

    public void setMEZ_TRA(String newMEZ_TRA);

    public java.sql.Date getDAT_TRA();

    public void setDAT_TRA(java.sql.Date dtDAT_TRA);

    public String getLUO_TRA();

    public void setLUO_TRA(String newLUO_TRA);

    public String getDIN_INC_INO();

    public void setDIN_INC_INO(String newDIN_INC_INO);

    //  Codice Infortunio relazionato al precedente
    public long getCOD_INO_REL();

    public void setCOD_INO_REL(long lCOD_INO_REL);

    public String getDES_EVE_INO();

    public void setDES_EVE_INO(String strDES_EVE_INO);

    public String getDES_ANL_INO();

    public void setDES_ANL_INO(String strDES_ANL_INO);

    public String getDES_CRZ_INO();

    public void setDES_CRZ_INO(String strDES_CRZ_INO);

    public String getDES_RAC_INO();

    public void setDES_RAC_INO(String strDES_RAC_INO);

    public String getDES_DVU_INO();

    public void setDES_DVU_INO(String strDES_DVU_INO);

    public long getCOD_AGE_MAT();

    public void setCOD_AGE_MAT(long lCOD_AGE_MAT);

    public long getCOD_TPL_FRM_INO();

    public void setCOD_TPL_FRM_INO(long lCOD_TPL_FRM_INO);

    public long getCOD_NAT_LES();

    public void setCOD_NAT_LES(long lCOD_NAT_LES);

    public long getCOD_SED_LES();

    public void setCOD_SED_LES(long lCOD_SED_LES);

    public long getCOD_CAN();

    public void setCOD_CAN(long lCOD_CAN);

    public long getCOD_LUO_FSC();

    public void setCOD_LUO_FSC(long lCOD_LUO_FSC);

    public long getCOD_DPD();

    public void setCOD_DPD(long lCOD_DPD);

    public long getCOD_DTE();

    public void setCOD_DTE(long lCOD_DTE);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    // Aggiunge la relazione con il Documento
    public void addINO_DOC(long COD_DOC);

    // Rimuove la relazione con il Documento
    public void removeINO_DOC(long COD_DOC);
}


