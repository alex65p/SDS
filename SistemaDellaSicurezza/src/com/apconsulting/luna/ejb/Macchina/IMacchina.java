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
package com.apconsulting.luna.ejb.Macchina;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IMacchina extends EJBObject {
    //   *Require Fields*
    //1 COD_MAC (Macchina ID)

    public long getCOD_MAC();
    //2 IDE_MAC ()

    public String getIDE_MAC();

    public void setIDE_MAC__DES_MAC(String newIDE_MAC, String newDES_MAC);
    //3 DES_MAC (decription)

    public String getDES_MAC();
    //public void setDES_MAC(String newDES_MAC);
    //4 MDL_MAC ()

    public String getMDL_MAC();

    public void setMDL_MAC(String newMDL_MAC);
    //5 DIT_CST_MAC ()

    public String getDIT_CST_MAC();

    public void setDIT_CST_MAC(String newDIT_CST_MAC);
    //6 FBR_MAC ()

    public String getFBR_MAC();

    public void setFBR_MAC(String newFBR_MAC);
    //7 COD_TPL_MAC ()

    public long getCOD_TPL_MAC();

    public void setCOD_TPL_MAC(long newCOD_TPL_MAC);
    //8 COD_AZL ()

    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);
    //9   *Not require Fields*
    // YEA_CST_MAC ()

    public long getYEA_CST_MAC();

    public void setYEA_CST_MAC(long newYEA_CST_MAC);
    //10 TAR_MAC ()

    public String getTAR_MAC();

    public void setTAR_MAC(String newTAR_MAC);
    //11 PPO_MAC ()

    public String getPPO_MAC();

    public void setPPO_MAC(String newPPO_MAC);
    //12 MRC_MAC ()

    public String getMRC_MAC();

    public void setMRC_MAC(String newMRC_MAC);
    //13 PRT_MAC ()

    public long getPRT_MAC();

    public void setPRT_MAC(long newPRT_MAC);
    //14 CAT_MAC ()

    public String getCAT_MAC();

    public void setCAT_MAC(String newCAT_MAC);
    //15 PRE_MAC ()

    public String getPRE_MAC();

    public void setPRE_MAC(String newPRE_MAC);
    //

    public void addMAC_LUO_FSC(java.sql.Date Today, String strCOD_LUO_FSC);

    public void removeMAC_LUO_FSC(String newCOD_LUO_FSC);

    //-------GET TPL_CLF_RSO-----------------------
    public Collection getTipClassView(long lCOD_RSO, long lCOD_AZL);
    //-------GET TABS INFO ------------------------

    public Collection getAnagraficaDocumentiView();

    public Collection getNormativeSentenzeView();

    public Collection getNormativeSentenzeViewEx(); // by Artur

    public Collection getLuoghiFisiciView();

    public Collection getRischioMacchinaView(long lCOD_AZL);

    public Collection getReportRischioMacchinaView();//by Artur

    public Collection getAttivitaMntView();

    public Collection getFornitoriMacView();

    public Collection getAttivitaLavorativeMacchineView();

    //------SET/DELETE REFERENCES FOR TABS---------
    public void addRischio(long lCOD_RSO, String strTPL_CLF_RSO);

    public void deleteRischio(long lCOD_RSO);

    public void addAttManutenzione(long lCOD_MNT_MAC);

    public void deleteAttManutenzione(long lCOD_MNT_MAC);

    public void addDocument(long lCOD_DOC);

    public void deleteDocument(long lCOD_DOC);

    public void addNormativa(long lCOD_NOR_SEN);

    public void deleteNormativa(long lCOD_NOR_SEN);

    public void addFornitore(long lCOD_FOR);

    public void deleteFornitore(long lCOD_FOR);

    public void store(String strIDE_MAC, String strDES_MAC, String strMDL_MAC, String strDIT_CST_MAC, String strFBR_MAC, long lYEA_CST_MAC, String strTAR_MAC, String strPPO_MAC, String strMRC_MAC, long lPRT_MAC, String strCAT_MAC, String strPRE_MAC, long lCOD_TPL_MAC, java.util.ArrayList alAziende);

    public boolean isMultiple();
}
