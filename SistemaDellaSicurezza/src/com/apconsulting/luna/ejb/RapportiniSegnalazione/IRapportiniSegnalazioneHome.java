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
package com.apconsulting.luna.ejb.RapportiniSegnalazione;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IRapportiniSegnalazioneHome extends EJBHome {

    public IRapportiniSegnalazione create(String strDES_SGZ, java.sql.Date dtDAT_SGZ, long lNUM_SGZ, long lVER_SGZ, String strTIT_SGZ, String strSTA_SGZ, String strURG_SGZ, String strNOM_RIL_SGZ, long lCOD_DPD, long lCOD_AZL) throws CreateException;

    public IRapportiniSegnalazione findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);
    // opredelenie view metodov

    public Collection getRapportiniSegnalazione_List_View();

    public Collection getRapportiniSegnalazione_List_ID_View(long lCOD_SGZ);
    
    public Collection getRischi_View(long lCOD_SGZ, long lCOD_AZL);
    
    public Collection getMax_Numero_View();

    public Collection getRapportini_View(
            long lCOD_AZL, long lCOD_DPD, String strTIT_SGZ, String strNOM_RIL_SGZ,
            java.sql.Date dDAT_SGZ_DAL, java.sql.Date dDAT_SGZ_AL,
            java.sql.Date dDAT_SCA_DAL, java.sql.Date dDAT_SCA_AL,
            String strRG_GROUP, String strSTA_INT, String strVAR_SGZ, String strVAR_SCA);

    public Collection findEx(
            Long lCOD_DPD,
            String strDES_SGZ,
            java.sql.Date dtDAT_SGZ,
            Long lNUM_SGZ,
            Long lVER_SGZ,
            String strTIT_SGZ,
            String strSTA_SGZ,
            String strURG_SGZ,
            String strDES_ATI_SGZ,
            String strSTA_FIE_SGZ,
            java.sql.Date dtDAT_FIE,
            String strNOM_RIL_SGZ,
            long lCOD_IMM,
            long lCOD_LUO_FSC,
            long lCOD_AZL,
            int iOrderParameter //not used for now
            );
}
