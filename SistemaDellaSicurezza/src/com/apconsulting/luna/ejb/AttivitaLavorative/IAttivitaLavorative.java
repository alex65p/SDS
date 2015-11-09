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
package com.apconsulting.luna.ejb.AttivitaLavorative;

import java.util.Collection;
import javax.ejb.EJBObject;
import java.util.ArrayList;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta 
//public interface  IAttivitaLavorative extends EJBObject
public interface IAttivitaLavorative extends EJBObject {
    //   *Require Fields*
    //1 COD_MAN (AttivitaLavorative ID)

    public long getCOD_MAN();
    //2 COD_AZL (cod of azienda)

    public long getCOD_AZL();
    //3 NOM_MAN (name)

    public String getNOM_MAN();

    public void setCOD_AZL__NOM_MAN(long newCOD_AZL, String newNOM_MAN);
    //   *Not require Fields*
    //4 DES_MAN (description)

    public String getDES_MAN();

    public void setDES_MAN(String newDES_MAN);
    //5 DES_RSP_COM (cod ISAT)

    public String getDES_RSP_COM();

    public void setDES_RSP_COM(String newDES_RSP_COM);
    //6 COD_MAN_RPO ()

    public long getCOD_MAN_RPO();

    public void setCOD_MAN_RPO(long newCOD_MAN_RPO);
    //7 IDX_RSO_CHI

    public void setIDX_RSO_CHI(double newIDX_RSO_CHI);

    public double getIDX_RSO_CHI();
    //8 

    public long getRSO_VAL();

    public void setRSO_VAL(long newRSO_VAL);

    //5 DES_RSP_COM (cod ISAT)

    public String getNOTE();

    public void setNOTE(String newNOTE);

    public Collection getRischiByAttivataLavorativaView(long lCOD_AZL);

    public Collection getVisteMediche_View();

    public Collection getAgentiChimici_View();

    public void addGEST_MAN_COR(long lCOD_COR, java.sql.Date dDAT_INZ);

    public void addGEST_MAN_DPI(long lCOD_TPL_DPI, java.sql.Date dDAT_INZ);

    public void addGEST_MAN_PRO_SAN(long lCOD_PRO_SAN, java.sql.Date dDAT_INZ);

    public void addGEST_MAN_OPE_SVO(long lCOD_OPE_SVO, java.sql.Date dDAT_INZ);

    /* Metodi per la gestione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * INIZIO
     */
    // INSERIMENTO ASSOCIAZIONE DIRETTA MULTIAZIENDA "CORSI / ATTIVITA' LAVORATIVA"
    public void addCOR_MAN_Ex(long lCOD_COR, java.sql.Date dDAT_INZ, ArrayList alAziende);

    // INSERIMENTO ASSOCIAZIONE DIRETTA MULTIAZIENDA "PROTOCOLLI SANITARI / ATTIVITA' LAVORATIVA"
    public void addPRO_SAN_MAN_Ex(long lCOD_PRO_SAN, java.sql.Date dDAT_INZ, ArrayList alAziende);

    // INSERIMENTO ASSOCIAZIONE DIRETTA MULTIAZIENDA "DPI / ATTIVITA' LAVORATIVA"
    public void addDPI_MAN_Ex(long lCOD_TPL_DPI, java.sql.Date dDAT_INZ, ArrayList alAziende);

    /* Metodi per la gestione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * FINE
     */

    /* Metodi per la cancellazione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * INIZIO
     */
    // ELIMINAZIONE ASSOCIAZIONE DIRETTA MULTIAZIENDA "CORSI / ATTIVITA' LAVORATIVA"
    public void deleteCOR_MAN_Ex(long lCOD_COR, ArrayList alAziende);

    // ELIMINAZIONE ASSOCIAZIONE DIRETTA MULTIAZIENDA "PROTOCOLLI SANITARI / ATTIVITA' LAVORATIVA"
    public void deletePRO_SAN_MAN_Ex(long lCOD_PRO_SAN, ArrayList alAziende);

    // ELIMINAZIONE ASSOCIAZIONE DIRETTA MULTIAZIENDA "DPI / ATTIVITA' LAVORATIVA"
    public void deleteDPI_MAN_Ex(long lCOD_TPL_DPI, ArrayList alAziende);

    /* Metodi per la cancellazione dell'associazione diretta di
    CORSI, DPI, PROTOCOLLI SANITARI
     * all'attività lavorativa
     * FINE
     */
    public Collection getOperazioniSvolte_View();

    public Collection getRischi_View(long lCOD_AZL);

    public Collection getCorsi_View();

    public Collection getAgentiChimici_View_Report();

    public Collection getProtocoliSanitari_View();

    public Collection getDPI_View();

    public Collection getDPI_ViewEx();

    public Collection getRischioChimico_View();

    public Collection getDocumenti_View();

    public Collection getMacchina_View();

    public String getDescRischio(double idx);
    //

    public Collection getReportDocumenti_View();

    public Collection getMisurePreventiveView(long lCOD_RSO);
    //
   /*<comment date="12/02/2004" author="Roman Chumachenko">
    <description>Adding of add/remove methods</description>
    </comment>*/

    public void addOperazioneSvolte(long COD_OPE_SVO, long COD_AZL);

    public void removeOperazioneSvolte(long COD_OPE_SVO, long COD_AZL);
    // --- adding of external associations ---

    public String addExRischi(String[] CODS_OF_RSO, long COD_AZL);

    public String addExCorsi(String[] CODS_OF_COR, long COD_AZL);

    public String addExProtocoli(String[] CODS_OF_PSA, long COD_AZL);

    public String addExDPI(String[] CODS_OF_DPI, long COD_AZL);
    //

    public void addXRischioAssociations(long COD_RSO, long COD_AZL);

    public void addDocumenti(long COD_DOC);
    
    public void addAGENTECHIMICO(long COD_SOS_CHI);

    public void addCOD_MAC(long newCOD_MAC);

    public void deleteXRischioAssociations(long COD_RSO, long COD_AZL);
    //

    public void removeCorso(long lCOD_COR);

    public void removeProtocoloSanitario(long lCOD_PRO_SAN);

    public void removeDPI(long lCOD_TPL_DPI);

    public void removeDocumenti(long COD_DOC);

    public void removeAGENTECHIMICO(long COD_SOS_CHI);

    public void removeMacchina(long COD_MAC);

    // -- not associated records --
    public Collection getNotAssRischi_View(long lCOD_AZL);

    public Collection getNotAssCorsi_View();

    public Collection getNotAssProtocoli_View(long lCOD_AZL);

    public Collection getNotAssDPI_View(long lCOD_AZL);

    //--- multiAazienda mode ---
    public boolean isMultiple();

    public void store(
            String strNOM_MAN,
            String strDES_MAN,
            String strDES_RSP_COM,
            String strNOTE,
            long lCOD_MAN_RPO,
            long lRSO_VAL,
            java.util.ArrayList alAziende);
    //--------------------------
}
