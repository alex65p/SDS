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
package com.apconsulting.luna.ejb.Sopraluogo;

import java.util.Collection;
import java.sql.Date;
import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

/**
 *
 * @author Dario
 */
public interface ISopraluogoHome extends EJBHome {

    public ISopraluogo create(
            long lCOD_AZL,
            long lCOD_PRO,
            long lCOD_OPE,
            long lCOD_CAN,
            java.sql.Date dtDAT_SOP,
            String sNUM_SOP,
            java.sql.Time tORA_INI,
            java.sql.Time tORA_FIN) throws CreateException;

    public void remove(Object primaryKey);

    public void removeDPD(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL);

    public void removeDPDImp(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL);

    public void removeCONDIS(Long lCOD_SOP_CST);

    public void removeCOLLEGAMENTO(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL);

    public void removeMEDIA(Long lCOD_MED);

    public void removeDOC_GES_CAN_SOP(Long lCOD_SOP, Long lCOD_DPD, Long lCOD_AZL);

    public ISopraluogo findByPrimaryKey(Long primaryKey) throws FinderException;

    public Collection findAll() throws FinderException;

    public Collection findEx(Long COD_AZL, Long lCOD_PRO, Long lCOD_OPE, Long lCOD_CAN,
            String sNUM_SOP, Date dDAT_SOP, Short sESITO);

    public long getSopraluoghiCount();

    public Collection getDocumentiAssociatiView();

    public AnagDocumentoSopFileInfo getFileInfo();

    public Collection getFattoriRischio(Long lCOD_AZL);
    
    public Collection getConstatazioni(Long lCOD_FAT_RSO, Long lCOD_AZL);

    public Collection getConstatazioniSop(Long lCOD_SOP);

    public jbConstatazione getConstatazione(Long lCOD_CST);

    public jbConstatazione getConstatazioneSOP(Long lCOD_SOP_CST);

    public Collection getMediaSOP(Long lCOD_SOP);

    public Collection getDocumentiCantiereSOP(Long lCOD_SOP);

    public Collection getDocumentiCantiereSOP_STAMPA(Long lCOD_SOP);

    public Collection getRischi(Long lCOD_AZL, Long lCOD_CST);

    public Collection getDisposizioni(Long lCOD_AZL, Long lCOD_RSO);

    public Collection getArticoli(Long lCOD_AZL);

     public Collection getArticoli_GEN(Long lCOD_AZL, Long lCOD_CST);

    public Collection getArticoliDaDisp(Long lCOD_AZL, Long lCOD_DSP, Long lCOD_CST);

    public Long addSOP_CST(
            Long lCOD_SOP_CST, Long lCOD_SOP, Long lCOD_CST, 
            Long lCON_DIS_COD_DTE, Long lCON_DIS_COD_DOC, Long lCOD_AZL, 
            String sCON_DIS_DES_LIB, String sDIS_GEN);

    public Long addSOP_COL(Long lCOD_SOP, Long lCOD_OGGETTO, Integer iTipo);

    public Integer chkPOC_SOP(Long lCOD_PRO, Long lCOD_OPE, Long lCOD_CAN);

    public Boolean chkNUM_SOP(String sNSOP, Date data);

    public Boolean chkCOD_DOC(Long lCOD_DOC, Long lCOD_SOP);

    public Collection buildCollegamentiTab(Long lCOD_SOP);

    public Collection buildCollegamentiForm(Long lCOD_AZL, Long lCOD_SOP);
}
