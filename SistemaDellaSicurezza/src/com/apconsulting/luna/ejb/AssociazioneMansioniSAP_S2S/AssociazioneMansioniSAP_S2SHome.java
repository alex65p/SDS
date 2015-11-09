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

import java.util.Collection;
import javax.ejb.EJBHome;

/**
 *
 * @author Alessandro
 */
public interface AssociazioneMansioniSAP_S2SHome extends EJBHome {
// Metodi bean (Create, FindAll, Remove, ecc.)

// Metodi di business
    public Collection getUO_Mansioni_S2S_View(long COD_AZL);
    public Collection getDipendenti_Mansioni_SAP_View(long COD_AZL);
    public long getDipendenti_Mansioni_SAP_Count(long COD_AZL);
    public int AggiornaAssociazioneSAP_S2S(long ID, long COD_UNI_ORG, long COD_MAN);
}

