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
package com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface ISchedaAttivitaSegnalazioneHome extends EJBHome {

    public ISchedaAttivitaSegnalazione create(
            long lCOD_MNT_MAC,
            long lCOD_MAC,
            long lCOD_DPD,
            java.sql.Date dtDAT_PIF_INR,
            String strTPL_ATI,
            long lCOD_AZL) throws CreateException;

    public ISchedaAttivitaSegnalazione findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getDocuments__View(long COD_SCH_ATI_MNT);

    public Collection getMacchina_for_SCHMAC_View(long lCOD_AZL, String strSCH_MAC, String strSTA_INT, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_ATI_MNT_DAL, java.sql.Date dDAT_ATI_MNT_AL, String RG_GROUP, long NB_COD_MAC, long NB_COD_DPD, String NB_ATI_SVO, String strTYPE);
}
