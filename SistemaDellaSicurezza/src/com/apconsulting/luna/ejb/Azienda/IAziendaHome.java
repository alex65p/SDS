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
package com.apconsulting.luna.ejb.Azienda;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
//public interface IAziendaHome extends EJBHome
public interface IAziendaHome extends EJBHome {

    public IAzienda create(
            String strRAG_SCL_AZL,
            String strDES_ATI_SVO_AZL,
            String strIDZ_AZL,
            String strCIT_AZL,
            long lCOD_STA,
            short sMOD_CLC_RSO) throws CreateException;

    public void remove(Object primaryKey);

    public IAzienda findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
// opredelenie view metodov classa

    public Collection getAzienda_Name_Address_View();

    public Collection getAzienda_Name_Address_View(java.util.ArrayList WHE_IN_AZL);
// list of Aziendas names besides pointed AZL_ID

    public Collection getAzienda_Name_BesidesID_View(long BesidesID);

    public Collection getAzienda_Name_ByID_View(java.util.ArrayList AZLs);

//--- ydalenie aziendi+svaz s concultant
    public void deleteAzienda(long newCOD_AZL, long newCOD_COU);

    public Collection findEx(java.util.ArrayList WHE_IN_AZL, String CAG_AZL, String DES_ATI_SVO_AZL, String RAG_SCL_AZL, String IDZ_AZL, String NUM_CIC_AZL, String CIT_AZL, String PRV_AZL, String CAP_AZL, String QLF_RSP_AZL, String NOM_RSP_AZL, String NOM_RSP_SPP_AZL, String NOM_MED_AZL, Short MOD_CLC_RSO, String COD_FIS_AZL, String PAR_IVA_AZL);

    public boolean CheckRischiExists(long lCOD_AZL);

    public long getAziendeCount();

    public Collection getAzienda_SAP_S2S_View(long C_SOC, String C_ARE);

    // Metodo per aggiornare i campi NOM_RSP_AZL e NOM_RSP_SPP_AZL
    // nel caso in cui, dall'anagrafica dipendenti,
    // venga modificato il valore della Matricola, del Cognome o del Nome del Dipendente. (Bug 1.75)
    public void updateMtrCogNom_AZL(String strMTR_DPD_old, String strCOG_DPD_old, String strNOM_DPD_old, String strMTR_DPD, String strCOG_DPD, String strNOM_DPD);
}
