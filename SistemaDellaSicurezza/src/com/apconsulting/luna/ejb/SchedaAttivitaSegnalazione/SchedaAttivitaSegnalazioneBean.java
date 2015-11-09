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
package com.apconsulting.luna.ejb.SchedaAttivitaSegnalazione;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class SchedaAttivitaSegnalazioneBean extends BMPEntityBean implements ISchedaAttivitaSegnalazione, ISchedaAttivitaSegnalazioneHome {
    //< member-varibles description="Member Variables">

    long lCOD_SCH_ATI_MNT;
    long lCOD_MNT_MAC;
    long lCOD_MAC;
    long lCOD_DPD;
    String strATI_SVO;
    java.sql.Date dtDAT_ATI_MNT;
    String strESI_ATI_MNT;
    String strPBM_ATI_MNT;
    java.sql.Date dtDAT_PIF_INR;
    String strTPL_ATI;
    long lCOD_AZL;
    //< /member-varibles>
    //< ISchedaAttivitaSegnalazioneHome-implementation>
    public static final String BEAN_NAME = "SchedaAttivitaSegnalazioneBean";
    private static SchedaAttivitaSegnalazioneBean ys = null;

    private SchedaAttivitaSegnalazioneBean() {
    }

    public static SchedaAttivitaSegnalazioneBean getInstance() {
        if (ys == null) {
            ys = new SchedaAttivitaSegnalazioneBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        SchedaAttivitaSegnalazioneBean bean = new SchedaAttivitaSegnalazioneBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

    public ISchedaAttivitaSegnalazione create(long lCOD_MNT_MAC, long lCOD_MAC, long lCOD_DPD, java.sql.Date dtDAT_PIF_INR, String strTPL_ATI, long lCOD_AZL) throws javax.ejb.CreateException {
        SchedaAttivitaSegnalazioneBean bean = new SchedaAttivitaSegnalazioneBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_MNT_MAC, lCOD_MAC, lCOD_DPD, dtDAT_PIF_INR, strTPL_ATI, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_MNT_MAC, lCOD_MAC, lCOD_DPD, dtDAT_PIF_INR, strTPL_ATI, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public ISchedaAttivitaSegnalazione findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        SchedaAttivitaSegnalazioneBean bean = new SchedaAttivitaSegnalazioneBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    //
    //-vews -----------

    public Collection getDocuments__View(long COD_SCH_ATI_MNT) {
        return (new SchedaAttivitaSegnalazioneBean()).ejbGetDocuments__View(COD_SCH_ATI_MNT);
    }
//--- mary ejbGetMacchina_for_SCHMAC_View(lCOD_AZL,  strSCH_MAC);

    public Collection getMacchina_for_SCHMAC_View(long lCOD_AZL, String strSCH_MAC, String strSTA_INT, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_ATI_MNT_DAL, java.sql.Date dDAT_ATI_MNT_AL, String RG_GROUP, long NB_COC_MAC, long NB_COC_DPD, String NB_ATI_SVO, String strTYPE) {
        return (new SchedaAttivitaSegnalazioneBean()).ejbGetMacchina_for_SCHMAC_View(lCOD_AZL, strSCH_MAC, strSTA_INT, dDAT_PIF_INR_DAL, dDAT_PIF_INR_AL, dDAT_ATI_MNT_DAL, dDAT_ATI_MNT_AL, RG_GROUP, NB_COC_MAC, NB_COC_DPD, NB_ATI_SVO, strTYPE);
    }
    //-----------------

    public Long ejbCreate(long lCOD_MNT_MAC, long lCOD_MAC, long lCOD_DPD, java.sql.Date dtDAT_PIF_INR, String strTPL_ATI, long lCOD_AZL) {
        this.lCOD_SCH_ATI_MNT = NEW_ID();
        this.lCOD_MNT_MAC = lCOD_MNT_MAC;
        this.lCOD_MAC = lCOD_MAC;
        this.lCOD_DPD = lCOD_DPD;
        this.dtDAT_PIF_INR = dtDAT_PIF_INR;
        this.strTPL_ATI = strTPL_ATI;
        this.lCOD_AZL = lCOD_AZL;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO sch_ati_mnt_tab (cod_sch_ati_mnt,cod_mnt_mac,cod_mac,cod_dpd,dat_pif_inr,tpl_ati,cod_azl) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_SCH_ATI_MNT);
            ps.setLong(2, lCOD_MNT_MAC);
            ps.setLong(3, lCOD_MAC);
            ps.setLong(4, lCOD_DPD);
            ps.setDate(5, dtDAT_PIF_INR);
            ps.setString(6, strTPL_ATI);
            ps.setLong(7, lCOD_AZL);
            ps.executeUpdate();
            return new Long(lCOD_SCH_ATI_MNT);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lCOD_MNT_MAC, long lCOD_MAC, long lCOD_DPD, java.sql.Date dtDAT_PIF_INR, String strTPL_ATI, long lCOD_AZL) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_ati_mnt FROM sch_ati_mnt_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_SCH_ATI_MNT = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_SCH_ATI_MNT = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sch_ati_mnt,cod_mnt_mac,cod_mac,cod_dpd,ati_svo,dat_ati_mnt,esi_ati_mnt,pbm_ati_mnt,dat_pif_inr,tpl_ati,cod_azl FROM sch_ati_mnt_tab WHERE cod_sch_ati_mnt=?");
            ps.setLong(1, lCOD_SCH_ATI_MNT);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_SCH_ATI_MNT = rs.getLong(1);
                lCOD_MNT_MAC = rs.getLong(2);
                lCOD_MAC = rs.getLong(3);
                lCOD_DPD = rs.getLong(4);
                strATI_SVO = rs.getString(5);
                dtDAT_ATI_MNT = rs.getDate(6);
                strESI_ATI_MNT = rs.getString(7);
                strPBM_ATI_MNT = rs.getString(8);
                dtDAT_PIF_INR = rs.getDate(9);
                strTPL_ATI = rs.getString(10);
                lCOD_AZL = rs.getLong(11);
            } else {
                throw new NoSuchEntityException("SchedaAttivitaSegnalazione with ID=" + lCOD_SCH_ATI_MNT + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM sch_ati_mnt_tab WHERE cod_sch_ati_mnt=?");
            ps.setLong(1, lCOD_SCH_ATI_MNT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("SchedaAttivitaSegnalazione with ID=" + lCOD_SCH_ATI_MNT + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE sch_ati_mnt_tab SET cod_sch_ati_mnt=?, cod_mnt_mac=?, cod_mac=?, cod_dpd=?, ati_svo=?, dat_ati_mnt=?, esi_ati_mnt=?, pbm_ati_mnt=?, dat_pif_inr=?, tpl_ati=?, cod_azl=? WHERE cod_sch_ati_mnt=?");
            ps.setLong(1, lCOD_SCH_ATI_MNT);
            ps.setLong(2, lCOD_MNT_MAC);
            ps.setLong(3, lCOD_MAC);
            ps.setLong(4, lCOD_DPD);
            ps.setString(5, strATI_SVO);
            ps.setDate(6, dtDAT_ATI_MNT);
            ps.setString(7, strESI_ATI_MNT);
            ps.setString(8, strPBM_ATI_MNT);
            ps.setDate(9, dtDAT_PIF_INR);
            ps.setString(10, strTPL_ATI);
            ps.setLong(11, lCOD_AZL);
            ps.setLong(12, lCOD_SCH_ATI_MNT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("SchedaAttivitaSegnalazione with ID=" + lCOD_SCH_ATI_MNT + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //< setter-getters>
    public long getCOD_SCH_ATI_MNT() {
        return lCOD_SCH_ATI_MNT;
    }

    public long getCOD_MNT_MAC() {
        return lCOD_MNT_MAC;
    }

    public void setCOD_MNT_MAC(long lCOD_MNT_MAC) {
        if (this.lCOD_MNT_MAC == lCOD_MNT_MAC) {
            return;
        }
        this.lCOD_MNT_MAC = lCOD_MNT_MAC;
        setModified();
    }

    public long getCOD_MAC() {
        return lCOD_MAC;
    }

    public void setCOD_MAC(long lCOD_MAC) {
        if (this.lCOD_MAC == lCOD_MAC) {
            return;
        }
        this.lCOD_MAC = lCOD_MAC;
        setModified();
    }

    public long getCOD_DPD() {
        return lCOD_DPD;
    }

    public void setCOD_DPD(long lCOD_DPD) {
        if (this.lCOD_DPD == lCOD_DPD) {
            return;
        }
        this.lCOD_DPD = lCOD_DPD;
        setModified();
    }

    public String getATI_SVO() {
        return strATI_SVO;
    }

    public void setATI_SVO(String strATI_SVO) {
        if ((this.strATI_SVO != null) && (this.strATI_SVO.equals(strATI_SVO))) {
            return;
        }
        this.strATI_SVO = strATI_SVO;
        setModified();
    }

    public java.sql.Date getDAT_ATI_MNT() {
        return dtDAT_ATI_MNT;
    }

    public void setDAT_ATI_MNT(java.sql.Date dtDAT_ATI_MNT) {
        if (this.dtDAT_ATI_MNT == dtDAT_ATI_MNT) {
            return;
        }
        this.dtDAT_ATI_MNT = dtDAT_ATI_MNT;
        setModified();
    }

    public String getESI_ATI_MNT() {
        return strESI_ATI_MNT;
    }

    public void setESI_ATI_MNT(String strESI_ATI_MNT) {
        if ((this.strESI_ATI_MNT != null) && (this.strESI_ATI_MNT.equals(strESI_ATI_MNT))) {
            return;
        }
        this.strESI_ATI_MNT = strESI_ATI_MNT;
        setModified();
    }

    public String getPBM_ATI_MNT() {
        return strPBM_ATI_MNT;
    }

    public void setPBM_ATI_MNT(String strPBM_ATI_MNT) {
        if ((this.strPBM_ATI_MNT != null) && (this.strPBM_ATI_MNT.equals(strPBM_ATI_MNT))) {
            return;
        }
        this.strPBM_ATI_MNT = strPBM_ATI_MNT;
        setModified();
    }

    public java.sql.Date getDAT_PIF_INR() {
        return dtDAT_PIF_INR;
    }

    public void setDAT_PIF_INR(java.sql.Date dtDAT_PIF_INR) {
        if (this.dtDAT_PIF_INR == dtDAT_PIF_INR) {
            return;
        }
        this.dtDAT_PIF_INR = dtDAT_PIF_INR;
        setModified();
    }

    public String getTPL_ATI() {
        return strTPL_ATI;
    }

    public void setTPL_ATI(String strTPL_ATI) {
        if ((this.strTPL_ATI != null) && (this.strTPL_ATI.equals(strTPL_ATI))) {
            return;
        }
        this.strTPL_ATI = strTPL_ATI;
        setModified();
    }

    public long getCOD_AZL() {
        return lCOD_AZL;
    }

    public void setCOD_AZL(long lCOD_AZL) {
        if (this.lCOD_AZL == lCOD_AZL) {
            return;
        }
        this.lCOD_AZL = lCOD_AZL;
        setModified();
    }
    //< /setter-getters>

    //---------#############################################
    // %%%Link%%% Table DOC_SCH_ATI_MNT_TAB
    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO doc_sch_ati_mnt_tab (cod_doc,cod_sch_ati_mnt) VALUES(?,?)");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_SCH_ATI_MNT);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    // %%%UNLink%%% Table DOC_SCH_ATI_MNT_TAB

    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM doc_sch_ati_mnt_tab  WHERE cod_doc=? AND cod_sch_ati_mnt=?");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_SCH_ATI_MNT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sezioni con ID=" + newCOD_DOC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //------#############################################

    public Collection ejbGetDocuments__View(long COD_SCH_ATI_MNT) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT doc.tit_doc, doc.rsp_doc, doc.dat_rev_doc, doc.cod_doc  FROM ana_doc_tab doc, doc_sch_ati_mnt_tab doc_ati WHERE doc.cod_doc=doc_ati.cod_doc  AND  doc_ati.cod_sch_ati_mnt=? ");
            ps.setLong(1, COD_SCH_ATI_MNT);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Documents__View obj = new Documents__View();
                obj.TIT_DOC = rs.getString(1);
                obj.RSP_DOC = rs.getString(2);
                obj.DAT_REV_DOC = rs.getDate(3);
                obj.COD_DOC = rs.getLong(4);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--- mary

    public Collection ejbGetMacchina_for_SCHMAC_View(long lCOD_AZL, String strSCH_MAC, String strSTA_INT, java.sql.Date dDAT_PIF_INR_DAL, java.sql.Date dDAT_PIF_INR_AL, java.sql.Date dDAT_ATI_MNT_DAL, java.sql.Date dDAT_ATI_MNT_AL, String RG_GROUP, long NB_COD_MAC, long NB_COD_DPD, String NB_ATI_SVO, String strTYPE) {
        int icounterWhere = 2;
        int iCOUNT_COD_AZL = 0, iCOUNT_DAT_PIF_INR_DAL = 0, iCOUNT_DAT_PIF_INR_AL = 0, iCOUNT_DAT_ATI_MNT_DAL = 0, iCOUNT_DAT_ATI_MNT_AL = 0;
        int indexATI_SVO = 0, indexCOD_DPD = 0, indexCOD_MAC = 0;
        String strFROM = "", strWHERE = "", strGROUP = "";
        //--- azienda
        if (lCOD_AZL != 0) {
            iCOUNT_COD_AZL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + "AND a.cod_azl = ? ";
        }
        //--- DATA PIANIFICAZIONE 
        if ((dDAT_PIF_INR_DAL != null) && (dDAT_PIF_INR_AL != null)) {
            iCOUNT_DAT_PIF_INR_DAL = icounterWhere;
            icounterWhere++;
            iCOUNT_DAT_PIF_INR_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr BETWEEN ? AND ? ";
        }
        if ((dDAT_PIF_INR_DAL != null) && (dDAT_PIF_INR_AL == null)) {
            iCOUNT_DAT_PIF_INR_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr >= ? ";
        }
        if ((dDAT_PIF_INR_DAL == null) && (dDAT_PIF_INR_AL != null)) {
            iCOUNT_DAT_PIF_INR_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr <= ? ";
        }
        //--- CONTROLLO SULLO STATO D'INTERVENTO
        if (strSTA_INT.equals("G")) {
            strWHERE = strWHERE + " AND a.dat_ati_mnt IS NOT NULL ";
        }
        if (strSTA_INT.equals("D")) {
            strWHERE = strWHERE + " AND a.dat_ati_mnt IS NULL  ";
            dDAT_ATI_MNT_DAL = null;
            dDAT_ATI_MNT_AL = null;
        }
        //--- DATA Effettuale 
        if ((dDAT_ATI_MNT_DAL != null) && (dDAT_ATI_MNT_AL != null)) {
            iCOUNT_DAT_ATI_MNT_DAL = icounterWhere;
            icounterWhere++;
            iCOUNT_DAT_ATI_MNT_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr BETWEEN ? AND ? ";
        }
        if ((dDAT_ATI_MNT_DAL != null) && (dDAT_ATI_MNT_AL == null)) {
            iCOUNT_DAT_ATI_MNT_DAL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr >= ? ";
        }
        if ((dDAT_ATI_MNT_DAL == null) && (dDAT_ATI_MNT_AL != null)) {
            iCOUNT_DAT_ATI_MNT_AL = icounterWhere;
            icounterWhere++;
            strWHERE = strWHERE + " AND a.dat_pif_inr <= ? ";
        }

        if (NB_COD_DPD != 0) {
            strWHERE += " AND a.cod_dpd =?";
            indexCOD_DPD = icounterWhere++;
        }

        if (NB_ATI_SVO != null) {
            strWHERE += " AND a.ati_svo LIKE ?||'%' ";
            indexATI_SVO = icounterWhere++;
        }

        if (NB_COD_MAC != 0) {
            strWHERE += " AND a.cod_mac =?";
            indexCOD_MAC = icounterWhere++;
        }
        String strORDER = "";
        String strSort = "";
        if ("INRup".equals(strTYPE)) {
            strORDER = " ORDER BY a.dat_pif_inr ";
            strSort = ", a.dat_pif_inr ";
        }
        if ("ADTup".equals(strTYPE)) {
            strORDER = " ORDER BY a.dat_ati_mnt ";
            strSort = ", a.dat_ati_mnt ";
        }
        if ("INRdw".equals(strTYPE)) {
            strORDER = " ORDER BY a.dat_pif_inr DESC ";
            strSort = ", a.dat_pif_inr DESC ";
        }
        if ("ADTdw".equals(strTYPE)) {
            strSort = ", a.dat_ati_mnt DESC ";
            strORDER = " ORDER BY a.dat_ati_mnt DESC ";
        }
        if ("N".equals(RG_GROUP)) {
            strGROUP = strORDER;
        } else if ("M".equals(RG_GROUP)) {
            strGROUP = " ORDER BY  d.des_mac " + strSort;
        } else if ("D".equals(RG_GROUP)) {
            strGROUP = " ORDER BY b.cog_dpd " + strSort;
        } else if ("A".equals(RG_GROUP)) {
            strGROUP = " ORDER BY c.rag_scl_azl " + strSort;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_mac, a.cod_sch_ati_mnt, a.dat_pif_inr, a.dat_ati_mnt, b.cog_dpd|| ' ' ||b.nom_dpd, d.des_mac, c.rag_scl_azl, c.cod_azl FROM sch_ati_mnt_tab a, view_ana_dpd_tab b, ana_azl_tab c, ana_mac_tab d " + strFROM + " WHERE a.tpl_ati= ? AND a.cod_dpd=b.cod_dpd AND a.cod_azl=c.cod_azl AND a.cod_mac=d.cod_mac " + strWHERE + " " + strGROUP);
            ps.setString(1, strSCH_MAC);
            if (iCOUNT_COD_AZL != 0) {
                ps.setLong(iCOUNT_COD_AZL, lCOD_AZL);
            }
            if (iCOUNT_DAT_PIF_INR_DAL != 0) {
                ps.setDate(iCOUNT_DAT_PIF_INR_DAL, dDAT_PIF_INR_DAL);
            }
            if (iCOUNT_DAT_PIF_INR_AL != 0) {
                ps.setDate(iCOUNT_DAT_PIF_INR_AL, dDAT_PIF_INR_AL);
            }
            if (iCOUNT_DAT_ATI_MNT_DAL != 0) {
                ps.setDate(iCOUNT_DAT_ATI_MNT_DAL, dDAT_ATI_MNT_DAL);
            }
            if (iCOUNT_DAT_ATI_MNT_AL != 0) {
                ps.setDate(iCOUNT_DAT_ATI_MNT_AL, dDAT_ATI_MNT_AL);
            }
            if (indexCOD_DPD != 0) {
                ps.setLong(indexCOD_DPD, NB_COD_DPD);
            }
            if (indexATI_SVO != 0) {
                ps.setString(indexATI_SVO, NB_ATI_SVO);
            }
            if (indexCOD_MAC != 0) {
                ps.setLong(indexCOD_MAC, NB_COD_MAC);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Macchina_for_SCHMAC_View obj = new Macchina_for_SCHMAC_View();
                obj.COD_MAC = rs.getLong(1);
                obj.COD_SCH_ATI_MNT = rs.getLong(2);
                obj.DAT_PIF_INR = rs.getDate(3);
                obj.DAT_ATI_MNT = rs.getDate(4);
                obj.DIP = rs.getString(5);
                obj.DES_MAC = rs.getString(6);
                obj.RAG_SCL_AZL = rs.getString(7);
                obj.COD_AZL = rs.getLong(8);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
}
