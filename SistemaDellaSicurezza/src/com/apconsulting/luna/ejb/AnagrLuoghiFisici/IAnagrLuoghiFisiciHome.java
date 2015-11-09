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
package com.apconsulting.luna.ejb.AnagrLuoghiFisici;

import java.util.ArrayList;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface IAnagrLuoghiFisiciHome extends EJBHome {

    public IAnagrLuoghiFisici create(
            long COD_SIT_AZL,
            long COD_AZL,
            String NOM_LUO_FSC,
            long COD_ALA,
            long COD_IMO,
            long COD_IMM_3LV,
            long COD_PNO,
            String DES_LUO_FSC,
            String QLF_RSP_LUO_FSC,
            String NOM_RSP_LUO_FSC,
            String IDZ_PSA_ELT_RSP_LUO_FSC) throws CreateException;

        public IAnagrLuoghiFisici createExtended(
            long COD_SIT_AZL,
            long COD_AZL,
            String NOM_LUO_FSC,
            long COD_ALA,
            long COD_IMO,
            long COD_IMM_3LV,
            long COD_PNO,
            String DES_LUO_FSC,
            String QLF_RSP_LUO_FSC,
            String NOM_RSP_LUO_FSC,
            String IDZ_PSA_ELT_RSP_LUO_FSC,
            ArrayList alAziende) throws CreateException;

    public void remove(Object primaryKey);

    public void removeExtended(Object primaryKey, ArrayList alAziende);

    public IAnagrLuoghiFisici findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
// opredelenie view metodov
//by Artur for reports

    public Collection getAnagrLuoghiFisici_4Sede_List_View(long lCOD_AZL, long lCOD_MAN);

    public Collection getAnagrLuoghiFisici_List_View(long lCOD_AZL, long lCOD_MAN);

    public Collection getAnagrLuoghiFisici_List_View(long lCOD_AZL);

    public Collection getAllAnagrLuoghiFisici_List_View();

    public Collection getAnagrLuoghiFisici_Sit_Azl_View(long COD_SIT_AZL);

    public Collection getAnagrLuoghiFisici_Imm_3lv_View(long COD_IMM_3LV);

    public Collection getAnagrLuoghiFisici_NOM_List_View(String strNOM_LUO_FSC, long lCOD_AZL);

    public Collection findEx(
            long lCOD_AZL,
            Long lCOD_SIT_AZL,
            Long lCOD_PNO,
            Long lCOD_ALA,
            Long lCOD_IMO,
            Long lCOD_IMM_3LV,
            String strNOM_LUO_FSC,
            String strDES_LUO_FSC,
            String strNOM_RSP_LUO_FSC,
            String strIDZ_PSA_ELT_RSP_LUO_FSC,
            String strQLF_RSP_LUO_FSC,
            String strFLG_IMP,
            int iOrderParameter);
//-----------------------------------------------------------------
}
