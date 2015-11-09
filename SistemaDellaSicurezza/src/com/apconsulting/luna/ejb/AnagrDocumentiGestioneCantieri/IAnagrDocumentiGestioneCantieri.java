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
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IAnagrDocumentiGestioneCantieri extends EJBObject {
//1 COD_DOC (AnagrDocumento ID)

    public long getCOD_DOC();

//10 TIT_DOC ()
 public void setTIT_DOC(String newTIT_DOC);
    public String getTIT_DOC();

 public void setNUM_DOC(String newNUM_DOC);
    public String getNUM_DOC();
    
 public void setDES(String newDES);
    public String getDES();

 public void setDAT_DOC(java.sql.Date newDAT_DOC);
    public java.sql.Date getDAT_DOC();

//public void setTIT_DOC(String newstrTIT_DOC);

    public long getCOD_TPL_DOC();

    public void setCOD_TPL_DOC(long newCOD_TPL_DOC);

    public long getCOD_SOP();

    public void setCOD_SOP(long newCOD_SOP);

    public long getCOD_OPE();

    public void setCOD_OPE(long newCOD_OPE);

    public long getCOD_CAN();

    public void setCOD_CAN(long newCOD_CAN);

    public long getCOD_PRO();

    public void setCOD_PRO(long newCOD_PRO);

    public void setCOD_PRO_CAN_OPE(long COD_PRO, long COD_CAN, long COD_OPE);
    
    //20 COD_AZL ()

    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);

    public byte[] downloadFile();
// Inizio modifica gestione link esterno documenti

    public byte[] downloadFileLink();
// Fine modifica gestione link esterno documenti

    public void uploadFile(String strFileName, String strContentType, byte[] content);
// Inizio modifica gestione link esterno documenti

    public void uploadFileLink(String strFileName, String strContentType, byte[] content);
// Fine modifica gestione link esterno documenti

    public void deleteFile();
// Inizio modifica gestione link esterno documenti

    public void deleteFileLink();
// Fine modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfo();
// Inizio modifica gestione link esterno documenti

    public AnagDocumentoFileInfo getFileInfoLink();
// Fine modifica gestione link esterno documenti
/*
    <comment date="05/03/2004" author="Roman Chumachenko">
    <description>Views for Reports</description>
    </comment>*/

    public Collection getRSCollegati();
}
