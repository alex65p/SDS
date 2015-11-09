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
package com.apconsulting.luna.ejb.MisurePreventProtettiveAz;

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
public class MisurePreventProtettiveAzBean extends BMPEntityBean implements IMisurePreventProtettiveAz, IMisurePreventProtettiveAzHome {
    //< member-varibles description="Member Variables">

    long lCOD_MIS_PET_AZL;
    String strNOM_MIS_PET;
    java.sql.Date dtDAT_CMP;
    long lVER_MIS_PET;
    String strPER_MIS_PET;
    long lPNZ_MIS_PET_MES;
    java.sql.Date dtDAT_PNZ_MIS_PET;
    String strDES_MIS_PET;
    String strTPL_DSI_MIS_PET;
    String strSTA_MIS_PET;
    long lCOD_AZL;
    long lCOD_TPL_MIS_PET;
    long lCOD_RSO_MAN;
    long lCOD_MAN;
    long lCOD_RSO_LUO_FSC;
    long lCOD_LUO_FSC;
    //< /member-varibles>

    //< IMisurePreventProtettiveAzHome-implementation>
    public static final String BEAN_NAME = "MisurePreventProtettiveAzBean";

    // CONSTRUCTOR
    private static MisurePreventProtettiveAzBean ys = null;

    private MisurePreventProtettiveAzBean() {
    }

    public static MisurePreventProtettiveAzBean getInstance() {
        if (ys == null) {
            ys = new MisurePreventProtettiveAzBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        MisurePreventProtettiveAzBean bean = new MisurePreventProtettiveAzBean();
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

    public IMisurePreventProtettiveAz create(String strNOM_MIS_PET, java.sql.Date dtDAT_CMP, long lVER_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strSTA_MIS_PET, long lCOD_AZL, long lCOD_TPL_MIS_PET) throws javax.ejb.CreateException {
        MisurePreventProtettiveAzBean bean = new MisurePreventProtettiveAzBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_MIS_PET, dtDAT_CMP, lVER_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strSTA_MIS_PET, lCOD_AZL, lCOD_TPL_MIS_PET);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_MIS_PET, dtDAT_CMP, lVER_MIS_PET, strPER_MIS_PET, dtDAT_PNZ_MIS_PET, strTPL_DSI_MIS_PET, strSTA_MIS_PET, lCOD_AZL, lCOD_TPL_MIS_PET);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IMisurePreventProtettiveAz findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        MisurePreventProtettiveAzBean bean = new MisurePreventProtettiveAzBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll(long lAzienda) throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll(lAzienda);
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getMisure_Preventive_ByAzienda_View(long lCOD_AZL) {
        return (new MisurePreventProtettiveAzBean()).ejbMisure_Preventive_ByAzienda_View(lCOD_AZL);
    }

    public Collection getMisureByLuoghiAndRischiView(long Azienda, long Luogo, String STA, String RSO) {
        return (new MisurePreventProtettiveAzBean()).ejbMisureByLuoghiAndRischiView(Azienda, Luogo, STA, RSO);
    }

    public Collection getMisureByAttivitaAndRischiView(long Azienda, long Attivita, String STA, String RSO) {
        return (new MisurePreventProtettiveAzBean()).ejbMisureByAttivitaAndRischiView(Azienda, Attivita, STA, RSO);
    }

    public Collection getMisureComboView(String strAPL_A) {
        return (new MisurePreventProtettiveAzBean()).ejbGetMisureComboView(strAPL_A);
    }

    public Collection getMisurePreventProtettiveAz_foo_View(
            long lCOD_AZL, long lCOD_MIS_PET_LUO_MAN,
            String strAPL_A, String strNOM_MIS_PET, String strDES_TPL_MIS_PET, String strNOM_RSO,
            java.sql.Date dDAT_PNZ_MIS_PET_DAL, java.sql.Date dDAT_PNZ_MIS_PET_AL,
            String strGROUP, String strVAR_PAR_ADT) {
        return (new MisurePreventProtettiveAzBean()).ejbGetMisurePreventProtettiveAz_foo_View(
                lCOD_AZL, lCOD_MIS_PET_LUO_MAN, strAPL_A, strNOM_MIS_PET, strDES_TPL_MIS_PET, strNOM_RSO,
                dDAT_PNZ_MIS_PET_DAL, dDAT_PNZ_MIS_PET_AL,
                strGROUP, strVAR_PAR_ADT);
    }

    //</ IMisurePreventProtettiveAzHome-implementation>
    public Long ejbCreate(String strNOM_MIS_PET, java.sql.Date dtDAT_CMP, long lVER_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strSTA_MIS_PET, long lCOD_AZL, long lCOD_TPL_MIS_PET) {
        this.lCOD_MIS_PET_AZL = NEW_ID();
        this.strNOM_MIS_PET = strNOM_MIS_PET;
        this.dtDAT_CMP = dtDAT_CMP;
        this.lVER_MIS_PET = lVER_MIS_PET;
        this.strPER_MIS_PET = strPER_MIS_PET;
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
        this.strTPL_DSI_MIS_PET = strTPL_DSI_MIS_PET;
        this.strSTA_MIS_PET = strSTA_MIS_PET;
        this.lCOD_AZL = lCOD_AZL;
        this.lCOD_TPL_MIS_PET = lCOD_TPL_MIS_PET;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_mis_pet_azl_tab (cod_mis_pet_azl,nom_mis_pet,dat_cmp,ver_mis_pet,per_mis_pet,dat_pnz_mis_pet,tpl_dsi_mis_pet,sta_mis_pet,cod_azl,cod_tpl_mis_pet) VALUES(?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ps.setString(2, strNOM_MIS_PET);
            ps.setDate(3, dtDAT_CMP);
            ps.setLong(4, lVER_MIS_PET);
            ps.setString(5, strPER_MIS_PET);
            ps.setDate(6, dtDAT_PNZ_MIS_PET);
            ps.setString(7, strTPL_DSI_MIS_PET);
            ps.setString(8, strSTA_MIS_PET);
            ps.setLong(9, lCOD_AZL);
            ps.setLong(10, lCOD_TPL_MIS_PET);
            ps.executeUpdate();
            return new Long(lCOD_MIS_PET_AZL);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strNOM_MIS_PET, java.sql.Date dtDAT_CMP, long lVER_MIS_PET, String strPER_MIS_PET, java.sql.Date dtDAT_PNZ_MIS_PET, String strTPL_DSI_MIS_PET, String strSTA_MIS_PET, long lCOD_AZL, long lCOD_TPL_MIS_PET) {
    }

    public Collection ejbFindAll(long lAzienda) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_pet_azl FROM ana_mis_pet_azl_tab where cod_azl=? ");
            ps.setLong(1, lAzienda);
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
        this.lCOD_MIS_PET_AZL = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_MIS_PET_AZL = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mis_pet_azl,nom_mis_pet,dat_cmp,ver_mis_pet,per_mis_pet,pnz_mis_pet_mes,dat_pnz_mis_pet,des_mis_pet,tpl_dsi_mis_pet,sta_mis_pet,cod_azl,cod_tpl_mis_pet,cod_rso_man,cod_man,cod_rso_luo_fsc,cod_luo_fsc FROM ana_mis_pet_azl_tab WHERE cod_mis_pet_azl=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_MIS_PET_AZL = rs.getLong(1);
                strNOM_MIS_PET = rs.getString(2);
                dtDAT_CMP = rs.getDate(3);
                lVER_MIS_PET = rs.getLong(4);
                strPER_MIS_PET = rs.getString(5);
                lPNZ_MIS_PET_MES = rs.getLong(6);
                dtDAT_PNZ_MIS_PET = rs.getDate(7);
                strDES_MIS_PET = rs.getString(8);
                strTPL_DSI_MIS_PET = rs.getString(9);
                strSTA_MIS_PET = rs.getString(10);
                lCOD_AZL = rs.getLong(11);
                lCOD_TPL_MIS_PET = rs.getLong(12);
                lCOD_RSO_MAN = rs.getLong(13);
                lCOD_MAN = rs.getLong(14);
                lCOD_RSO_LUO_FSC = rs.getLong(15);
                lCOD_LUO_FSC = rs.getLong(16);
            } else {
                throw new NoSuchEntityException("MisurePreventProtettiveAz with ID=" + lCOD_MIS_PET_AZL + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_mis_pet_azl_tab WHERE cod_mis_pet_azl=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("MisurePreventProtettiveAz with ID=" + lCOD_MIS_PET_AZL + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_mis_pet_azl_tab SET cod_mis_pet_azl=?, nom_mis_pet=?, dat_cmp=?, ver_mis_pet=?, per_mis_pet=?, pnz_mis_pet_mes=?, dat_pnz_mis_pet=?, des_mis_pet=?, tpl_dsi_mis_pet=?, sta_mis_pet=?, cod_azl=?, cod_tpl_mis_pet=?, cod_rso_man=?, cod_man=?, cod_rso_luo_fsc=?, cod_luo_fsc=? WHERE cod_mis_pet_azl=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ps.setString(2, strNOM_MIS_PET);
            ps.setDate(3, dtDAT_CMP);
            ps.setLong(4, lVER_MIS_PET);
            ps.setString(5, strPER_MIS_PET);
            if (lPNZ_MIS_PET_MES == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, lPNZ_MIS_PET_MES);
            }
            ps.setDate(7, dtDAT_PNZ_MIS_PET);
            ps.setString(8, strDES_MIS_PET);
            ps.setString(9, strTPL_DSI_MIS_PET);
            ps.setString(10, strSTA_MIS_PET);
            ps.setLong(11, lCOD_AZL);
            ps.setLong(12, lCOD_TPL_MIS_PET);
            if (lCOD_RSO_MAN == 0) {
                ps.setNull(13, java.sql.Types.BIGINT);
            } else {
                ps.setLong(13, lCOD_RSO_MAN);
            }
            if (lCOD_MAN == 0) {
                ps.setNull(14, java.sql.Types.BIGINT);
            } else {
                ps.setLong(14, lCOD_MAN);
            }
            if (lCOD_RSO_LUO_FSC == 0) {
                ps.setNull(15, java.sql.Types.BIGINT);
            } else {
                ps.setLong(15, lCOD_RSO_LUO_FSC);
            }
            if (lCOD_LUO_FSC == 0) {
                ps.setNull(16, java.sql.Types.BIGINT);
            } else {
                ps.setLong(16, lCOD_LUO_FSC);
            }
            ps.setLong(17, lCOD_MIS_PET_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("MisurePreventProtettiveAz with ID=" + lCOD_MIS_PET_AZL + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //< setter-getters>
    public long getCOD_MIS_PET_AZL() {
        return lCOD_MIS_PET_AZL;
    }

    public String getNOM_MIS_PET() {
        return strNOM_MIS_PET;
    }

    public void setNOM_MIS_PET(String strNOM_MIS_PET) {
        if ((this.strNOM_MIS_PET != null) && (this.strNOM_MIS_PET.equals(strNOM_MIS_PET))) {
            return;
        }
        this.strNOM_MIS_PET = strNOM_MIS_PET;
        setModified();
    }

    public java.sql.Date getDAT_CMP() {
        return dtDAT_CMP;
    }

    public void setDAT_CMP(java.sql.Date dtDAT_CMP) {
        if (this.dtDAT_CMP == dtDAT_CMP) {
            return;
        }
        this.dtDAT_CMP = dtDAT_CMP;
    }

    public long getVER_MIS_PET() {
        return lVER_MIS_PET;
    }

    public void setVER_MIS_PET(long lVER_MIS_PET) {
        if (this.lVER_MIS_PET == lVER_MIS_PET) {
            return;
        }
        this.lVER_MIS_PET = lVER_MIS_PET;
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
    }

    public java.sql.Date getDAT_PNZ_MIS_PET() {
        return dtDAT_PNZ_MIS_PET;
    }

    public void setDAT_PNZ_MIS_PET(java.sql.Date dtDAT_PNZ_MIS_PET) {
        if (this.dtDAT_PNZ_MIS_PET == dtDAT_PNZ_MIS_PET) {
            return;
        }
        this.dtDAT_PNZ_MIS_PET = dtDAT_PNZ_MIS_PET;
    }

    public String getDES_MIS_PET() {
        return strDES_MIS_PET;
    }

    public void setDES_MIS_PET(String strDES_MIS_PET) {
        if ((this.strDES_MIS_PET != null) && (this.strDES_MIS_PET.equals(strDES_MIS_PET))) {
            return;
        }
        this.strDES_MIS_PET = strDES_MIS_PET;
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

    public long getCOD_RSO_MAN() {
        return lCOD_RSO_MAN;
    }

    public void setCOD_RSO_MAN(long lCOD_RSO_MAN) {
        if (this.lCOD_RSO_MAN == lCOD_RSO_MAN) {
            return;
        }
        this.lCOD_RSO_MAN = lCOD_RSO_MAN;
        setModified();
    }

    public long getCOD_MAN() {
        return lCOD_MAN;
    }

    public void setCOD_MAN(long lCOD_MAN) {
        if (this.lCOD_MAN == lCOD_MAN) {
            return;
        }
        this.lCOD_MAN = lCOD_MAN;
        setModified();
    }

    public long getCOD_RSO_LUO_FSC() {
        return lCOD_RSO_LUO_FSC;
    }

    public void setCOD_RSO_LUO_FSC(long lCOD_RSO_LUO_FSC) {
        if (this.lCOD_RSO_LUO_FSC == lCOD_RSO_LUO_FSC) {
            return;
        }
        this.lCOD_RSO_LUO_FSC = lCOD_RSO_LUO_FSC;
        setModified();
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

    public void setCOD_RSO_LUO_FSC_COD_LUO_FSC(long lCOD_RSO_LUO_FSC, long lCOD_LUO_FSC) {
        if (this.lCOD_LUO_FSC == lCOD_LUO_FSC && this.lCOD_RSO_LUO_FSC == lCOD_RSO_LUO_FSC) {
            return;
        }
        this.lCOD_LUO_FSC = lCOD_LUO_FSC;
        this.lCOD_RSO_LUO_FSC = lCOD_RSO_LUO_FSC;
        setModified();
    }

    public void setCOD_RSO_MAN_COD_MAN(long lCOD_RSO_MAN, long lCOD_MAN) {
        if (this.lCOD_RSO_MAN == lCOD_RSO_MAN && this.lCOD_MAN == lCOD_MAN) {
            return;
        }
        this.lCOD_MAN = lCOD_MAN;
        this.lCOD_RSO_MAN = lCOD_RSO_MAN;
        setModified();
    }
    //< /setter-getters>
    //-----------------------------------------------------------

    public Collection ejbMisure_Preventive_ByAzienda_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_mis_pet_azl_tab WHERE cod_azl=? order by nom_mis_pet");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisureByParamsView obj = new MisureByParamsView();
                obj.lCOD_MIS_PET_AZL = rs.getLong(1);
                obj.strNOM_MIS_PET_AZL = rs.getString(2);
                obj.dtDAT_CMP = rs.getDate(3);
                obj.lVER_MIS_PET = rs.getLong(4);
                obj.strPER_MIS_PET = rs.getString(5);
                obj.lPNZ_MIS_PET_MES = rs.getLong(6);
                obj.dtDAT_PNZ_MIS_PET = rs.getDate(7);
                obj.strDES_MIS_PET = rs.getString(8);
                obj.strTPL_DSI_MIS_PET = rs.getString(9);
                obj.strSTA_MIS_PET = rs.getString(10);
                obj.lCOD_AZL = rs.getLong(11);
                obj.lCOD_TPL_MIS_PET = rs.getLong(12);
                obj.lCOD_RSO_MAN = rs.getLong(13);
                obj.lCOD_MAN = rs.getLong(14);
                obj.lCOD_RSO_LUO_FSC = rs.getLong(15);
                obj.lCOD_LUO_FSC = rs.getLong(16);
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

    public Collection getAnagraficaDocumentiView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  doc.cod_doc, doc.tit_doc, doc.rsp_doc, doc.dat_rev_doc from ana_doc_tab doc,  ana_mis_pet_azl_tab mis, doc_mis_pet_azl_tab doc_mis    where   doc.cod_doc=doc_mis.cod_doc and mis.cod_mis_pet_azl=doc_mis.cod_mis_pet_azl and mis.cod_mis_pet_azl=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MPAZ_AnagraficaDocumentiView obj = new MPAZ_AnagraficaDocumentiView();
                obj.lCOD_DOC = rs.getLong(1);
                obj.strTIT_DOC = rs.getString(2);
                obj.strRSP_DOC = rs.getString(3);
                obj.dtDAT_REV_DOC = rs.getDate(4);
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

    public Collection getNormativeSentenzeView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  sen.cod_nor_sen, sen.tit_nor_sen, sen.dat_nor_sen from   ana_nor_sen_tab sen, ana_mis_pet_azl_tab  mis, nor_sen_mis_pet_azl_tab sen_mis where   sen.cod_nor_sen = sen_mis.cod_nor_sen and  mis.cod_mis_pet_azl=sen_mis.cod_mis_pet_azl and mis.cod_mis_pet_azl=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MPAZ_NormativeSentenzeView obj = new MPAZ_NormativeSentenzeView();
                obj.lCOD_NOR_SEN = rs.getLong(1);
                obj.strTIT_NOR_SEN = rs.getString(2);
                obj.dtDAT_NOR_SEN = rs.getDate(3);
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

    public Collection ejbMisureByLuoghiAndRischiView(long Azienda, long Luogo, String STA, String RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_mis_pet_azl , nom_mis_pet, ver_mis_pet from ana_mis_pet_azl_tab a , rso_luo_fsc_tab  b ,	 ana_rso_tab c  where a.cod_rso_luo_fsc = b.cod_rso_luo_fsc and   a.cod_luo_fsc = ? and  c.cod_rso = b.cod_rso and  c.cod_azl = b.cod_azl and  a.cod_azl = ? and  c.nom_rso like ? and a.sta_mis_pet = ? order by nom_mis_pet");
            ps.setLong(1, Luogo);
            ps.setLong(2, Azienda);
            ps.setString(3, RSO);
            ps.setString(4, STA);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisureByParamsView obj = new MisureByParamsView();
                obj.lCOD_MIS_PET_AZL = rs.getLong(1);
                obj.strNOM_MIS_PET_AZL = rs.getString(2);
                obj.lVER_MIS_PET = rs.getLong(3);
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

    public Collection ejbMisureByAttivitaAndRischiView(long Azienda, long Attivita, String STA, String RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_mis_pet_azl , nom_mis_pet, ver_mis_pet  from ana_mis_pet_azl_tab a , rso_man_tab b ,ana_rso_tab c where a.cod_rso_man = b.cod_rso_man and a.cod_man = ? and  c.cod_azl = b.cod_azl  and  c.cod_rso = b.cod_rso and  a.cod_azl = ? and c.nom_rso like ? and a.sta_mis_pet = ? order by nom_mis_pet");
            ps.setLong(1, Attivita);
            ps.setLong(2, Azienda);
            ps.setString(3, RSO);
            ps.setString(4, STA);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisureByParamsView obj = new MisureByParamsView();
                obj.lCOD_MIS_PET_AZL = rs.getLong(1);
                obj.strNOM_MIS_PET_AZL = rs.getString(2);
                obj.lVER_MIS_PET = rs.getLong(3);
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

    public Collection ejbGetMisureComboView(String strAPL_A) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_mis_pet_azl, a.nom_mis_pet, c.nom_rso, a.ver_mis_pet ";
            query += "FROM ana_mis_pet_azl_tab a,tpl_mis_pet_tab b,ana_rso_tab c ";
            if (strAPL_A.equals("L")) {
                query += ",rso_luo_fsc_tab d WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet AND a.cod_rso_luo_fsc=d.cod_rso_luo_fsc AND a.cod_luo_fsc=d.cod_luo_fsc AND c.cod_rso=d.cod_rso AND c.cod_azl=d.cod_azl ";
            } else {
                query += ",rso_man_tab d WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet AND a.cod_rso_man=d.cod_rso_man AND a.cod_man=d.cod_man AND c.cod_rso=d.cod_rso AND c.cod_azl=d.cod_azl ";
            }
            PreparedStatement ps = bmp.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MPAZ_MisureComboView obj = new MPAZ_MisureComboView();
                obj.lCOD_MIS_PET_AZL = rs.getLong(1);
                obj.strNOM_MIS_PET = rs.getString(2);
                obj.strNOM_RSO = rs.getString(3);
                obj.lVER_MIS_PET = rs.getLong(4);
                al.add(obj);
            }
            bmp.close();
            return al;
//		  throw new EJBException(query);
        } catch (Exception ex1) {
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }

//---------Pogrebnoy Yura funka
    public Collection ejbGetMisurePreventProtettiveAz_foo_View(
            long lCOD_AZL, long lCOD_MIS_PET_LUO_MAN,
            String strAPL_A, String strNOM_MIS_PET, String strDES_TPL_MIS_PET, String strNOM_RSO,
            java.sql.Date dDAT_PNZ_MIS_PET_DAL, java.sql.Date dDAT_PNZ_MIS_PET_AL,
            String strGROUP, String strVAR_PAR_ADT) {
        int index = 2;       //eto nesprosta
        int ifCOD_MIS_PET_LUO_MAN = 0;
        int ifNOM_RSO = 0;
        int ifNOM_MIS_PET = 0;
        int ifDES_TPL_MIS_PET = 0;
        int ifDAT_PNZ_MIS_PET_DAL = 0;
        int ifDAT_PNZ_MIS_PET_AL = 0;

        String vFrom = "";
        String vWhere = "";
        String vGroup = "";

        if (strGROUP.equals("N") && (strVAR_PAR_ADT.equals("X"))) {
            vGroup = " ORDER BY a.dat_cmp asc ";
        }

        if (strAPL_A.equals("L")) {
            if (lCOD_MIS_PET_LUO_MAN != 0) {
                vWhere += " AND a.cod_luo_fsc = ? ";
                ifCOD_MIS_PET_LUO_MAN = index++;
            } else {
                vWhere += " AND a.cod_luo_fsc IS NOT NULL ";
//    ifCOD_MIS_PET_LUO_MAN = index++;
            }
        } else if (strAPL_A.equals("M")) {
            if (lCOD_MIS_PET_LUO_MAN != 0) {
                vWhere += " AND a.cod_man = ? ";
                ifCOD_MIS_PET_LUO_MAN = index++;
            } else {
                vWhere += " AND a.cod_man IS NOT NULL ";
//    ifCOD_MIS_PET_LUO_MAN = index++;
            }
        }
        if (!strNOM_RSO.equals("")) {
            if (strAPL_A.equals("L")) {
                vFrom += ", rso_luo_fsc_tab e ";
                vWhere += " AND a.cod_luo_fsc = e.cod_luo_fsc AND a.cod_rso_luo_fsc=e.cod_rso_luo_fsc ";
            }
            if (strAPL_A.equals("M")) {
                vFrom += ", rso_man_tab e ";
                vWhere += " AND a.cod_man = e.cod_man AND a.cod_rso_man=e.cod_rso_man ";
            }
            vFrom += ",an f ";
            vWhere += " AND e.cod_rso=f.cod_rso AND f.nom_rso LIKE ?||'%'";
            ifNOM_RSO = index++;
        }
        if (!strNOM_MIS_PET.equals("")) {
            vWhere += " AND a.nom_mis_pet LIKE ?||'%'";
            ifNOM_MIS_PET = index++;
        }
        if (!strDES_TPL_MIS_PET.equals("")) {
            vWhere += " AND b.des_tpl_mis_pet LIKE ?||'%'";
            ifDES_TPL_MIS_PET = index++;
        }
        if ((dDAT_PNZ_MIS_PET_DAL != null) && (dDAT_PNZ_MIS_PET_AL != null)) {
            vWhere += " AND a.dat_pnz_mis_pet BETWEEN ? AND ?";
            ifDAT_PNZ_MIS_PET_DAL = index++;
            ifDAT_PNZ_MIS_PET_AL = index++;
        } else if ((dDAT_PNZ_MIS_PET_DAL != null) && (dDAT_PNZ_MIS_PET_AL == null)) {
            vWhere += " AND a.dat_pnz_mis_pet >= ? ";
            ifDAT_PNZ_MIS_PET_DAL = index++;
        } else if ((dDAT_PNZ_MIS_PET_DAL == null) && (dDAT_PNZ_MIS_PET_AL != null)) {
            vWhere += " AND a.dat_pnz_mis_pet <= ?";
            ifDAT_PNZ_MIS_PET_AL = index++;
        }
//sorting
        if (strGROUP.equals("N") && (!strVAR_PAR_ADT.equals("X"))) {
            vGroup += " ORDER BY a.dat_pnz_mis_pet " + strVAR_PAR_ADT;
        } else if (strGROUP.equals("T")) {
            vGroup += " ORDER BY b.des_tpl_mis_pet";
            if (!strVAR_PAR_ADT.equals("X")) {
                vGroup += ", a.dat_pnz_mis_pet " + strVAR_PAR_ADT;
            }
        } else if (strGROUP.equals("A")) {
            vGroup += " ORDER BY c.rag_scl_azl ";
            if (!strVAR_PAR_ADT.equals("X")) {
                vGroup += ", a.dat_pnz_mis_pet " + strVAR_PAR_ADT;
            }
        }

        BMPConnection bmp = getConnection();

        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT a.cod_mis_pet_azl,a.cod_azl,a.nom_mis_pet,a.dat_cmp,a.dat_pnz_mis_pet,b.des_tpl_mis_pet,c.rag_scl_azl FROM ana_mis_pet_azl_tab a,tpl_mis_pet_tab b,ana_azl_tab c" + vFrom + " WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet AND a.cod_azl = c.cod_azl AND c.cod_azl = ? " + vWhere + vGroup);
            ps.setLong(1, lCOD_AZL);
            if (ifCOD_MIS_PET_LUO_MAN != 0) {
                ps.setLong(ifCOD_MIS_PET_LUO_MAN, lCOD_MIS_PET_LUO_MAN);
            }
            if (ifNOM_RSO != 0) {
                ps.setString(ifNOM_RSO, strNOM_RSO);
            }
            if (ifNOM_MIS_PET != 0) {
                ps.setString(ifNOM_MIS_PET, strNOM_MIS_PET);
            }
            if (ifDES_TPL_MIS_PET != 0) {
                ps.setString(ifDES_TPL_MIS_PET, strDES_TPL_MIS_PET);
            }
            if (ifDAT_PNZ_MIS_PET_DAL != 0) {
                ps.setDate(ifDAT_PNZ_MIS_PET_DAL, dDAT_PNZ_MIS_PET_DAL);
            }
            if (ifDAT_PNZ_MIS_PET_AL != 0) {
                ps.setDate(ifDAT_PNZ_MIS_PET_AL, dDAT_PNZ_MIS_PET_AL);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisurePreventProtettiveAz_foo_View obj = new MisurePreventProtettiveAz_foo_View();
                obj.COD_MIS_PET_AZL = rs.getLong(1);
                obj.COD_AZL = rs.getLong(2);
                obj.NOM_MIS_PET = rs.getString(3);
                obj.DAT_CMP = rs.getDate(4);
                obj.DAT_PNZ_MIS_PET = rs.getDate(5);
                obj.DES_TPL_MIS_PET = rs.getString(6);
                obj.RAG_SCL_AZL = rs.getString(7);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }

//throw new EJBException("SELECT a.cod_mis_pet_azl,a.cod_azl,a.nom_mis_pet,a.dat_cmp,a.dat_pnz_mis_pet,b.des_tpl_mis_pet,c.rag_scl_azl FROM ana_mis_pet_azl_tab a,tpl_mis_pet_tab b,ana_azl_tab c"+vFrom+" WHERE a.cod_tpl_mis_pet = b.cod_tpl_mis_pet AND a.cod_azl = c.cod_azl AND c.cod_azl = ? " + vWhere + vGroup);
/////-------finish
    }

//-----------methods for dependences --------------------------
    public void addDocument(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_mis_pet_azl_tab (cod_mis_pet_azl, cod_doc) VALUES(?,?)");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ps.setLong(2, lCOD_DOC);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDocument(long lCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_mis_pet_azl_tab WHERE cod_mis_pet_azl=? AND cod_doc=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ps.setLong(2, lCOD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento with ID=" + lCOD_DOC + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addNormativa(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO nor_sen_mis_pet_azl_tab (cod_mis_pet_azl, cod_nor_sen) VALUES(?,?)");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ps.setLong(2, lCOD_NOR_SEN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteNormativa(long lCOD_NOR_SEN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM nor_sen_mis_pet_azl_tab WHERE cod_mis_pet_azl=? AND cod_nor_sen=?");
            ps.setLong(1, lCOD_MIS_PET_AZL);
            ps.setLong(2, lCOD_NOR_SEN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Normativa sentenza con ID=" + lCOD_NOR_SEN + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx(long lCOD_AZL,
            Long LCOD_ANA_MAN,
            Long LCOD_LUO_FSC,
            String strSTA,
            String strNOM_RSO,
            String strNOM_MIS_PET,
            String strDES_MIS_PET,
            Long LVER_MIS_PET,
            Long LCOD_TPL_MIS_PET,
            java.sql.Date dtDAT_CMP,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            Long LPNZ_MIS_PET_MES,
            String strTPL_DSI_MIS_PET,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(lCOD_AZL, LCOD_ANA_MAN,
                LCOD_LUO_FSC,
                strSTA,
                strNOM_RSO,
                strNOM_MIS_PET,
                strDES_MIS_PET,
                LVER_MIS_PET,
                LCOD_TPL_MIS_PET,
                dtDAT_CMP,
                dtDAT_PNZ_MIS_PET,
                LPNZ_MIS_PET_MES,
                strTPL_DSI_MIS_PET, iOrderParameter);
    }

    public Collection ejbFindEx(long lCOD_AZL,
            Long LCOD_ANA_MAN,
            Long LCOD_LUO_FSC,
            String strSTA,
            String strNOM_RSO,
            String strNOM_MIS_PET,
            String strDES_MIS_PET,
            Long LVER_MIS_PET,
            Long LCOD_TPL_MIS_PET,
            java.sql.Date dtDAT_CMP,
            java.sql.Date dtDAT_PNZ_MIS_PET,
            Long LPNZ_MIS_PET_MES,
            String strTPL_DSI_MIS_PET,
            int iOrderParameter /*not used for now*/) {

        String SELE1 = "";
        String SELE2 = "";
        Long LCOD_ANA_MAN2 = LCOD_ANA_MAN;

        if (LCOD_ANA_MAN != null && LCOD_ANA_MAN.longValue() != 0) {
            SELE1 = ", rso_man_tab b ";
            SELE2 = " WHERE a.cod_rso_man = b.cod_rso_man and a.cod_man = ? AND ";
        }

        if (LCOD_LUO_FSC != null && LCOD_LUO_FSC.longValue() != 0) {
            SELE1 = ", rso_luo_fsc_tab b ";
            SELE2 = " WHERE a.cod_rso_luo_fsc = b.cod_rso_luo_fsc AND a.cod_luo_fsc = ? AND ";
        }

        if (strNOM_RSO != null) {
            SELE1 = SELE1 + ",ana_rso_tab c ";
            SELE2 = SELE2 + " c.cod_rso = b.cod_rso AND ";
        }


        String strSql = "SELECT cod_mis_pet_azl , nom_mis_pet, ver_mis_pet " + " FROM ana_mis_pet_azl_tab a " + SELE1 + SELE2 + " a.cod_azl = ?";

        if (strNOM_MIS_PET != null) {
            strSql += " AND UPPER(a.nom_mis_pet) LIKE ? ";
        }
        if (strDES_MIS_PET != null) {
            strSql += " AND UPPER(a.des_mis_pet) LIKE ? ";
        }
        if (strNOM_RSO != null) {
            strSql += " AND UPPER(c.nom_rso) LIKE ? ";
        }
        if (LVER_MIS_PET != null && LVER_MIS_PET.longValue() != 0) {
            strSql += " AND a.ver_mis_pet=? ";
        }
        if (strSTA != null) {
            strSql += " AND UPPER(a.sta_mis_pet) LIKE ? ";
        }
        if (LCOD_TPL_MIS_PET != null && LCOD_TPL_MIS_PET.longValue() != 0) {
            strSql += " AND a.cod_tpl_mis_pet=? ";
        }
        if (dtDAT_CMP != null) {
            strSql += " AND a.dat_cmp=? ";
        }
        if (dtDAT_PNZ_MIS_PET != null) {
            strSql += " AND a.dat_pnz_mis_pet=? ";
        }
        if (LPNZ_MIS_PET_MES != null && LPNZ_MIS_PET_MES.longValue() != 0) {
            strSql += " AND a.pnz_mis_pet_mes=? ";
        }
        if (strTPL_DSI_MIS_PET != null) {
            strSql += " AND UPPER(a.tpl_dsi_mis_pet) LIKE ? ";
        }
        if (iOrderParameter == 0) {
            strSql += " ORDER BY UPPER(nom_mis_pet) ";
        } else {
            strSql += " ORDER BY UPPER(nom_mis_pet) " + (iOrderParameter > 0 ? " ASC" : "DESC");
        }
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (LCOD_ANA_MAN != null && LCOD_ANA_MAN.longValue() != 0) {
                ps.setLong(i++, LCOD_ANA_MAN.longValue());
            }
            if (LCOD_LUO_FSC != null && LCOD_LUO_FSC.longValue() != 0) {
                ps.setLong(i++, LCOD_LUO_FSC.longValue());
            }

            ps.setLong(i++, lCOD_AZL);

            if (strNOM_MIS_PET != null) {
                ps.setString(i++, strNOM_MIS_PET);
            }
            if (strDES_MIS_PET != null) {
                ps.setString(i++, strDES_MIS_PET);
            }
            if (strNOM_RSO != null) {
                ps.setString(i++, strNOM_RSO);
            }
            if (LVER_MIS_PET != null && LVER_MIS_PET.longValue() != 0) {
                ps.setLong(i++, LVER_MIS_PET.longValue());
            }
            if (strSTA != null) {
                ps.setString(i++, strSTA);
            }
            if (LCOD_TPL_MIS_PET != null && LCOD_TPL_MIS_PET.longValue() != 0) {
                ps.setLong(i++, LCOD_TPL_MIS_PET.longValue());
            }
            if (dtDAT_CMP != null) {
                ps.setDate(i++, dtDAT_CMP);
            }
            if (dtDAT_PNZ_MIS_PET != null) {
                ps.setDate(i++, dtDAT_PNZ_MIS_PET);
            }
            if (LPNZ_MIS_PET_MES != null && LPNZ_MIS_PET_MES.longValue() != 0) {
                ps.setLong(i++, LPNZ_MIS_PET_MES.longValue());
            }
            if (strTPL_DSI_MIS_PET != null) {
                ps.setString(i++, strTPL_DSI_MIS_PET.toUpperCase());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                MisureByParamsView v = new MisureByParamsView();
                v.lCOD_MIS_PET_AZL = rs.getLong(1);
                v.strNOM_MIS_PET_AZL = rs.getString(2);
                v.lVER_MIS_PET = rs.getLong(3);
                ar.add(v);
            }
            return ar;
        //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(i + strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
}
