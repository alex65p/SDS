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

import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface  ILottiDPI extends EJBObject
{
  //1 COD_LOT_DPI (LottiDPI ID)
  public long getCOD_LOT_DPI();
  //2 COD_TPL_DPI (cod of tipologia)
  public long getCOD_TPL_DPI();
  public void setCOD_TPL_DPI(long newCOD_TPL_DPI);
  //3 IDE_LOT_DPI ()
  public String getIDE_LOT_DPI();
  public void setIDE_LOT_DPI (String newIDE_LOT_DPI );
  //4
  public java.sql.Date getDAT_CSG_LOT();
  public  void setDAT_CSG_LOT(java.sql.Date newDAT_CSG_LOT);
  //5  ()
  public long getQTA_FRT();
  public void setQTA_FRT(long newQTA_FRT);
  //6  ()
  public long getQTA_AST();
  public void setQTA_AST(long newQTA_AST);
  //7  ()
  public long getQTA_DSP();
  public void setQTA_DSP(long newQTA_DSP);
  //8  ()
  public long getCOD_FOR_AZL();
  public void setCOD_FOR_AZL(long newCOD_FOR_AZL);
  //9  ()
  public long getCOD_AZL();
  public void setCOD_AZL(long newCOD_AZL);
}
