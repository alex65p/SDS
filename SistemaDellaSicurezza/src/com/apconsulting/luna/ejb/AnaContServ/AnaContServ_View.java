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
package com.apconsulting.luna.ejb.AnaContServ;

/**
 *
 * @author Dario
 */

/* - - - - - Classe per la costruzione della View e per il bottone SEARCH*/

public class AnaContServ_View implements java.io.Serializable {

    public String PRO_CON,  DES_CON,  RIF_CON,  ORA_LAV;
    public String LAV_NOT;
    public String RAG_SCL_DTE;
    public java.sql.Date DAT_INI_LAV,  DAT_FIN_LAV;
    public int NUM_LAV_PRE;
    public long COD_SRV,  COD_UNI_ORG,  APP_COD_DTE;
}
