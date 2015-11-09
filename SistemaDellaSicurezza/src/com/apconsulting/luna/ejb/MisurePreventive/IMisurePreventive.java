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
package com.apconsulting.luna.ejb.MisurePreventive;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//<ejb-interfaces description="EJB Interfaces">
public interface IMisurePreventive extends EJBObject {

    public long getCOD_MIS_RSO_LUO();

    public long getCOD_MIS_PET();
    //public void setCOD_MIS_PET(long lCOD_MIS_PET);

    public java.sql.Date getDAT_INZ();

    public void setDAT_INZ(java.sql.Date dtDAT_INZ);

    public java.sql.Date getDAT_FIE();

    public void setDAT_FIE(java.sql.Date dtDAT_FIE);

    public String getPRS_MIS_PET();

    public void setPRS_MIS_PET(String strPRS_MIS_PET);

    public long getVER_MIS_PET();

    public void setVER_MIS_PET(long lVER_MIS_PET);

    public String getADT_MIS_PET();

    public void setADT_MIS_PET(String strADT_MIS_PET);

    public java.sql.Date getDAT_PAR_ADT();

    public void setDAT_PAR_ADT(java.sql.Date dtDAT_PAR_ADT);

    public String getPER_MIS_PET();

    public void setPER_MIS_PET(String strPER_MIS_PET);

    public long getPNZ_MIS_PET_MES();

    public void setPNZ_MIS_PET_MES(long lPNZ_MIS_PET_MES);

    public java.sql.Date getDAT_PNZ_MIS_PET();

    public void setDAT_PNZ_MIS_PET(java.sql.Date dtDAT_PNZ_MIS_PET);

    public String getTPL_DSI_MIS_PET();

    public void setTPL_DSI_MIS_PET(String strTPL_DSI_MIS_PET);

    public String getDSI_AZL_MIS_PET();

    public void setDSI_AZL_MIS_PET(String strDSI_AZL_MIS_PET);

    public String getSTA_MIS_PET();

    public void setSTA_MIS_PET(String strSTA_MIS_PET);

    public long getCOD_RSO_LUO_FSC();
    //public void setCOD_RSO_LUO_FSC(long lCOD_RSO_LUO_FSC);

    public long getCOD_LUO_FSC();
    //public void setCOD_LUO_FSC(long lCOD_LUO_FSC);

    public long getCOD_TPL_MIS_PET();

    public void setCOD_TPL_MIS_PET(long lCOD_TPL_MIS_PET);

    public void setCOD_LUO_FSC__COD_MIS_PET__COD_RSO_LUO_FSC(long newCOD_LUO_FSC, long newCOD_MIS_PET, long newCOD_RSO_LUO_FSC);

    public void addCOD_DOC(long DOC_ID);

    public void addCOD_NOR_SEN(long NOR_SEN_ID);
}
