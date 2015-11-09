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
package com.apconsulting.luna.ejb.SchedeParagrafo;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
// Remote Intrface EJB obiekta
public interface ISchedeParagrafo extends EJBObject {
    //*Require Fields*
    //1

    public long getCOD_SCH_PRG();

    public void setCOD_PRG(long newCOD_PRG);

    public long getCOD_PRG();
    //4

    public void setTPL_SCH(String newTPL_SCH);

    public String getTPL_SCH();
    //============================================
    // not required field
    //5

    public void setCOD_MAC(long newCOD_MAC);

    public long getCOD_MAC();

    public void setCOD_UNI_ORG(long newCOD_UNI_ORG);

    public long getCOD_UNI_ORG();

    public void setCOD_UNI_SIC(long newCOD_UNI_SIC);

    public long getCOD_UNI_SIC();

    public void setCOD_SOS_CHI(long newCOD_SOS_CHI);

    public long getCOD_SOS_CHI();

    public void setCOD_MAN(long newCOD_MAN);

    public long getCOD_MAN();

    public void setCOD_LUO_FSC(long newCOD_LUO_FSC);

    public long getCOD_LUO_FSC();

    public void setCOD_FAT_RSO(long newCOD_FAT_RSO);

    public long getCOD_FAT_RSO();
    
    public void setCOD_IMM_3LV(long newCOD_IMM_3LV);

    public long getCOD_IMM_3LV();
    
    public void setCOD_PNO(long newCOD_PNO);

    public long getCOD_PNO();

    public void setCOD_MIS_PET(long newCOD_MIS_PET);

    public long getCOD_MIS_PET();

    public void setCOD_RSO(long newCOD_RSO);

    public long getCOD_RSO();

    public void setCOD_AZL(long newCOD_AZL);

    public long getCOD_AZL();

    public void setCOD_UNI_ORG_FK(long newCOD_FAT_RSO);
    
    public byte getSTL_IND();
    
    public void setSTL_IND(byte newSTL_IND);
}
