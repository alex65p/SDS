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

package com.apconsulting.luna.ejb.AnagrPOS;

import java.util.Date;
import javax.ejb.EJBHome;
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IAnagrPOS extends EJBObject{


    //1 COD_PRO ()

    public long getlCOD_POS();

    public void setlCOD_POS(long newlCOD_PRO);
    
    public long getlCOD_DTE();

    public void setlCOD_DTE(long newlCOD_DTE);

    public long getlCOD_DOC();

    public void setlCOD_PRO(long newlCOD_PRO);
    public long getlCOD_PRO();

    public void setlCOD_OPE(long newlCOD_OPE);
    public long getlCOD_OPE();

    public void setlCOD_CAN(long newlCOD_CAN);
    public long getlCOD_CAN();

    public void setlCOD_DOC(long newlCOD_DOC);

    
    //2 DES ()
    
    public String getstrTIT();
    
    public Date getdatData();
    
    public String getstrUFF();
    
    public String getstrSTA();
    
    public String getstrFAL();
    
    public String getstrPRO();

    public void setstrTIT(String newstrTIT);
    
    public void setdatData(java.sql.Date newdatData);
        
    public void setstrUFF(String newstrUFF);
    
    public void setstrSTA(String newstrSTA);

    public void setstrFAL(String newstrFAL);
    
    public void setstrPRO(String newstrPRO);
    
    
}
