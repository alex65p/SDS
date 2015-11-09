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
package com.apconsulting.luna.ejb.Sopraluogo;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface ISopraluogo extends EJBObject {
    //   *Require Fields*
    public long getCOD_AZL();
    public long getCOD_SOP();
    public String getNUM_SOP();
    public void setNUM_SOP(String num);
    public long getCOD_PRO();
    public void setCOD_PRO(long cod_pro);
    public long getCOD_OPE();
    public void setCOD_OPE(long cod_ope);
    public long getCOD_CAN();
    public void setCOD_CAN(long cod_can);
    public java.sql.Date getDAT_SOP();
    public void setDAT_SOP(java.sql.Date data);
    public void setCOD_PRO_CAN_OPE(long COD_PRO, long COD_CAN, long COD_OPE);
    
//   *Not require Fields*
    public java.sql.Time getORA_INI();
    public void setORA_INI(java.sql.Time time);
    public java.sql.Time getORA_FIN();
    public void setORA_FIN(java.sql.Time time);
    public short getESITO();
    public void setESITO(short esito);
    public java.sql.Date getDAT_FER_LAV();
    public void setDAT_FER_LAV(java.sql.Date data);
    public java.sql.Date getDAT_RIP_LAV();
    public void setDAT_RIP_LAV(java.sql.Date data);

    public String getDIS_GEN();
    public void setDIS_GEN(String sDisGen);
    
    public int addCOD_SOP_DPD(long newCOD_SOP_FRM,String alt_nominativo);
    public int addCOD_SOP_DPD_est(long newCOD_SOP_FRM,String alt_nominativo);
    public void addDOC_GES_CAN_SOP(long newCOD_SOP);
}
