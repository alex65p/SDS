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

package com.apconsulting.luna.ejb.AssociazioneMansioniSAP_S2S;

import java.util.Date;

/**
 *
 * @author Alessandro
 */
public class Dipendenti_Mansioni_SAP_View implements java.io.Serializable{
    public long ID;
    public long COD_AZL_S2S;
    public long COD_DPD_S2S;
    public String COG_DPD;
    public String NOM_DPD;
    public String COD_UNI_ORG_SAP;
    public String COD_MAN_SAP;
    public String COD_POS_SAP;
    public String DES_UNI_ORG_SAP;
    public String DES_MAN_SAP;
    public String DES_POS_SAP;
    public Date COD_UNI_ORG_SAP_DAT_INI;
    public Date COD_UNI_ORG_SAP_DAT_FIN;
    public Date COD_MAN_SAP_DAT_INI;
    public Date COD_MAN_SAP_DAT_FIN;
    public Date COD_POS_SAP_DAT_INI;
    public Date COD_POS_SAP_DAT_FIN;
    public String DES_LUO_FSC_S2S;
}
