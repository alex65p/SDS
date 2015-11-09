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
package com.apconsulting.luna.ejb.Immobili3lv;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
// BASE TABLE: ANA_IMM_TAB
//     Remote Intrface EJB obiekta
public interface IImmobili3lv extends EJBObject {

    public long getCOD_IMM();

    public String getNOM_IMM();

    public void setNOM_IMM(String newNOM_IMM);

    public String getDES_IMM();

    public void setDES_IMM(String newDES_IMM);

    public long getCOD_SIT_AZL();

    public void setCOD_SIT_AZL(long newCOD_SIT_AZL);
    
    public String getIND_IMM();

    public void setIND_IMM(String newIND_IMM);
    
    public String getNUM_CIV_IMM();

    public void setNUM_CIV_IMM(String newNUM_CIV_IMM);
    
    public String getCIT_IMM();

    public void setCIT_IMM(String newCIT_IMM);
    
    public String getPRO_IMM();

    public void setPRO_IMM(String newPRO_IMM);
    
    public String getCAP_IMM();

    public void setCAP_IMM(String newCAP_IMM);
}
