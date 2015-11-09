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

/**
 *
 * @author Dario
 */
public class SchedeParagrafo_ByPRG_View implements java.io.Serializable {

    public long 
            COD_SCH_PRG,  
            COD_MAC,  
            COD_UNI_ORG,  
            COD_UNI_SIC,  
            COD_SOS_CHI,  
            COD_MAN,  
            COD_LUO_FSC,  
            COD_FAT_RSO, 
            COD_IMM_3LV,
            COD_PNO,
            COD_MIS_PET,
            COD_RSO,
            COD_AZL;
    public byte 
            STL_IND;
}
