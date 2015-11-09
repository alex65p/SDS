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

package com.apconsulting.luna.ejb.SezioneGenerale;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface IsezioneGeneraleHome extends EJBHome {

    public ISezioneGenerale create(String strOGG, String strCOD, String strREV,java.sql.Date dtDAT_EMI,java.sql.Date dtDAT_PRO, String strDOC_COL, long lCOD_PSC,long lCOD_PRO, long lCOD_AZL) throws CreateException;

    public void remove(Object primaryKey);

    public ISezioneGenerale findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public String getUltimo_Doc_Sez(long lCOD_PRO);
    public Collection getSezioneGeneralePSCByID_View(long lCOD_PSC, long lCOD_PRO,long lCOD_AZL);
    public Collection getSezioneGeneralePSCByID_View_SINTETICA(long lCOD_PSC, long lCOD_PRO);
    public String getDataProtocollo(long lCOD_PRO);
    public String getDataProtocolloPREC(long lCOD_PRO);

    public Collection findEx(
            Long lCOD_PSC,
            Long lCOD_PRO,
            String strCOD,
            String strREV,
            String strDAT_EMI,
            String strDAT_PRO,
            String strOGG,
            String strDOC_COL,
            int iOrderParameter);


    public String getUltimaRevisione(long lCOD_PRO);
}

