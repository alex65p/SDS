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
package com.apconsulting.luna.ejb.DipendenteCorsi;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IDipendenteCorsi extends EJBObject {
    //   *Require Fields*
    //1 COD_COR

    public long getCOD_COR();
    //2 NOM_COR ()

    public String getNOM_COR();

    public void setNOM_COR(String newNOM_COR);

    //   *Not require Fields*
    //3 DES_COR ()
    public String getDES_COR();

    public void setDES_COR(String newDES_COR);
    //4 DAT_EFT_COR()

    public java.sql.Date getDAT_EFT_COR();

    public void setDAT_EFT_COR(java.sql.Date newDAT_EFT_COR);
}
