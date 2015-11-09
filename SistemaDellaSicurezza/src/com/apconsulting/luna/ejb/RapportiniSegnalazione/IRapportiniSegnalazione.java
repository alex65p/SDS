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
package com.apconsulting.luna.ejb.RapportiniSegnalazione;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IRapportiniSegnalazione extends EJBObject {

    public long getCOD_SGZ();

    public String getDES_SGZ();

    public void setDES_SGZ(String strDES_SGZ);

    public java.sql.Date getDAT_SGZ();

    public void setDAT_SGZ(java.sql.Date dtDAT_SGZ);

    public long getNUM_SGZ();

    public void setNUM_SGZ(long lNUM_SGZ);

    public long getVER_SGZ();

    public void setVER_SGZ(long lVER_SGZ);

    public String getTIT_SGZ();

    public void setTIT_SGZ(String strTIT_SGZ);

    public String getSTA_SGZ();

    public void setSTA_SGZ(String strSTA_SGZ);

    public String getURG_SGZ();

    public void setURG_SGZ(String strURG_SGZ);

    public String getDES_ATI_SGZ();

    public void setDES_ATI_SGZ(String strDES_ATI_SGZ);

    public String getSTA_FIE_SGZ();

    public void setSTA_FIE_SGZ(String strSTA_FIE_SGZ);

    public java.sql.Date getDAT_FIE();

    public void setDAT_FIE(java.sql.Date dtDAT_FIE);

    public String getNOM_RIL_SGZ();

    public void setNOM_RIL_SGZ(String strNOM_RIL_SGZ);

    public long getCOD_IMM();

    public void setCOD_IMM(long lCOD_IMM);

    public long getCOD_LUO_FSC();

    public void setCOD_LUO_FSC(long lCOD_LUO_FSC);
            
    public long getCOD_DPD();

    public void setCOD_DPD(long lCOD_DPD);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    public void setVER_SGZ__TIT_SGZ(long lVER_SGZ, String strTIT_SGZ);
    
    public void addRischio(long COD_RSO);
    public void removeRischio(long COD_RSO);
}
