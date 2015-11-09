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
package com.apconsulting.luna.ejb.ValutazioneRischi;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface IValutazioneRischiHome extends EJBHome {

    public IValutazioneRischi create(java.sql.Date dtDAT_DOC_VLU, String strVER_DOC, long lCOD_AZL) throws CreateException;

    public IValutazioneRischi findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public void remove(Object primaryKey);
    // opredelenie view metodov

    public Collection getValutazioneRischiSezioniByID_View(long lCOD_DOC_VLU);

    public Collection getValutazioneRischiAllegati(long lCOD_DOC_VLU);
    
    public long getAllegatiCount(long lCOD_DOC_VLU);

    public Collection getValutazioneRischiArchivio(long lCOD_DOC_VLU, long lCOD_AZL);
    
    public Collection getValutazioneRischiSezioniNames_View(long lCOD_AZL);
    
    public byte[] downloadFileArchivio(long lCOD_ARC);

    public Collection findEx(
            long lCOD_AZL,
            java.sql.Date dtDAT_DOC_VLU,
            String strNOM_RSP_DOC,
            String strVER_DOC,
            long lCOD_UNI_ORG,
            int iOrderParameter);
}
