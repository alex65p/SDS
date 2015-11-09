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
package com.apconsulting.luna.ejb.LuogoFisicoRischio;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.EJBException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

/**
 *
 * @author Dario
 */
public class LuogoFisicoRischioBean extends BMPEntityBean implements ILuogoFisicoRischio, ILuogoFisicoRischioHome {
    //<member-varibles description="Member Variables">

    long lCOD_RSO_LUO_FSC;
    long lCOD_LUO_FSC;
    long lCOD_RSO;
    long lCOD_AZL;
    String strPRS_RSO;
    java.sql.Date dtDAT_INZ;
    java.sql.Date dtDAT_FIE;
    String strNOM_RIL_RSO;
    String strCLF_RSO;
    long lPRB_EVE_LES;
    long lENT_DAN;
    long lFRQ_RIP_ATT_DAN;
    long lNUM_INC_INF;
    float lSTM_NUM_RSO;
    java.sql.Date dtDAT_RFC_VLU_RSO;
    String strSTA_RSO;
    //</member-varibles>

    //<ILuogoFisicoRischioHome-implementation>
    public static final String BEAN_NAME = "LuogoFisicoRischioBean";
    private static LuogoFisicoRischioBean ys = null;

    private LuogoFisicoRischioBean() {
    }

    public static LuogoFisicoRischioBean getInstance() {
        if (ys == null) {
            ys = new LuogoFisicoRischioBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        LuogoFisicoRischioBean bean = new LuogoFisicoRischioBean();
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

    public ILuogoFisicoRischio create(long lCOD_LUO_FSC, long lCOD_RSO, long lCOD_AZL, String strPRS_RSO, java.sql.Date dtDAT_INZ, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, java.sql.Date dtDAT_RFC_VLU_RSO, String strSTA_RSO) throws javax.ejb.CreateException {
        LuogoFisicoRischioBean bean = new LuogoFisicoRischioBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_LUO_FSC, lCOD_RSO, lCOD_AZL, strPRS_RSO, dtDAT_INZ, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, dtDAT_RFC_VLU_RSO, strSTA_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_LUO_FSC, lCOD_RSO, lCOD_AZL, strPRS_RSO, dtDAT_INZ, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF, lSTM_NUM_RSO, dtDAT_RFC_VLU_RSO, strSTA_RSO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public ILuogoFisicoRischio findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        LuogoFisicoRischioBean bean = new LuogoFisicoRischioBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    
    public ILuogoFisicoRischio findByUniqueKey(long lCOD_RSO, long lCOD_AZL, long lCOD_LUO_FSC) {
        return (new LuogoFisicoRischioBean()).ejbFindByUniqueKey(lCOD_RSO, lCOD_AZL, lCOD_LUO_FSC);
    }

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    // (Home Interface) VIEWS
    public Collection getLuogoFisicoRischio_List_View(long COD_AZL) {
        return (new LuogoFisicoRischioBean()).ejbGetLuogoFisicoRischio_List_View(COD_AZL);
    }
    //

    public Collection getLuogoFisicoRischio_Tab_View(long COD_AZL, long COD_LUO_FSC) {
        return (new LuogoFisicoRischioBean()).ejbGetLuogoFisicoRischio_Tab_View(COD_AZL, COD_LUO_FSC);
    }
    //

    public Long ejbCreate(long lCOD_LUO_FSC, long lCOD_RSO, long lCOD_AZL, String strPRS_RSO, java.sql.Date dtDAT_INZ, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, java.sql.Date dtDAT_RFC_VLU_RSO, String strSTA_RSO) {
        this.lCOD_RSO_LUO_FSC = NEW_ID();
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
        this.lCOD_RSO = lCOD_RSO;
        this.lCOD_AZL = lCOD_AZL;
        this.strPRS_RSO = strPRS_RSO;
        this.dtDAT_INZ = dtDAT_INZ;
        this.strNOM_RIL_RSO = strNOM_RIL_RSO;
        this.strCLF_RSO = strCLF_RSO;
        this.lPRB_EVE_LES = lPRB_EVE_LES;
        this.lENT_DAN = lENT_DAN;
        this.lFRQ_RIP_ATT_DAN = lFRQ_RIP_ATT_DAN;
        this.lNUM_INC_INF = lNUM_INC_INF;
        this.lSTM_NUM_RSO = lSTM_NUM_RSO;
        this.dtDAT_RFC_VLU_RSO = dtDAT_RFC_VLU_RSO;
        this.strSTA_RSO = strSTA_RSO;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO rso_luo_fsc_tab (cod_rso_luo_fsc,cod_luo_fsc,cod_rso,cod_azl,prs_rso,dat_inz,nom_ril_rso,clf_rso,prb_eve_les,ent_dan,stm_num_rso,dat_rfc_vlu_rso,sta_rso,frq_rip_att_dan,num_inc_inf) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            ps.setLong(2, lCOD_LUO_FSC);
            ps.setLong(3, lCOD_RSO);
            ps.setLong(4, lCOD_AZL);
            ps.setString(5, strPRS_RSO);
            ps.setDate(6, dtDAT_INZ);
            ps.setString(7, strNOM_RIL_RSO);
            ps.setString(8, strCLF_RSO);
            ps.setLong(9, lPRB_EVE_LES);
            ps.setLong(10, lENT_DAN);
            ps.setFloat(11, lSTM_NUM_RSO);
            ps.setDate(12, dtDAT_RFC_VLU_RSO);
            ps.setString(13, strSTA_RSO);
            ps.setLong(14, lFRQ_RIP_ATT_DAN);
            ps.setLong(15, lNUM_INC_INF);
            ps.executeUpdate();
            return new Long(lCOD_RSO_LUO_FSC);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lCOD_LUO_FSC, long lCOD_RSO, long lCOD_AZL, String strPRS_RSO, java.sql.Date dtDAT_INZ, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF, float lSTM_NUM_RSO, java.sql.Date dtDAT_RFC_VLU_RSO, String strSTA_RSO) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_rso_luo_fsc FROM rso_luo_fsc_tab");
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
        this.lCOD_RSO_LUO_FSC = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_RSO_LUO_FSC = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_rso_luo_fsc, cod_luo_fsc, cod_rso, cod_azl, prs_rso, dat_inz, dat_fie, nom_ril_rso, clf_rso, prb_eve_les, ent_dan, stm_num_rso, dat_rfc_vlu_rso, sta_rso, frq_rip_att_dan, num_inc_inf FROM rso_luo_fsc_tab WHERE cod_rso_luo_fsc=?");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_RSO_LUO_FSC = rs.getLong(1);
                lCOD_LUO_FSC = rs.getLong(2);
                lCOD_RSO = rs.getLong(3);
                lCOD_AZL = rs.getLong(4);
                strPRS_RSO = rs.getString(5);
                dtDAT_INZ = rs.getDate(6);
                dtDAT_FIE = rs.getDate(7);
                strNOM_RIL_RSO = rs.getString(8);
                strCLF_RSO = rs.getString(9);
                lPRB_EVE_LES = rs.getLong(10);
                lENT_DAN = rs.getLong(11);
                lSTM_NUM_RSO = rs.getFloat(12);
                dtDAT_RFC_VLU_RSO = rs.getDate(13);
                strSTA_RSO = rs.getString(14);
                lFRQ_RIP_ATT_DAN = rs.getLong(15);
                lNUM_INC_INF = rs.getLong(16);
            } else {
                throw new NoSuchEntityException("LuogoFisicoRischio with ID=" + lCOD_RSO_LUO_FSC + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM rso_luo_fsc_tab WHERE cod_rso_luo_fsc=?");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("LuogoFisicoRischio with ID=" + lCOD_RSO_LUO_FSC + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE rso_luo_fsc_tab SET cod_rso_luo_fsc=?, cod_luo_fsc=?, cod_rso=?, cod_azl=?, prs_rso=?, dat_inz=?, dat_fie=?, nom_ril_rso=?, clf_rso=?, prb_eve_les=?, ent_dan=?, stm_num_rso=?, dat_rfc_vlu_rso=?, sta_rso=?, frq_rip_att_dan=?, num_inc_inf=? WHERE cod_rso_luo_fsc=?");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            ps.setLong(2, lCOD_LUO_FSC);
            ps.setLong(3, lCOD_RSO);
            ps.setLong(4, lCOD_AZL);
            ps.setString(5, strPRS_RSO);
            ps.setDate(6, dtDAT_INZ);
            ps.setDate(7, dtDAT_FIE);
            ps.setString(8, strNOM_RIL_RSO);
            ps.setString(9, strCLF_RSO);
            ps.setLong(10, lPRB_EVE_LES);
            ps.setLong(11, lENT_DAN);
            ps.setFloat(12, lSTM_NUM_RSO);
            ps.setDate(13, dtDAT_RFC_VLU_RSO);
            ps.setString(14, strSTA_RSO);
            ps.setLong(15, lFRQ_RIP_ATT_DAN);
            ps.setLong(16, lNUM_INC_INF);
            ps.setLong(17, lCOD_RSO_LUO_FSC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("LuogoFisicoRischio with ID=" + lCOD_RSO_LUO_FSC + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public ILuogoFisicoRischio ejbFindByUniqueKey(long lCOD_RSO, long lCOD_AZL, long lCOD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "COD_RSO_LUO_FSC "
                    + "FROM "
                        + "RSO_LUO_FSC_TAB "
                    + "WHERE "
                        + "COD_RSO = ? "
                        + "AND COD_AZL = ? "
                        + "AND COD_LUO_FSC = ?");                    
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return findByPrimaryKey(rs.getLong(1));
            }
            bmp.close();
            return null;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    //----------------------------------------------------
    public void removeMisure(long l) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM mis_pet_luo_fsc_tab " + " WHERE cod_rso_luo_fsc=? AND cod_mis_rso_luo=?");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            ps.setLong(2, l);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Misure Preventive with ID=" + l + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<setter-getters>
    public long getCOD_RSO_LUO_FSC() {
        return lCOD_RSO_LUO_FSC;
    }

    public long getCOD_LUO_FSC() {
        return lCOD_LUO_FSC;
    }

    public void setCOD_LUO_FSC(long lCOD_LUO_FSC) {
        if (this.lCOD_LUO_FSC == lCOD_LUO_FSC) {
            return;
        }
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
        setModified();
    }

    public long getCOD_RSO() {
        return lCOD_RSO;
    }

    public void setCOD_RSO(long lCOD_RSO) {
        if (this.lCOD_RSO == lCOD_RSO) {
            return;
        }
        this.lCOD_RSO = lCOD_RSO;
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

    public void setCOD_LUO_FSC__COD_RSO__COD_AZL(long lCOD_LUO_FSC, long lCOD_RSO, long lCOD_AZL) {
        if ((this.lCOD_LUO_FSC == lCOD_LUO_FSC) && (this.lCOD_RSO == lCOD_RSO) && (this.lCOD_AZL == lCOD_AZL)) {
            return;
        }
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
        this.lCOD_RSO = lCOD_RSO;
        this.lCOD_AZL = lCOD_AZL;
        setModified();
    }

    public String getPRS_RSO() {
        return strPRS_RSO;
    }

    public void setPRS_RSO(String strPRS_RSO) {
        if ((this.strPRS_RSO != null) && (this.strPRS_RSO.equals(strPRS_RSO))) {
            return;
        }
        this.strPRS_RSO = strPRS_RSO;
        setModified();
    }

    public java.sql.Date getDAT_INZ() {
        return dtDAT_INZ;
    }

    public void setDAT_INZ(java.sql.Date dtDAT_INZ) {
        if (this.dtDAT_INZ == dtDAT_INZ) {
            return;
        }
        this.dtDAT_INZ = dtDAT_INZ;
        setModified();
    }

    public java.sql.Date getDAT_FIE() {
        return dtDAT_FIE;
    }

    public void setDAT_FIE(java.sql.Date dtDAT_FIE) {
        if (this.dtDAT_FIE == dtDAT_FIE) {
            return;
        }
        this.dtDAT_FIE = dtDAT_FIE;
        setModified();
    }

    public String getNOM_RIL_RSO() {
        return strNOM_RIL_RSO;
    }

    public void setNOM_RIL_RSO(String strNOM_RIL_RSO) {
        if ((this.strNOM_RIL_RSO != null) && (this.strNOM_RIL_RSO.equals(strNOM_RIL_RSO))) {
            return;
        }
        this.strNOM_RIL_RSO = strNOM_RIL_RSO;
        setModified();
    }

    public String getCLF_RSO() {
        return strCLF_RSO;
    }

    public void setCLF_RSO(String strCLF_RSO) {
        if ((this.strCLF_RSO != null) && (this.strCLF_RSO.equals(strCLF_RSO))) {
            return;
        }
        this.strCLF_RSO = strCLF_RSO;
        setModified();
    }

    public long getPRB_EVE_LES() {
        return lPRB_EVE_LES;
    }

    public void setPRB_EVE_LES(long lPRB_EVE_LES) {
        if (this.lPRB_EVE_LES == lPRB_EVE_LES) {
            return;
        }
        this.lPRB_EVE_LES = lPRB_EVE_LES;
        setModified();
    }

    public long getENT_DAN() {
        return lENT_DAN;
    }

    public void setENT_DAN(long lENT_DAN) {
        if (this.lENT_DAN == lENT_DAN) {
            return;
        }
        this.lENT_DAN = lENT_DAN;
        setModified();
    }

    public long getFRQ_RIP_ATT_DAN() {
        return lFRQ_RIP_ATT_DAN;
    }

    public void setFRQ_RIP_ATT_DAN(long lFRQ_RIP_ATT_DAN) {
        if (this.lFRQ_RIP_ATT_DAN == lFRQ_RIP_ATT_DAN) {
            return;
        }
        this.lFRQ_RIP_ATT_DAN = lFRQ_RIP_ATT_DAN;
        setModified();
    }

    public long getNUM_INC_INF() {
        return lNUM_INC_INF;
    }

    public void setNUM_INC_INF(long lNUM_INC_INF) {
        if (this.lNUM_INC_INF == lNUM_INC_INF) {
            return;
        }
        this.lNUM_INC_INF = lNUM_INC_INF;
        setModified();
    }

    public float getSTM_NUM_RSO() {
        return lSTM_NUM_RSO;
    }

    public void setSTM_NUM_RSO(float lSTM_NUM_RSO) {
        if (this.lSTM_NUM_RSO == lSTM_NUM_RSO) {
            return;
        }
        this.lSTM_NUM_RSO = lSTM_NUM_RSO;
        setModified();
    }

    public java.sql.Date getDAT_RFC_VLU_RSO() {
        return dtDAT_RFC_VLU_RSO;
    }

    public void setDAT_RFC_VLU_RSO(java.sql.Date dtDAT_RFC_VLU_RSO) {
        if (this.dtDAT_RFC_VLU_RSO == dtDAT_RFC_VLU_RSO) {
            return;
        }
        this.dtDAT_RFC_VLU_RSO = dtDAT_RFC_VLU_RSO;
        setModified();
    }

    public String getSTA_RSO() {
        return strSTA_RSO;
    }

    public void setSTA_RSO(String strSTA_RSO) {
        if ((this.strSTA_RSO != null) && (this.strSTA_RSO.equals(strSTA_RSO))) {
            return;
        }
        this.strSTA_RSO = strSTA_RSO;
        setModified();
    }
    //</setter-getters>

    // %%%Update%%% Table MIS_PET_LUO_FSC_TAB  --- forest
    public void editDatFine(String strchDatFine) {
        BMPConnection bmp = getConnection();
        try {
            java.util.Date dt = new java.util.Date();
            java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE mis_pet_luo_fsc_tab SET  prs_mis_pet=?, dat_fie=? WHERE prs_mis_pet=? AND cod_rso_luo_fsc=? AND cod_luo_fsc=? AND cod_mis_rso_luo NOT IN (" + strchDatFine + ") ");
            ps.setString(1, "N");
            ps.setDate(2, CUR_DAT);
            ps.setString(3, "S");
            ps.setLong(4, this.lCOD_RSO_LUO_FSC);
            ps.setLong(5, this.lCOD_LUO_FSC);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetLuogoFisicoRischio_List_View(long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT a.cod_rso_luo_fsc, a.nom_ril_rso, " + " b.nom_rso " + " FROM rso_luo_fsc_tab a, ana_rso_tab b " + " WHERE a.cod_rso=b.cod_rso " + " AND a.cod_azl=b.cod_azl " + " AND a.cod_azl=? " + " ORDER BY a.nom_ril_rso ");
            ps.setLong(1, COD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                LuogoFisicoRischio_List_View obj = new LuogoFisicoRischio_List_View();
                obj.COD_RSO_LUO_FSC = rs.getLong(1);
                obj.NOM_RIL_RSO = rs.getString(2);
                obj.NOM_RSO = rs.getString(3);
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

    public Collection ejbGetLuogoFisicoRischio_Tab_View(long COD_AZL, long COD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_rso_luo_fsc, "
                        + "b.nom_rso "
                    + "FROM "
                        + "rso_luo_fsc_tab a, "
                        + "ana_rso_tab b "
                    + "WHERE "
                        + "a.cod_azl=b.cod_azl "
                        + "AND a.cod_rso=b.cod_rso "
                        + "AND a.cod_azl=? "
                        + "AND a.cod_luo_fsc=? "
                    + "ORDER BY "
                        + "nom_rso ");
            ps.setLong(1, COD_AZL);
            ps.setLong(2, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                LuogoFisicoRischio_Tab_View obj = new LuogoFisicoRischio_Tab_View();
                obj.COD_RSO_LUO_FSC = rs.getLong(1);
                obj.NOM_RSO = rs.getString(2);
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
    //-------------------

    public Collection getLuogiFisicoMisureView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "ampt.nom_mis_pet, "
                        + "mplft.ver_mis_pet, "
                        + "mplft.dat_inz, "
                        + "mplft.dat_fie, "
                        + "mplft.prs_mis_pet, "
                        + "mplft.cod_mis_rso_luo "
                    + "FROM "
                        + "mis_pet_luo_fsc_tab mplft, "
                        + "ana_mis_pet_tab ampt "
                    + "WHERE "
                        + "mplft.cod_mis_pet=ampt.cod_mis_pet "
                        + "AND mplft.cod_luo_fsc=? "
                        + "AND mplft.cod_rso_luo_fsc=?");

            ps.setLong(1, lCOD_LUO_FSC);
            ps.setLong(2, lCOD_RSO_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                LuogiFisicoMisure_View v = new LuogiFisicoMisure_View();
                v.strNOM_MIS_PET = rs.getString(1);
                v.lVER_MIS_PET = rs.getLong(2);
                v.dtDAT_INZ = rs.getDate(3);
                v.dtDAT_FIE = rs.getDate(4);
                v.strPRS_MIS_PET = rs.getString(5);
                v.lCOD_MIS_RSO_LUO = rs.getLong(6);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getLuogiFisicoDocumentiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_doc_tab.cod_doc," + " ana_doc_tab.tit_doc" + " FROM doc_rso_tab, ana_doc_tab, rso_luo_fsc_tab" + " WHERE " + " doc_rso_tab.cod_doc=ana_doc_tab.cod_doc" + " AND doc_rso_tab.cod_azl=rso_luo_fsc_tab.cod_azl" + " AND doc_rso_tab.cod_rso=rso_luo_fsc_tab.cod_rso" + " AND rso_luo_fsc_tab.cod_rso_luo_fsc=?");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                LuogiFisicoDocumenti_View v = new LuogiFisicoDocumenti_View();
                v.lCOD_DOC = rs.getLong(1);
                v.strTIT_DOC = rs.getString(2);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getLuogiFisicoNormativeView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " + " ana_nor_sen_tab.cod_nor_sen," + " ana_nor_sen_tab.tit_nor_sen " + " FROM nor_sen_rso_tab, ana_nor_sen_tab, rso_luo_fsc_tab" + " WHERE" + " nor_sen_rso_tab.cod_nor_sen=ana_nor_sen_tab.cod_nor_sen" + " AND nor_sen_rso_tab.cod_azl=rso_luo_fsc_tab.cod_azl" + " AND nor_sen_rso_tab.cod_rso=rso_luo_fsc_tab.cod_rso" + " AND rso_luo_fsc_tab.cod_rso_luo_fsc=?");
            ps.setLong(1, lCOD_RSO_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                LuogiFisicoNormative_View v = new LuogiFisicoNormative_View();
                v.lCOD_NOR_SEN = rs.getLong(1);
                v.strTIT_NOR_SEN = rs.getString(2);
                ar.add(v);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /*<comment date="01/03/2004" author="Roman Chumachenko">
    <description>Connection to Rischio Object</description>
    </comment>*/
    public Collection getNotAssMesure_View(long COD_RSO, long COD_LUO_FSC) {
        BMPConnection bmp = getConnection();
        PreparedStatement ps = null;
        try {
            ps = bmp.prepareStatement(
                    "SELECT COD_MIS_PET, VER_MIS_PET, NOM_MIS_PET " +
                    "FROM   ANA_MIS_PET_TAB " +
                    "WHERE ( COD_MIS_PET IN ( " +
                    "SELECT A.COD_MIS_PET " +
                    "FROM   RSO_MIS_PET_TAB A " +
                    "WHERE  A.COD_RSO = ? " +
                    // "minus( "+
                    " and A.COD_MIS_PET not in (" +
                    "SELECT A.COD_MIS_PET " +
                    "FROM   MIS_PET_LUO_FSC_TAB A, " +
                    "RSO_LUO_FSC_TAB B " +
                    "WHERE  B.COD_RSO = ? " +
                    "AND    B.COD_RSO_LUO_FSC = A.COD_RSO_LUO_FSC " +
                    "AND    A.COD_LUO_FSC = ? )  ) ) " +
                    "AND COD_AZL = ? " +
                    "ORDER BY COD_MIS_PET");
            ps.setLong(1, COD_RSO);
            ps.setLong(2, COD_RSO);
            ps.setLong(3, COD_LUO_FSC);
            ps.setLong(4, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssLU_NotAssMesure_View obj = new AssLU_NotAssMesure_View();
                obj.COD_MIS_PET = rs.getLong(1);
                obj.VER_MIS_PET = rs.getLong(2);
                obj.NOM_MIS_PET = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
//---------------------------------------
//------------------------------------------------------------

    public String addExMesurePreventive(String[] CODS_OF_MESURES) {
        String result = "";
        BMPConnection bmp = getConnection();
        ResultSet REC_MIS_PET;
        PreparedStatement ps = null;
        PreparedStatement ps_insert = null;
        //----------------------------------------------
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            for (int i = 0; i < CODS_OF_MESURES.length; i++) {
                long id = Long.parseLong(CODS_OF_MESURES[i]);
                //-LIST_OF_MIS_PET-------
                ps = bmp.prepareStatement(
                        "SELECT COD_MIS_PET, " +
                        "VER_MIS_PET, " +
                        "ADT_MIS_PET, " +
                        "DAT_PAR_ADT, " +
                        "PER_MIS_PET, " +
                        "PNZ_MIS_PET_MES, " +
                        "DAT_PNZ_MIS_PET, " +
                        "DSI_AZL_MIS_PET, " +
                        "COD_TPL_MIS_PET " +
                        "FROM ANA_MIS_PET_TAB WHERE COD_MIS_PET = ? ");
                ps.setLong(1, id);
                REC_MIS_PET = ps.executeQuery();
                //------------------------------
                int INC = 1;
                while (REC_MIS_PET.next()) {
                    ps_insert = bmp.prepareStatement(
                            "INSERT INTO MIS_PET_LUO_FSC_TAB( " +
                            "COD_MIS_RSO_LUO, " +
                            "COD_MIS_PET, " +
                            "DAT_INZ, " +
                            "DAT_FIE, " +
                            "PRS_MIS_PET, " +
                            "VER_MIS_PET, " +
                            "ADT_MIS_PET, " +
                            "DAT_PAR_ADT, " +
                            "PER_MIS_PET, " +
                            "PNZ_MIS_PET_MES, " +
                            "DAT_PNZ_MIS_PET, " +
                            "TPL_DSI_MIS_PET, " +
                            "DSI_AZL_MIS_PET, " +
                            "STA_MIS_PET, " +
                            "COD_RSO_LUO_FSC, " +
                            "COD_LUO_FSC, " +
                            "COD_TPL_MIS_PET) " +
                            "VALUES( " +
                            " ?,  " + //COD_MIS_PET_MAN
                            " ?,  " + //COD_MIS_PET
                            " ?,  " + //DAT_INZ
                            " ?,  " + //DAT_FIE
                            " 'S'," + //PRS_MIS_PET
                            " ?,  " + //VER_MIS_PET
                            " ?,  " + //ADT_MIS_PET
                            " ?,  " + //DAT_PAR_ADT
                            " ?,  " + //PER_MIS_PET
                            " ?,  " + //PNZ_MIS_PET_MES
                            " ?,  " + //DAT_PNZ_MIS_PET
                            " 'M'," + //TPL_DSI_MIS_PET
                            " ?,  " + //DSI_AZL_MIS_PET
                            " 'A'," + //STA_MIS_PET
                            " ?,  " + //COD_RSO_LUO_FSC
                            " ?,  " + //COD_LUO_FSC
                            " ? ) " //COD_TPL_MIS_PET
                            );
                    ps_insert.setLong(1, NEW_ID() + INC);
                    ps_insert.setLong(2, id);
                    ps_insert.setDate(3, this.dtDAT_INZ);
                    ps_insert.setDate(4, this.dtDAT_FIE);
                    ps_insert.setLong(5, REC_MIS_PET.getLong(2));
                    ps_insert.setString(6, REC_MIS_PET.getString(3));
                    if (REC_MIS_PET.getDate(4) != null) {
                        ps_insert.setDate(7, REC_MIS_PET.getDate(4));
                    } else {
                        ps_insert.setDate(7, CUR_DAT);
                    }
                    ps_insert.setString(8, REC_MIS_PET.getString(5));
                    ps_insert.setLong(9, REC_MIS_PET.getLong(6));
                    if (REC_MIS_PET.getDate(7) != null) {
                        ps_insert.setDate(10, REC_MIS_PET.getDate(7));
                    } else {
                        ps_insert.setDate(10, CUR_DAT);
                    }
                    ps_insert.setString(11, REC_MIS_PET.getString(8));
                    ps_insert.setLong(12, this.lCOD_RSO_LUO_FSC);
                    ps_insert.setLong(13, this.lCOD_LUO_FSC);
                    ps_insert.setLong(14, REC_MIS_PET.getLong(9));
                    if (ps_insert.executeUpdate() == 0) {
                        result = CODS_OF_MESURES[i];
                    }
                    ps_insert.clearParameters();
                    INC++;
                }// while
                ps.clearParameters();
            }// if
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }
    //--------------------------------------------------------------
    //<comment date="29/03/2004" author="Roman Chumachenko">

    public void addRischioAssociations(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_CUR, REC_MIS_PET, REC_PRO_SAN, REC_DPI, REC_COR;
        //---
        java.util.Date dt = new java.util.Date();
        java.sql.Date CUR_DAT = new java.sql.Date(dt.getTime());
        long lCUR_DATE = CUR_DAT.getTime();
        java.sql.Date SUM_DAT = new java.sql.Date(0L);
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            conn.setAutoCommit(false);
            //---------------REC_CUR------------------
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    " cod_rso,		" +
                    " nom_ril_rso, 	" +
                    " clf_rso, 		" +
                    " prb_eve_les, 	" +
                    " ent_dan, 		" +
                    " frq_rip_att_dan,	" +
                    " num_inc_inf,	" +
                    " stm_num_rso, 	" +
                    " rfc_vlu_rso_mes " +
                    "FROM ana_rso_tab where cod_rso= ? and cod_azl= ?");
            ps.setLong(1, this.lCOD_RSO);
            ps.setLong(2, this.lCOD_AZL);
            //--------------------------
            REC_CUR = ps.executeQuery();
            //--------------------------------------------------
            // Main Loop
            int INC = 1;

            while (REC_CUR.next()) {
                //======================PRO_SAN_MAN=====================================
                if (!ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV)){
                    PreparedStatement ps_pro_san = bmp.prepareStatement(
                            "SELECT a.cod_pro_san " +
                            "FROM pro_san_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ?");
                    ps_pro_san.setLong(1, REC_CUR.getLong(1));
                    ps_pro_san.setLong(2, lCOD_AZL);
                    REC_PRO_SAN = ps_pro_san.executeQuery();
                    while (REC_PRO_SAN.next()) {
                        PreparedStatement ps_pro_san_ins;
                        ps_pro_san_ins = bmp.prepareStatement("select * from pro_san_luo_fsc_tab where cod_pro_san=? and cod_luo_fsc=?");
                        ps_pro_san_ins.setLong(1, REC_PRO_SAN.getLong(1));
                        ps_pro_san_ins.setLong(2, this.lCOD_LUO_FSC);
                        ResultSet rs_test = ps_pro_san_ins.executeQuery();
                        if (rs_test.next()) {
                            continue;
                        }
                        //-------------------
                        ps_pro_san_ins = bmp.prepareStatement(
                                "INSERT INTO pro_san_luo_fsc_tab " +
                                "(cod_pro_san, cod_luo_fsc, prs_pro_san, dat_inz)" +
                                "VALUES ( ?, ?, 'S', ?)");
                        ps_pro_san_ins.setLong(1, REC_PRO_SAN.getLong(1));
                        ps_pro_san_ins.setLong(2, this.lCOD_LUO_FSC);
                        ps_pro_san_ins.setDate(3, CUR_DAT);
                        ps_pro_san_ins.executeUpdate();
                    }
                    REC_PRO_SAN.close();
                }
                //======================DPI_MAN=====================================
                if (!ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV)){
                    PreparedStatement ps_dpi = bmp.prepareStatement(
                            "SELECT a.cod_tpl_dpi " +
                            "FROM dpi_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ? ");
                    ps_dpi.setLong(1, REC_CUR.getLong(1));
                    ps_dpi.setLong(2, lCOD_AZL);
                    REC_DPI = ps_dpi.executeQuery();
                    while (REC_DPI.next()) {
                        PreparedStatement ps_dpi_ins;
                        ps_dpi_ins = bmp.prepareStatement("select * from dpi_luo_fsc_tab where cod_tpl_dpi=? and cod_luo_fsc=?");
                        ps_dpi_ins.setLong(1, REC_DPI.getLong(1));
                        ps_dpi_ins.setLong(2, this.lCOD_LUO_FSC);
                        ResultSet rs_test = ps_dpi_ins.executeQuery();
                        if (rs_test.next()) {
                            continue;
                        }
                        //-----------------
                        ps_dpi_ins = bmp.prepareStatement(
                                "INSERT INTO dpi_luo_fsc_tab " +
                                "(cod_tpl_dpi, cod_luo_fsc, prs_dpi, dat_inz) VALUES (?, ?, 'S', ?)");
                        ps_dpi_ins.setLong(1, REC_DPI.getLong(1));
                        ps_dpi_ins.setLong(2, this.lCOD_LUO_FSC);
                        ps_dpi_ins.setDate(3, CUR_DAT);
                        ps_dpi_ins.executeUpdate();
                    }
                    REC_DPI.close();
                }
                //======================COR_MAN=====================================
                if (!ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV)){
                    PreparedStatement ps_cor = bmp.prepareStatement(
                            "SELECT a.cod_cor " +
                            "FROM cor_rso_tab a WHERE a.cod_rso = ? AND a.cod_azl = ?");
                    ps_cor.setLong(1, REC_CUR.getLong(1));
                    ps_cor.setLong(2, lCOD_AZL);
                    REC_COR = ps_cor.executeQuery();
                    while (REC_COR.next()) {
                        PreparedStatement ps_cor_ins;
                        ps_cor_ins = bmp.prepareStatement(
                                "select * from cor_luo_fsc_tab where cod_cor=? and cod_luo_fsc=?");
                        ps_cor_ins.setLong(1, REC_COR.getLong(1));
                        ps_cor_ins.setLong(2, this.lCOD_LUO_FSC);
                        ResultSet rs_test = ps_cor_ins.executeQuery();
                        if (rs_test.next()) {
                            continue;
                        }
                        //------------------------------------
                        ps_cor_ins = bmp.prepareStatement(
                                "INSERT INTO cor_luo_fsc_tab " +
                                "(cod_cor, cod_luo_fsc, prs_cor, dat_inz) VALUES (?, ?, 'S', ?)");
                        ps_cor_ins.setLong(1, REC_COR.getLong(1));
                        ps_cor_ins.setLong(2, this.lCOD_LUO_FSC);
                        ps_cor_ins.setDate(3, CUR_DAT);
                        ps_cor_ins.executeUpdate();
                    }
                    REC_COR.close();
                }
                //=================================================================
			/*===============================
                === main loop finalization === */
                INC++;
            }// /main loop
            //+++ main block finalization +++
            conn.commit();
            REC_CUR.close();
        //++++++++++++++++++++++++++++++++++++++++++++++
        } catch (Exception ex) {
            try {
                conn.rollback();
            } catch (Exception ex1) {
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex2) {
            }
        }
    }//
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    public void deleteRischioAssociations(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        Connection conn = bmp.getConnection();
        ResultSet REC_CUR, REC_PRO_SAN, REC_DPI, REC_COR;
        //++++++++++++++++++++++++++++++++++++++++++++++
        try {
            conn.setAutoCommit(false);
            //======================PRO_SAN_MAN=================================
            if (!ApplicationConfigurator.isModuleEnabled(MODULES.PRO_SAN_4_ATT_LAV)){
                PreparedStatement ps_pro_san;
                ps_pro_san = bmp.prepareStatement(
                        "SELECT a.cod_pro_san FROM pro_san_luo_fsc_tab a " +
                        "WHERE a.cod_luo_fsc = ?  " +
                        "AND a.cod_pro_san IN " +
                        "(SELECT b.cod_pro_san FROM pro_san_rso_tab b " +
                        "WHERE b.cod_rso = ? AND b.cod_azl =?) " +
                        "AND a.cod_pro_san NOT IN " +
                        "(SELECT c.cod_pro_san from  pro_san_rso_tab c, rso_luo_fsc_tab d " +
                        "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ?)");
                ps_pro_san.setLong(1, this.lCOD_LUO_FSC);
                ps_pro_san.setLong(2, this.lCOD_RSO);
                ps_pro_san.setLong(3, lCOD_AZL);
                ps_pro_san.setLong(4, this.lCOD_RSO);
                ps_pro_san.setLong(5, lCOD_AZL);
                ps_pro_san.setLong(6, this.lCOD_LUO_FSC);
                REC_PRO_SAN = ps_pro_san.executeQuery();
                while (REC_PRO_SAN.next()) {
                    PreparedStatement ps_pro_san_del = bmp.prepareStatement(
                            "DELETE FROM pro_san_luo_fsc_tab WHERE cod_pro_san = ? AND cod_luo_fsc = ? ");
                    ps_pro_san_del.setLong(1, REC_PRO_SAN.getLong(1));
                    ps_pro_san_del.setLong(2, this.lCOD_LUO_FSC);
                    ps_pro_san_del.executeUpdate();
                }
                REC_PRO_SAN.close();
            }
            //======================DPI_MAN=====================================
            if (!ApplicationConfigurator.isModuleEnabled(MODULES.DPI_4_ATT_LAV)){
                PreparedStatement ps_dpi = bmp.prepareStatement(
                        "SELECT a.cod_tpl_dpi FROM dpi_luo_fsc_tab a  " +
                        "WHERE a.cod_luo_fsc =?	AND a.cod_tpl_dpi IN  " +
                        "(SELECT b.cod_tpl_dpi FROM dpi_rso_tab b " +
                        "WHERE b.cod_azl = ?  AND b.cod_rso=? )   " +
                        "AND a.cod_tpl_dpi NOT IN " +
                        "(SELECT c.cod_tpl_dpi FROM dpi_rso_tab c, rso_luo_fsc_tab d " +
                        "WHERE d.cod_rso=c.cod_rso AND d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ? )");
                ps_dpi.setLong(1, this.lCOD_LUO_FSC);
                ps_dpi.setLong(2, lCOD_AZL);
                ps_dpi.setLong(3, this.lCOD_RSO);
                ps_dpi.setLong(4, this.lCOD_RSO);
                ps_dpi.setLong(5, lCOD_AZL);
                ps_dpi.setLong(6, this.lCOD_LUO_FSC);
                REC_DPI = ps_dpi.executeQuery();
                while (REC_DPI.next()) {
                    PreparedStatement ps_dpi_del = bmp.prepareStatement(
                            "DELETE FROM dpi_luo_fsc_tab WHERE cod_tpl_dpi = ? AND cod_luo_fsc = ? ");
                    ps_dpi_del.setLong(1, REC_DPI.getLong(1));
                    ps_dpi_del.setLong(2, this.lCOD_LUO_FSC);
                    ps_dpi_del.executeUpdate();
                }
                REC_DPI.close();
            }
            //======================COR_MAN=====================================
            if (!ApplicationConfigurator.isModuleEnabled(MODULES.CORSI_4_ATT_LAV)){
                PreparedStatement ps_cor = bmp.prepareStatement(
                        "SELECT a.cod_cor  FROM cor_luo_fsc_tab a  " +
                        "WHERE a.cod_luo_fsc = ? AND a.cod_cor IN  " +
                        "(SELECT b.cod_cor FROM cor_rso_tab b  " +
                        "WHERE b.cod_azl= ? AND b.cod_rso = ?) AND a.cod_cor NOT IN  " +
                        "(SELECT c.cod_cor FROM cor_rso_tab c, rso_luo_fsc_tab d  " +
                        "WHERE d.cod_rso=c.cod_rso and d.cod_rso <>? AND d.cod_azl=? AND d.cod_luo_fsc = ? )");
                ps_cor.setLong(1, this.lCOD_LUO_FSC);
                ps_cor.setLong(2, lCOD_AZL);
                ps_cor.setLong(3, this.lCOD_RSO);
                ps_cor.setLong(4, this.lCOD_RSO);
                ps_cor.setLong(5, lCOD_AZL);
                ps_cor.setLong(6, this.lCOD_LUO_FSC);
                REC_COR = ps_cor.executeQuery();
                while (REC_COR.next()) {
                    PreparedStatement ps_cor_del = bmp.prepareStatement(
                            "DELETE FROM cor_luo_fsc_tab WHERE cod_cor = ? AND cod_luo_fsc = ? ");
                    ps_cor_del.setLong(1, REC_COR.getLong(1));
                    ps_cor_del.setLong(2, this.lCOD_LUO_FSC);
                    ps_cor_del.executeUpdate();
                }
                REC_COR.close();
            }
            //======== MIS_PET_LUO_FSC =================
            PreparedStatement ps_mis_pet_del = bmp.prepareStatement(
                    "DELETE FROM mis_pet_luo_fsc_tab " +
                    " WHERE cod_rso_luo_fsc IN " +
                    "(SELECT h.cod_rso_luo_fsc FROM rso_luo_fsc_tab h WHERE h.cod_azl = ? " +
                    "AND h.cod_luo_fsc = ? AND h.cod_rso = ?)");
            ps_mis_pet_del.setLong(1, lCOD_AZL);
            ps_mis_pet_del.setLong(2, this.lCOD_LUO_FSC);
            ps_mis_pet_del.setLong(3, this.lCOD_RSO);
            ps_mis_pet_del.executeUpdate();
            //======== RSO_LUO_FSC =====================
            conn.commit();
        //-------------------------------
        } catch (Exception ex) {
            try {
                conn.rollback();
            } catch (Exception ex1) {
            }
            throw new EJBException(ex);
        } finally {
            try {
                conn.close();
                bmp.close();
            } catch (Exception ex1) {
            }
        }
    }
    //</comment>
}
