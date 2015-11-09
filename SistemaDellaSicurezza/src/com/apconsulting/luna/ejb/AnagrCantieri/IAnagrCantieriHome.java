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

package com.apconsulting.luna.ejb.AnagrCantieri;

import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Alessandro
 */
public interface IAnagrCantieriHome extends EJBHome{

 public IAnagrCantieri create(
        String strDES_OPE, String strNOM_OPE, long lCOD_AZL ) throws CreateException;

 public void remove(Object primaryKey);

    public IAnagrCantieri findByPrimaryKey(Long primaryKey) throws FinderException;

//    public Collection getRischi_View(long lCOD_CST, long lCOD_AZL);
    
    public Collection findAll() throws FinderException;

    public Collection findEx(
            String strDES_CAN, String strNOM_CAN, long lCOD_AZL);

    public Collection getAnagr_All_View();

    public Collection getAnagrCantieri_List_View(long lCOD_AZL);

    public Collection getOpere_View(long lCOD_PRO, long lCOD_AZL);
    
 /*   public String EXdeleteAssociationOfRiscFromConstatazioni(
            long lCOD_RSO,
            long lCOD_AZL,
            long lCOD_CST);
    
   */
    }
