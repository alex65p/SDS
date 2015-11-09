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
package com.apconsulting.luna.ejb.CategorieFattoreRischio;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface ICategorioRischioHome extends EJBHome //public interface ICategorioRischioHome extends  ICategorioRischio
{

    public ICategorioRischio create(String strNOM_CAG_FAT_RSO) throws CreateException;

    public void remove(Object primaryKey);

    public ICategorioRischio findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov

    public Collection getCategorioRischio_Name_Address_View() throws FinderException;

    public Collection getCategorio_FattoriRischio_View(long COD_CAG_FAT_RSO) throws FinderException;

    public Collection findEx(String strNOM_CAG_RSO, int iOrderParameter /*not used for now*/);
    //<report>

    public Collection getCategorioRischio_LuogiFisici_View(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO);

    public Collection getCategorioRischio_Rischio_View(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_CAG_FAT_RSO);
    //</report>

    public Collection getCategorieWithRischi_View(long lCOD_AZL);
}
