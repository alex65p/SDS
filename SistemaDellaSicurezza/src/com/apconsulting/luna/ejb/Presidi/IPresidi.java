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

package com.apconsulting.luna.ejb.Presidi;

import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface  IPresidi extends EJBObject
{
  	public long getCOD_PSD_ACD();
	//
	public long getCOD_CAG_PSD_ACD();
	public void setCOD_CAG_PSD_ACD(long lCOD_CAG_PSD_ACD);
	//
	public String getIDE_PSD_ACD();
	public void setIDE_PSD_ACD(String strIDE_PSD_ACD);
	//
	public java.sql.Date getDAT_ULT_CTL();
	public void setDAT_ULT_CTL(java.sql.Date dtDAT_ULT_CTL);
	//
	public String getESI_ULT_CTL();
	public void setESI_ULT_CTL(String strESI_ULT_CTL);
	//
	public long getCOD_LUO_FSC();
	public void setCOD_LUO_FSC(long lCOD_LUO_FSC);
	//
	public String getSTA_PSD_ACD();
	public void setSTA_PSD_ACD(String strSTA_PSD_ACD);
	//-----------------------------
  	// Link Table DOC_PSD_ACD_TAB
  	public void addCOD_DOC(long newCOD_DOC);
  	public void removeCOD_DOC(long newCOD_DOC);
}
