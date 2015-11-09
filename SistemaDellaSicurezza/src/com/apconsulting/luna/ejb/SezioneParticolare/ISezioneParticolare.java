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

package com.apconsulting.luna.ejb.SezioneParticolare;

import javax.ejb.EJBHome;

/**
 *
 * @author Alessandro
 */
public interface ISezioneParticolare extends EJBHome{

    //1 COD_SEZ_GEN (Aanagrafica PSC ID)

    public long getlCOD_SEZ_PAR();

    public void setlCOD_SEZ_PAR(long newlCOD_SEZ_PAR);

    //2 COD_PRO ()

    public long getlCOD_PRO();

    public void setlCOD_PRO(long newlCOD_PRO);

    //3 REV ()

    public String getstrREV();

    public void setstrREV(String newstrREV);

    //4 OGG ()

    public String getstrOGG();

    public void setstrOGG(String newstrOGG);

    //5 COD ()

    public String getstrCOD();

    public void setstrCOD(String newstrCOD);

    //6 DAT_PRM_REG ()

    public java.sql.Date getdtDAT_EMI();

    public void setdtDAT_EMI(java.sql.Date newdtDAT_EMI);

    //7 DAT_PRO ()

    public java.sql.Date getdtDAT_PRO();

    public void setdtDAT_PRO(java.sql.Date newdtDAT_PRO);

     //8 DOC_COL ()

    public String getstrDOC_COL();

    public void setstrDOC_COL(String newstrDOC_COL);

    //9 COD_AZL ()

    public long getlCOD_AZL();

    public void setlCOD_AZL(long newlCOD_AZL);

    //10 COD_PSC ()

    public long getlCOD_PSC();

    public void setlCOD_PSC(long newlCOD_PSC);

    //11 TIT ()

    public String getstrTIT();

    public void setstrTIT(String newstrTIT);

}
