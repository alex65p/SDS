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
package com.apconsulting.luna.ejb.AnagrDocumento;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
//public interface IAnagrDocumentoHome extends EJBHome
public interface IAnagrDocumentoHome extends EJBHome {

    public IAnagrDocumento create(
            String strRSP_DOC,
            String strAPV_DOC,
            String strEMS_DOC,
            String strNUM_DOC,
            long lEDI_DOC,
            String strREV_DOC,
            java.sql.Date dtDAT_REV_DOC,
            long lMES_REV_DOC,
            String strTIT_DOC,
            long lCOD_CAG_DOC,
            long lCOD_TPL_DOC) throws CreateException;

    public void remove(Object primaryKey);

    public IAnagrDocumento findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
// opredelenie view metodov classa
// list of AnagrDocumento by AZL_ID
//public Collection getAnagrDocumento_ByAZLID_View(long AZL_ID);

// list for tab of DOC_CSG_DTE (ANA_DTE Form)
    public Collection getAnagrDocumento_TIT_DOC_ByAZLID_View(long AZL_ID);

    public Collection getView(long AZL_ID); // AnagrDocumento_View

    public Collection getAnagraficaDocumente_View(String COD_FAT_RSO);//by Pogrebnoy Yura
//by Juli (View dlya SCH_DOC)

    public Collection getAnagrDocumento_to_SCH_DOC_View(long lCOD_AZL, String strTPL_DOC, String strCAG_DOC, String strTIT_DOC, String strRSP_DOC, String strREV_DOC, java.sql.Date dDAT_REV_D, java.sql.Date dDAT_REV_A, String strRAGGRUPPATI, String strSORT_DAT_REV, String strSORT_TPL_DOC);

    // Metodo per aggiornare i campi RSP_DOC, APV_DOC e EMS_DOC
    // nel caso in cui, dall'anagrafica dipendenti,
    // venga modificato il valore della Matricola, del Cognome o del Nome del Dipendente. (Bug 1.75)
    public void updateMtrCogNom_DOC(String strMTR_DPD_old, String strCOG_DPD_old, String strNOM_DPD_old, String strMTR_DPD, String strCOG_DPD, String strNOM_DPD);

//--- mary - 19/02/2004
    public byte[] downloadFileU(String strNOM_TAB, long lCOD_DOC);
// Inizio modifica gestione link esterno documenti

    public byte[] downloadFileULink(String strNOM_TAB, long lCOD_DOC);
// Fine modifica gestione link esterno documenti

    public void uploadFileU(String strNOM_TAB, long lCOD_DOC, String strFileName, String strContentType, byte[] content);
// Inizio modifica gestione link esterno documenti

    public void uploadFileULink(String strNOM_TAB, long lCOD_DOC, String strFileName, String strContentType, byte[] content);
// Fine modifica gestione link esterno documenti

    public void deleteFileU(String strNOM_TAB, long lCOD_DOC);
// Inizio modifica gestione link esterno documenti

    public void deleteFileULink(String strNOM_TAB, long lCOD_DOC);
// Fine modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfoU(String strNOM_TAB, long lCOD_DOC);
// Inizio modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfoULink(String strNOM_TAB, long lCOD_DOC);
// Fine modifica gestione link esterno documenti

//<search>
    public Collection findEx(long AZL_ID,
            String RSP_DOC, String EMS_DOC, String NUM_DOC,
            Long EDI_DOC, java.sql.Date DAT_REV_DOC, Long MES_REV_DOC,
            String TIT_DOC, Long COD_CAG_DOC,
            Long COD_TPL_DOC, java.sql.Date DAT_FUT_REV_DOC,
            String PRG_RIF_DOC, String PGN_RIF_DOC,
            Long COD_LUO_FSC, String NOT_LUO_CON,
            Long PER_CON_YEA,
            int iOrderBy);
//</search>
}
