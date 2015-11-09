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
package com.apconsulting.luna.ejb.DipendenteCorsi;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IDipendenteCorsiHome extends EJBHome {

    public IDipendenteCorsi create(String strNOM_COR) throws CreateException;

    public void remove(Object primaryKey);

    public IDipendenteCorsi findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public Collection getDipendente_View(long lCOD_AZL, long lCOD_COR, java.sql.Date dDATE, long lCOD_SCH_EGZ_COR);

    public void addCOR_DPD_ISC(long lCOD_DPD, long lCOD_SCH_EGZ_COR, long lCOD_AZL);

    public Collection getDipendenteCorsi_View(long lCOD_DPD);
    public Collection getDipendenteCorsi_View(long lCOD_DPD, String columnOrdered, String orderType);

    public Collection getDipendentiCorsi(long lCOD_COR, long lCOD_AZL, long lCOD_DPD, java.sql.Date DAT_EFT_COR);
}
