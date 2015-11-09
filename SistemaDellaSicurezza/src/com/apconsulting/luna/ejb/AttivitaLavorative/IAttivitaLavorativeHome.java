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
import javax.ejb.CreateException;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta 
//public interface IAttivitaLavorativeHome extends EJBHome
public interface IAttivitaLavorativeHome extends IAttivitaLavorative {

    public IAttivitaLavorative create(
            long lCOD_AZL,
            String strNOM_MAN,
            String strDES_MAN,
            String strDES_RSP_COM,
            String strNOTE,
            long lCOD_MAN_RPO,
            long lRSO_VAL,
            java.util.ArrayList alAziende) throws CreateException;

    public void remove(Object primaryKey);

    public void remove(Object primaryKey, java.util.ArrayList alAziende);

    public IAttivitaLavorative findByPrimaryKey(AttivitaLavorativePK primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov
    //<report>

    public Collection getAttivitaLavorative_Name_ViewBySito(long COD_SIT_AZL);
    //</report>

    public Collection getAttivitaLavorative_Name_View();

    public Collection getAttivitaLavorative_Name_View(long AZL_ID);

    public Collection getAllAttivitaLavorative_Name_View();

    public Collection getAttivitaLavorative_AZL_Name_View(long AZL_ID, long UNI_ORG_ID);
    //<alex>

    public Collection getAttivitaLavorativaByDipendente_View(long lCOD_DPD);

    //GEST_MAN view by Pogrebnoy Yura
    public Collection getAGGIORNA_MANSIONE_COR_View(String strCOD_RSO, String strCOD_COR, long lCOD_AZL);

    public Collection getAGGIORNA_MANSIONE_DPI_View(String strCOD_RSO, String strCOD_TPL_DPI, long lCOD_AZL);

    public Collection getAGGIORNA_MANSIONE_PRO_SAN_View(String strCOD_RSO, String strCOD_PRO_SAN, long lCOD_AZL);

    public Collection getAGGIORNA_MANSIONE_MIS_PET_View(String strCOD_RSO, String strCOD_MIS_PET, long lCOD_AZL);
    
    public Collection getAGGIORNA_LUOGO_FISICO_MIS_PET_View(String strCOD_RSO, String strCOD_MIS_PET, long lCOD_AZL);

    public Collection getCARICA_MANSIONI_View(String strCOD_OPE_SVO, long lCOD_AZL);

    public Collection getGEST_MAN_LUO_View(String strCOD_RSO, String strCOD, String FuncType, long lCOD_AZL);

    public Collection findEx(
            long lCOD_AZL,
            String strNOM_MAN,
            String strDES_RSP_COM,
            String strNOTE,
            String strDES_MAN,
            int iOrderParameter /*not used for now*/);

    // -- FORM GEST_ATTIVITA --
    public Collection getAttLavListToOperSvolta_View(long lCOD_OPE_SVO, long COD_AZL);

    public long getCountAttivitaLavorativeByCOD_OPE_SVO(long COD_OPE_SVO, long lCOD_AZL);

    public Collection getAttivitaLavorativa_CRM_MAN_View(String strNOM, long COD_AZL);

    public boolean caricaRpMansioni(long P_COD_AZL, String P_NOM_MAN);

    public boolean Carica_db_mansioni(long P_COD_AZL, long P_COD_MAN, java.sql.Date dtDAT);
    //
    //<alex date="07/04/2004">

    public String addRischioToSostanzeChimiche(long lCOD_AZL, long lCOD_SOS_CHI, long lCOD_RSO, String strTPL_CLF_RSO, java.util.ArrayList ID_AZIENDE, java.util.ArrayList ID_MAN, java.util.ArrayList ID_LUO);

    public String addRischioToMacchina(long lCOD_AZL, long lCOD_MAC, long lCOD_RSO, String strTPL_CLF_RSO, java.util.ArrayList ID_AZIENDE, java.util.ArrayList ID_MAN, java.util.ArrayList ID_LUO);
    //<alex date="13/04/2004">

    public String addMacchinaToOperazioneSvolta(long lCOD_AZL, long lCOD_MAC, long lCOD_OPE_SVO, java.util.ArrayList AZIENDA_ID, java.util.ArrayList ID_MAN);

    public String addSostanzaToOperazioneSvolta(long lCOD_AZL, long lCOD_SOS_CHI, long lCOD_OPE_SVO, java.util.ArrayList AZIENDA_ID, java.util.ArrayList col_lCOD_MAN);
    //</alex>
    //<romas date="13/04/2004">
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	 /*	*date:06/04/2004 *author:Roman Chumachenko
    Adding of Risc Assotiation to Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXaddAssociationOfRiscToOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_MAN,
            long lCOD_AZL,
            long lCOD_RSO,
            java.util.ArrayList COD_MAN_LIST,
            java.util.ArrayList COD_AZL_LIST);
    /*	*date:07/04/2004 *author:Roman Chumachenko
    Adding of Operaziona Svolta to Attivita Lavorativa with parameters (EX-ed mode)
     */

    public String EXaddAssociationOfOpSvoltaToAttLavorativa(
            long lCOD_MAN,
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST);
    /*	*date:08/04/2004 *author:Roman Chumachenko
    Deleting of Risk from Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfRiscFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_RSO,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST);
    /*	*date:09/04/2004 *author:Roman Chumachenko
    Deleting of Operaziona Svolta from Attivita Lavorativa with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfOpSvoltaFromAttLavorativa(
            long lCOD_OPE_SVO,
            long lCOD_AZL,
            long lCOD_MAN,
            java.util.ArrayList COD_AZL_LIST);
    /*	*date:09/04/2004 *author:Roman Chumachenko
    Deleting of Macchina Attr from Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfMacchinaFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_MAC,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST);
    /*	*date:09/04/2004 *author:Roman Chumachenko
    Deleting of Agente Chimico from Operaziona Svolta with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfAgenteFromOperazionaSvolta(
            long lCOD_OPE_SVO,
            long lCOD_SOS_CHI,
            long lCOD_AZL,
            java.util.ArrayList COD_AZL_LIST);

    /*	*date:13/04/2004 *author:Roman Chumachenko
    Deleting of Rischio from Macchina Attr. with parameters (EX-ed mode)
     */
    public String EXdeleteAssociationOfRiscFromMacchina(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_MAC,
            java.util.ArrayList COD_AZL_LIST);
    /*	*date:13/04/2004 *author:Roman Chumachenko
    Deleting of Rischio from Agente Chimico with parameters (EX-ed mode)
     */

    public String EXdeleteAssociationOfRiscFromAgente(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_SOS_CHI,
            java.util.ArrayList COD_AZL_LIST);
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    //</romas>
}
