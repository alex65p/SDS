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
package com.apconsulting.luna.ejb.AssociativaAgentoChimico;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IAssociativaAgentoChimico extends EJBObject {
    // Required fields
    //1

    public long getCOD_SOS_CHI();
    //2

    public String getDES_SOS();

    public void setDES_SOS(String strDES_SOS);
    //3

    public String getNOM_COM_SOS();

    public void setNOM_COM_SOS(String strNOM_COM_SOS);
    //4

    public long getCOD_STA_FSC();

    public void setCOD_STA_FSC(long lCOD_STA_FSC);
    //5

    public long getCOD_CLF_SOS();

    public void setCOD_CLF_SOS(long lCOD_CLF_SOS);
    //6

    public long getCOD_PTA_FSC();

    public void setCOD_PTA_FSC(long lCOD_PTA_FSC);
    // 7

    public String getTIP_RSO();

    public void setTIP_RSO(String newTIP_RSO);
    // Not required fields
    //6

    public String getFRS_R();

    public void setFRS_R(String strFRS_R);
    //7

    public String getFRS_S();

    public void setFRS_S(String strFRS_S);
    //8

    public String getSIM_RIS();

    public void setSIM_RIS(String strSIM_RIS);
    //9

    public long getCOD_SIM();

    public void setCOD_SIM(long lCOD_SIM);

    public void addCOD_RSO(long lCOD_RSO, long lCOD_AZL, String strTPL_CLF_RSO);

    public void removeCOD_RSO(long lCOD_RSO);

    public void addSOS_CHI_LUO_FSC(long lCOD_LUO_FSC, long lQTA_GIA, long lQTA_USO, String strTPL_QTA);

    public void editSOS_CHI_LUO_FSC(long lCOD_LUO_FSC, long lQTA_GIA, long lQTA_USO, String strTPL_QTA);

    public void removeSOS_CHI_LUO_FSC(long lCOD_LUO_FSC);

    public void addCOD_FRS_R(long lCOD_FRS_R);

    public void removeCOD_FRS_R(long lCOD_FRS_R);

    public void addCOD_FRS_S(long lCOD_FRS_S);

    public void removeCOD_FRS_S(long lCOD_FRS_S);

    public void addCOD_DOC(long lCOD_DOC);

    public void removeCOD_DOC(long lCOD_DOC);

    public void addCOD_NOR_SEN(long lCOD_NOR_SEN);

    public void removeCOD_NOR_SEN(long lCOD_NOR_SEN);

    // getting RischiAgente list
    public Collection getRischiAgente_View(long lCOD_AZL);
    //<alex date="01/04/2004">

    public String getTipClassView(long lCOD_RSO, long lCOD_AZL);
    //</alex>
}
