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
package com.apconsulting.luna.ejb.AssociativaAgentoChimico;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
// Home Intrface EJB obiekta
public interface IAssociativaAgentoChimicoHome extends EJBHome {

    public IAssociativaAgentoChimico create(
            String strDES_SOS,
            String strNOM_COM_SOS,
            long lCOD_STA_FSC,
            long lCOD_CLF_SOS,
            long lCOD_PTA_FSC,
            String sTIP_RSO) throws CreateException;

    public IAssociativaAgentoChimico findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);
    // opredelenie view metodov

    public Collection getAssAgentiChimichi_View();

    public Collection getRischi_View(long lCOD_SOS_CHI, long lCOD_AZL);

    public Collection getLuoghiFisici_View(long lCOD_SOS_CHI, long lCOD_AZL);

    public Collection getFrasiR_View(long lCOD_SOS_CHI);

    public Collection getFrasiS_View(long lCOD_SOS_CHI);

    public Collection getDocumenti_View(long lCOD_SOS_CHI);

    public Collection getNormSent_View(long lCOD_SOS_CHI);

    public Collection getProprietaChimicoFisiche_View();

    public Collection getSOS_CHI_View();

    public Collection getSOS_CHI_LUO_FSC_View(long COD_SOS_CHI, long COD_LUO_FSC);

    public Collection getSOS_CHI_LUO_FSC_View();

    public Collection getSOS_CHI_LUO_FSC_TPL_QTA_View();
    //<alex date="01/04/2004">

    public Collection getCARICA_LUOGHI_FISICI_View(long lCOD_SOS_CHI, long lCOD_AZL);

    public Collection getCARICA_ATTIVITA_View(long lCOD_SOS_CHI, long lCOD_AZL);

    public int getCountAttivitaForSostanza(long lCOD_SOS_CHI, long lCOD_AZL);

    public int getCountLuoghiForSostanza(long lCOD_SOS_CHI, long lCOD_AZL);
    //</alex>
    //<report>

    public Collection getReportRischi_View(long lCOD_AZL, long lCOD_SOS_CHI);
    //</report>

    public void addSostanzeRischiToOperazione(long lCOD_OPE_SVO, long lCOD_SOS_CHI, long lCOD_AZL);

    public Collection getRischioSostanza_View(long lCOD_SOS_CHI);
    //--------Kushkarov for Search

    public Collection findEx(String NOM_COM_SOS, String DES_SOS, long COD_STA_FSC, long COD_CLF_SOS, int iOrder);

    //--- mary for search
    public Collection findEx(
            String strNOM_COM_SOS,
            String strDES_SOS,
            String strSIM_RIS,
            Long lCOD_STA_FSC,
            Long lCOD_SIM,
            Long lCOD_CLF_SOS,
            int iOrderParameter //not used for now
            );
}
