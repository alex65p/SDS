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
package com.apconsulting.luna.ejb.RischioChimico;

import java.util.Collection;
import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IRischioChimicoBean extends EJBObject {

    public long getCOD_AZL();

    public long getCOD_MAN();

    public void setCOD_MAN(long lCOD_MAN);

    public long getCOD_OPE_SVO();

    public void setCOD_OPE_SVO(long lCOD_OPE_SVO);

    public long getCOD_SOS_CHI();

    public void setCOD_SOS_CHI(long lCOD_SOS_CHI);

    public long getCOD_QTA();

    public void setCOD_QTA(long lCOD_QTA);

    public long getCOD_CCP();

    public void setCOD_CCP(long lCOD_CCP);

    public long getCOD_TIP();

    public void setCOD_TIP(long lCOD_TIP);

    public long getCOD_CTR();

    public void setCOD_CTR(long lCOD_CTR);

    public long getCOD_TMP_ESP();

    public void setCOD_TMP_ESP(long lCOD_TMP_ESP);

    public long getCOD_DIS();

    public void setCOD_DIS(long lCOD_DIS);

    public long getCOD_ALG();

    public void setCOD_ALG(long lCOD_ALG);

    public double getIDX_RSO_CHI();

    public void calcolaIDX();

    public void store();

    public void storeIdxMan(long lpCOD_MAN);

    public String getDescRischio(double idx);

    public void findByPrimaryKey(long lCOD_MAN, long lCOD_OPE_SVO, long lCOD_SOS_CHI);

    public Collection getQTA_View(long l);

    public Collection getCCP_View();

    public Collection getTIP_View();

    public Collection getCTR_View(long l);

    public Collection getTMP_ESP_View();

    public Collection getDIS_View();

    public Collection getALG_View();
}
