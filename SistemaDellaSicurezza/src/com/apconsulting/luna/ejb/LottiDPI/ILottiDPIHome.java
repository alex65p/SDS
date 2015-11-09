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

package com.apconsulting.luna.ejb.LottiDPI;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface ILottiDPIHome extends  ILottiDPI
{
   public ILottiDPI create(
			long lCOD_TPL_DPI,
			String strIDE_LOT_DPI,
			java.sql.Date  dDAT_CSG_LOT,
			long lQTA_FRT,
			long lQTA_AST,
			long lQTA_DSP,
			long lCOD_FOR_AZL,
			long lCOD_AZL
   ) throws CreateException;
   public void remove(Object primaryKey);
   public ILottiDPI findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
   public Collection getLottiDPI_IDE_DATA_View(long AZL_ID);
   public Collection getLottiDPIByFORAZLID_View(long FOR_AZL_ID, long AZL_ID);
   public Collection getLottiDPIByTPLDPIID_View(long TPL_DPI_ID);
   public Collection findEx(
		long lCOD_AZL,
		Long lCOD_TPL_DPI,
		String strIDE_LOT_DPI,
		java.sql.Date	dDAT_CSG_LOT,
		Long lQTA_FRT,
		Long lCOD_FOR_AZL,
		int iOrderParameter //not used for now
  );
}
