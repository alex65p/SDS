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

package com.apconsulting.luna.ejb.AnagrCantieri;

import javax.ejb.EJBHome;
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IAnagrCantieri extends EJBObject{


    //1 COD_PRO ()

    public long getlCOD_CAN();

    public void setlCOD_CAN(long newlCOD_OPE);

    //2 DES ()

//     public void addCOD_RSO(long lCOD_RSO, long lCOD_AZL);
    
    public String getstrDES_CAN();
    
    public String getstrNOM_CAN();

    public void setstrDES_CAN(String newstrDES);
    
    public void setstrNOM_CAN(String newstrNOM);

    public void addCOD_OPE(long lCOD_OPE, long lCOD_AZL);

    public void deleteOpera(long lCOD_OPE,long lCOD_PRO);
    
//    public void deleteRischio(long lCOD_RSO,long lCOD_CST);

    
}
