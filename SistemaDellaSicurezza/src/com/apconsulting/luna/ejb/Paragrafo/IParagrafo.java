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
package com.apconsulting.luna.ejb.Paragrafo;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IParagrafo extends EJBObject {

    public long getCOD_PRG();

    public String getNOM_PRG();

    public void setNOM_PRG(String strNOM_PRG);

    public String getDES_PRG();

    public void setDES_PRG(String strDES_PRG);

    public long getCOD_ARE();

    public void setCOD_ARE(long lCOD_ARE);

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);

    public long getCOD_CPL();

    public void setCOD_CPL(long lCOD_CPL);

    public long getPRIORITY();

    public void setPRIORITY(long lPRIORITY);

    //-----------------------------
    // Link Table DOC_ANA_PRG_TAB
    // COD_DOC
    public void addCOD_DOC(long newCOD_DOC);

    public void removeCOD_DOC(long newCOD_DOC);
}

