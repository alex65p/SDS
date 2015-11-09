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

package com.apconsulting.luna.ejb.Testimone;

import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface  ITestimone extends EJBObject
{
  	public long getCOD_TST_EVE();

	public String getNOM_TST_EVE();
	public void setNOM_TST_EVE(String strNOM_TST_EVE);

	public String getDES_TST_EVE();
	public void setDES_TST_EVE(String strDES_TST_EVE);

	public String getCTO_TST_EVE();
	public void setCTO_TST_EVE(String strCTO_TST_EVE);

	public long getCOD_INO();
	public void setCOD_INO(long lCOD_INO);
  }
