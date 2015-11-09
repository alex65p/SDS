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
package com.apconsulting.luna.ejb.InterventoAudut;

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
public class InterventoAudutBean extends BMPEntityBean implements IInterventoAudut, IInterventoAudutHome {
    //<member-varibles description="Member Variables">

    long lCOD_INR_ADT;
    String strDES_INR_ADT;
    java.sql.Date dtDAT_PIF_INR;
    long lNUM_VIS_ISP;
    java.sql.Date dtDAT_ADT;
    long lCOD_MIS_PET;
    long lCOD_PSD_ACD;
    long lCOD_LUO_FSC;
    long lCOD_DPD;
    long lCOD_AZL;
    String strSEC_PNO_YEA;
    long lPNG_TEO;
    long lPNG_RIL;
    long lPNG_PCT;
    long lCOD_UNI_ORG;
    long lCOD_MIS_RSO_LUO;
    long lCOD_MIS_PET_MAN;
    //</member-varibles>

    //<IInterventoAudutHome-implementation>
    public static final String BEAN_NAME = "InterventoAudutBean";

////////////////////// CONSTRUCTOR///////////////////
    private static InterventoAudutBean ys = null;

    private InterventoAudutBean() {
        //
    }

    public static InterventoAudutBean getInstance() {
        if (ys == null) {
            ys = new InterventoAudutBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        InterventoAudutBean bean = new InterventoAudutBean();
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

    public IInterventoAudut create(java.sql.Date dtDAT_PIF_INR, long lCOD_AZL) throws javax.ejb.CreateException {
        InterventoAudutBean bean = new InterventoAudutBean();
        try {
            Object primaryKey = bean.ejbCreate(dtDAT_PIF_INR, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(dtDAT_PIF_INR, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IInterventoAudut findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        InterventoAudutBean bean = new InterventoAudutBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws javax.ejb.FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getInterventoAudut_Combo_View() {
        return (new InterventoAudutBean()).ejbGetInterventoAudut_Combo_View();
    }

    public Collection getGestioneInterventoAudit_ForSelectDPI_View(long lCOD_AZL) {
        return (new InterventoAudutBean()).ejbGetGestioneInterventoAudit_ForSelectDPI_View(lCOD_AZL);
    }
    //--------------------<ALEX>--------------------------------------------

    public Collection getInterventoAuditView(long lCOD_AZL) {
        return (new InterventoAudutBean()).ejbGetInterventoAuditView(lCOD_AZL);
    }

    public Collection getInterventoAuditFORLUOView(long lCOD_AZL, long lCOD_MIS_RSO_LUO) {
        return (new InterventoAudutBean()).ejbGetInterventoAuditFORLUOView(lCOD_AZL, lCOD_MIS_RSO_LUO);
    }

    public MisuraPreventivaView getMisuraPreventivaByAttivita(long lCOD_MIS_PET_MAN, long lCOD_AZL) {
        return (new InterventoAudutBean()).ejbGetMisuraPreventivaByAttivita(lCOD_MIS_PET_MAN, lCOD_AZL);
    }

    public MisuraPreventivaView getMisuraPreventivaByLuogo(long lCOD_MIS_RSO_LUO, long lCOD_AZL) {
        return (new InterventoAudutBean()).ejbGetMisuraPreventivaByLuogo(lCOD_MIS_RSO_LUO, lCOD_AZL);
    }

    public Collection getMisurePreventiveAllByAttivita(long lCOD_AZL, String strMisura) {
        return (new InterventoAudutBean()).ejbGetMisurePreventiveAllByAttivita(lCOD_AZL, strMisura);
    }

    public Collection getMisurePreventiveAllByLuogo(long lCOD_AZL, String strMisura) {
        return (new InterventoAudutBean()).ejbGetMisurePreventiveAllByLuogo(lCOD_AZL, strMisura);
    }

    public Collection getGestioneInterventoAudit_SCH_View(long lCOD_AZL, String strNOM_MIS_PET_LUO_MAN, java.sql.Date dtDAT_PIF_INR_DAL, java.sql.Date dtDAT_PIF_INR_AL, java.sql.Date dtDAT_EFT_DAL, java.sql.Date dtDAT_EFT_AL, String strNOM_MIS_PET, String strNOM_RSP_INR, String strNOM_LUO_FSC, String strDES_INTERVENTO, String strSTA_INT, String strRG_GROUP, String strINR_ADT_AZL, String strNB_APL_A, String strSORT) {
        return (new InterventoAudutBean()).ejbGetGestioneInterventoAudit_SCH_View(lCOD_AZL, strNOM_MIS_PET_LUO_MAN, dtDAT_PIF_INR_DAL, dtDAT_PIF_INR_AL, dtDAT_EFT_DAL, dtDAT_EFT_AL, strNOM_MIS_PET, strNOM_RSP_INR, strNOM_LUO_FSC, strDES_INTERVENTO, strSTA_INT, strRG_GROUP, strINR_ADT_AZL, strNB_APL_A, strSORT);
    }
    //-------------------</ALEX>--------------------------------------------
    //

    public Long ejbCreate(java.sql.Date dtDAT_PIF_INR, long lCOD_AZL) {
        this.lCOD_INR_ADT = NEW_ID();
        this.dtDAT_PIF_INR = dtDAT_PIF_INR;
        this.lCOD_AZL = lCOD_AZL;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_inr_adt_tab (cod_inr_adt,dat_pif_inr,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, lCOD_INR_ADT);
            ps.setDate(2, dtDAT_PIF_INR);
            ps.setLong(3, lCOD_AZL);
            ps.executeUpdate();
            return new Long(lCOD_INR_ADT);
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(java.sql.Date dtDAT_PIF_INR, long lCOD_AZL) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_inr_adt FROM ana_inr_adt_tab");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1))); // performance of the [new] operator?
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.lCOD_INR_ADT = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_INR_ADT = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_inr_adt,des_inr_adt,dat_pif_inr,num_vis_isp,dat_adt,cod_mis_pet,cod_psd_acd,cod_luo_fsc,cod_dpd,cod_azl,sec_pno_yea,png_teo,png_ril,png_pct,cod_uni_org,cod_mis_rso_luo,cod_mis_pet_man FROM ana_inr_adt_tab WHERE cod_inr_adt=?");
            ps.setLong(1, lCOD_INR_ADT);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_INR_ADT = rs.getLong(1);
                strDES_INR_ADT = rs.getString(2);
                dtDAT_PIF_INR = rs.getDate(3);
                lNUM_VIS_ISP = rs.getLong(4);
                dtDAT_ADT = rs.getDate(5);
                lCOD_MIS_PET = rs.getLong(6);
                lCOD_PSD_ACD = rs.getLong(7);
                lCOD_LUO_FSC = rs.getLong(8);
                lCOD_DPD = rs.getLong(9);
                lCOD_AZL = rs.getLong(10);
                strSEC_PNO_YEA = rs.getString(11);
                lPNG_TEO = rs.getLong(12);
                lPNG_RIL = rs.getLong(13);
                lPNG_PCT = rs.getLong(14);
                lCOD_UNI_ORG = rs.getLong(15);
                lCOD_MIS_RSO_LUO = rs.getLong(16);
                lCOD_MIS_PET_MAN = rs.getLong(17);
            } else {
                throw new NoSuchEntityException("InterventoAudut with ID=" + lCOD_INR_ADT + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_inr_adt_tab WHERE cod_inr_adt=?");
            ps.setLong(1, lCOD_INR_ADT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("InterventoAudut with ID=" + lCOD_INR_ADT + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_inr_adt_tab SET cod_inr_adt=?, des_inr_adt=?, dat_pif_inr=?, num_vis_isp=?, dat_adt=?, cod_mis_pet=?, cod_psd_acd=?, cod_luo_fsc=?, cod_dpd=?, cod_azl=?, sec_pno_yea=?, png_teo=?, png_ril=?, png_pct=?, cod_uni_org=?, cod_mis_rso_luo=?, cod_mis_pet_man=? WHERE cod_inr_adt=?");
            ps.setLong(1, lCOD_INR_ADT);
            ps.setString(2, strDES_INR_ADT);
            ps.setDate(3, dtDAT_PIF_INR);
            if (lNUM_VIS_ISP == 0) {
                ps.setNull(4, java.sql.Types.BIGINT);
            } else {
                ps.setLong(4, lNUM_VIS_ISP);
            }
            ps.setDate(5, dtDAT_ADT);
            if (lCOD_MIS_PET == 0) {
                ps.setNull(6, java.sql.Types.BIGINT);
            } else {
                ps.setLong(6, lCOD_MIS_PET);
            }
            if (lCOD_PSD_ACD == 0) {
                ps.setNull(7, java.sql.Types.BIGINT);
            } else {
                ps.setLong(7, lCOD_PSD_ACD);
            }
            if (lCOD_LUO_FSC == 0) {
                ps.setNull(8, java.sql.Types.BIGINT);
            } else {
                ps.setLong(8, lCOD_LUO_FSC);
            }
            if (lCOD_DPD == 0) {
                ps.setNull(9, java.sql.Types.BIGINT);
            } else {
                ps.setLong(9, lCOD_DPD);
            }
            ps.setLong(10, lCOD_AZL);
            ps.setString(11, strSEC_PNO_YEA);
            if (lPNG_TEO == 0) {
                ps.setNull(12, java.sql.Types.BIGINT);
            } else {
                ps.setLong(12, lPNG_TEO);
            }
            if (lPNG_RIL == 0) {
                ps.setNull(13, java.sql.Types.BIGINT);
            } else {
                ps.setLong(13, lPNG_RIL);
            }
            if (lPNG_PCT == 0) {
                ps.setNull(14, java.sql.Types.BIGINT);
            } else {
                ps.setLong(14, lPNG_PCT);
            }
            if (lCOD_UNI_ORG == 0) {
                ps.setNull(15, java.sql.Types.BIGINT);
            } else {
                ps.setLong(15, lCOD_UNI_ORG);
            }
            if (lCOD_MIS_RSO_LUO == 0) {
                ps.setNull(16, java.sql.Types.BIGINT);
            } else {
                ps.setLong(16, lCOD_MIS_RSO_LUO);
            }
            if (lCOD_MIS_PET_MAN == 0) {
                ps.setNull(17, java.sql.Types.BIGINT);
            } else {
                ps.setLong(17, lCOD_MIS_PET_MAN);
            }
            ps.setLong(18, lCOD_INR_ADT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("InterventoAudut with ID=" + lCOD_INR_ADT + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //<setter-getters>
    public long getCOD_INR_ADT() {
        return lCOD_INR_ADT;
    }

    public String getDES_INR_ADT() {
        return strDES_INR_ADT;
    }

    public void setDES_INR_ADT(String strDES_INR_ADT) {
        if ((this.strDES_INR_ADT != null) && (this.strDES_INR_ADT.equals(strDES_INR_ADT))) {
            return;
        }
        this.strDES_INR_ADT = strDES_INR_ADT;
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

    public long getNUM_VIS_ISP() {
        return lNUM_VIS_ISP;
    }

    public void setNUM_VIS_ISP(long lNUM_VIS_ISP) {
        if (this.lNUM_VIS_ISP == lNUM_VIS_ISP) {
            return;
        }
        this.lNUM_VIS_ISP = lNUM_VIS_ISP;
        setModified();
    }

    public java.sql.Date getDAT_ADT() {
        return dtDAT_ADT;
    }

    public void setDAT_ADT(java.sql.Date dtDAT_ADT) {
        if (this.dtDAT_ADT == dtDAT_ADT) {
            return;
        }
        this.dtDAT_ADT = dtDAT_ADT;
        setModified();
    }

    public long getCOD_MIS_PET() {
        return lCOD_MIS_PET;
    }

    public void setCOD_MIS_PET(long lCOD_MIS_PET) {
        if (this.lCOD_MIS_PET == lCOD_MIS_PET) {
            return;
        }
        this.lCOD_MIS_PET = lCOD_MIS_PET;
        setModified();
    }

    public long getCOD_PSD_ACD() {
        return lCOD_PSD_ACD;
    }

    public void setCOD_PSD_ACD(long lCOD_PSD_ACD) {
        if (this.lCOD_PSD_ACD == lCOD_PSD_ACD) {
            return;
        }
        this.lCOD_PSD_ACD = lCOD_PSD_ACD;
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

    public String getSEC_PNO_YEA() {
        return strSEC_PNO_YEA;
    }

    public void setSEC_PNO_YEA(String strSEC_PNO_YEA) {
        if ((this.strSEC_PNO_YEA != null) && (this.strSEC_PNO_YEA.equals(strSEC_PNO_YEA))) {
            return;
        }
        this.strSEC_PNO_YEA = strSEC_PNO_YEA;
        setModified();
    }

    public long getPNG_TEO() {
        return lPNG_TEO;
    }

    public void setPNG_TEO(long lPNG_TEO) {
        if (this.lPNG_TEO == lPNG_TEO) {
            return;
        }
        this.lPNG_TEO = lPNG_TEO;
        setModified();
    }

    public long getPNG_RIL() {
        return lPNG_RIL;
    }

    public void setPNG_RIL(long lPNG_RIL) {
        if (this.lPNG_RIL == lPNG_RIL) {
            return;
        }
        this.lPNG_RIL = lPNG_RIL;
        setModified();
    }

    public long getPNG_PCT() {
        return lPNG_PCT;
    }

    public void setPNG_PCT(long lPNG_PCT) {
        if (this.lPNG_PCT == lPNG_PCT) {
            return;
        }
        this.lPNG_PCT = lPNG_PCT;
        setModified();
    }

    public long getCOD_UNI_ORG() {
        return lCOD_UNI_ORG;
    }

    public void setCOD_UNI_ORG(long lCOD_UNI_ORG) {
        if (this.lCOD_UNI_ORG == lCOD_UNI_ORG) {
            return;
        }
        this.lCOD_UNI_ORG = lCOD_UNI_ORG;
        setModified();
    }

    public long getCOD_MIS_RSO_LUO() {
        return lCOD_MIS_RSO_LUO;
    }

    public void setCOD_MIS_RSO_LUO(long lCOD_MIS_RSO_LUO) {
        if (this.lCOD_MIS_RSO_LUO == lCOD_MIS_RSO_LUO) {
            return;
        }
        this.lCOD_MIS_RSO_LUO = lCOD_MIS_RSO_LUO;
        setModified();
    }

    public long getCOD_MIS_PET_MAN() {
        return lCOD_MIS_PET_MAN;
    }

    public void setCOD_MIS_PET_MAN(long lCOD_MIS_PET_MAN) {
        if (this.lCOD_MIS_PET_MAN == lCOD_MIS_PET_MAN) {
            return;
        }
        this.lCOD_MIS_PET_MAN = lCOD_MIS_PET_MAN;
        setModified();
    }

    public Collection ejbGetGestioneInterventoAudit_ForSelectDPI_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_inr_adt, des_inr_adt FROM ana_inr_adt_tab WHERE cod_azl=?");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioneInterventoAudit_ForSelectDPI_View obj = new GestioneInterventoAudit_ForSelectDPI_View();
                obj.COD_INR_ADT = rs.getLong(1);
                obj.DES_INR_ADT = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</setter-getters>

    public Collection ejbGetInterventoAudut_Combo_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_inr_adt, des_inr_adt	FROM ana_inr_adt_tab");

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                InterventoAudut_Combo_View obj = new InterventoAudut_Combo_View();
                obj.COD_INR_ADT = rs.getLong(1);
                obj.DES_INR_ADT = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-------------------<ALEX>--------------------------

    public Collection ejbGetInterventoAuditView(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  a.cod_inr_adt, a.des_inr_adt, a.dat_pif_inr, a.num_vis_isp,a.dat_adt, a.cod_mis_pet, a.cod_psd_acd, a.cod_luo_fsc, a.cod_dpd, a.cod_azl, a.sec_pno_yea, a.png_teo,  a.png_ril,    a.png_pct, a.cod_uni_org, a.cod_mis_rso_luo, a.cod_mis_pet_man from ana_inr_adt_tab a  where a.cod_azl = ? ORDER BY a.des_inr_adt ");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                InterventoAuditView obj = new InterventoAuditView();
                obj.lCOD_INR_ADT = rs.getLong(1);
                obj.strDES_INR_ADT = rs.getString(2);
                obj.dtDAT_PIF_INR = rs.getDate(3);
                obj.lNUM_VIS_ISP = rs.getLong(4);
                obj.dtDAT_ADT = rs.getDate(5);
                obj.lCOD_MIS_PET = rs.getLong(6);
                obj.lCOD_PSD_ACD = rs.getLong(7);
                obj.lCOD_LUO_FSC = rs.getLong(8);
                obj.lCOD_DPD = rs.getLong(9);
                obj.lCOD_AZL = rs.getLong(10);
                obj.strSEC_PNO_YEA = rs.getString(11);
                obj.lPNG_TEO = rs.getLong(12);
                obj.lPNG_RIL = rs.getLong(13);
                obj.lPNG_PCT = rs.getLong(14);
                obj.lCOD_UNI_ORG = rs.getLong(15);
                obj.lCOD_MIS_RSO_LUO = rs.getLong(16);
                obj.lCOD_MIS_PET_MAN = rs.getLong(17);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetInterventoAuditFORLUOView(long lCOD_AZL, long lCOD_MIS_RSO_LUO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_inr_adt,des_inr_adt FROM ana_inr_adt_tab  WHERE cod_azl = ? AND cod_mis_rso_luo = ?");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_MIS_RSO_LUO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                InterventoAuditFORLUOView obj = new InterventoAuditFORLUOView();
                obj.lCOD_INR_ADT = rs.getLong(1);
                obj.strDES_INR_ADT = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public LavoratoreView getLavoratore(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("Select nom_dpd,cog_dpd,mtr_dpd  from view_ana_dpd_tab where cod_dpd = ? and cod_azl=?");
            ps.setLong(1, lCOD_DPD);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            LavoratoreView w = new LavoratoreView();
            if (rs.next()) {
                w.strNOM_DPD = rs.getString(1);
                w.strCOG_DPD = rs.getString(2);
                w.strMTR_DPD = rs.getString(3);
                w.lCOD_DPD = lCOD_DPD;
            }
            return w;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //---

    public ADT_PresidioView getPresidio() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("Select a.ide_psd_acd, b.nom_cag_psd_acd " +
                    "from ana_psd_acd_tab a, cag_psd_acd_tab b " +
                    "Where a.cod_cag_psd_acd = b.cod_cag_psd_acd and a.cod_psd_acd=? ");
            ps.setLong(1, lCOD_PSD_ACD);
            ResultSet rs = ps.executeQuery();
            ADT_PresidioView w = new ADT_PresidioView();
            if (rs.next()) {
                w.strIDE_PSD_ACD = rs.getString(1);
                w.strNOM_CAG_PSD_ACD = rs.getString(2);
                w.lCOD_PSD_ACD = lCOD_PSD_ACD;
            }
            return w;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public MisuraPreventivaView ejbGetMisuraPreventivaByAttivita(long lCOD_MIS_PET_MAN, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(" select b.cod_mis_pet, b.nom_mis_pet   from mis_pet_man_tab a, ana_mis_pet_tab b where a.cod_mis_pet_man = ? and b.cod_azl=? and a.cod_mis_pet     = b.cod_mis_pet ");
            ps.setLong(1, lCOD_MIS_PET_MAN);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            MisuraPreventivaView w = new MisuraPreventivaView();
            if (rs.next()) {
                w.lCOD_MIS_PET = rs.getLong(1);
                w.strNOM_MIS_PET = rs.getString(2);
            }
            return w;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public MisuraPreventivaView ejbGetMisuraPreventivaByLuogo(long lCOD_MIS_RSO_LUO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(" select b.cod_mis_pet, b.nom_mis_pet  from mis_pet_luo_fsc_tab a, ana_mis_pet_tab b  where a.cod_mis_rso_luo = ? and b.cod_azl=? and a.cod_mis_pet  = b.cod_mis_pet ");
            ps.setLong(1, lCOD_MIS_RSO_LUO);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            MisuraPreventivaView w = new MisuraPreventivaView();
            if (rs.next()) {
                w.lCOD_MIS_PET = rs.getLong(1);
                w.strNOM_MIS_PET = rs.getString(2);
            }
            return w;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetMisurePreventiveAllByAttivita(long lCOD_AZL, String strMisura) {
        BMPConnection bmp = getConnection();
        try {
            String strSQL = " select a.cod_mis_pet_man, b.nom_mis_pet, a.dat_pnz_mis_pet ,a.cod_rso_man, c.nom_rso, e.nom_man,e.cod_man ,a.cod_mis_pet from ana_mis_pet_tab b, mis_pet_man_tab a,ana_rso_tab c,rso_man_tab d, ana_man_tab e  where a.cod_mis_pet = b.cod_mis_pet and a.cod_man = e.cod_man and a.cod_rso_man = d.cod_rso_man  and c.cod_rso = d.cod_rso and c.cod_azl = d.cod_azl and d.cod_azl= ? ";
            if (strMisura != null) {
                strSQL = strSQL + " and UPPER(b.nom_mis_pet) LIKE ?";
            }
            int i = 1;
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            ps.setLong(1, lCOD_AZL);
            if (strMisura != null) {
                ps.setString(++i, strMisura.toUpperCase() + "%");
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisuraPreventivaView w = new MisuraPreventivaView();
                w.lCOD_MIS_PET_MAN = rs.getLong(1);
                w.strNOM_MIS_PET = rs.getString(2);
                w.dtDAT_PNZ_MIS_PET = rs.getDate(3);
                w.lCOD_RSO_MAN = rs.getLong(4);
                w.strNOM_RSO = rs.getString(5);
                w.strNOM_MAN = rs.getString(6);
                w.lCOD_MAN = rs.getLong(7);
                w.lCOD_MIS_PET = rs.getLong(8);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetMisurePreventiveAllByLuogo(long lCOD_AZL, String strMisura) {
        BMPConnection bmp = getConnection();
        try {
            String strSQL = 
                    "select "
                        + "a.cod_mis_rso_luo, "
                        + "b.nom_mis_pet, "
                        + "a.dat_pnz_mis_pet, "
                        + "a.cod_rso_luo_fsc, "
                        + "c.nom_rso, "
                        + "e.nom_luo_fsc, "
                        + "e.cod_luo_fsc, "
                        + "a.cod_mis_pet "
                    + "from "
                        + "mis_pet_luo_fsc_tab a, "
                        + "ana_mis_pet_tab b, "
                        + "ana_rso_tab c, "
                        + "rso_luo_fsc_tab d, "
                        + "ana_luo_fsc_tab e "
                    + "where "
                        + "a.cod_mis_pet = b.cod_mis_pet "
                        + "and a.cod_luo_fsc = e.cod_luo_fsc "
                        + "and a.cod_rso_luo_fsc = d.cod_rso_luo_fsc "
                        + "and c.cod_rso = d.cod_rso "
                        + "and c.cod_azl = d.cod_azl and d.cod_azl= ? ";
            if (strMisura != null) {
                strSQL = strSQL + " and UPPER(b.nom_mis_pet) like ?";
            
            }
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            ps.setLong(1, lCOD_AZL);
            int i = 1;
            if (strMisura != null) {
                ps.setString(++i, strMisura.toUpperCase() + "%");
            }
           
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MisuraPreventivaView w = new MisuraPreventivaView();
                w.lCOD_MIS_RSO_LUO = rs.getLong(1);
                w.strNOM_MIS_PET = rs.getString(2);
                w.dtDAT_PNZ_MIS_PET = rs.getDate(3);
                w.lCOD_RSO_LUO_FSC = rs.getLong(4);
                w.strNOM_RSO = rs.getString(5);
                w.strNOM_LUO_FSC = rs.getString(6);
                w.lCOD_LUO_FSC = rs.getLong(7);
                w.lCOD_MIS_PET = rs.getLong(8);
                al.add(w);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteNonConformita(long lCOD_NON_CFO) {
    }

    public Collection getNonConformita() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select 	cod_non_cfo,	des_non_cfo,	dat_ril_non_cfo,cod_inr_adt,nom_ril_non_cfo from ana_non_cfo_tab  where cod_inr_adt = ?");
            ps.setLong(1, lCOD_INR_ADT);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                NonConformitaView obj = new NonConformitaView();
                obj.lCOD_NON_CFO = rs.getLong(1);
                obj.strDES_NON_CFO = rs.getString(2);
                obj.dtDAT_RIL_NON_CFO = rs.getDate(3);
                obj.lCOD_INR_ADT = rs.getLong(4);
                obj.strNOM_RIL_NON_CFO = rs.getString(5);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex1) {
            ex1.printStackTrace(System.err);
            throw new EJBException(ex1);
        } finally {
            bmp.close();
        }
    }
    //------------------</ALEX>-----------------------------
    ///////<comment>Added 1.03.2004 by Yuriy Kushkarov FOR SCH_INR_ADT_Form!!!!!//////////////

    public Collection ejbGetGestioneInterventoAudit_SCH_View(long lCOD_AZL, String strNOM_MIS_PET_LUO_MAN, java.sql.Date dtDAT_PIF_INR_DAL, java.sql.Date dtDAT_PIF_INR_AL, java.sql.Date dtDAT_EFT_DAL, java.sql.Date dtDAT_EFT_AL, String strNOM_MIS_PET, String strNOM_RSP_INR, String strNOM_LUO_FSC, String strDES_INTERVENTO, String strSTA_INT, String strRG_GROUP, String strINR_ADT_AZL, String strNB_APL_A, String strSORT) {
        String VAR_SELECT = 
                " SELECT "
                    + "a.cod_inr_adt, "
                    + "a.cod_azl, "
                    + "d.cog_dpd, "
                    + "d.nom_dpd, "
                    + "b.nom_luo_fsc, "
                    + "c.nom_mis_pet, "
                    + "a.dat_pif_inr, "
                    + "a.dat_adt, "
                    + "g.rag_scl_azl ";
        String VAR_FROM = 
                " FROM "
                    + "ana_inr_adt_tab a, "
                    + "ana_luo_fsc_tab b, "
                    + "ana_mis_pet_tab c, "
                    + "view_ana_dpd_tab d, "
                    + "ana_azl_tab g ";
        String VAR_WHERE = 
                " WHERE "
                    + "a.cod_luo_fsc = b.cod_luo_fsc "
                    + "AND a.cod_mis_pet = c.cod_mis_pet "
                    + "AND a.cod_dpd = d.cod_dpd "
                    + "AND a.cod_azl = d.cod_azl "
                    + "AND a.cod_azl = g.cod_azl "
                    + "AND g.cod_azl=?";
        String VAR_GROUP = "";
        String VAR_ORDER = "";
        String strOrder = "";
        if (!"".equals(strSORT)) {
            if ("INRup".equals(strSORT)) {
                VAR_ORDER = " ORDER BY a.dat_pif_inr ";
                strOrder = ", a.dat_pif_inr ";
            }
            if ("ADTup".equals(strSORT)) {
                VAR_ORDER = " ORDER BY a.dat_adt ";
                strOrder = ", a.dat_adt ";
            }
            if ("INRdw".equals(strSORT)) {
                VAR_ORDER = " ORDER BY a.dat_pif_inr DESC ";
                strOrder = ", a.dat_pif_inr DESC ";
            }
            if ("ADTdw".equals(strSORT)) {
                VAR_ORDER = " ORDER BY a.dat_adt DESC ";
                strOrder = ", a.dat_adt DESC ";
            }
        }
        int i = 1;
        int indexNOM_MIS_PET = 0;
        int indexDES_INTERVENTO = 0;
        int indexNOM_LUO_FSC = 0;
        int indexNOM_MIS_PET_LUO_MAN = 0;
        int indexNOM_RSP_INR = 0;
        int indexDT_EFT_DAL = 0;
        int indexDT_EFT_AL = 0;
        int indexDT_PIF_DAL = 0;
        int indexDT_PIF_AL = 0;
        int indexAZL = i;
        if ("N".equals(strINR_ADT_AZL)) {
            if (    strNOM_MIS_PET_LUO_MAN != null &&
                    strNOM_MIS_PET_LUO_MAN.equals("")==false &&
                    strNOM_MIS_PET_LUO_MAN.equals("0")==false) {
                if ("L".equals(strNB_APL_A)) {
                    VAR_FROM += ",mis_pet_luo_fsc_tab f ";
                    VAR_WHERE += " AND a.cod_mis_rso_luo=f.cod_mis_rso_luo AND c.cod_mis_pet=f.cod_mis_pet AND c.cod_mis_pet =?";
                } else if ("M".equals(strNB_APL_A)) {
                    VAR_FROM += ",mis_pet_man_tab f ";
                    VAR_WHERE += " AND a.cod_mis_pet_man=f.cod_mis_pet_man AND c.cod_mis_pet=f.cod_mis_pet AND c.cod_mis_pet=?";
                }
                indexNOM_MIS_PET_LUO_MAN = ++i;
            } else {
                if ("L".equals(strNB_APL_A)) {
                    VAR_WHERE += " AND a.cod_mis_rso_luo IS NOT NULL ";
                } else if ("M".equals(strNB_APL_A)) {
                    VAR_WHERE += " AND a.cod_mis_pet_man IS NOT NULL ";
                }
            }
        } else if ("S".equals(strINR_ADT_AZL)) {
            VAR_WHERE += " AND (a.cod_mis_rso_luo IS NOT NULL or a.cod_mis_pet_man IS NOT NULL) ";
        }
        if ((dtDAT_PIF_INR_DAL != null) && (dtDAT_PIF_INR_AL != null)) {
            VAR_WHERE += " AND a.dat_pif_inr BETWEEN ? AND ? ";
            indexDT_PIF_DAL = ++i;
            indexDT_PIF_AL = ++i;
        }
        if ((dtDAT_PIF_INR_DAL != null) && (dtDAT_PIF_INR_AL == null)) {
            VAR_WHERE += " AND a.dat_pif_inr >= ? ";
            indexDT_PIF_DAL = ++i;
        }
        if ((dtDAT_PIF_INR_DAL == null) && (dtDAT_PIF_INR_AL != null)) {
            VAR_WHERE += " AND a.dat_pif_inr <= ? ";
            indexDT_PIF_AL = ++i;
        }
        if ("D".equals(strSTA_INT)) {
            VAR_WHERE += " AND a.dat_adt IS NULL ";
            dtDAT_EFT_DAL = null;
            dtDAT_EFT_AL = null;
        } else if ("G".equals(strSTA_INT)) {
            VAR_WHERE += " AND a.dat_adt IS NOT NULL ";
        }
        if ((dtDAT_EFT_DAL != null) && (dtDAT_EFT_AL != null)) {
            VAR_WHERE += " AND a.dat_adt BETWEEN ? AND ? ";
            indexDT_EFT_DAL = ++i;
            indexDT_EFT_AL = ++i;
        }
        if ((dtDAT_EFT_DAL != null) && (dtDAT_EFT_AL == null)) {
            VAR_WHERE += " AND a.dat_adt >= " + dtDAT_EFT_DAL + " ";
            indexDT_EFT_DAL = ++i;
        }
        if ((dtDAT_EFT_DAL == null) && (dtDAT_EFT_AL != null)) {
            VAR_WHERE += " AND a.dat_adt <= " + dtDAT_EFT_AL + " ";
            indexDT_EFT_AL = ++i;
        }
        if ((strNOM_RSP_INR != null) && (!"0".equals(strNOM_RSP_INR))) {
            VAR_WHERE += " AND d.cod_dpd =? ";
            indexNOM_RSP_INR = ++i;
        }
        if ((strNOM_MIS_PET != null) && (!"0".equals(strNOM_MIS_PET))) {
            VAR_WHERE += " AND c.cod_mis_pet = ? ";
            indexNOM_MIS_PET = ++i;
        }
        if ((strNOM_LUO_FSC != null) && (!"0".equals(strNOM_LUO_FSC))) {
            VAR_WHERE += " AND b.cod_luo_fsc=? ";
            indexNOM_LUO_FSC = ++i;
        }
        if ((strDES_INTERVENTO != null) && (!"".equals(strDES_INTERVENTO))) {
            VAR_WHERE += " AND a.des_inr_adt LIKE ?||'%' ";
            indexDES_INTERVENTO = ++i;
        }
        if ("N".equals(strRG_GROUP)) {
            VAR_GROUP = VAR_ORDER;
        } else if ("A".equals(strRG_GROUP)) {
            VAR_GROUP = " ORDER BY g.rag_scl_azl " + strOrder;
        } else if ("L".equals(strRG_GROUP)) {
            VAR_GROUP = " ORDER BY b.nom_luo_fsc " + strOrder;
        } else if ("R".equals(strRG_GROUP)) {
            VAR_GROUP = " ORDER BY d.cog_dpd " + strOrder;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(VAR_SELECT + VAR_FROM + VAR_WHERE + VAR_GROUP);
            ps.setLong(indexAZL, lCOD_AZL);
           
            ////////////
            if (indexNOM_MIS_PET_LUO_MAN != 0) {
                ps.setLong(indexNOM_MIS_PET_LUO_MAN, new Long(strNOM_MIS_PET_LUO_MAN).longValue());
            }
            ///////////
            if (indexDT_PIF_DAL != 0) {
                ps.setDate(indexDT_PIF_DAL, dtDAT_PIF_INR_DAL);
            }
            ///////////
            if (indexDT_PIF_AL != 0) {
                ps.setDate(indexDT_PIF_AL, dtDAT_PIF_INR_AL);
            }
            ////////////
            if (indexDT_EFT_DAL != 0) {
                ps.setDate(indexDT_EFT_DAL, dtDAT_EFT_DAL);
            }
            ////////////
            if (indexDT_EFT_AL != 0) {
                ps.setDate(indexDT_EFT_AL, dtDAT_EFT_AL);
            }
            /////////////
            if (indexNOM_MIS_PET != 0) {
                ps.setLong(indexNOM_MIS_PET, new Long(strNOM_MIS_PET).longValue());
            }
            //////////////
            if (indexNOM_RSP_INR != 0) {
                ps.setLong(indexNOM_RSP_INR, new Long(strNOM_RSP_INR).longValue());
            }
            //////////////
            if (indexNOM_LUO_FSC != 0) {
                ps.setLong(indexNOM_LUO_FSC, new Long(strNOM_LUO_FSC).longValue());
            }
            //////////////
            if (indexDES_INTERVENTO != 0) {
                ps.setString(indexDES_INTERVENTO, strDES_INTERVENTO);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioneInterventoAudit_SCH_View obj = new GestioneInterventoAudit_SCH_View();
                obj.COD_INR_ADT = rs.getLong(1);
                obj.COD_AZL = rs.getLong(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_DPD = rs.getString(4);
                obj.NOM_LUO_FSC = rs.getString(5);
                obj.NOM_MIS_PET = rs.getString(6);
                obj.DAT_PIF_INR = rs.getDate(7);
                obj.DAT_ADT = rs.getDate(8);
                obj.RAG_SCL_AZL = rs.getString(9);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//////////</comment>

//--- mary for search
    public Collection findEx(
            long lCOD_AZL,
            Long lCOD_LUO_FSC,
            String strDES_INR_ADT,
            Long lPNG_TEO,
            Long lPNG_RIL,
            Long lNUM_VIS_ISP,
            java.sql.Date dtDAT_ADT,
            java.sql.Date dtDAT_PIF_INR,
            Long lPNG_PCT,
            Long lCOD_DPD,
            String strCOG_DPD,
            String strNOM_DPD,
            String strMTR_DPD,
            String strINR_ADT_AZL,
            String strNOM_MIS_PET,
            String strRB_LUO_FSC_MAN,
            int iOrderParameter //not used for now
            ) {
        return ejbFindEx(lCOD_AZL, lCOD_LUO_FSC, strDES_INR_ADT, lPNG_TEO, lPNG_RIL, lNUM_VIS_ISP, dtDAT_ADT, dtDAT_PIF_INR, lPNG_PCT, lCOD_DPD, strCOG_DPD, strNOM_DPD, strMTR_DPD, strINR_ADT_AZL, strNOM_MIS_PET, strRB_LUO_FSC_MAN, iOrderParameter);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            Long lCOD_LUO_FSC,
            String strDES_INR_ADT,
            Long lPNG_TEO,
            Long lPNG_RIL,
            Long lNUM_VIS_ISP,
            java.sql.Date dtDAT_ADT,
            java.sql.Date dtDAT_PIF_INR,
            Long lPNG_PCT,
            Long lCOD_DPD,
            String strCOG_DPD,
            String strNOM_DPD,
            String strMTR_DPD,
            String strINR_ADT_AZL,
            String strNOM_MIS_PET,
            String strRB_LUO_FSC_MAN,
            int iOrderParameter //not used for now
            ) {
        String strSql = "SELECT a.cod_inr_adt, a.des_inr_adt, a.dat_pif_inr, a.num_vis_isp, a.dat_adt, a.cod_mis_pet, a.cod_psd_acd, a.cod_luo_fsc, a.cod_dpd,  a.cod_azl, a.sec_pno_yea, a.png_teo, a.png_ril, a.png_pct, a.cod_uni_org, a.cod_mis_rso_luo, a.cod_mis_pet_man ";
        String strFrom = " FROM ana_inr_adt_tab a ";
        String strWhere = " WHERE a.cod_azl = ? ";

        if (lCOD_LUO_FSC != null) {
            strWhere += " AND a.cod_luo_fsc=? ";
        }
        if (strDES_INR_ADT != null) {
            strWhere += " AND UPPER(a.des_inr_adt) LIKE ? ";
        }
        if (lPNG_TEO != null) {
            strWhere += " AND a.png_teo=? ";
        }
        if (lPNG_RIL != null) {
            strWhere += " AND a.png_ril=? ";
        }
        if (lNUM_VIS_ISP != null) {
            strWhere += " AND a.num_vis_isp=? ";
        }
        if (dtDAT_ADT != null) {
            strWhere += " AND a.dat_adt=? ";
        }
        if (dtDAT_PIF_INR != null) {
            strWhere += " AND a.dat_pif_inr=? ";
        }
        if (lPNG_PCT != null) {
            strWhere += " AND a.png_pct=? ";
        }
        //--- dipendente
        if (lCOD_DPD != null) {
            strWhere += " AND a.cod_dpd=? ";
        } else if (strCOG_DPD != null || strNOM_DPD != null || strMTR_DPD != null) {
            strFrom += " , view_ana_dpd_tab b ";
            strWhere += " AND a.cod_dpd = b.cod_dpd ";
            if (strCOG_DPD != null) {
                strWhere += " AND UPPER(b.cog_dpd) LIKE ? ";
            }
            if (strNOM_DPD != null) {
                strWhere += " AND UPPER(b.nom_dpd) LIKE ? ";
            }
            if (strMTR_DPD != null) {
                strWhere += " AND UPPER(b.mtr_dpd) LIKE ? ";
            }
        }

        //strINR_ADT_AZL, strNOM_MIS_PET, strRB_LUO_FSC_MAN,
        if (strINR_ADT_AZL.equals("N")) {
            if (strNOM_MIS_PET != null) {
                if (strRB_LUO_FSC_MAN.equals("L")) {
                    strFrom += ", mis_pet_luo_fsc_tab c, ana_mis_pet_tab d ";
                    strWhere += " AND a.cod_mis_rso_luo=c.cod_mis_rso_luo AND c.cod_mis_pet=d.cod_mis_pet AND UPPER(d.nom_mis_pet) LIKE ?";
                } else if (strRB_LUO_FSC_MAN.equals("M")) {
                    strFrom += ", mis_pet_man_tab c, ana_mis_pet_tab d ";
                    strWhere += " AND a.cod_mis_pet_man=c.cod_mis_pet_man AND c.cod_mis_pet=d.cod_mis_pet AND UPPER(d.nom_mis_pet) LIKE ?";
                }
            } else {
                if (strRB_LUO_FSC_MAN.equals("L")) {
                    strWhere += "  AND a.cod_mis_rso_luo IS NOT NULL ";
                } else if (strRB_LUO_FSC_MAN.equals("M")) {
                    strWhere += "  AND a.cod_mis_pet_man IS NOT NULL ";
                }
            }
        }

        strSql = strSql + strFrom + strWhere /* + " ORDER BY UPPER(a.des_inr_adt) " */;

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (lCOD_LUO_FSC != null) {
                ps.setLong(i++, lCOD_LUO_FSC.longValue());
            }
            if (strDES_INR_ADT != null) {
                ps.setString(i++, strDES_INR_ADT.toUpperCase());
            }
            if (lPNG_TEO != null) {
                ps.setLong(i++, lPNG_TEO.longValue());
            }
            if (lPNG_RIL != null) {
                ps.setLong(i++, lPNG_RIL.longValue());
            }
            if (lNUM_VIS_ISP != null) {
                ps.setLong(i++, lNUM_VIS_ISP.longValue());
            }
            if (dtDAT_ADT != null) {
                ps.setDate(i++, dtDAT_ADT);
            }
            if (dtDAT_PIF_INR != null) {
                ps.setDate(i++, dtDAT_PIF_INR);
            }
            if (lPNG_PCT != null) {
                ps.setLong(i++, lPNG_PCT.longValue());
            }

            if (lCOD_DPD != null) {
                ps.setLong(i++, lCOD_DPD.longValue());
            } else {
                if (strCOG_DPD != null) {
                    ps.setString(i++, strCOG_DPD.toUpperCase());
                }
                if (strNOM_DPD != null) {
                    ps.setString(i++, strNOM_DPD.toUpperCase());
                }
                if (strMTR_DPD != null) {
                    ps.setString(i++, strMTR_DPD.toUpperCase());
                }
            }
            if (strINR_ADT_AZL != null && strINR_ADT_AZL.equals("N") &&
                    strNOM_MIS_PET != null) {
                ps.setString(i++, strNOM_MIS_PET.toUpperCase());
            }


            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                InterventoAuditView obj = new InterventoAuditView();
                obj.lCOD_INR_ADT = rs.getLong(1);
                obj.strDES_INR_ADT = rs.getString(2);
                obj.dtDAT_PIF_INR = rs.getDate(3);
                obj.lNUM_VIS_ISP = rs.getLong(4);
                obj.dtDAT_ADT = rs.getDate(5);
                obj.lCOD_MIS_PET = rs.getLong(6);
                obj.lCOD_PSD_ACD = rs.getLong(7);
                obj.lCOD_LUO_FSC = rs.getLong(8);
                obj.lCOD_DPD = rs.getLong(9);
                obj.lCOD_AZL = rs.getLong(10);
                obj.strSEC_PNO_YEA = rs.getString(11);
                obj.lPNG_TEO = rs.getLong(12);
                obj.lPNG_RIL = rs.getLong(13);
                obj.lPNG_PCT = rs.getLong(14);
                obj.lCOD_UNI_ORG = rs.getLong(15);
                obj.lCOD_MIS_RSO_LUO = rs.getLong(16);
                obj.lCOD_MIS_PET_MAN = rs.getLong(17);
                ar.add(obj);
            }
            return ar;
        //----------------------------------------------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }
}
