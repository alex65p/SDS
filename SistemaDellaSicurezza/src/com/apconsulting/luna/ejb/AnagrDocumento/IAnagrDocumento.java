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
package com.apconsulting.luna.ejb.AnagrDocumento;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IAnagrDocumento extends EJBObject {
//   *Require Fields*
//1 COD_DOC (AnagrDocumento ID)

    public long getCOD_DOC();
//2 RSP_DOC ()

    public String getRSP_DOC();

    public void setRSP_DOC(String newRSP_DOC);
//3 APV_DOC ()

    public String getAPV_DOC();

    public void setAPV_DOC(String newAPV_DOC);
//4 EMS_DOC ()

    public String getEMS_DOC();

    public void setEMS_DOC(String newEMS_DOC);
//5 NUM_DOC ()

    public String getNUM_DOC();

    public void setNUM_DOC(String newNUM_DOC);
//6 EDI_DOC ()

    public long getEDI_DOC();

    public void setEDI_DOC__TIT_DOC(long newEDI_DOC, String newTIT_DOC);
//7 REV_DOC ()

    public String getREV_DOC();

    public void setREV_DOC(String newREV_DOC);
//8 DAT_REV_DOC ()

    public java.sql.Date getDAT_REV_DOC();

    public void setDAT_REV_DOC(java.sql.Date newDAT_REV_DOC);
//9 MES_REV_DOC ()

    public long getMES_REV_DOC();

    public void setMES_REV_DOC(long newMES_REV_DOC);
//10 TIT_DOC ()

    public String getTIT_DOC();
//public void setTIT_DOC(String newTIT_DOC);
//11 COD_CAG_DOC ()

    public long getCOD_CAG_DOC();

    public void setCOD_CAG_DOC(long newCOD_CAG_DOC);
//12 COD_TPL_DOC ()

    public long getCOD_TPL_DOC();

    public void setCOD_TPL_DOC(long newCOD_TPL_DOC);

//   *Not require Fields*
//13 DAT_FUT_REV_DOC ()
    public java.sql.Date getDAT_FUT_REV_DOC();

    public void setDAT_FUT_REV_DOC(java.sql.Date newDAT_FUT_REV_DOC);
//14 DES_REV_DOC ()

    public String getDES_REV_DOC();

    public void setDES_REV_DOC(String newDES_REV_DOC);
//15 PRG_RIF_DOC ()

    public String getPRG_RIF_DOC();

    public void setPRG_RIF_DOC(String newPRG_RIF_DOC);
//16 PGN_RIF_DOC ()

    public String getPGN_RIF_DOC();

    public void setPGN_RIF_DOC(String newPGN_RIF_DOC);
//17 COD_LUO_FSC ()

    public long getCOD_LUO_FSC();

    public void setCOD_LUO_FSC(long newCOD_LUO_FSC);
//18 NOT_LUO_CON ()

    public String getNOT_LUO_CON();

    public void setNOT_LUO_CON(String newNOT_LUO_CON);
//19 PER_CON_YEA ()

    public long getPER_CON_YEA();

    public void setPER_CON_YEA(long newPER_CON_YEA);
//20 COD_AZL ()

    public long getCOD_AZL();

    public void setCOD_AZL(long newCOD_AZL);

    public Collection getDestinatarioDocumentoView();

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

    public Collection getDocDestinatari_List_View();
}
