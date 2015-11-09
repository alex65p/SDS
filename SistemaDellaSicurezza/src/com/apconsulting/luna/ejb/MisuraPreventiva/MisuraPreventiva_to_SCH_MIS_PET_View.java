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
package com.apconsulting.luna.ejb.MisuraPreventiva;

/**
 *
 * @author Dario
 */
public class MisuraPreventiva_to_SCH_MIS_PET_View implements java.io.Serializable {

    public long COD_MIS_PET,  COD_AZL,  COD_MIS_RSO_LUO,  COD_RSO_LUO_FSC,  COD_LUO_FSC,  COD_MIS_PET_MAN,  COD_RSO_MAN,  COD_MAN;
    public String NOM_MIS_PET,  DES_TPL_MIS_PET,  RAG_SCL_AZL;
    public java.sql.Date DAT_CMP,  DAT_PNZ_MIS_PET;
}
