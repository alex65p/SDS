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
package com.apconsulting.luna.ejb.AssRischioAttivita;

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
public class AssRischioAttivitaBean extends BMPEntityBean implements IAssRischioAttivitaHome, IAssRischioAttivita {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    long lCOD_RSO_MAN;				//1
    long lCOD_RSO;					//2
    long lCOD_AZL;					//3
    java.sql.Date dtDAT_INZ;		//4
    String strPRS_RSO;				//5
    String strNOM_RIL_RSO;			//6
    String strCLF_RSO;				//7
    long lPRB_EVE_LES;				//7
    long lENT_DAN;					//8
    float lSTM_NUM_RSO;				//9
    java.sql.Date dtDAT_RFC_VLU_RSO;//10
    String strSTA_RSO;				//11
    long lCOD_MAN;					//12
    // not required --------
    java.sql.Date dtDAT_FIE;		//13
    long lFRQ_RIP_ATT_DAN;
    long lNUM_INC_INF;

////////////////////// CONSTRUCTOR///////////////////
    private static AssRischioAttivitaBean ys = null;

    private AssRischioAttivitaBean() {
    }

    public static AssRischioAttivitaBean getInstance() {
        if (ys == null) {
            ys = new AssRischioAttivitaBean();
        }
        return ys;
    }
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IAssRischioAttivita create(long lCOD_RSO,
            long lCOD_AZL,
            java.sql.Date dtDAT_INZ,
            String strPRS_RSO,
            String strNOM_RIL_RSO,
            String strCLF_RSO,
            long lPRB_EVE_LES,
            long lENT_DAN,
            float lSTM_NUM_RSO,
            java.sql.Date dtDAT_RFC_VLU_RSO,
            String strSTA_RSO,
            long lCOD_MAN,
            long lFRQ_RIP_ATT_DAN,
            long lNUM_INC_INF) throws javax.ejb.CreateException {
        AssRischioAttivitaBean bean = new AssRischioAttivitaBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_RSO, lCOD_AZL, dtDAT_INZ, strPRS_RSO, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN, lSTM_NUM_RSO, dtDAT_RFC_VLU_RSO, strSTA_RSO, lCOD_MAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_RSO, lCOD_AZL, dtDAT_INZ, strPRS_RSO, strNOM_RIL_RSO, strCLF_RSO, lPRB_EVE_LES, lENT_DAN, lSTM_NUM_RSO, dtDAT_RFC_VLU_RSO, strSTA_RSO, lCOD_MAN, lFRQ_RIP_ATT_DAN, lNUM_INC_INF);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AssRischioAttivitaBean bean = new AssRischioAttivitaBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IAssRischioAttivita findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        AssRischioAttivitaBean bean = new AssRischioAttivitaBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public IAssRischioAttivita findByUniqueKey(long lCOD_MAN, long lCOD_RSO, long lCOD_AZL) {
        return (new AssRischioAttivitaBean()).ejbFindByUniqueKey(lCOD_MAN, lCOD_RSO, lCOD_AZL);
    }
    
    // (Home Intrface) findAll()
    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    // (Home Intrface) VIEWS
    public Collection getAssRischioAttivita_View() {
        return (new AssRischioAttivitaBean()).ejbGetAssRischioAttivita_View();
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

//</IAziendaHome-implementation>
//------------------------------------------------------------------------------------------------------
    public Long ejbCreate(long lCOD_RSO, long lCOD_AZL, java.sql.Date dtDAT_INZ, String strPRS_RSO, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, float lSTM_NUM_RSO, java.sql.Date dtDAT_RFC_VLU_RSO, String strSTA_RSO, long lCOD_MAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF) {
        this.lCOD_RSO_MAN = NEW_ID();
        this.lCOD_RSO = lCOD_RSO;
        this.lCOD_AZL = lCOD_AZL;
        this.dtDAT_INZ = dtDAT_INZ;
        this.strPRS_RSO = strPRS_RSO;
        this.strNOM_RIL_RSO = strNOM_RIL_RSO;
        this.strCLF_RSO = strCLF_RSO;
        this.lPRB_EVE_LES = lPRB_EVE_LES;
        this.lENT_DAN = lENT_DAN;
        this.lSTM_NUM_RSO = lSTM_NUM_RSO;
        this.dtDAT_RFC_VLU_RSO = dtDAT_RFC_VLU_RSO;
        this.strSTA_RSO = strSTA_RSO;
        this.lCOD_MAN = lCOD_MAN;
        this.lFRQ_RIP_ATT_DAN = lFRQ_RIP_ATT_DAN;
        this.lNUM_INC_INF = lNUM_INC_INF;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO rso_man_tab " +
                        "(cod_rso_man, " +
                        "cod_rso, " +
                        "cod_azl, " +
                        "dat_inz, " +
                        "prs_rso, " +
                        "nom_ril_rso, " +
                        "clf_rso, " +
                        "prb_eve_les, " +
                        "ent_dan, " +
                        "stm_num_rso, " +
                        "dat_rfc_vlu_rso, " +
                        "sta_rso, " +
                        "cod_man, " +
                        "frq_rip_att_dan, " +
                        "num_inc_inf) " +
                    "VALUES " +
                        "(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_RSO_MAN);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
            ps.setDate(4, dtDAT_INZ);
            ps.setString(5, strPRS_RSO);
            ps.setString(6, strNOM_RIL_RSO);
            ps.setString(7, strCLF_RSO);
            ps.setLong(8, lPRB_EVE_LES);
            ps.setLong(9, lENT_DAN);
            ps.setFloat(10, lSTM_NUM_RSO);
            ps.setDate(11, dtDAT_RFC_VLU_RSO);
            ps.setString(12, strSTA_RSO);
            ps.setLong(13, lCOD_MAN);
            ps.setLong(14, lFRQ_RIP_ATT_DAN);
            ps.setLong(15, lNUM_INC_INF);
            ps.executeUpdate();
            return new Long(lCOD_RSO_MAN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------   
    public void ejbPostCreate(long lCOD_RSO, long lCOD_AZL, java.sql.Date dtDAT_INZ, String strPRS_RSO, String strNOM_RIL_RSO, String strCLF_RSO, long lPRB_EVE_LES, long lENT_DAN, float lSTM_NUM_RSO, java.sql.Date dtDAT_RFC_VLU_RSO, String strSTA_RSO, long lCOD_MAN, long lFRQ_RIP_ATT_DAN, long lNUM_INC_INF) {
    }
//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_rso_man " +
                    "FROM " +
                        "rso_man_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-----------------------------------------------------------
    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------
    public void ejbActivate() {
        this.lCOD_RSO_MAN = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------
    public void ejbPassivate() {
        this.lCOD_RSO_MAN = -1;
    }
//----------------------------------------------------------
    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_rso_man, " +
                        "cod_rso, " +
                        "cod_azl, " +
                        "dat_inz, " +
                        "dat_fie, " +
                        "prs_rso, " +
                        "nom_ril_rso, " +
                        "clf_rso, " +
                        "prb_eve_les, " +
                        "ent_dan, " +
                        "stm_num_rso, " +
                        "dat_rfc_vlu_rso, " +
                        "sta_rso, " +
                        "cod_man," +
                        "frq_rip_att_dan, " +
                        "num_inc_inf " +
                    "FROM " +
                        "rso_man_tab " +
                    "WHERE " +
                        "cod_rso_man=?");
            ps.setLong(1, lCOD_RSO_MAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_RSO_MAN = rs.getLong(1);
                lCOD_RSO = rs.getLong(2);
                lCOD_AZL = rs.getLong(3);
                dtDAT_INZ = rs.getDate(4);
                dtDAT_FIE = rs.getDate(5);
                strPRS_RSO = rs.getString(6);
                strNOM_RIL_RSO = rs.getString(7);
                strCLF_RSO = rs.getString(8);
                lPRB_EVE_LES = rs.getLong(9);
                lENT_DAN = rs.getLong(10);
                lSTM_NUM_RSO = rs.getFloat(11);
                dtDAT_RFC_VLU_RSO = rs.getDate(12);
                strSTA_RSO = rs.getString(13);
                lCOD_MAN = rs.getLong(14);
                lFRQ_RIP_ATT_DAN = rs.getLong(15);
                lNUM_INC_INF = rs.getLong(16);
            } else {
                throw new NoSuchEntityException("AssRischioAttivita with ID=" + lCOD_RSO_MAN + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------
    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM " +
                        "rso_man_tab " +
                    "WHERE " +
                        "cod_rso_man=?");
            ps.setLong(1, lCOD_RSO_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AssRischioAttivita with ID=" + lCOD_RSO_MAN + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------
    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                        "rso_man_tab " +
                    "SET " +
                        "cod_rso=?, " +
                        "cod_azl=?, " +
                        "dat_inz=?, " +
                        "dat_fie=?, " +
                        "prs_rso=?, " +
                        "nom_ril_rso=?, " +
                        "clf_rso=?, " +
                        "prb_eve_les=?, " +
                        "ent_dan=?, " +
                        "stm_num_rso=?, " +
                        "dat_rfc_vlu_rso=?, " +
                        "sta_rso=?, " +
                        "cod_man=?, " +
                        "frq_rip_att_dan=?, " +
                        "num_inc_inf=? " +
                    "WHERE " +
                        "cod_rso_man=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_AZL);
            ps.setDate(3, dtDAT_INZ);
            ps.setDate(4, dtDAT_FIE);
            ps.setString(5, strPRS_RSO);
            ps.setString(6, strNOM_RIL_RSO);
            ps.setString(7, strCLF_RSO);
            ps.setLong(8, lPRB_EVE_LES);
            ps.setLong(9, lENT_DAN);
            ps.setFloat(10, lSTM_NUM_RSO);
            ps.setDate(11, dtDAT_RFC_VLU_RSO);
            ps.setString(12, strSTA_RSO);
            ps.setLong(13, lCOD_MAN);
            ps.setLong(14, lFRQ_RIP_ATT_DAN);
            ps.setLong(15, lNUM_INC_INF);
            ps.setLong(16, lCOD_RSO_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AssRischioAttivita with ID=" + lCOD_RSO_MAN + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public IAssRischioAttivita ejbFindByUniqueKey(long lCOD_MAN, long lCOD_RSO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "COD_RSO_MAN "
                    + "FROM "
                        + "RSO_MAN_TAB "
                    + "WHERE "
                        + "COD_MAN = ? "
                        + "AND COD_RSO = ? "
                        + "AND COD_AZL = ?");                    
            ps.setLong(1, lCOD_MAN);
            ps.setLong(2, lCOD_RSO);
            ps.setLong(3, lCOD_AZL);
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
    
/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //--1
    public long getCOD_RSO_MAN() {
        return lCOD_RSO_MAN;
    }
    //--2
    public long getCOD_RSO() {
        return lCOD_RSO;
    }

    public void setCOD_RSO__COD_MAN__COD_AZL(long lCOD_RSO, long lCOD_MAN, long lCOD_AZL) {
        if ((this.lCOD_RSO == lCOD_RSO) && (this.lCOD_MAN == lCOD_MAN) && (this.lCOD_AZL == lCOD_AZL)) {
            return;
        }
        this.lCOD_RSO = lCOD_RSO;
        this.lCOD_MAN = lCOD_MAN;
        this.lCOD_AZL = lCOD_AZL;
        setModified();
    }
    //--3
    public long getCOD_AZL() {
        return lCOD_AZL;
    }
    //--4
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
    //--5
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
    //--6
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
    //--7
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
    //--8
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
    //--9
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
    //--10
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
    //--11
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
    //--12
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
    //--13
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
    //--14
    public long getCOD_MAN() {
        return lCOD_MAN;
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

//</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    public Collection ejbGetAssRischioAttivita_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "rso_man_tab.cod_rso_man, " +
                        "rso_man_tab.nom_ril_rso, " +
                        "rso_man_tab.prb_eve_les, " +
                        "rso_man_tab.ent_dan, " +
                        "rso_man_tab.dat_rfc_vlu_rso, " +
                        "rso_man_tab.sta_rso, " +
                        "ana_rso_tab.nom_rso, " +
                        "ana_fat_rso_tab.nom_fat_rso, " +
                        "rso_man_tab.stm_num_rso " +
                    "FROM " +
                        "rso_man_tab, " +
                        "ana_rso_tab, " +
                        "ana_fat_rso_tab " +
                    "WHERE " +
                        "rso_man_tab.cod_azl = ana_rso_tab.cod_azl AND " +
                        "rso_man_tab.cod_rso = ana_rso_tab.cod_rso " +
                        "AND ana_rso_tab.cod_fat_rso = ana_fat_rso_tab.cod_fat_rso ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssRischioAttivita_View obj = new AssRischioAttivita_View();
                obj.COD_RSO_MAN = rs.getLong(1);
                obj.NOM_RIL_RSO = rs.getString(2);
                obj.PRB_EVE_LES = rs.getLong(3);
                obj.ENT_DAN = rs.getLong(4);
                obj.DAT_RFC_VLU_RSO = rs.getDate(5);
                obj.STA_RSO = rs.getString(6);
                obj.NOM_RSO = rs.getString(7);
                obj.NOM_FAT_RSO = rs.getString(8);
                obj.STM_NUM_RSO = rs.getFloat(9);
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

    //============= Views for tabs =============================
    //-- MisurePreventive -----------------------
    public Collection getMisurePreventive_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "mis_pet_man_tab.cod_mis_pet_man, " +
                    "ana_mis_pet_tab.nom_mis_pet, " +
                    "mis_pet_man_tab.dat_inz, " +
                    "mis_pet_man_tab.dat_fie, " +
                    "mis_pet_man_tab.prs_mis_pet  " +
                    "FROM  rso_man_tab, ana_mis_pet_tab, mis_pet_man_tab " +
                    "WHERE " +
                    "rso_man_tab.cod_rso_man = mis_pet_man_tab.cod_rso_man " +
                    "AND mis_pet_man_tab.cod_mis_pet = ana_mis_pet_tab.cod_mis_pet " +
                    "AND mis_pet_man_tab.cod_rso_man = ? " +
                    "AND rso_man_tab.cod_azl = ? ");
            ps.setLong(1, this.lCOD_RSO_MAN);
            ps.setLong(2, this.lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssRA_MisurePreventive_View obj = new AssRA_MisurePreventive_View();
                obj.COD_MIS_PET_MAN = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
                obj.DAT_INZ = rs.getDate(3);
                obj.DAT_FIE = rs.getDate(4);
                obj.PRS_MIS_PET = rs.getString(5);

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

    //-- Documenti -----------------------
    public Collection getDocumenti_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "ana_doc_tab.cod_doc, " +
                    "ana_doc_tab.tit_doc, " +
                    "rso_man_tab.cod_rso_man " +
                    "FROM rso_man_tab, doc_rso_tab, ana_doc_tab, ana_rso_tab " +
                    "WHERE " +
                    "rso_man_tab.cod_rso = ana_rso_tab.cod_rso " +
                    "AND ana_rso_tab.cod_rso = doc_rso_tab.cod_rso " +
                    "AND doc_rso_tab.cod_doc =  ana_doc_tab.cod_doc " +
                    "AND  rso_man_tab.cod_rso_man = ? " +
                    "AND  doc_rso_tab.cod_azl = ? ");
            ps.setLong(1, lCOD_RSO_MAN);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssRA_Documenti_View obj = new AssRA_Documenti_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
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

    //-- NormativeSentenze -----------------------
    public Collection getNormativeSentenze_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "ana_nor_sen_tab.cod_nor_sen, " +
                    "ana_nor_sen_tab.tit_nor_sen, " +
                    "rso_man_tab.cod_rso_man " +
                    "FROM " +
                    "rso_man_tab, nor_sen_rso_tab, ana_nor_sen_tab, ana_rso_tab " +
                    "WHERE " +
                    "rso_man_tab.cod_rso = ana_rso_tab.cod_rso " +
                    "AND ana_rso_tab.cod_rso = nor_sen_rso_tab.cod_rso " +
                    "AND nor_sen_rso_tab.cod_nor_sen = ana_nor_sen_tab.cod_nor_sen " +
                    "AND rso_man_tab.cod_rso_man = ? " +
                    "AND  nor_sen_rso_tab.cod_azl = ? ");
            ps.setLong(1, lCOD_RSO_MAN);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssRA_NormativeSentenze_View obj = new AssRA_NormativeSentenze_View();
                obj.COD_NOR_SEN = rs.getLong(1);
                obj.TIT_NOR_SEN = rs.getString(2);
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
    // 
    public int removeAssociatedMisurePreventive() {
        int result = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mis_pet_man_tab WHERE (cod_rso_man=? )");
            ps.setLong(1, this.lCOD_RSO_MAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Associated Misure Preventive non è annulata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            result = 0;
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }

    //------------------------------------------------------------
    public Collection getNotAssMesure_View(long COD_RSO, long COD_MAN) {
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
                    //"MINUS( "+
                    " and A.COD_MIS_PET not in (" +
                    "SELECT A.COD_MIS_PET " +
                    "FROM   MIS_PET_MAN_TAB A, " +
                    "RSO_MAN_TAB B " +
                    "WHERE  B.COD_RSO = ? " +
                    "AND B.COD_RSO_MAN = A.COD_RSO_MAN " +
                    "AND A.COD_MAN     = ? )  ) ) " +
                    "AND COD_AZL = ? " +
                    "ORDER BY COD_MIS_PET");
            ps.setLong(1, COD_RSO);
            ps.setLong(2, COD_RSO);
            ps.setLong(3, COD_MAN);
            ps.setLong(4, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AssRA_NotAssMesure_View obj = new AssRA_NotAssMesure_View();
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
    //------------------------------------------------------------
    public String addExMesurePreventive(String[] CODS_OF_MESURES) {
        String result = "";
        BMPConnection bmp = getConnection();
        ResultSet REC_MIS_PET;
        PreparedStatement ps = null;
        PreparedStatement ps_insert = null;
        //-------------------------------
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
                            "INSERT INTO MIS_PET_MAN_TAB( " +
                            "COD_MIS_PET_MAN, " +
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
                            "COD_RSO_MAN, " +
                            "COD_MAN, " +
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
                            " 'O'," + //TPL_DSI_MIS_PET
                            " ?,  " + //DSI_AZL_MIS_PET
                            " 'A'," + //STA_MIS_PET
                            " ?,  " + //COD_RSO_MAN
                            " ?,  " + //COD_MAN
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
                    ps_insert.setLong(12, this.lCOD_RSO_MAN);
                    ps_insert.setLong(13, this.lCOD_MAN);
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
    //------------------------------------------------------------
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AziendaBean"/>

