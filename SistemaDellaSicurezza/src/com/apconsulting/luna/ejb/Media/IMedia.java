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
package com.apconsulting.luna.ejb.Media;
import java.sql.Blob;
import java.sql.Date;
import java.sql.Time;
import java.util.Collection;
import javax.ejb.EJBObject;

public interface IMedia extends EJBObject {

    public byte[] downloadFile();

    public void uploadFile(String strFileName, String strContentType, byte[] content);

    public void deleteFile();

    public MediaFileInfo getFileInfo();

    public void ejbStore();
    
    public Long getCOD_MED();
    public void setCOD_MED(Long COD_MED);
    public Long getCOD_SOP();
    public void setCOD_SOP(Long COD_SOP);
    public String getNOM_MED();
    public void setNOM_MED(String NOM_MED);
    public String getDES_MED();
    public void setDES_MED(String DES_MED);
    public Integer getTIPO();
    public void setTIPO(Integer TIPO);
    public String getFILE();
    public void setFILE(String FILE);
    public Blob getBLOB();
    public void setBLOB(Blob BLOB);
    public String getNOTE();
    public void setNOTE(String NOTE);
    public Date getDATA();
    public void setDATA(Date DATA);
    public Time getORA();
    public void setORA(Time ORA);
    public String getMIME();
    public void setMIME(String MIME);
    public Long getLEN();
    public void setLEN(Long LEN);
    public void setMediadata(byte [] mediadata);
    public byte [] getMediadata();
}
