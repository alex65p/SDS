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

package com.apconsulting.luna.ejb.PSC;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IPSC extends EJBObject {

    //1 COD_PSC (Aanagrafica PSC ID)

    public long getlCOD_PSC();
                
    //2 COD_PRO ()

    public long getlCOD_PRO();

    public void setlCOD_PRO(long newlCOD_PRO);

    //3 TIT ()

    public String getstrTIT();

    public void setstrTIT(String newstrTIT);
    
    //4 OGG ()

    public String getstrOGG();

    public void setstrOGG(String newstrOGG);
    
    //5 COD ()

    public String getstrCOD();

    public void setstrCOD(String newstrCOD);
    
    //6 DAT_PRM_REG ()

    public java.sql.Date getdtDAT_PRM_REG();

    public void setdtDAT_PRM_REG(java.sql.Date newdtDAT_PRM_REG);

    //7 COD_ELA ()

    public String getCOD_ELA();

    public void setCOD_ELA(String newCOD_ELA);
    
    
    //8 COD_AZL ()

    public long getlCOD_AZL();

    public void setlCOD_AZL(long newlCOD_AZL);

    public Collection getSezioneGeneraleView();
    public Collection getSchedediSicurezzaView();
    public Collection getSezioneParticolareView();
    public Collection getFascicoloView();
    public boolean areAssociations();

}
