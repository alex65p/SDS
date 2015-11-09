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

package com.apconsulting.luna.ejb.AnagrProcedimento;

import javax.ejb.EJBHome;
import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface IAnagrProcedimento extends EJBObject{


    //1 COD_PRO ()

    public long getlCOD_PRO();

    public void setlCOD_PRO(long newlCOD_PRO);

    //2 DES ()

    public String getstrDES();

    public void setstrDES(String newstrDES);

    //3 NOM_RUP ()

    public String getstrNOM_RUP();

    public void setstrNOM_RUP(String newstrNOM_RUP);

    //5 COD ()

    public String getstrCOD();

    public void setstrCOD(String newstrCOD);

    //6 DAT_PRM_REG ()

    public java.sql.Date getdtDAT_AMM();

    public void setdtDAT_AMM(java.sql.Date newdtDAT_AMM);
    
    //7 COD_OPE ()
    
  //  public void addCOD_OPE(long lCOD_OPE, long lCOD_AZL);

    //8 COD_CAN ()
    public void addCOD_CAN(long lCOD_CAN, long lCOD_AZL);
    
    //9 COD_AZL ()

    public long getlCOD_AZL();

    public void setlCOD_AZL(long newlCOD_AZL);
    
    //public void deleteOpera(long lCOD_OPE,long lCOD_PRO);

    public void deleteCantiere(long lCOD_CAN,long lCOD_OPE);
}
