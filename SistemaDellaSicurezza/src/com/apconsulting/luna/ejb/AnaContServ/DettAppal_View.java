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

/* DET_APL: - - - Classe per la costruzione della View e per il bottone SEARCH*/
public class DettAppal_View implements java.io.Serializable {

    public long COD_SRV,  APP_COD_DTE;
    public String PRO_CON,  DES_CON;
    public String RAG_SCL_DTE,  IDZ_DTE;
    public String APP_TEL,  APP_FAX,  APP_EMAIL;
    public String APP_RES_NOM,  APP_RES_QUA,  APP_RES_TEL;
    public String APP_INT_ASS_DES,  APP_INT_ASS_ORA_LAV,  APP_INT_ASS_CON_DES;
    public java.sql.Date DAT_INI_LAV,  DAT_FIN_LAV;
    public int APP_INT_ASS_COD_CON;
}
