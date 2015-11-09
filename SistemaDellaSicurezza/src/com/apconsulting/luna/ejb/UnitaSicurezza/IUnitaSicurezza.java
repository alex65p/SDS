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
package com.apconsulting.luna.ejb.UnitaSicurezza;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IUnitaSicurezza extends EJBObject {

    public long getCOD_UNI_SIC();
    //

    public String getNOM_UNI_SIC();

    public void setNOM_UNI_SIC(String strNOM_UNI_SIC);
    //

    public String getDES_UNI_SIC();

    public void setDES_UNI_SIC(String strDES_UNI_SIC);
    //

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);
    //

    public long getCOD_UNI_SIC_ASC();

    public void setCOD_UNI_SIC_ASC(long lCOD_UNI_SIC_ASC);
    //------------------<ALEX>--------------------

    public void setNOM_UNI_SIC__COD_AZL(String strNOM_UNI_SIC, long lCOD_AZL);

    public Collection getChildren(long lCOD_AZL);

    //<report>

    public Collection getResponsabile();
    public Collection getResponsabiliSicurezza();

    //</report>
    //------------------</ALEX>-------------------
    public AssociativaView getUO(long lCOD_UNI_ORG, long lCOD_DPD);
    public AssociativaView getDIP(long lCOD_RUO_SIC, long lCOD_DPD);

    public void addUO(long lCOD_UNI_SIC, long lCOD_AZL, long lCOD_DPD, long lCOD_UNI_ORG);
    public void addDIP(long lCOD_UNI_SIC, long lCOD_AZL, long lCOD_DPD, long lCOD_RUO_SIC);

    public void removeUO(long lCOD_UNI_SIC, long lCOD_AZL, long lCOD_DPD, long lCOD_UNI_ORG);
    public void removeDIP(long lCOD_UNI_SIC, long lCOD_AZL, long lCOD_DPD, long lCOD_RUO_SIC);
}
