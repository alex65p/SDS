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
package com.apconsulting.luna.ejb.Sopraluogo;

/**
 *
 * @author Dario
 */
public class findEx_sop implements java.io.Serializable {
    public String NUM_SOP;
    public long COD_AZL,COD_SOP,COD_PRO,COD_OPE,COD_CAN;
    public short ESITO;
    public String NOME_PRO,NOME_OPE,NOME_CAN,DIS_GEN;
    public java.sql.Date DAT_SOP,DAT_FER_LAV,DAT_RIP_LAV;
    public java.sql.Time ORA_INI,ORA_FIN;
    public Integer iTipo;
}
