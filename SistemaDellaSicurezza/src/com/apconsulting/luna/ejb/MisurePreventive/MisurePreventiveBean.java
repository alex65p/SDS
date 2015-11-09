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
package com.apconsulting.luna.ejb.MisurePreventive;

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
public class MisurePreventiveBean extends BMPEntityBean implements IMisurePreventive, IMisurePreventiveHome {
    //< member-varibles description="Member Variables">

    long lCOD_MIS_RSO_LUO;
    long lCOD_MIS_PET;
    java.sql.Date dtDAT_INZ;
    java.sql.Date dtDAT_FIE;
    String strPRS_MIS_PET;
    long lVER_MIS_PET;
    String strADT_MIS_PET;
    java.sql.Date dtDAT_PAR_ADT;
    String strPER_MIS_PET;
    long lPNZ_MIS_PET_MES;
    java.sql.Date dtDAT_PNZ_MIS_PET;
    String strTPL_DSI_MIS_PET;
    String strDSI_AZL_MIS_PET;
    String strSTA_MIS_PET;
    long lCOD_RSO_LUO_FSC;
    long lCOD_LUO_FSC;
    long lCOD_TPL_MIS_PET;
    String NOM_RSO;
    //long newCOD_MIS_PET;
    //< /member-varibles>

    //< IMisurePreventiveHome-implementation>
    public static final String BEAN_NAME = "MisurePreventiveBean";
    private static MisurePreventiveBean ys = null;

    private MisurePreventiveBean() {
        //
    }

    public static MisurePreventiveBean getInstance() {
        if (ys == null) {
            ys = new MisurePreventiveBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        MisurePreventiveBean bean = new MisurePreventiveBean();
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

    public IMisurePreventive create(long lCOD_MIS_PET, String strPRS_MIS_PET, long lVER_MIS_PET, String strADT_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strDSI_AZL_MIS_PET, String strSTA_MIS_PET, long lCOD_RSO_LUO_FSC, long lCOD_LUO_FSC, long lCOD_TPL_MIS_PET) throws javax.ejb.CreateException {
        MisurePreventiveBean bean = new MisurePreventiveBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_MIS_PET, strPRS_MIS_PET, lVER_MIS_PET, strADT_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strDSI_AZL_MIS_PET, strSTA_MIS_PET, lCOD_RSO_LUO_FSC, lCOD_LUO_FSC, lCOD_TPL_MIS_PET);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_MIS_PET, strPRS_MIS_PET, lVER_MIS_PET, strADT_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strDSI_AZL_MIS_PET, strSTA_MIS_PET, lCOD_RSO_LUO_FSC, lCOD_LUO_FSC, lCOD_TPL_MIS_PET);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IMisurePreventive findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        MisurePreventiveBean bean = new MisurePreventiveBean();
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

    public String getMisurePreventive_ForRSO_View(long RSO_LUO_FSC_ID) {
        return ejbGetMisurePreventive_ForRSO_View(RSO_LUO_FSC_ID);
    }

    public Collection getMisurePreventive_ForMIS_PET_View(long AZL_ID) {
        return (new MisurePreventiveBean()).ejbGetMisurePreventive_ForMIS_PET_View(AZL_ID);
    }

    public Collection getMisurePreventive_ForTPL_PET_View() {
        return (new MisurePreventiveBean()).ejbGetMisurePreventive_ForTPL_PET_View();
    }

    public Collection getMisurePreventive_ForDOC_TAB_View(long MID_PET_ID) {
        return (new MisurePreventiveBean()).ejbGetMisurePreventive_ForDOC_TAB_View(MID_PET_ID);
    }

    public Collection getMisurePreventive_ForNORSEN_TAB_View(long MID_PET_ID) {
        return (new MisurePreventiveBean()).ejbGetMisurePreventive_ForNORSEN_TAB_View(MID_PET_ID);
    }

    public Collection getMisurePreventive_ForATI_EGZ_TAB_View(long MID_PET_ID) {
        return (new MisurePreventiveBean()).ejbGetMisurePreventive_ForATI_EGZ_TAB_View(MID_PET_ID);
    }
    //

    public Collection getMisurePrev_LuogiFsc_View(String WHE_IN_AZL) {
        return (new MisurePreventiveBean()).ejbGetMisurePrev_LuogiFsc_View(WHE_IN_AZL);
    }
    //

    public Long ejbCreate(long lCOD_MIS_PET, String strPRS_MIS_PET, long lVER_MIS_PET, String strADT_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strDSI_AZL_MIS_PET, String strSTA_MIS_PET, long lCOD_RSO_LUO_FSC, long lCOD_LUO_FSC, long lCOD_TPL_MIS_PET) {
        this.lCOD_MIS_RSO_LUO = NEW_ID();
        this.lCOD_MIS_PET = lCOD_MIS_PET;
        this.strPRS_MIS_PET = strPRS_MIS_PET;
        this.lVER_MIS_PET = lVER_MIS_PET;
        this.strADT_MIS_PET = strADT_MIS_PET;
        this.strPER_MIS_PET = strPER_MIS_PET;
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        this.strDSI_AZL_MIS_PET = strDSI_AZL_MIS_PET;
        this.strSTA_MIS_PET = strSTA_MIS_PET;
        this.lCOD_RSO_LUO_FSC = lCOD_RSO_LUO_FSC;
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mis_pet_luo_fsc_tab (cod_mis_rso_luo,cod_mis_pet,prs_mis_pet,ver_mis_pet,adt_mis_pet,per_mis_pet,dat_pnz_mis_pet,tpl_dsi_mis_pet,dsi_azl_mis_pet,sta_mis_pet,cod_rso_luo_fsc,cod_luo_fsc,cod_tpl_mis_pet) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_MIS_RSO_LUO);
            ps.setLong(2, lCOD_MIS_PET);
            ps.setString(3, strPRS_MIS_PET);
            ps.setLong(4, lVER_MIS_PET);
            ps.setString(5, strADT_MIS_PET);
            ps.setString(6, strPER_MIS_PET);
            ps.setDate(7, dtDAT_PNZ_MIS_PET);
            ps.setString(8, strTPL_DSI_MIS_PET);
            ps.setString(9, strDSI_AZL_MIS_PET);
            ps.setString(10, strSTA_MIS_PET);
            ps.setLong(11, lCOD_RSO_LUO_FSC);
            ps.setLong(12, lCOD_LUO_FSC);
            ps.setLong(13, lCOD_TPL_MIS_PET);
            ps.executeUpdate();
            return new Long(lCOD_MIS_RSO_LUO);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lCOD_MIS_PET, String strPRS_MIS_PET, long lVER_MIS_PET, String strADT_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strDSI_AZL_MIS_PET, String strSTA_MIS_PET, long lCOD_RSO_LUO_FSC, long lCOD_LUO_FSC, long lCOD_TPL_MIS_PET) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_rso_luo FROM mis_pet_luo_fsc_tab");
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

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_MIS_RSO_LUO = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_MIS_RSO_LUO = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_rso_luo,cod_mis_pet,dat_inz,dat_fie,prs_mis_pet,ver_mis_pet,adt_mis_pet,dat_par_adt,per_mis_pet,pnz_mis_pet_mes,dat_pnz_mis_pet,tpl_dsi_mis_pet,dsi_azl_mis_pet,sta_mis_pet,cod_rso_luo_fsc,cod_luo_fsc,cod_tpl_mis_pet FROM mis_pet_luo_fsc_tab WHERE cod_mis_rso_luo=?");
            ps.setLong(1, lCOD_MIS_RSO_LUO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_MIS_RSO_LUO = rs.getLong(1);
                lCOD_MIS_PET = rs.getLong(2);
                dtDAT_INZ = rs.getDate(3);
                dtDAT_FIE = rs.getDate(4);
                strPRS_MIS_PET = rs.getString(5);
                lVER_MIS_PET = rs.getLong(6);
                strADT_MIS_PET = rs.getString(7);
                dtDAT_PAR_ADT = rs.getDate(8);
                strPER_MIS_PET = rs.getString(9);
                lPNZ_MIS_PET_MES = rs.getLong(10);
                dtDAT_PNZ_MIS_PET = rs.getDate(11);
                strTPL_DSI_MIS_PET = rs.getString(12);
                strDSI_AZL_MIS_PET = rs.getString(13);
                strSTA_MIS_PET = rs.getString(14);
                lCOD_RSO_LUO_FSC = rs.getLong(15);
                lCOD_LUO_FSC = rs.getLong(16);
                lCOD_TPL_MIS_PET = rs.getLong(17);
            } else {
                throw new NoSuchEntityException("MisurePreventive with ID=" + lCOD_MIS_RSO_LUO + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mis_pet_luo_fsc_tab WHERE cod_mis_rso_luo=?");
            ps.setLong(1, lCOD_MIS_RSO_LUO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("MisurePreventive with ID=" + lCOD_MIS_RSO_LUO + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE mis_pet_luo_fsc_tab SET cod_mis_pet=?, dat_inz=?, dat_fie=?, prs_mis_pet=?, ver_mis_pet=?, adt_mis_pet=?, dat_par_adt=?, per_mis_pet=?, pnz_mis_pet_mes=?, dat_pnz_mis_pet=?, tpl_dsi_mis_pet=?, dsi_azl_mis_pet=?, sta_mis_pet=?, cod_rso_luo_fsc=?, cod_luo_fsc=?, cod_tpl_mis_pet=? WHERE cod_mis_rso_luo=?");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setDate(2, dtDAT_INZ);
            ps.setDate(3, dtDAT_FIE);
            ps.setString(4, strPRS_MIS_PET);
            ps.setLong(5, lVER_MIS_PET);
            ps.setString(6, strADT_MIS_PET);
            ps.setDate(7, dtDAT_PAR_ADT);
            ps.setString(8, strPER_MIS_PET);
            if (lPNZ_MIS_PET_MES == 0) {
                ps.setNull(9, java.sql.Types.BIGINT);
            } else {
                ps.setLong(9, lPNZ_MIS_PET_MES);
            }
            ps.setDate(10, dtDAT_PNZ_MIS_PET);
            ps.setString(11, strTPL_DSI_MIS_PET);
            ps.setString(12, strDSI_AZL_MIS_PET);
            ps.setString(13, strSTA_MIS_PET);
            ps.setLong(14, lCOD_RSO_LUO_FSC);
            ps.setLong(15, lCOD_LUO_FSC);
            ps.setLong(16, lCOD_TPL_MIS_PET);
            ps.setLong(17, lCOD_MIS_RSO_LUO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("MisurePreventive with ID=" + lCOD_MIS_RSO_LUO + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //< setter-getters>
    public long getCOD_MIS_RSO_LUO() {
        return lCOD_MIS_RSO_LUO;
    }

    public long getCOD_MIS_PET() {
        return lCOD_MIS_PET;
    }

    /*public void setCOD_MIS_PET(long lCOD_MIS_PET){
    if(this.lCOD_MIS_PET==lCOD_MIS_PET) return;
    this.lCOD_MIS_PET=lCOD_MIS_PET;
    setModified();
    }*/
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

    public String getPRS_MIS_PET() {
        return strPRS_MIS_PET;
    }

    public void setPRS_MIS_PET(String strPRS_MIS_PET) {
        if ((this.strPRS_MIS_PET != null) && (this.strPRS_MIS_PET.equals(strPRS_MIS_PET))) {
            return;
        }
        this.strPRS_MIS_PET = strPRS_MIS_PET;
        setModified();
    }

    public long getVER_MIS_PET() {
        return lVER_MIS_PET;
    }

    public void setVER_MIS_PET(long lVER_MIS_PET) {
        if (this.lVER_MIS_PET == lVER_MIS_PET) {
            return;
        }
        this.lVER_MIS_PET = lVER_MIS_PET;
        setModified();
    }

    public String getADT_MIS_PET() {
        return strADT_MIS_PET;
    }

    public void setADT_MIS_PET(String strADT_MIS_PET) {
        if ((this.strADT_MIS_PET != null) && (this.strADT_MIS_PET.equals(strADT_MIS_PET))) {
            return;
        }
        this.strADT_MIS_PET = strADT_MIS_PET;
        setModified();
    }

    public java.sql.Date getDAT_PAR_ADT() {
        return dtDAT_PAR_ADT;
    }

    public void setDAT_PAR_ADT(java.sql.Date dtDAT_PAR_ADT) {
        if (this.dtDAT_PAR_ADT == dtDAT_PAR_ADT) {
            return;
        }
        this.dtDAT_PAR_ADT = dtDAT_PAR_ADT;
        setModified();
    }

    public String getPER_MIS_PET() {
        return strPER_MIS_PET;
    }

    public void setPER_MIS_PET(String strPER_MIS_PET) {
        if ((this.strPER_MIS_PET != null) && (this.strPER_MIS_PET.equals(strPER_MIS_PET))) {
            return;
        }
        this.strPER_MIS_PET = strPER_MIS_PET;
        setModified();
    }

    public long getPNZ_MIS_PET_MES() {
        return lPNZ_MIS_PET_MES;
    }

    public void setPNZ_MIS_PET_MES(long lPNZ_MIS_PET_MES) {
        if (this.lPNZ_MIS_PET_MES == lPNZ_MIS_PET_MES) {
            return;
        }
        this.lPNZ_MIS_PET_MES = lPNZ_MIS_PET_MES;
        setModified();
    }

    public java.sql.Date getDAT_PNZ_MIS_PET() {
        return dtDAT_PNZ_MIS_PET;
    }

    public void setDAT_PNZ_MIS_PET(java.sql.Date dtDAT_PNZ_MIS_PET) {
        if (this.dtDAT_PNZ_MIS_PET == dtDAT_PNZ_MIS_PET) {
            return;
        }
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        setModified();
    }

    public String getTPL_DSI_MIS_PET() {
        return strTPL_DSI_MIS_PET;
    }

    public void setTPL_DSI_MIS_PET(String strTPL_DSI_MIS_PET) {
        if ((this.strTPL_DSI_MIS_PET != null) && (this.strTPL_DSI_MIS_PET.equals(strTPL_DSI_MIS_PET))) {
            return;
        }
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        setModified();
    }

    public String getDSI_AZL_MIS_PET() {
        return strDSI_AZL_MIS_PET;
    }

    public void setDSI_AZL_MIS_PET(String strDSI_AZL_MIS_PET) {
        if ((this.strDSI_AZL_MIS_PET != null) && (this.strDSI_AZL_MIS_PET.equals(strDSI_AZL_MIS_PET))) {
            return;
        }
        this.strDSI_AZL_MIS_PET = strDSI_AZL_MIS_PET;
        setModified();
    }

    public String getSTA_MIS_PET() {
        return strSTA_MIS_PET;
    }

    public void setSTA_MIS_PET(String strSTA_MIS_PET) {
        if ((this.strSTA_MIS_PET != null) && (this.strSTA_MIS_PET.equals(strSTA_MIS_PET))) {
            return;
        }
        this.strSTA_MIS_PET = strSTA_MIS_PET;
        setModified();
    }

    public long getCOD_RSO_LUO_FSC() {
        return lCOD_RSO_LUO_FSC;
    }

    /*public void setCOD_RSO_LUO_FSC(long lCOD_RSO_LUO_FSC){
    if(this.lCOD_RSO_LUO_FSC==lCOD_RSO_LUO_FSC) return;
    this.lCOD_RSO_LUO_FSC=lCOD_RSO_LUO_FSC;
    setModified();
    }*/
    public long getCOD_LUO_FSC() {
        return lCOD_LUO_FSC;
    }

    /*public void setCOD_LUO_FSC(long lCOD_LUO_FSC){
    if(this.lCOD_LUO_FSC==lCOD_LUO_FSC) return;
    this.lCOD_LUO_FSC=lCOD_LUO_FSC;
    setModified();
    }*/
    public long getCOD_TPL_MIS_PET() {
        return lCOD_TPL_MIS_PET;
    }

    public void setCOD_TPL_MIS_PET(long lCOD_TPL_MIS_PET) {
        if (this.lCOD_TPL_MIS_PET == lCOD_TPL_MIS_PET) {
            return;
        }
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;
        setModified();
    }

    public void setCOD_LUO_FSC__COD_MIS_PET__COD_RSO_LUO_FSC(long newCOD_LUO_FSC, long newCOD_MIS_PET, long newCOD_RSO_LUO_FSC) {
        if ((lCOD_LUO_FSC == newCOD_LUO_FSC) && (lCOD_MIS_PET == newCOD_MIS_PET) && (lCOD_RSO_LUO_FSC == newCOD_RSO_LUO_FSC)) {
            return;
        }
        lCOD_LUO_FSC = newCOD_LUO_FSC;
        lCOD_MIS_PET = newCOD_MIS_PET;
        lCOD_RSO_LUO_FSC = newCOD_RSO_LUO_FSC;
        setModified();
    }
    //<report>

    public Collection getReportMisurePreventive_View(long lCOD_RSO_MAN) {
        return this.ejbGetReportMisurePreventive_View(lCOD_RSO_MAN);
    }

    public Collection ejbGetReportMisurePreventive_View(long lCOD_RSO_MAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    " SELECT " +
                    " A.COD_MIS_PET_AZL,  " +
                    " A.NOM_MIS_PET, " +
                    " A.DAT_CMP, " +
                    " A.DES_MIS_PET " +
                    " FROM " +
                    " ANA_MIS_PET_AZL_TAB A " +
                    " WHERE " +
                    " A.COD_RSO_MAN=? " +
                    " ORDER BY 2");
            ps.setLong(1, lCOD_RSO_MAN);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportMisurePreventive_View obj = new ReportMisurePreventive_View();
                obj.lCOD_MIS_PET_AZL = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
                obj.dtDAT_CMP = rs.getDate(3);
                obj.strDES_MIS_PET = rs.getString(4);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</report>

    public String ejbGetMisurePreventive_ForRSO_View(long RSO_LUO_FSC_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.nom_rso FROM ana_rso_tab a, rso_luo_fsc_tab b WHERE a.cod_azl=b.cod_azl AND  a.cod_rso=b.cod_rso AND b.cod_rso_luo_fsc=? ");
            ps.setLong(1, RSO_LUO_FSC_ID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                NOM_RSO = rs.getString(1);
            }
            bmp.close();
            return NOM_RSO;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetMisurePreventive_ForMIS_PET_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_mis_pet, " +
                        "nom_mis_pet " +
                    "FROM " +
                        "ana_mis_pet_tab " +
                    "WHERE " +
                        "cod_azl=? " +
                    "ORDER BY " +
                        "nom_mis_pet");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePreventive_ForMIS_PET_View obj = new MisurePreventive_ForMIS_PET_View();
                obj.COD_MIS_PET = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
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

    public Collection ejbGetMisurePreventive_ForTPL_PET_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_tpl_mis_pet, des_tpl_mis_pet FROM tpl_mis_pet_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePreventive_ForTPL_PET_View obj = new MisurePreventive_ForTPL_PET_View();
                obj.COD_TPL_MIS_PET = rs.getLong(1);
                obj.DES_TPL_MIS_PET = rs.getString(2);
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

    public Collection ejbGetMisurePreventive_ForDOC_TAB_View(long MID_PET_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_doc, a.tit_doc, a.rsp_doc, a.dat_rev_doc FROM ana_doc_tab a, doc_mis_pet_tab b WHERE a.cod_doc = b.cod_doc AND b.cod_mis_pet=?");
            ps.setLong(1, MID_PET_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePreventive_ForDOC_TAB_View obj = new MisurePreventive_ForDOC_TAB_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
                obj.RSP_DOC = rs.getString(3);
                obj.DAT_REV_DOC = rs.getDate(4);
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

    public Collection ejbGetMisurePreventive_ForNORSEN_TAB_View(long MID_PET_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_nor_sen, a.tit_nor_sen, a.dat_nor_sen FROM ana_nor_sen_tab a, nor_sen_mis_pet_tab b WHERE a.cod_nor_sen = b.cod_nor_sen AND b.cod_mis_pet=?");
            ps.setLong(1, MID_PET_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePreventive_ForNORSEN_TAB_View obj = new MisurePreventive_ForNORSEN_TAB_View();
                obj.COD_NOR_SEN = rs.getLong(1);
                obj.TIT_NOR_SEN = rs.getString(2);
                obj.DAT_NOR_SEN = rs.getDate(3);
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

    public Collection ejbGetMisurePreventive_ForATI_EGZ_TAB_View(long MID_PET_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_ati_sgz, a.des_ati_sgz, a.dat_sca FROM ana_ati_sgz_tab a, sgz_mis_pet_tab b WHERE a.cod_ati_sgz = b.cod_ati_sgz AND b.cod_mis_pet=?");
            ps.setLong(1, MID_PET_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePreventive_ForATI_EGZ_TAB_View obj = new MisurePreventive_ForATI_EGZ_TAB_View();
                obj.COD_ATI_SGZ = rs.getLong(1);
                obj.DES_ATI_SGZ = rs.getString(2);
                obj.DAT_SCA = rs.getDate(3);
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

    public void addCOD_DOC(long DOC_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_mis_pet_tab (cod_mis_pet,cod_doc) VALUES(?,?)");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, DOC_ID);
            ps.executeUpdate();
        //return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_NOR_SEN(long NOR_SEN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO nor_sen_mis_pet_tab (cod_mis_pet,cod_nor_sen) VALUES(?,?)");
            ps.setLong(1, lCOD_MIS_PET);
            ps.setLong(2, NOR_SEN_ID);
            ps.executeUpdate();
        //return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</setter-getters>

    public Collection ejbGetMisurePrev_LuogiFsc_View(String WHE_IN_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query = 
                    "SELECT "
                        + "a.cod_luo_fsc, "
                        + "a.nom_mis_pet, "
                        + "b.nom_luo_fsc "
                    + "FROM "
                        + "ana_mis_pet_azl_tab a, "
                        + "ana_luo_fsc_tab b "
                    + "WHERE "
                        + "a.cod_luo_fsc = b.cod_luo_fsc "
                        + "AND a.cod_azl in (" + WHE_IN_AZL + ")";
            PreparedStatement ps = bmp.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePrev_LuogiFsc_View obj = new MisurePrev_LuogiFsc_View();
                obj.COD_MIS_RSO_LUO = rs.getLong(1);
                obj.NOM_MIS_PET = rs.getString(2);
                obj.NOM_LUO_FSC = rs.getString(3);
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
//===========================================================================================
}
