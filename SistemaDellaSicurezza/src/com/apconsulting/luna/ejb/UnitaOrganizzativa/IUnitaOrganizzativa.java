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
package com.apconsulting.luna.ejb.UnitaOrganizzativa;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IUnitaOrganizzativa extends EJBObject {

    public long getCOD_UNI_ORG();
//

    public String getDVR();

    public void setDVR(String strDVR);
//

    public String getNOM_UNI_ORG();

    public void setNOM_UNI_ORG(String strNOM_UNI_ORG);
//

    public String getDES_UNI_ORG();

    public void setDES_UNI_ORG(String strDES_UNI_ORG);
//

    public String getEMAIL();

    public void setEMAIL(String strEMAIL);
//

    public long getCOD_TPL_UNI_ORG();

    public void setCOD_TPL_UNI_ORG(long lCOD_TPL_UNI_ORG);
//

    public long getCOD_UNI_ORG_ASC();

    public void setCOD_UNI_ORG_ASC(long lCOD_UNI_ORG_ASC);
//

    public long getCOD_DPD();

    public void setCOD_DPD(long lCOD_DPD);
//

    public long getCOD_AZL();

    public void setCOD_AZL(long lCOD_AZL);
//

    public void setCOD_DPD__COD_AZL(long lCOD_DPD, long lCOD_AZL);
//

    public Collection getChildren(long lCOD_AZL);
  

    public ResponsabileView getResponsabile(long lCOD_AZL);

    public Collection getAllAttivitaLavorativaView(long lCOD_AZL);
//-----TABS-------------------------------

    public Collection getLuoghiFisiciView();

    public Collection getAttivitaLavorativaView();

    public void addLuogoFisico(long lCOD_LUO_FSC);

    public Collection getLuogoFisico(long lCOD_LUO_FSC);

    public void deleteLuogoFisico(long lCOD_LUO_FSC);

    public void addAttivitaLavorativa(long lCOD_MAN);

    public void deleteAttivitaLavorativa(long lCOD_MAN);
//<report>

    public Collection getReportUnitaOrganizzativa_LuogoFisico_DPI_View();

    public Collection getReportUnitaOrganizzativa_RefSicurezza_View();

    public Collection getReportUnitaOrganizzativa_AttivitaLavorativa_Eventuale_View();
    public Collection getReportUnitaOrganizzativa_Resp_Unit‡Sicurezza_View();
//</report>
}
