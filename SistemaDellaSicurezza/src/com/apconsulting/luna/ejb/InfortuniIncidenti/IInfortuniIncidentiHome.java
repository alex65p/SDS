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
package com.apconsulting.luna.ejb.InfortuniIncidenti;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface IInfortuniIncidentiHome extends EJBHome {

    public long getCOD_INO();

    public IInfortuniIncidenti create(long lCOD_AGE_MAT, long lCOD_TPL_FRM_INO, long lCOD_NAT_LES, long lCOD_SED_LES, long lCOD_LUO_FSC, long lCOD_DPD, long lCOD_AZL) throws CreateException;

    public IInfortuniIncidenti findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getInfortuniIncidenti_View(long lCOD_AZL);
    //<report>

    public SchedaInfortunioIncidenteView getSchedaInfortunioIncidenteView(long lCOD_AZL, long lCOD_INO);

    public Collection getElencoInfortuniIncidentiView(long lCOD_AZL, String strDAT_DAL, String strDAT_AL);

    public Collection findEx(long lCOD_AZL, long COD_LUO_FSC, long COD_DPD, long COD_NAT_LES, long COD_AGE_MAT, long COD_TPL_FRM_INO, long COD_SED_LES);

    public Collection getInfortuniIncidentiDipendenteView(long COD_DPD, long COD_AZL, String DAT_EVE_INO, long COD_INO, long COD_INO_REL);

    public Collection getDocumenti_View(long lCOD_INO, long lCOD_AZL);
}
