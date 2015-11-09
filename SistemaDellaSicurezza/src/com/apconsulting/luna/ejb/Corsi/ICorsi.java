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
package com.apconsulting.luna.ejb.Corsi;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface ICorsi extends EJBObject {

    public long getCOD_COR();

    public long getDUR_COR_GOR();

    public void setDUR_COR_GOR(long lDUR_COR_GOR);

    public String getNOM_COR();

    public void setNOM_COR(String strNOM_COR);

    public String getDES_COR();

    public void setDES_COR(String strDES_COR);

    public String getUSO_ATE_FRE_COR();

    public void setUSO_ATE_FRE_COR(String strUSO_ATE_FRE_COR);

    public String getUSO_PTG_COR();

    public void setUSO_PTG_COR(String strUSO_PTG_COR);

    public long getCOD_TPL_COR();

    public void setCOD_TPL_COR(long lCOD_TPL_COR);

    public void removeLUO_FSC_COR();

    public void removeGEST_MAN_COR();

    //-----------------------------------------------
    public void addCOD_TES_VRF(long newCOD_TES_VRF);

    public void removeCOD_TES_VRF(long newCOD_TES_VRF);

    public void addCOD_DOC(long newCOD_DOC);

    public void removeCOD_DOC(long newCOD_DOC);
    /*
    <comment date="08/03/2004" author="Roman Chumachenko">
    <description>Views for Reports</description>
    </comment>*/

    public String getCorsoTipologia();

    public Collection getDocCorsoMateriali_List_View();

    public Collection getDocentiForCorso_List_View();

    public Collection getErogazioneForCorso_List_View(long lCOD_AZL);
    //------------------------------------------------------------------
}
