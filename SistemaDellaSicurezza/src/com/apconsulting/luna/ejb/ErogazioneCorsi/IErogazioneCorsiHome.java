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

package com.apconsulting.luna.ejb.ErogazioneCorsi;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface IErogazioneCorsiHome extends EJBHome
{
   	public IErogazioneCorsi create(
		long lCOD_COR,
		long lCOD_AZL,
		String strSTA_EGZ_COR,
		java.sql.Date dtDAT_PIF_EGZ_COR
	) throws CreateException;
   	public void remove(Object primaryKey);
   	public IErogazioneCorsi findByPrimaryKey(Long primaryKey) throws FinderException;
   	public Collection findAll() throws FinderException;
	//--- view
  	public Collection getErogazioneCorsiNames_View(long lCOD_AZL);
	public Collection getErogazioneCorsi_SelectData_View();
	public Collection getErogazioneCorsi_ForTabDPD_View(long SCH_EGZ_COR_ID);
	public Collection getErogazioneCorsi_ForAssocia_View(long COR_ID, long AZL_ID);
	public String getErogazioneCorsi_ForTabByAZL_View(long AZL_ID);
	public String getErogazioneCorsi_ForTabByDTE_View(long DTE_ID);
   	public Collection getErogazioneCorsi_DTEGet_View();
	public Collection getScadenzario_Corsi_View(
		long lCOD_AZL,
		long lNOM_COR,
		String lNOM_DCT,
		java.sql.Date dDAT_PIF_EGZ_COR_DAL,
		java.sql.Date dDAT_PIF_EGZ_COR_AL,
		String strSTA_INT,
		java.sql.Date dEFF_DAT_DAL,
		java.sql.Date dEFF_DAT_AL,
		String strRAGGRUPPATI,
		String strTYPE);
	public Collection findEx(
		Long lCOD_AZL,
		Long lCOD_COR,
		java.sql.Date dtDAT_PIF_EGZ_COR,
		java.sql.Date dtDAT_EFT_EGZ_COR,
		String strNB_DUR_COR_GOR,
		String strSTA_EGZ_COR,
		String strNB_NOM_TPL_COR,
		int iOrderBy);
}
