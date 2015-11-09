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
package com.apconsulting.luna.ejb.LuogoFisicoRischio;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface ILuogoFisicoRischioHome extends EJBHome {

    public ILuogoFisicoRischio create(long lCOD_LUO_FSC, long lCOD_RSO, long lCOD_AZL, String strPRS_RSO, java.sql.Date dtDAT_INZ, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, java.sql.Date dtDAT_RFC_VLU_RSO, String strSTA_RSO) throws CreateException;

    public ILuogoFisicoRischio findByPrimaryKey(Long primaryKey) throws FinderException;
    
    public ILuogoFisicoRischio findByUniqueKey(long lCOD_RSO, long lCOD_AZL, long lCOD_LUO_FSC);

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);

    public Collection getLuogoFisicoRischio_List_View(long COD_AZL);

    public Collection getLuogoFisicoRischio_Tab_View(long COD_AZL, long COD_LUO_FSC);
}
