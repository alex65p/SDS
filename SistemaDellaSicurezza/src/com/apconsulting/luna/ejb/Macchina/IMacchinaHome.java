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
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IMacchinaHome extends IMacchina //<comment>
{
    /*
    public IMacchina create(
    String strIDE_MAC,
    String strDES_MAC,
    String strMDL_MAC,
    String strDIT_CST_MAC,
    String strFBR_MAC,
    long lCOD_TPL_MAC,
    long lCOD_AZL
    ) throws CreateException;
     */

    public IMacchina create(long lCOD_AZL, String strIDE_MAC, String strDES_MAC, String strMDL_MAC, String strDIT_CST_MAC, String strFBR_MAC, long lYEA_CST_MAC, String strTAR_MAC, String strPPO_MAC, String strMRC_MAC, long lPRT_MAC, String strCAT_MAC, String strPRE_MAC, long lCOD_TPL_MAC, java.util.ArrayList alAziende) throws javax.ejb.CreateException;

    public void remove(Object primaryKey) throws FinderException;

    public void remove(Object primaryKey, java.util.ArrayList alAziende) throws FinderException;

    public IMacchina findByPrimaryKey(MacchinaPK primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    // opredelenie view metodov

    public Collection getMacchina_Name_Desc_View(long lCOD_AZL);

    public Collection getRischioMacchina_View(String strCOD_MAC);

    public Collection getMacchineAttrezzature_View(String strCOD_LUO_FSC);

    public Collection getMacchineAttrezzatureAll_View(long lCOD_AZL);

    public long getOPE_SVO_MAN_View(String strCOD_OPE_SVO);

    public Collection getMacchineAtt_View(long lCOD_AZL, long lCOD_TPL_MAC, String strDES_MAC, String strMDL_MAC, String strIDE_MAC, String NomeParent, long lID_PARENT);

    public void addRSO_OPE_SVO(long ID_PARENT, long COD_AZL, long newCOD_MAC);

    public void addRischioAssociations(long lID_PARENT, long lCOD_AZL, long lCOD_MAC);
    //

    public Collection getMacchina_LOV_View(long AZL_ID, String strNOM, String strDES);
    //<alex date="31/03/2004">

    public Collection getCARICA_LUOGHI_FISICI_View(long lCOD_MAC, long lCOD_AZL);

    public Collection getCARICA_ATTIVITA_View(long lCOD_MAC, long lCOD_AZL);

    public int getCountAttivitaForMacchina(long lCOD_MAC, long lCOD_AZL);

    public int getCountLuoghiForMacchina(long lCOD_MAC, long lCOD_AZL);
    //</alex>

    //--- mary for search
    public Collection findEx(
            long lCOD_AZL,
            String strIDE_MAC,
            String strDES_MAC,
            String strMDL_MAC,
            String strDIT_CST_MAC,
            String strFBR_MAC,
            Long lYEA_CST_MAC,
            String strTAR_MAC,
            String strPPO_MAC,
            String strMRC_MAC,
            Long lPRT_MAC,
            String strCAT_MAC,
            String strPRE_MAC,
            Long lCOD_TPL_MAC,
            int iOrderParameter //not used for now
            );
}
