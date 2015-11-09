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

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IValutazioneRischi extends EJBObject {

    public long getCOD_DOC_VLU();
    //

    public long getCOD_UNI_ORG();

    public void setCOD_UNI_ORG(long lCOD_UNI_ORG);
    //

    public java.sql.Date getDAT_DOC_VLU();

    public void setDAT_DOC_VLU(java.sql.Date dtDAT_DOC_VLU);
    //

    public String getNOM_RSP_DOC();

    public void setNOM_RSP_DOC(String strNOM_RSP_DOC);
    //

    public String getVER_DOC();

    public void setVER_DOC(String strVER_DOC);
    //

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);
    //-----------------------------
    // Link Table ARE_DOC_VLU_TAB
    // COD_ARE

    public void addCOD_ARE(long newCOD_ARE, long lPRT);

    public void removeCOD_ARE(long newCOD_ARE);
    
    
    public void addCOD_DOC(long newCOD_DOC);
    public void removeCOD_DOC(long newCOD_DOC);

    public void addCOD_ARC(String NOM_ARC, java.sql.Date DAT_ARC, byte[] PDF_GEN);
    public void removeCOD_ARC(long newCOD_ARC);
}
