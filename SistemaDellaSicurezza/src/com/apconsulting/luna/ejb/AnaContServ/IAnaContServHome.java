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
package com.apconsulting.luna.ejb.AnaContServ;

import java.rmi.RemoteException;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IAnaContServHome extends EJBHome {

    public IAnaContServ create(
            long lCOD_AZL,
            String strPRO_CON,
            long lAPP_COD_DTE) throws RemoteException, CreateException;

    public void remove(Object primaryKey);

    public IAnaContServ findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException;

    public Collection findAll() throws RemoteException, FinderException;

    /* - - - - - Collezioni per la costruzione delle comboBox del Form*/
    public Collection getCopiaDa_Form(long AZL_ID);//per la comboBox 'Copia da'
    public Collection getDesConOnProCon(long AZL_ID);//per la comboBox 'Nominativo' in DET_CMT
    public String getProConOnCodSrv(long AZL_ID, long SRV_ID);

    //public void deleteInfo(long SRV_ID);
    public void deleteDescFluidi(long SRV_ID);

    public void deleteDescCentriEmergenza(long SRV_ID);

    public void deleteDescServiziSanitari(long SRV_ID);

    public void deleteDescPrestitoMateriali(long SRV_ID);

    public void deleteDescProdottiSostanzeApp(long SRV_ID);

    public void deleteDescProdottiSostanzeSubApp(long SRV_ID);

    /* - - - - - Collezione per il bottone SEARCH del Form*/
    public Collection findEx_AnaContServ(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON,
            String strRIF_CON,
            long lCOD_UNI_ORG,
            java.sql.Date dtDAT_INI_LAV,
            java.sql.Date dtDAT_FIN_LAV,
            String strORA_LAV,
            String strLAV_NOT,
            int iNUM_LAV_PRE,
            long lAPP_COD_DTE,
            int iOrderParameter);

    /* - - - - - Collezione per il bottone SEARCH del Form*/
    public Collection findEx_DettComm(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON,
            long lCOM_COD_DPD,
            String strCOM_RES_TEL,
            int jOrderParameter);

    public Collection findEx_DettAppal(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON);

    // Determina, in base all'anno passato in input (nel formato yyyy) e 
    // per una data azienda, il primo numero progressivo disponibile 
    // per un contratto/servizio, 
    public String getProgressivoContratto(long lCOD_AZL, String strANNO);
}
