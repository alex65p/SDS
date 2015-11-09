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

package com.apconsulting.luna.ejb.AnagrDocumentiGestioneCantieri;

import com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface IAnagrDocumentiGestioneCantieriHome extends EJBHome {

    public IAnagrDocumentiGestioneCantieri create(
            String strTIT_DOC,
            String strNUM_DOC,
            java.sql.Date dtDAT_DOC,
            long lCOD_TPL_DOC,
            long lCOD_SOP,
            long lCOD_OPE,
            long lCOD_CAN,
            long lCOD_PRO,
            String strDES,
            long lCOD_AZL) throws CreateException;

    public void remove(Object primaryKey);

    public IAnagrDocumentiGestioneCantieri findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;
// opredelenie view metodov classa
// list of AnagrDocumento by AZL_ID
//public Collection getAnagrDocumento_ByAZLID_View(long AZL_ID);

public Collection getDocumentiGet_View(long lCOD_AZL);

public Collection getPRO_OPE_CAN(long lCOD_DOC);
//--- mary - 19/02/2004
    public byte[] downloadFileU(String strNOM_TAB, long lCOD_DOC);
// Inizio modifica gestione link esterno documenti

    public byte[] downloadFileULink(String strNOM_TAB, long lCOD_DOC);
// Fine modifica gestione link esterno documenti

    public void uploadFileU(String strNOM_TAB, long lCOD_DOC, String strFileName, String strContentType, byte[] content);
// Inizio modifica gestione link esterno documenti

    public void uploadFileULink(String strNOM_TAB, long lCOD_DOC, String strFileName, String strContentType, byte[] content);
// Fine modifica gestione link esterno documenti

    public void deleteFileU(String strNOM_TAB, long lCOD_DOC);
// Inizio modifica gestione link esterno documenti

    public void deleteFileULink(String strNOM_TAB, long lCOD_DOC);
// Fine modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfoU(String strNOM_TAB, long lCOD_DOC);
// Inizio modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfoULink(String strNOM_TAB, long lCOD_DOC);
// Fine modifica gestione link esterno documenti

//<search>
    public Collection findEx(long AZL_ID,
            String TIT_DOC,
            String NUM_DOC,
            java.sql.Date DAT_DOC,
            Long COD_TPL_DOC,
            Long COD_SOP,
            Long COD_OPE,
            Long COD_CAN,
            Long COD_PRO,
            String DES,
            int iOrderBy);
//</search>
}
