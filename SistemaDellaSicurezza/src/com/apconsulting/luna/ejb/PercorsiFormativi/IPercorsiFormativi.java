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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.PercorsiFormativi;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IPercorsiFormativi extends EJBObject {

    public long getCOD_PCS_FRM();

    public String getNOM_PCS_FRM();

    public void setNOM_PCS_FRM(String strNOM_PCS_FRM);

    public String getDES_PCS_FRM();

    public void setDES_PCS_FRM(String strDES_PCS_FRM);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    //-----------------------------
    // Link Table COR_PCS_FRM_TAB
    public void addCOD_COR(long newCOD_COR);

    public void removeCOD_COR(long newCOD_COR);
}
