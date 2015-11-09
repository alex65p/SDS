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
package com.apconsulting.luna.ejb.CategoriePreside;

import java.rmi.RemoteException;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta 
//public interface ICategoriePresideHome extends EJBHome
public interface ICategoriePresideHome extends EJBHome {

    public ICategoriePreside create(String strNOM_CAG_PSD_ACD) throws RemoteException, CreateException;

    public void removeCOD_RST(long newCOD_DPD, long newCOD_AZL, long newCOD_CAG_PSD_ACD);

    public void addCOD_RST(long newCOD_DPD, long newCOD_AZL, long newCOD_CAG_PSD_ACD);

    public void remove(Object primaryKey);

    public ICategoriePreside findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;

    public Collection findAll() throws RemoteException, FinderException;
    // opredelenie view metodov

    public Collection getCategoriePreside_Categoria_RagSoc_View();

    public Collection getResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD);

    public Collection getResronsabiliti__View(long FOR_AZL_ID, long FOR_COD_CAG_PSD_ACD, long FOR_COD_DPD);
//<report>

    public Collection getCategoriePresidiView(long lCOD_CAG_PSD_ACD);

    public Collection getPresidiByCategoriaView(long lCOD_CAG_PSD_ACD, long lCOD_PSD_ACD);

    public Collection getInterventoByPresidiView(long lCOD_PSD_ACD);
    //

    public Collection getCAG_Lov(long lCOD_AZL, String strNOM_CAG_PSD_ACD);

    public Collection findEx(
            String strNOM_CAG_PSD_ACD,
            String strDES_CAG_PSD_ACD,
            Long lPER_MES_SST,
            Long lPER_MES_MNT,
            int iOrderParameter //not used for now
            );
}
