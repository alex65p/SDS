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

package com.apconsulting.luna.ejb.FattoriRischio;

import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface  IFattoriRischio extends EJBObject {
  //--Ruquire fields
  //--COD_FAT_RSO
 	public long getCOD_FAT_RSO();
	//--NOM_FAT_RSO
	public String getNOM_FAT_RSO();
	public void setNOM_FAT_RSO(String strNOM_FAT_RSO);
	//--NUM_FAT_RSO
	public long getNUM_FAT_RSO();
	public void setNUM_FAT_RSO(long lNUM_FAT_RSO);
	//--COD_CAG_FAT_RSO
	public long getCOD_CAG_FAT_RSO();
	public void setCOD_CAG_FAT_RSO(long lCOD_CAG_FAT_RSO);

  //--Not ruquire fields
	//--COD_NOR_SEN
	public long getCOD_NOR_SEN();
	public void setCOD_NOR_SEN(long lCOD_NOR_SEN);
	//DES_FAT_RSO
	public String getDES_FAT_RSO();
	public void setDES_FAT_RSO(String strDES_FAT_RSO);
}
