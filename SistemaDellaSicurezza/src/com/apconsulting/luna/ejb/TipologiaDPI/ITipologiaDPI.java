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
package com.apconsulting.luna.ejb.TipologiaDPI;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface ITipologiaDPI extends EJBObject {
    //   *Require Fields*
    //1 COD_TPL_DPI (TipologiaDPI ID)

    public long getCOD_TPL_DPI();
    //2 NOM_TPL_DPI (tipologia)

    public void setNOM_TPL_DPI(String newNOM_TPL_DPI);

    public String getNOM_TPL_DPI();
    //3 DES_CAR_DPI (number)

    public void setDES_CAR_DPI(String newDES_CAR_DPI);

    public String getDES_CAR_DPI();
    //   *not Require Fields*
    //4 MDL_PTR_UTI_DPI ()

    public void setMDL_PTR_UTI_DPI(String newMDL_PTR_UTI_DPI);

    public String getMDL_PTR_UTI_DPI();
    //5 IMG_CSI_DPI ()

    public void setIMG_CSI_DPI(String newIMG_CSI_DPI);

    public String getIMG_CSI_DPI();
    //6 CAG_DPI ()

    public void setCAG_DPI(long newCAG_DPI);

    public long getCAG_DPI();
    //7 PER_MES_SST ()

    public void setPER_MES_SST(long newPER_MES_SST);

    public long getPER_MES_SST();
    //8 PER_MES_MNT ()

    public void setPER_MES_MNT(long newPER_MES_MNT);

    public long getPER_MES_MNT();

    // Link Table NOR_SEN_TPL_DPI_TAB
    //9 COD_NOR_SEN
    public void addCOD_NOR_SEN(long newCOD_NOR_SEN);

    public void removeCOD_NOR_SEN(long newCOD_NOR_SEN);
    // Link Table DOC_DPI_TAB

    public void addCOD_DOC(long newCOD_DOC);

    public void removeCOD_DOC(long newCOD_DOC);

    public void removeLUO_FSC_DPI();

    public void removeGEST_MAN_DPI();
}
