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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.AzioniCorrectivePreventive;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IAzioniCorrectivePreventive extends EJBObject {

    public long getCOD_AZN_CRR_PET();

    public long getCOD_INR_ADT();

    public void setCOD_INR_ADT(long lCOD_INR_ADT);

    public String getDES_AZN_RCH();

    public void setDES_AZN_RCH(String strDES_AZN_RCH);

    public String getRCH_AZN_CRR_PET();

    public void setRCH_AZN_CRR_PET(String strRCH_AZN_CRR_PET);

    public java.sql.Date getDAT_RCH();

    public void setDAT_RCH(java.sql.Date dtDAT_RCH);

    public String getTPL_ATT();

    public void setTPL_ATT(String strTPL_ATT);

    public String getMTZ_ATT();

    public void setMTZ_ATT(String strMTZ_ATT);

    public String getDES_AZN_CRR_PET();

    public void setDES_AZN_CRR_PET(String strDES_AZN_CRR_PET);

    public String getTPL_AZN();

    public void setTPL_AZN(String strTPL_AZN);

    public String getMTZ_AZN();

    public void setMTZ_AZN(String strMTZ_AZN);

    public java.sql.Date getDAT_AZN();

    public void setDAT_AZN(java.sql.Date dtDAT_AZN);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    //--------------------------------------------------------
    public String getInterventiAuditDesc();

    //--------------------------------------------------------
    public void addDOC_GEST_AZN_CRR_PET(long lCOD_DOC);

    public void removeDOC_GEST_AZN_CRR_PET(String strCOD_DOC);
	//--------------------------------------------------------
    // -- Report --
    public Collection getDocumenti_List_View();
}
