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
package com.apconsulting.luna.ejb.SchedeParagrafo;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
//     Home Intrface EJB obiekta
public interface ISchedeParagrafoHome extends EJBHome {

    public ISchedeParagrafo create(long lCOD_PRG, String strTPL_SCH) throws CreateException;

    public void remove(Object primaryKey);

    public ISchedeParagrafo findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
    //--- view

    public Collection getSchedeParagrafo_MAC_View(long AZL_ID);

    public Collection getSchedeParagrafo_UNI_ORG_View(long AZL_ID);

    public Collection getSchedeParagrafo_UNI_SIC_View(long AZL_ID);

    public Collection getSchedeParagrafo_SOS_CHI_View(long AZL_ID);

    public Collection getSchedeParagrafo_MAN_ViewU(long AZL_ID, long lCOD_UNI_ORG);

    public Collection getSchedeParagrafo_LUO_FSC_ViewU(long AZL_ID, long lCOD_UNI_ORG);

    public Collection getSchedeParagrafo_FAT_RSO_View(long AZL_ID);

    public Collection getSchedeParagrafo_IMM_3LV_View(long AZL_ID);

    public Collection getSchedeParagrafo_PNO_View(long AZL_ID);

    public Collection getSchedeParagrafo_MIS_PET_View(long AZL_ID);

    public Collection getSchedeParagrafo_RSO_View(long AZL_ID);

    public Collection getSchedeParagrafo_ByPRG_View(long PRG_ID, String strTYPE);
    
    public boolean existSchedeParagrafo_ByPRG_View(long PRG_ID, String strTYPE);

    public Collection getSchedeParagrafo_GetType_View_BASE(long PRG_ID, long lCOD_UNI_ORG);

    public Collection getSchedeParagrafo_GetType_View_DESC(long PRG_ID, long lCOD_UNI_ORG);

    //by Juli
    public Collection getSchedeParagrafo_GetType_View_ALL(long PRG_ID, long lCOD_UNI_ORG); //by Juli

    public Collection getSchedeParagrafo_MAC_View(long AZL_ID, long COD_MAC);

    public Collection getSchedeParagrafo_UNI_ORG_View(long AZL_ID, long COD_UNI_ORG);

    public Collection getSchedeParagrafo_UNI_SIC_View(long AZL_ID, long COD_UNI_SIC);

    public Collection getSchedeParagrafo_SOS_CHI_View(long AZL_ID, long COD_SOS_CHI);

    public Collection getSchedeParagrafo_MAN_View(long AZL_ID, long COD_MAN);

    public Collection getSchedeParagrafo_LUO_FSC_View(long AZL_ID, long COD_LUO_FSC);

    public Collection getSchedeParagrafo_FAT_RSO_View(long AZL_ID, long COD_FAT_RSO);

    public Collection getSchedeParagrafo_IMM_3LV_View(long AZL_ID, long COD_IMM);

    public Collection getSchedeParagrafo_PNO_View(long AZL_ID, long COD_PNO);

    public Collection getSchedeParagrafo_MIS_PET_View(long AZL_ID, long COD_MIS_PET);

    public Collection getSchedeParagrafo_RSO_View(long AZL_ID, long COD_RSO);

    public String BuildSchedeParagrafoTab(long lCOD_PRG, long lCOD_AZL, long lCOD_UNI_ORG1111);

    public boolean checkBloccoDescrizioni(String tipoScheda);

    //<report>
    public Collection getReportSchedeParagrafo_GetType_View(long PRG_ID, String strType, long lCOD_UNI_ORG);
    //</report>
}
