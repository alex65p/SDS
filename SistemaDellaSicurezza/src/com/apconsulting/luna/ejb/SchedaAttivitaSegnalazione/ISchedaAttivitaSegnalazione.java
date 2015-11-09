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
package com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface ISchedaAttivitaSegnalazione extends EJBObject {

    public long getCOD_SCH_ATI_MNT();

    public long getCOD_MNT_MAC();

    public void setCOD_MNT_MAC(long lCOD_MNT_MAC);

    public long getCOD_MAC();

    public void setCOD_MAC(long lCOD_MAC);

    public long getCOD_DPD();

    public void setCOD_DPD(long lCOD_DPD);

    public String getATI_SVO();

    public void setATI_SVO(String strATI_SVO);

    public java.sql.Date getDAT_ATI_MNT();

    public void setDAT_ATI_MNT(java.sql.Date dtDAT_ATI_MNT);

    public String getESI_ATI_MNT();

    public void setESI_ATI_MNT(String strESI_ATI_MNT);

    public String getPBM_ATI_MNT();

    public void setPBM_ATI_MNT(String strPBM_ATI_MNT);

    public java.sql.Date getDAT_PIF_INR();

    public void setDAT_PIF_INR(java.sql.Date dtDAT_PIF_INR);

    public String getTPL_ATI();

    public void setTPL_ATI(String strTPL_ATI);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    //-----------------------------
    // Link Table DOC_SCH_ATI_MNT_TAB
    // COD_DOC 
    public void addCOD_DOC(long newCOD_DOC);

    public void removeCOD_DOC(long newCOD_DOC);
}
