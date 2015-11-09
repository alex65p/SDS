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

package com.apconsulting.luna.ejb.TipologiaDocumentiCantiere;

import javax.ejb.EJBObject;

/**
 *
 * @author Alessandro
 */
public interface ITipologiaDocumentiCantiere extends EJBObject {

  //   *Require Fields*
  public long getCOD_TPL_DOC();
  public String getNOM_TPL_DOC();
  public void setNOM_TPL_DOC(String newNOM_TPL_DOC);
  //   *Not require Fields*
  public String getDES_TPL_DOC();
  public void setDES_TPL_DOC (String newDES_TPL_DOC);
  public String getCOL_SOP();
  public void setCOL_SOP (String newCOL_SOP);
  public String getALL_STA_SOP();
  public void setALL_STA_SOP (String newALL_STA_SOP);
  public String getTPL_ACQ_POS();
  public void setTPL_ACQ_POS (String newTPL_ACQ_POS);
}

