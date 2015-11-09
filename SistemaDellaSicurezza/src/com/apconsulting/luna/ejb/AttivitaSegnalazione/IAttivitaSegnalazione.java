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
package com.apconsulting.luna.ejb.AttivitaSegnalazione;

import javax.ejb.EJBObject;
import java.sql.Date;

/**
 *
 * @author Alessandro
 */
public interface IAttivitaSegnalazione extends EJBObject {

    public long getCOD_ATI_SGZ();

    public String getDES_ATI_SGZ();

    public void setDES_ATI_SGZ(String strDES_ATI_SGZ);

    public Date getDAT_SCA();

    public void setDAT_SCA(Date dtDAT_SCA);

    public Date getDAT_VER();

    public void setDAT_VER(Date dtDAT_VER);

    public float getRIS();

    public void setRIS(float fRIS);
    
    public Date getDAT_ATT();

    public void setDAT_ATT(Date dtDAT_ATT);
    
    public String getVER_DA();

    public void setVER_DA(String strVER_DA);

    public long getCOD_SGZ();

    public void setCOD_SGZ(long lCOD_SGZ);

    public long getCOD_DPD();

    public void setCOD_DPD(long lCOD_DPD);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    public void addCOD_DOC(long newCOD_DOC);

    public void removeCOD_DOC(long newCOD_DOC);

    public void addMisura(long COD_MIS_PET);

    public void removeMisura(long COD_MIS_PET);
}
