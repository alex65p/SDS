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
package com.apconsulting.luna.ejb.Fornitore;

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
//public interface IFornitoreHome extends EJBHome
public interface IFornitoreHome extends EJBHome {

    public IFornitore create(
            String RAG_SOC_FOR_AZL,
            String CAG_FOR,
            String IDZ_FOR,
            String CIT_FOR,
            String QLF_RSP_FOR,
            String NOM_RSP_FOR,
            long COD_AZL,
            long COD_STA) throws RemoteException, CreateException;

    public void remove(Object primaryKey);

    public IFornitore findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;

    public Collection findAll() throws RemoteException, FinderException;
    // opredelenie view metodov

    public Collection getFornitore_Categoria_RagSoc_View(long AZL_ID);

    public Collection getChimicalAgentoByFORAZLID_View(long FOR_AZL_ID);

    public Collection getMacchinaByFORAZLID_View(long FOR_AZL_ID);

    public Collection findEx(
            long lCOD_AZL,
            String strRAG_SOC_FOR_AZL,
            String strCAG_FOR,
            String strIDZ_FOR,
            String strNUM_CIC_FOR,
            String strCIT_FOR,
            String strPRV_FOR,
            String strCAP_FOR,
            String strQLF_RSP_FOR,
            String strNOM_RSP_FOR,
            String strIDZ_PSA_ELT_RSP,
            String strSIT_INT_FOR,
            int iOrderParameter //not used for now
            );
}
