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

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
// BASE TABLE: ANA_CTL_SAN_TAB
//	 Home Intrface EJB obiekta
public interface ICartelleSanitarieHome extends EJBHome //abstract class ICartelleSanitarieHome extends  ICartelleSanitarie
{

    public ICartelleSanitarie create(
            java.sql.Date dDAT_CRE_CTL_SAN,
            String strNOM_MED_RSP_CTL_SAN,
            long lCOD_DPD,
            long lCOD_AZL) throws CreateException;

    public void remove(Object primaryKey);

    public ICartelleSanitarie findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public Collection getDocumentiCartelle_View(long FilterID);

    public Collection getProtocolliSanitari_View(long FilterID);

    public Collection getVisiteIdoneita_View(long FilterID);

    public Collection getVisiteMediche_View(long FilterID);

    public Collection getCTL_VST_IDO_View();

    public Collection getCTL_VST_MED_View();

    public Collection getCTL_VST_IDO_All_View(long lCOD_VST_IDO, long lCOD_AZL, long lCOD_DPD, long lCOD_CTL_SAN, java.sql.Date dtDATE_PIF_VST);

    public Collection getCTL_VST_MED_All_View(long lCOD_VST_MED, long lCOD_AZL, long lCOD_DPD, long lCOD_CTL_SAN, java.sql.Date dtDATE_PIF_VST);

    public Collection getCTL_SAN_All_View(long lCOD_AZL);
    //<report>

    public Collection getReportVisiteIdoneita_View(long FilterID);

    public Collection getReportVisiteMediche_View(long FilterID);
    //</report>

    public Collection findEx(
            long lCOD_AZL,
            java.sql.Date datDAT_CRE_CTL_SAN,
            String strNOM_MED_RSP_CTL_SAN,
            Long lCOD_DPD,
            int iOrderParameter /*not used for now*/);
}
