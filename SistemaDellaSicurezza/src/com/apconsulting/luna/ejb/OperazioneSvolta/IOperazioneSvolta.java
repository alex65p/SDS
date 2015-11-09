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
package com.apconsulting.luna.ejb.OperazioneSvolta;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
//     Remote Intrface EJB obiekta
//public interface  IOperazioneSvolta extends EJBObject
public interface IOperazioneSvolta extends EJBObject {
    //   *Require Fields*
    //1 COD_OPE_SVO (OperazioneSvolta ID)

    public long getCOD_OPE_SVO();
    //2 NOM_OPE_SVO (Name)

    public String getNOM_OPE_SVO();

    public void setNOM_OPE_SVO(String newNOM_OPE_SVO);
    //   *Not require Fields*
    //3 DES_OPE_SVO (Description)

    public String getDES_OPE_SVO();

    public void setDES_OPE_SVO(String newDES_OPE_SVO);
    //---
  	/*<comment date="06/02/2004" author="Roman Chumachenko">
    <description>Adding of object views for ANA_OPE_SVO_Form</description>
    </comment>*/

    public Collection getRischi_View(long lCOD_AZL);

    public Collection getDocumenti_View(long lCOD_AZL);

    public Collection getMacchine_View(long lCOD_AZL);

    public Collection getAgentiChimici_View();
    //---
   /*<comment date="11/02/2004" author="Roman Chumachenko">
    <description>Adding of add/remove methods</description>
    </comment>*/

    public void addDocument(long COD_DOC);

    public void removeDocument(long COD_DOC);

    public void addRisc(long COD_RSO, long COD_AZL);

    public void removeRisc(long COD_RSO);

    public void addMacchina(long COD_MAC);

    public void removeMacchina(long COD_MAC);

    public void addAgenteChimico(long COD_SOS_CHI);

    public void removeAgenteChimico(long COD_SOS_CHI, long lCOD_AZL);

    public void removeGEST_MAN_OPE_SVO();
}
