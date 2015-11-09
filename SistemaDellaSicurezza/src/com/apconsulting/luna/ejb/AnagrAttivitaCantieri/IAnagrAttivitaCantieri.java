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

package com.apconsulting.luna.ejb.AnagrAttivitaCantieri;



import com.apconsulting.luna.ejb.AnagrDocumento.AnagDocumentoFileInfo;
import javax.ejb.EJBHome;
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IAnagrAttivitaCantieri extends EJBObject{


    //1 COD_DOC ()

    public long getlCOD_DOC();

    public void setlCOD_DOC(long newlCOD_DOC);

    //2 DES_ATT ()

    public String getstrDES_ATT();

    public void setstrDES_ATT(String newstrDES_ATT);

    //3 COD ()

    public String getstrCOD();

    public void setstrCOD(String newstrCOD);
    //4 NOM_ATT ()

    public String getstrNOM_ATT();

    public void setstrNOM_ATT(String newstrNOM_ATT);

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


}
