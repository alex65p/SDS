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
package com.apconsulting.luna.ejb.CartelleSanitarie;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
// BASE TABLE: ANA_CTL_SAN_TAB
//	 Remote Intrface EJB obiekta
public interface ICartelleSanitarie extends EJBObject //abstract class ICartelleSanitarie extends BMPEntityBean
{
    // COD_CTL_SAN

    public long getCOD_CTL_SAN();

    public void setCOD_CTL_SAN(long newCOD_CTL_SAN);

    // DAT_CRE_CTL_SAN
    public java.sql.Date getDAT_CRE_CTL_SAN();

    public void setDAT_CRE_CTL_SAN(java.sql.Date newDAT_CRE_CTL_SAN);

    // NOM_MED_RSP_CTL_SAN
    public String getNOM_MED_RSP_CTL_SAN();

    public void setNOM_MED_RSP_CTL_SAN(String newNOM_MED_RSP_CTL_SAN);

    // COD_DPD
    public long getCOD_DPD();

    public void setCOD_DPD(long newCOD_DPD);

    // COD_AZL
    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);

    public void addCOD_DOC(long newCOD_DOC);

    public void addCOD_PRO_SAN(long newCOD_PRO_SAN);

    public void addCOD_VST_IDO(long newCOD_VST_IDO, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newIDO_VST, String newNOT_VST_IDO);

    public void editCOD_VST_IDO(long oldCOD_VST_IDO, long newCOD_VST_IDO, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newIDO_VST, String newNOT_VST_IDO, java.sql.Date oldDAT_PIF_VST);

    public void addCOD_VST_MED(long newCOD_VST_MED, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newNOT_VST_MED);

    public void editCOD_VST_MED(long oldCOD_VST_MED, long newCOD_VST_MED, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newNOT_VST_MED, java.sql.Date oldDAT_PIF_VST);

    public void removeCOD_DOC(long newCOD_DOC);

    public void removeCOD_PRO_SAN(long newCOD_PRO_SAN);

    public void removeCOD_VST_IDO(long newCOD_VST_IDO, long COD_DPD, long COD_CTL_SAN, long COD_AZL, java.sql.Date DATA_PIF_VST_IDO);

    public void removeCOD_VST_MED(long newCOD_VST_MED, long COD_DPD, long COD_CTL_SAN, long COD_AZL, java.sql.Date DATA_PIF_VST_MED);
}
