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
package com.apconsulting.luna.ejb.Azienda;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
//public interface  IAzienda extends EJBObject
public interface IAzienda extends EJBObject {
//   *Require Fields*
//1 COD_STA (Azienda ID)

    public long getCOD_AZL();
//2 RAG_SCL_AZL (name)

    public String getRAG_SCL_AZL();

    public void setRAG_SCL_AZL(String newRAG_SCL_AZL);
//3 DES_ATI_SVO_AZL (descr)

    public String getDES_ATI_SVO_AZL();

    public void setDES_ATI_SVO_AZL(String newDES_ATI_SVO_AZL);
//4 IDZ_AZL (address)

    public String getIDZ_AZL();

    public void setIDZ_AZL(String newIDZ_AZL);
//5 CIT_AZL (city)

    public String getCIT_AZL();

    public void setCIT_AZL(String newCIT_AZL);
//6 COD_STA (cod of natzionalita)

    public long getCOD_STA();

    public void setCOD_STA(long newCOD_STA);

//   *Not require Fields*
//7 CAG_AZL (categoria)
    public String getCAG_AZL();

    public void setCAG_AZL(String newCAG_AZL);
//8 COD_IST_TAT_AZL (cod ISAT)

    public String getCOD_IST_TAT_AZL();

    public void setCOD_IST_TAT_AZL(String newCOD_IST_TAT_AZL);
//9 NUM_CIC_AZL (n.Civico)

    public String getNUM_CIC_AZL();

    public void setNUM_CIC_AZL(String newNUM_CIC_AZL);
//10 PRV_AZL (provinzia)

    public String getPRV_AZL();

    public void setPRV_AZL(String newPRV_AZL);
//11 CAP_AZL (cap)

    public String getCAP_AZL();

    public void setCAP_AZL(String newCAP_AZL);
//12 QLF_RSP_AZL (qualifica)

    public String getQLF_RSP_AZL();

    public void setQLF_RSP_AZL(String newQLF_RSP_AZL);
//13 NOM_RSP_AZL (dattore di lavoro)

    public String getNOM_RSP_AZL();

    public void setNOM_RSP_AZL(String newNOM_RSP_AZL);
//14 NOM_RSP_SPP_AZL (responsable SPP)

    public String getNOM_RSP_SPP_AZL();

    public void setNOM_RSP_SPP_AZL(String newNOM_RSP_SPP_AZL);
//15 NOM_MED_AZL (medico competente)

    public String getNOM_MED_AZL();

    public void setNOM_MED_AZL(String newNOM_MED_AZL);
//16 COD_AZL_ASC (azienda assozieta)

    public long getCOD_AZL_ASC();

    public void setCOD_AZL_ASC(long newCOD_AZL_ASC);
//17 IDZ_PSA_ELT_RSP_AZL (email)

    public String getIDZ_PSA_ELT_RSP_AZL();

    public void setIDZ_PSA_ELT_RSP_AZL(String newIDZ_PSA_ELT_RSP_AZL);
//18 SIT_AZL (site)

    public String getSIT_INT_AZL();

    public void setSIT_INT_AZL(String newSIT_INT_AZL);
//19 MOD_CLC_RSO (Modalità di calcolo del rischio)

    public short getMOD_CLC_RSO();

    public void setMOD_CLC_RSO(short newMOD_CLC_RSO);

    public String  getCOD_FIS_AZL();

    public void setCOD_FIS_AZL(String newCOD_FIS_AZL);

    public String  getPAR_IVA_AZL();

    public void setPAR_IVA_AZL(String newPAR_IVA_AZL);


}
