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
package com.apconsulting.luna.ejb.RischioFattore;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IRischioFattoreHome extends EJBHome {

    public IRischioFattore create(String strNOM_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO) throws CreateException;

    public IRischioFattore findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getComboView();

    public Collection getFattoreRischio_View();
    //by artur

    public Collection getReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_OPE_SVO, long lCOD_FAT_RSO);

    public Collection getReport_RischioFattore_RischioView(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO);

    public Collection getReport_RischioFattore_ComboView(long lCOD_AZL, long lCOD_MAN, long lCOD_OPE_SVO);

    public Collection getReport_RischioFattore_ComboView_CAG_FAT_RSO(long lCOD_AZL, long lCOD_MAN, long lCOD_CAG_FAT_RSO);

    public Collection getComboView(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO);

    public Collection getReport_RischioFattore_RischioView_UO(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_FAT_RSO);
    //<alex "19/03/2004">

    public Collection getFattoriWithoutRischiView(long lCOD_AZL, long lCOD_MAN);

    public Collection getFattoriWithRischi4Categoria(long lCOD_CAG_FAT_RSO, long lCOD_AZL);
            
    public void deleteFattoriRischiByAttivita(long lCOD_AZL, long lCOD_MAN);

    public void addFattoreRischioPerAttivita(long lCOD_AZL, long lCOD_MAN, long lCOD_FAT_RSO);
    //</alex>
    //<artur "19/03/2004">

    public Collection getFattoriUWithoutRischiView(long lCOD_AZL, long lCOD_UNI_ORG);

    public void deleteFattoriRischiByUnita(long lCOD_AZL, long lCOD_UNI_ORG);

    public void addFattoreRischioPerUnita(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_FAT_RSO);
    //</artur>

    //<Pogrebnoy Yura "27/03/2004">
    public Collection findEx(String strNOM_FAT_RSO, String strDES_FAT_RSO, long lNUM_FAT_RSO, long lCOD_CAG_FAT_RSO, long lCOD_NOR_SEN, int iOrderParameter);
}
