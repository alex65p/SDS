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
package com.apconsulting.luna.ejb.ErogazioneCorsi;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IErogazioneCorsi extends EJBObject {
    //*Require Fields*
    //1

    public long getCOD_SCH_EGZ_COR();
    //2

    public void setCOD_COR(long newCOD_COR);

    public long getCOD_COR();
    //4

    public void setSTA_EGZ_COR(String newSTA_EGZ_COR);

    public String getSTA_EGZ_COR();
    //6

    public void setDAT_PIF_EGZ_COR(java.sql.Date newDAT_PIF_EGZ_COR);

    public java.sql.Date getDAT_PIF_EGZ_COR();
    //5

    public void setCOD_AZL(long newCOD_AZL);

    public long getCOD_AZL();
    //============================================
    // not required field
    //7

    public void setDAT_EFT_EGZ_COR(java.sql.Date newDAT_EFT_EGZ_COR);

    public java.sql.Date getDAT_EFT_EGZ_COR();
    //////////////////////////////////////

    public void removeCOR_DPD(long newCOD_COR, long newCOD_DPD, long newCOD_AZL, java.sql.Date newDAT_EFT_COR);

    public void removeISC_COR_DPD(long newCOD_SCH_EGZ_COR, long newCOD_DPD, long newCOD_AZL);

    public void addCOR_DPD(long newCOD_COR, long newCOD_DPD, long newCOD_AZL, java.sql.Date newDAT_EFT_COR);

    public void addISC_COR_DPD(long newCOD_SCH_EGZ_COR, long newCOD_DPD, long newCOD_AZL);

    // -- Reports ---
    //---------------------------
    public Collection getErogazioneForCorso_View();
}
