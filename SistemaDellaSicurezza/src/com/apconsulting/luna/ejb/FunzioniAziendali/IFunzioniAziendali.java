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
package com.apconsulting.luna.ejb.FunzioniAziendali;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
public interface IFunzioniAziendali extends EJBObject //abstract class IFunzioniAziendali extends BMPEntityBean
{
    //   *Require Fields*
    //1 COD_STA (Azienda ID)

    public abstract long getCOD_FUZ_AZL();
    //2 RAG_SCL_AZL (name)

    public abstract String getNOM_FUZ_AZL();

    public abstract void setNOM_FUZ_AZL(String newNOM_FUZ_AZL);

    //   *Not require Fields*
    //3 DES_ATI_SVO_AZL (descr)
    public abstract String getDES_FUZ_AZL();

    public abstract void setDES_FUZ_AZL(String newDES_FUZ_AZL);
}
