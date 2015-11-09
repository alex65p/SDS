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
package com.apconsulting.luna.ejb.GestioneTabellare;

import javax.ejb.EJBObject;

/**
 *
 * @author Dario
 */
public interface IGestioneTabellare extends EJBObject {

    public long getCOD_TAB_UTN();

    public String getTIT_TAB();

    public void setTIT_TAB(String strTIT_TAB);

    public long getNUM_CLN();

    public void setNUM_CLN(long lNUM_CLN);

    public long getCOD_PRG();

    public void setCOD_PRG(long lCOD_PRG);

    public String getNOM_TIT_1();

    public void setNOM_TIT_1(String strNOM_TIT_1);

    public String getNOM_TIT_2();

    public void setNOM_TIT_2(String strNOM_TIT_2);

    public String getNOM_TIT_3();

    public void setNOM_TIT_3(String strNOM_TIT_3);

    public String getNOM_TIT_4();

    public void setNOM_TIT_4(String strNOM_TIT_4);

    public String getNOM_TIT_5();

    public void setNOM_TIT_5(String strNOM_TIT_5);

    public void setCLN(String[] arr, long lCOD_REC);

    public void delCLN(long lCOD_TAB_UTN);
}
