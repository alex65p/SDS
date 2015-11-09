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
package com.apconsulting.luna.ejb.DittaEsterna;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IDittaEsterna extends EJBObject {
    //   *Require Fields*
    //1 COD_DTE (DittaEsterna ID)

    public long getCOD_DTE();
    //2 COD_AZL

    public long getCOD_AZL();

    public void setCOD_AZL__RAG_SCL_DTE(long newCOD_AZL, String getRAG_SCL_DTE);
    //3 RAG_SCL_DTE

    public String getRAG_SCL_DTE();
    //public  void setRAG_SCL_DTE (String newRAG_SCL_DTE);
    //4 CAG_DTE

    public String getCAG_DTE();

    public void setCAG_DTE(String newCAG_DTE);
    //5 IDZ_DTE

    public String getIDZ_DTE();

    public void setIDZ_DTE(String newIDZ_DTE);
    //6 NUM_CIC_DTE

    public String getNUM_CIC_DTE();

    public void setNUM_CIC_DTE(String newNUM_CIC_DTE);
    //7 CIT_DTE

    public String getCIT_DTE();

    public void setCIT_DTE(String newCIT_DTE);
    //8 QLF_RSP_DTE

    public String getQLF_RSP_DTE();

    public void setQLF_RSP_DTE(String newQLF_RSP_DTE);
    //9 NOM_RSP_DTE

    public String getNOM_RSP_DTE();

    public void setNOM_RSP_DTE(String newNOM_RSP_DTE);
    //10 IDZ_PSA_ELT_RSP

    public String getNOM_RSP_SPP_DTE();

    public void setNOM_RSP_SPP_DTE(String newNOM_RSP_SPP_DTE);
    //11 DAT_CAT_DTE

    public java.sql.Date getDAT_CAT_DTE();

    public void setDAT_CAT_DTE(java.sql.Date newDAT_CAT_DTE);
    //12 COD_STA

    public long getCOD_STA();

    public void setCOD_STA(long newCOD_STA);

    //   *Not require Fields*
    //13 PRV_DTE
    public String getPRV_DTE();

    public void setPRV_DTE(String newPRV_DTE);
    //14 CAP_DTE

    public String getCAP_DTE();

    public void setCAP_DTE(String newCAP_DTE);
    //15 IDZ_PSA_ELT_RSP

    public String getIDZ_PSA_ELT_RSP();

    public void setIDZ_PSA_ELT_RSP(String newIDZ_PSA_ELT_RSP);
    //16 DAT_INZ_LAV

    public java.sql.Date getDAT_INZ_LAV();

    public void setDAT_INZ_LAV(java.sql.Date newDAT_INZ_LAV);
    //17 DAT_FIE_LAV

    public java.sql.Date getDAT_FIE_LAV();

    public void setDAT_FIE_LAV(java.sql.Date newDAT_FIE_LAV);

    // Collections methods
    public Collection getDocumentiAssociatiView();

    public Collection getLuoghiFisiciView();

    public Collection getDTETelefoniView();

    // external setters/getters
    public String getDOC_CSG_RCR(long COD_DOC);

    public void setDOC_CSG_RCR(long COD_DOC, String newDOC_CSG_RCR);

    public void addDocument(long COD_DOC, String newDOC_CSG_RCR);

    public void removeDocument(long COD_DOC);

    // Luogo Fisico
    public void addLuogoFisico(long lCOD_LUO_FSC);

    public void removeLuogoFisico(long lCOD_LUO_FSC);
}
