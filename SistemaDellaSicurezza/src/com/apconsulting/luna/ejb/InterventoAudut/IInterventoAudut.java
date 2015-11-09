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
package com.apconsulting.luna.ejb.InterventoAudut;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IInterventoAudut extends EJBObject {

    public long getCOD_INR_ADT();

    public String getDES_INR_ADT();

    public void setDES_INR_ADT(String strDES_INR_ADT);

    public java.sql.Date getDAT_PIF_INR();

    public void setDAT_PIF_INR(java.sql.Date dtDAT_PIF_INR);

    public long getNUM_VIS_ISP();

    public void setNUM_VIS_ISP(long lNUM_VIS_ISP);

    public java.sql.Date getDAT_ADT();

    public void setDAT_ADT(java.sql.Date dtDAT_ADT);

    public long getCOD_MIS_PET();

    public void setCOD_MIS_PET(long lCOD_MIS_PET);

    public long getCOD_PSD_ACD();

    public void setCOD_PSD_ACD(long lCOD_PSD_ACD);

    public long getCOD_LUO_FSC();

    public void setCOD_LUO_FSC(long lCOD_LUO_FSC);

    public long getCOD_DPD();

    public void setCOD_DPD(long lCOD_DPD);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    public String getSEC_PNO_YEA();

    public void setSEC_PNO_YEA(String strSEC_PNO_YEA);

    public long getPNG_TEO();

    public void setPNG_TEO(long lPNG_TEO);

    public long getPNG_RIL();

    public void setPNG_RIL(long lPNG_RIL);

    public long getPNG_PCT();

    public void setPNG_PCT(long lPNG_PCT);

    public long getCOD_UNI_ORG();

    public void setCOD_UNI_ORG(long lCOD_UNI_ORG);

    public long getCOD_MIS_RSO_LUO();

    public void setCOD_MIS_RSO_LUO(long lCOD_MIS_RSO_LUO);

    public long getCOD_MIS_PET_MAN();

    public void setCOD_MIS_PET_MAN(long lCOD_MIS_PET_MAN);

    //-<alex>
    public LavoratoreView getLavoratore(long lCOD_AZL);

    public ADT_PresidioView getPresidio();

    public Collection getNonConformita();

    public void deleteNonConformita(long lCOD_NON_CFO);
    //-</alex>
}
