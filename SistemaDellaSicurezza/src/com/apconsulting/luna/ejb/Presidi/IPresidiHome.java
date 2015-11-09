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

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface IPresidiHome extends EJBHome
{
     public IPresidi create(long lCOD_CAG_PSD_ACD, String strIDE_PSD_ACD, long lCOD_LUO_FSC, String strSTA_PSD_ACD) throws CreateException;
     public IPresidi findByPrimaryKey(Long primaryKey) throws  FinderException;
     public Collection findAll() throws FinderException;
     public void remove(Object primaryKey);
	// opredelenie view metodov
 	public Collection getPresidiDocumentiByID_View(long lCOD_PSD_ACD);
	// by Juli
    public Collection getPresidi_to_SCH_PSD_ACD_View(String SCH_PSD_ACD, long lCOD_AZL, String strSTA_INT, String strCAG_DOC, String strNOM_RSP_INR, long lCOD_CAG_PSD_ACD, String strNOM_CAG_PSD_ACD,  String strIDE_PSD_ACD, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_INR_DAL, java.sql.Date dDAT_INR_AL,String strRAGGRUPPATI, String strSORT_PIF, String strSORT_INT, String strSORT_RSP);
	   // <ALEX>
	   public PresidioView getPresidio(long lCOD_PSD_ACD);
	   public Collection getPresidiAll();
	   public Collection getPresidiByLuogo(long lCOD_LUO_FSC);
	   //</ALEX>
	   //<report>
       public Collection getPSD_Lov(long COD_AZL,long COD_CAG_PSD_ACD, long COD_PSD_ACD, String strNOM_CAG_PSD_ACD, String strIDE_PSD_ACD);
		//--- mary for search
		public Collection findEx(
			java.sql.Date dtDAT_ULT_CTL,
			String strIDE_PSD_ACD,
			String strESI_ULT_CTL,
			Long lCOD_CAG_PSD_ACD,
			Long lCOD_LUO_FSC,
			int iOrderParameter //not used for now
	);
  }
