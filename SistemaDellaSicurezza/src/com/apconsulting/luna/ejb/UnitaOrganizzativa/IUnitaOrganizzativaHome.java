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
package com.apconsulting.luna.ejb.UnitaOrganizzativa;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IUnitaOrganizzativaHome extends EJBHome {

    public IUnitaOrganizzativa create(String strNOM_UNI_ORG, long lCOD_TPL_UNI_ORG, long lCOD_DPD, long lCOD_AZL) throws CreateException;

    public IUnitaOrganizzativa findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getComboView(long lCOD_AZL);

    public Collection getDvrComboView(long lCOD_AZL);

    public Collection getUnitaOrganizzativaView(long lCOD_AZL);

    public Collection findEx(String NOM, String DES, long iOrderBy);
//-------------------ALEX-------------------------------------

    public Collection getTopOfTree(long lCOD_AZL);

    public String buildTreeNodes(IUnitaOrganizzativa bean, IUnitaOrganizzativaHome home, long n, long COD_UNI_ORG,long lCOD_AZL,boolean build);
    public Collection getFirstUOWithEmail(long lCOD_UNI_ORG);
}
