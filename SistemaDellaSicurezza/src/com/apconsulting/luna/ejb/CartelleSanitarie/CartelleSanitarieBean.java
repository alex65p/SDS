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
package com.apconsulting.luna.ejb.CartelleSanitarie;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
public class CartelleSanitarieBean extends BMPEntityBean implements ICartelleSanitarie, ICartelleSanitarieHome //class CartelleSanitarieBean extends ICartelleSanitarieHome
{
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    long COD_CTL_SAN;			//1
    java.sql.Date DAT_CRE_CTL_SAN;		//2
    String NOM_MED_RSP_CTL_SAN;	//3
    long COD_DPD;
    long COD_AZL;
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static CartelleSanitarieBean ys = null;

    private CartelleSanitarieBean() {
        //
    }

    public static CartelleSanitarieBean getInstance() {
        if (ys == null) {
            ys = new CartelleSanitarieBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public ICartelleSanitarie create(java.sql.Date dDAT_CRE_CTL_SAN, String strNOM_MED_RSP_CTL_SAN, long lCOD_DPD, long lCOD_AZL) throws CreateException {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        try {
            Object primaryKey = bean.ejbCreate(dDAT_CRE_CTL_SAN, strNOM_MED_RSP_CTL_SAN, lCOD_DPD, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(dDAT_CRE_CTL_SAN, strNOM_MED_RSP_CTL_SAN, lCOD_DPD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        CartelleSanitarieBean iCartelleSanitarieBean = new CartelleSanitarieBean();
        try {
            Object obj = iCartelleSanitarieBean.ejbFindByPrimaryKey((Long) primaryKey);
            iCartelleSanitarieBean.setEntityContext(new EntityContextWrapper(obj));
            iCartelleSanitarieBean.ejbActivate();
            iCartelleSanitarieBean.ejbLoad();
            iCartelleSanitarieBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public ICartelleSanitarie findByPrimaryKey(Long primaryKey) throws FinderException {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    // (Home Intrface) findAll()

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getCTL_SAN_All_View(long lCOD_AZL) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetCTL_SAN_All_View(lCOD_AZL);
    }

    public Collection getDocumentiCartelle_View(long FilterID) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetDocumentiCartelle_View(FilterID);
    }

    public Collection getProtocolliSanitari_View(long FilterID) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetProtocolliSanitari_View(FilterID);
    }

    public Collection getVisiteIdoneita_View(long FilterID) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetVisiteIdoneita_View(FilterID);
    }

    public Collection getVisiteMediche_View(long FilterID) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetVisiteMediche_View(FilterID);
    }

    public Collection getCTL_VST_IDO_View() {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetCTL_VST_IDO_View();
    }

    public Collection getCTL_VST_MED_View() {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetCTL_VST_MED_View();
    }

    public Collection getCTL_VST_IDO_All_View(long lCOD_VST_IDO, long lCOD_AZL, long lCOD_DPD, long lCOD_CTL_SAN, java.sql.Date newDATE_PIF_VST) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetCTL_VST_IDO_All_View(lCOD_VST_IDO, lCOD_AZL, lCOD_DPD, lCOD_CTL_SAN, newDATE_PIF_VST);
    }

    public Collection getCTL_VST_MED_All_View(long lCOD_VST_MED, long lCOD_AZL, long lCOD_DPD, long lCOD_CTL_SAN, java.sql.Date newDATE_PIF_MED) {
        CartelleSanitarieBean bean = new CartelleSanitarieBean();
        return bean.ejbGetCTL_VST_MED_All_View(lCOD_VST_MED, lCOD_AZL, lCOD_DPD, lCOD_CTL_SAN, newDATE_PIF_MED);
    }
//<report>

    public Collection getReportVisiteIdoneita_View(long FilterID) {
        return this.ejbGetReportVisiteIdoneita_View(FilterID);
    }

    public Collection getReportVisiteMediche_View(long FilterID) {
        return this.ejbGetReportVisiteMediche_View(FilterID);
    }
//<report>
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</ICartelleSanitarieHome-implementation>
    public Long ejbCreate(java.sql.Date dDAT_CRE_CTL_SAN, String strNOM_MED_RSP_CTL_SAN, long lCOD_DPD, long lCOD_AZL) {
        this.DAT_CRE_CTL_SAN = dDAT_CRE_CTL_SAN;
        this.NOM_MED_RSP_CTL_SAN = strNOM_MED_RSP_CTL_SAN;
        this.COD_DPD = lCOD_DPD;
        this.COD_AZL = lCOD_AZL;
        this.COD_CTL_SAN = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_ctl_san_tab (cod_ctl_san,dat_cre_ctl_san,nom_med_rsp_ctl_san,cod_dpd,cod_azl) VALUES(?,?,?,?,?)");

            ps.setLong(1, COD_CTL_SAN);
            ps.setDate(2, DAT_CRE_CTL_SAN);
            ps.setString(3, NOM_MED_RSP_CTL_SAN);
            ps.setLong(4, COD_DPD);
            ps.setLong(5, COD_AZL);

            ps.executeUpdate();
            return new Long(COD_CTL_SAN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(java.sql.Date dDAT_CRE_CTL_SAN, String strNOM_MED_RSP_CTL_SAN, long lCOD_DPD, long lCOD_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ctl_san FROM ana_ctl_san_tab ");
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

//-----------------------------------------------------------
    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        this.COD_CTL_SAN = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_CTL_SAN = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_ctl_san_tab  WHERE cod_ctl_san=?");
            ps.setLong(1, COD_CTL_SAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_CTL_SAN = rs.getLong("COD_CTL_SAN");
                this.DAT_CRE_CTL_SAN = rs.getDate("DAT_CRE_CTL_SAN");
                this.NOM_MED_RSP_CTL_SAN = rs.getString("NOM_MED_RSP_CTL_SAN");
                this.COD_DPD = rs.getLong("COD_DPD");
                this.COD_AZL = rs.getLong("COD_AZL");
            } else {
                throw new NoSuchEntityException("CartelleSanitarie con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_ctl_san_tab  WHERE cod_ctl_san=?");
            ps.setLong(1, COD_CTL_SAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Cartelle Sanitarie con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//----------------------------------------------------------

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_ctl_san_tab  SET dat_cre_ctl_san=?, nom_med_rsp_ctl_san=?, cod_dpd=?, cod_azl=? WHERE cod_ctl_san=?");
            ps.setDate(1, DAT_CRE_CTL_SAN);
            ps.setString(2, NOM_MED_RSP_CTL_SAN);
            ps.setLong(3, COD_DPD);
            ps.setLong(4, COD_AZL);
            ps.setLong(5, COD_CTL_SAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("CartelleSanitarie con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
    // COD_CTL_SAN
    public void setCOD_CTL_SAN(long newCOD_CTL_SAN) {
        if (COD_CTL_SAN == newCOD_CTL_SAN) {
            return;
        }
        COD_CTL_SAN = newCOD_CTL_SAN;
        setModified();
    }

    public long getCOD_CTL_SAN() {
        return COD_CTL_SAN;
    }

    // DAT_CRE_CTL_SAN
    public void setDAT_CRE_CTL_SAN(java.sql.Date newDAT_CRE_CTL_SAN) {
        if (DAT_CRE_CTL_SAN != null) {
            if (DAT_CRE_CTL_SAN.equals(newDAT_CRE_CTL_SAN)) {
                return;
            }
        }
        DAT_CRE_CTL_SAN = newDAT_CRE_CTL_SAN;
        setModified();
    }

    public java.sql.Date getDAT_CRE_CTL_SAN() {
        return DAT_CRE_CTL_SAN;
    }

    // NOM_MED_RSP_CTL_SAN
    public void setNOM_MED_RSP_CTL_SAN(String newNOM_MED_RSP_CTL_SAN) {
        if (NOM_MED_RSP_CTL_SAN != null) {
            if (NOM_MED_RSP_CTL_SAN.equals(newNOM_MED_RSP_CTL_SAN)) {
                return;
            }
        }
        NOM_MED_RSP_CTL_SAN = newNOM_MED_RSP_CTL_SAN;
        setModified();
    }

    public String getNOM_MED_RSP_CTL_SAN() {
        return NOM_MED_RSP_CTL_SAN;
    }

    // COD_DPD
    public void setCOD_DPD(long newCOD_DPD) {
        if (COD_DPD == newCOD_DPD) {
            return;
        }
        COD_DPD = newCOD_DPD;
        setModified();
    }

    public long getCOD_DPD() {
        return COD_DPD;
    }

    // COD_AZL
    public void setCOD_AZL(long newCOD_AZL) {
        if (COD_AZL == newCOD_AZL) {
            return;
        }
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }

    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_ctl_san_tab (cod_doc,cod_azl,cod_dpd,cod_ctl_san) VALUES(?,?,?,?)");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, COD_AZL);
            ps.setLong(3, COD_DPD);
            ps.setLong(4, COD_CTL_SAN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_PRO_SAN(long newCOD_PRO_SAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO pro_san_ctl_san_tab (cod_pro_san,cod_azl,cod_dpd,cod_ctl_san) VALUES(?,?,?,?)");
            ps.setLong(1, newCOD_PRO_SAN);
            ps.setLong(2, COD_AZL);
            ps.setLong(3, COD_DPD);
            ps.setLong(4, COD_CTL_SAN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_VST_IDO(long newCOD_VST_IDO, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newIDO_VST, String newNOT_VST_IDO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO vst_ido_ctl_san_tab "
                    + "(cod_vst_ido,cod_azl,cod_dpd,cod_ctl_san,dat_pif_vst_ido,dat_eft_vst_ido,tpl_acr_vlu_rso,"
                    + "tpl_acr_vlu_med,tpl_acr_eft,ido_vst,not_vst_ido) VALUES(?,?,?,?,?,?,?,?,?,?,?)");

            ps.setLong(1, newCOD_VST_IDO);
            ps.setLong(2, COD_AZL);
            ps.setLong(3, COD_DPD);
            ps.setLong(4, COD_CTL_SAN);
            ps.setDate(5, newDAT_PIF_VST);
            ps.setDate(6, newDAT_EFT_VST);
            ps.setString(7, newTPL_ACR_VLU_RSO);
            ps.setString(8, newTPL_ACR_VLU_MED);
            ps.setString(9, newTPL_ACR_EFT);
            ps.setString(10, newIDO_VST);
            ps.setString(11, newNOT_VST_IDO);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void editCOD_VST_IDO(long oldCOD_VST_IDO, long newCOD_VST_IDO, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newIDO_VST, String newNOT_VST_IDO, java.sql.Date oldDAT_PIF_VST) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE vst_ido_ctl_san_tab"
                    + " SET cod_vst_ido=?,dat_pif_vst_ido=?,dat_eft_vst_ido=?,"
                    + "tpl_acr_vlu_rso=?,tpl_acr_vlu_med=?,tpl_acr_eft=?,"
                    + "ido_vst=?,not_vst_ido=? WHERE cod_vst_ido=? "
                    + "AND cod_azl=? AND cod_dpd=? AND cod_ctl_san=? "
                    + "AND dat_pif_vst_ido=?");
            ps.setLong(1, newCOD_VST_IDO);
            ps.setDate(2, newDAT_PIF_VST);
            ps.setDate(3, newDAT_EFT_VST);
            ps.setString(4, newTPL_ACR_VLU_RSO);
            ps.setString(5, newTPL_ACR_VLU_MED);
            ps.setString(6, newTPL_ACR_EFT);
            ps.setString(7, newIDO_VST);
            ps.setString(8, newNOT_VST_IDO);
            ps.setLong(9, oldCOD_VST_IDO);
            ps.setLong(10, COD_AZL);
            ps.setLong(11, COD_DPD);
            ps.setLong(12, COD_CTL_SAN);
            ps.setDate(13, oldDAT_PIF_VST);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_VST_MED(long newCOD_VST_MED, java.sql.Date newDAT_PIF_VST, java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO, String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newNOT_VST_MED) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO vst_med_ctl_san_tab (cod_vst_med,cod_azl,cod_dpd,cod_ctl_san,dat_pif_vst_med,dat_eft_vst_med,tpl_acr_vlu_rso,tpl_acr_vlu_med,tpl_acr_eft,not_vst_med) VALUES(?,?,?,?,?,?,?,?,?,?)");
            ps.setLong(1, newCOD_VST_MED);
            ps.setLong(2, COD_AZL);
            ps.setLong(3, COD_DPD);
            ps.setLong(4, COD_CTL_SAN);
            ps.setDate(5, newDAT_PIF_VST);
            ps.setDate(6, newDAT_EFT_VST);
            ps.setString(7, newTPL_ACR_VLU_RSO);
            ps.setString(8, newTPL_ACR_VLU_MED);
            ps.setString(9, newTPL_ACR_EFT);
            ps.setString(10, newNOT_VST_MED);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void editCOD_VST_MED(long oldCOD_VST_MED,
            long newCOD_VST_MED, java.sql.Date newDAT_PIF_VST,
            java.sql.Date newDAT_EFT_VST, String newTPL_ACR_VLU_RSO,
            String newTPL_ACR_VLU_MED, String newTPL_ACR_EFT, String newNOT_VST_MED,
            java.sql.Date oldDAT_PIF_VST) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE vst_med_ctl_san_tab "
                    + " SET cod_vst_med=?,dat_pif_vst_med=?,"
                    + "dat_eft_vst_med=?,tpl_acr_vlu_rso=?,"
                    + "tpl_acr_vlu_med=?,tpl_acr_eft=?,"
                    + "not_vst_med=? "
                    + "WHERE cod_vst_med=? AND cod_azl=? "
                    + "AND cod_dpd=? AND cod_ctl_san=? AND dat_pif_vst_med=?");
            ps.setLong(1, newCOD_VST_MED);
            ps.setDate(2, newDAT_PIF_VST);
            ps.setDate(3, newDAT_EFT_VST);
            ps.setString(4, newTPL_ACR_VLU_RSO);
            ps.setString(5, newTPL_ACR_VLU_MED);
            ps.setString(6, newTPL_ACR_EFT);
            ps.setString(7, newNOT_VST_MED);
            ps.setLong(8, oldCOD_VST_MED);
            ps.setLong(9, COD_AZL);
            ps.setLong(10, COD_DPD);
            ps.setLong(11, COD_CTL_SAN);
            ps.setDate(12, oldDAT_PIF_VST);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_ctl_san_tab  WHERE cod_dpd=? AND cod_doc=? AND cod_ctl_san=? AND cod_azl=?");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_DOC);
            ps.setLong(3, COD_CTL_SAN);
            ps.setLong(4, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Riga con ID=" + newCOD_DOC + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_PRO_SAN(long newCOD_PRO_SAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM pro_san_ctl_san_tab  WHERE cod_dpd=? AND cod_pro_san=? AND cod_ctl_san=? AND cod_azl=?");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_PRO_SAN);
            ps.setLong(3, COD_CTL_SAN);
            ps.setLong(4, COD_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Riga con ID=" + newCOD_PRO_SAN + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_VST_IDO(long newCOD_VST_IDO, long COD_DPD, long COD_CTL_SAN, long COD_AZL, java.sql.Date DATA_PIF_VST_IDO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM vst_ido_ctl_san_tab  WHERE cod_dpd=? AND cod_vst_ido=? AND cod_ctl_san=? AND cod_azl=? AND dat_pif_vst_ido=?");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_VST_IDO);
            ps.setLong(3, COD_CTL_SAN);
            ps.setLong(4, COD_AZL);
            ps.setDate(5, DATA_PIF_VST_IDO);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Riga con ID=" + newCOD_VST_IDO + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_VST_MED(long newCOD_VST_MED, long COD_DPD, long COD_CTL_SAN, long COD_AZL, java.sql.Date DATA_PIF_VST_MED) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM vst_med_ctl_san_tab  WHERE cod_dpd=? AND cod_vst_med=? AND cod_ctl_san=? AND cod_azl=? AND dat_pif_vst_med=?");
            ps.setLong(1, COD_DPD);
            ps.setLong(2, newCOD_VST_MED);
            ps.setLong(3, COD_CTL_SAN);
            ps.setLong(4, COD_AZL);
            ps.setDate(5, DATA_PIF_VST_MED);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Riga con ID=" + newCOD_VST_MED + " non e' trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//</comment>
    //-------------------
    //</comment>
    public Collection ejbGetDocumentiCartelle_View(long FilterID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ana.cod_doc, tit_doc, rsp_doc, dat_rev_doc FROM ana_doc_tab ana,doc_ctl_san_tab  ctl WHERE   ctl.cod_doc = ana.cod_doc and cod_ctl_san = ? ORDER BY tit_doc ");
            ps.setLong(1, FilterID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DocumentiCartelle_View obj = new DocumentiCartelle_View();
                obj.COD_DOC = rs.getLong(1);
                obj.NB_TIT_DOC = rs.getString(2);
                obj.NB_RSP_DOC = rs.getString(3);
                obj.NB_DAT_REV_DOC = rs.getDate(4);
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

    public Collection ejbGetProtocolliSanitari_View(long FilterID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_pro_san, nom_pro_san FROM ana_pro_san_tab ana, pro_san_ctl_san_tab  ctl WHERE ana.cod_pro_san=ctl.cod_pro_san AND ctl.cod_ctl_san =? ORDER BY nom_pro_san");
            ps.setLong(1, FilterID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ProtocolliSanitari_View obj = new ProtocolliSanitari_View();
                obj.COD_PRO_SAN = rs.getLong(1);
                obj.NOM_PRO_SAN = rs.getString(2);
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

    public Collection ejbGetVisiteIdoneita_View(long FilterID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_vst_ido, nom_vst_ido,dat_pif_vst_ido FROM ana_vst_ido_tab ana, vst_ido_ctl_san_tab ctl WHERE ctl.cod_vst_ido = ana.cod_vst_ido and cod_ctl_san = ? ORDER BY nom_vst_ido");
            ps.setLong(1, FilterID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteIdoneita_View obj = new VisiteIdoneita_View();
                obj.COD_VST_IDO = rs.getLong(1);
                obj.NOM_VST_IDO = rs.getString(2);
                obj.DAT_PIF_VST_IDO = rs.getDate(3);
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

    public Collection ejbGetVisiteMediche_View(long FilterID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_vst_med, nom_vst_med,dat_pif_vst_med FROM ana_vst_med_tab ana, vst_med_ctl_san_tab ctl WHERE ctl.cod_vst_med = ana.cod_vst_med and cod_ctl_san = ? ORDER BY nom_vst_med");
            ps.setLong(1, FilterID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                VisiteMediche_View obj = new VisiteMediche_View();
                obj.COD_VST_MED = rs.getLong(1);
                obj.NOM_VST_MED = rs.getString(2);
                obj.DAT_PIF_VST_MED = rs.getDate(3);
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

    public Collection ejbGetCTL_VST_IDO_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_vst_ido, nom_vst_ido, dat_pif_vst_ido, dat_eft_vst_ido, cod_ctl_san FROM ana_vst_ido_tab ana, vst_ido_ctl_san_tab ctl WHERE ctl.cod_vst_ido = ana.cod_vst_ido");

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CTL_VST_IDO_View obj = new CTL_VST_IDO_View();
                obj.COD_VST_IDO = rs.getLong(1);
                obj.NOM_VST_IDO = rs.getString(2);
                obj.DAT_PIF_VST = rs.getDate(3);
                obj.DAT_EFT_VST = rs.getDate(4);
                obj.COD_CTL_SAN = rs.getLong(5);
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

    public Collection ejbGetCTL_VST_IDO_All_View(long newCOD_VST_IDO, long newCOD_AZL, long newCOD_DPD, long newCOD_CTL_SAN, java.sql.Date newDATE_PIF_VST) {
        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("SELECT dat_pif_vst_ido,dat_eft_vst_ido,"
                    + "tpl_acr_vlu_rso,tpl_acr_vlu_med,tpl_acr_eft,"
                    + "ido_vst,not_vst_ido FROM vst_ido_ctl_san_tab "
                    + "WHERE cod_azl=? AND cod_dpd=? AND cod_ctl_san=?"
                    + " AND cod_vst_ido=? AND dat_pif_vst_ido=? ");
            ps.setLong(1, newCOD_AZL);
            ps.setLong(2, newCOD_DPD);
            ps.setLong(3, newCOD_CTL_SAN);
            ps.setLong(4, newCOD_VST_IDO);
            ps.setDate(5, newDATE_PIF_VST);
            ResultSet rs = ps.executeQuery();


            java.util.ArrayList al = new java.util.ArrayList();
            if (rs.next()) {
                CTL_VST_IDO_All_View obj = new CTL_VST_IDO_All_View();
                obj.DAT_PIF_VST = rs.getDate(1);
                obj.DAT_EFT_VST = rs.getDate(2);
                obj.TPL_ACR_VLU_RSO = rs.getString(3);
                obj.TPL_ACR_VLU_MED = rs.getString(4);
                obj.TPL_ACR_EFT = rs.getString(5);
                obj.IDO_VST = rs.getString(6);
                obj.NOT_VST_IDO = rs.getString(7);
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

    public Collection ejbGetCTL_VST_MED_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_vst_med, nom_vst_med, dat_pif_vst_med, dat_eft_vst_med, cod_ctl_san FROM ana_vst_med_tab ana, vst_med_ctl_san_tab ctl WHERE ctl.cod_vst_med = ana.cod_vst_med");

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CTL_VST_MED_View obj = new CTL_VST_MED_View();
                obj.COD_VST_MED = rs.getLong(1);
                obj.NOM_VST_MED = rs.getString(2);
                obj.DAT_PIF_VST = rs.getDate(3);
                obj.DAT_EFT_VST = rs.getDate(4);
                obj.COD_CTL_SAN = rs.getLong(5);
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

    public Collection ejbGetCTL_VST_MED_All_View(long newCOD_VST_MED, long newCOD_AZL, long newCOD_DPD, long newCOD_CTL_SAN, java.sql.Date newDATE_PIF_MED) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT dat_pif_vst_med,dat_eft_vst_med,"
                    + "tpl_acr_vlu_rso,tpl_acr_vlu_med,tpl_acr_eft,"
                    + "not_vst_med FROM vst_med_ctl_san_tab "
                    + "WHERE cod_azl=? AND cod_dpd=? "
                    + "AND cod_ctl_san=? AND cod_vst_med=?"
                    + "AND dat_pif_vst_med=?");
            ps.setLong(1, newCOD_AZL);
            ps.setLong(2, newCOD_DPD);
            ps.setLong(3, newCOD_CTL_SAN);
            ps.setLong(4, newCOD_VST_MED);
            ps.setDate(5, newDATE_PIF_MED);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            if (rs.next()) {
                CTL_VST_MED_All_View obj = new CTL_VST_MED_All_View();
                obj.DAT_PIF_VST = rs.getDate(1);
                obj.DAT_EFT_VST = rs.getDate(2);
                obj.TPL_ACR_VLU_RSO = rs.getString(3);
                obj.TPL_ACR_VLU_MED = rs.getString(4);
                obj.TPL_ACR_EFT = rs.getString(5);
                obj.NOT_VST_MED = rs.getString(6);
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
    //<report>

    public Collection ejbGetReportVisiteIdoneita_View(long FilterID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_vst_ido, nom_vst_ido, dat_eft_vst_ido FROM ana_vst_ido_tab ana, vst_ido_ctl_san_tab ctl WHERE ctl.cod_vst_ido = ana.cod_vst_ido and cod_ctl_san = ? ORDER BY dat_eft_vst_ido");
            ps.setLong(1, FilterID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportVisiteIdoneita_View obj = new ReportVisiteIdoneita_View();
                obj.COD_VST_IDO = rs.getLong(1);
                obj.NOM_VST_IDO = rs.getString(2);
                obj.DAT_EFT_VST_IDO = rs.getDate(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetReportVisiteMediche_View(long FilterID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ctl.cod_vst_med, nom_vst_med, dat_eft_vst_med FROM ana_vst_med_tab ana, vst_med_ctl_san_tab ctl WHERE ctl.cod_vst_med = ana.cod_vst_med and cod_ctl_san = ? ORDER BY dat_eft_vst_med");
            ps.setLong(1, FilterID);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportVisiteMediche_View obj = new ReportVisiteMediche_View();
                obj.COD_VST_MED = rs.getLong(1);
                obj.NOM_VST_MED = rs.getString(2);
                obj.DAT_EFT_VST_MED = rs.getDate(3);
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
    //</report>

    public Collection ejbGetCTL_SAN_All_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_ctl_san, b.mtr_dpd, b.nom_dpd, b.cog_dpd, a.dat_cre_ctl_san, a.nom_med_rsp_ctl_san ";
            query += "FROM ana_ctl_san_tab a, view_ana_dpd_tab b ";
            query += "WHERE a.cod_azl = ? AND a.cod_azl = b.cod_azl AND a.cod_dpd = b.cod_dpd ";
            query += "ORDER BY cog_dpd";
            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CTL_SAN_All_View obj = new CTL_SAN_All_View();
                obj.COD_CTL_SAN = rs.getLong(1);
                obj.MTR_DPD = rs.getString(2);
                obj.NOM_DPD = rs.getString(3);
                obj.COG_DPD = rs.getString(4);
                obj.DAT_CRE_CTL_SAN = rs.getDate(5);
                obj.NOM_MED_RSP_CTL_SAN = rs.getString(6);
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

    public Collection findEx(long lCOD_AZL,
            java.sql.Date datDAT_CRE_CTL_SAN,
            String strNOM_MED_RSP_CTL_SAN,
            Long lCOD_DPD,
            int iOrderParameter) {
        return (new CartelleSanitarieBean()).ejbFindEx(lCOD_AZL,
                datDAT_CRE_CTL_SAN,
                strNOM_MED_RSP_CTL_SAN,
                lCOD_DPD,
                iOrderParameter);
    }

    public Collection ejbFindEx(long lCOD_AZL,
            java.sql.Date datDAT_CRE_CTL_SAN,
            String strNOM_MED_RSP_CTL_SAN,
            Long lCOD_DPD,
            int iOrderParameter) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_ctl_san, b.mtr_dpd, b.nom_dpd, b.cog_dpd, a.dat_cre_ctl_san, a.nom_med_rsp_ctl_san ";
            query += "FROM ana_ctl_san_tab a, view_ana_dpd_tab b ";
            query += "WHERE a.cod_azl = ? AND a.cod_azl = b.cod_azl AND a.cod_dpd = b.cod_dpd ";
            if (lCOD_DPD != null) {
                query += " AND  a.cod_dpd = ?";
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
                query += " AND  UPPER(a.nom_med_rsp_ctl_san)  LIKE ?";
            }
            if (datDAT_CRE_CTL_SAN != null) {
                query += " AND  a.dat_cre_ctl_san = ?";
            }
            query += "ORDER BY UPPER(cog_dpd)";

            int i = 1;

            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(i++, lCOD_AZL);

            if (lCOD_DPD != null) {
                ps.setLong(i++, lCOD_DPD.longValue());
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
                ps.setString(i++, strNOM_MED_RSP_CTL_SAN.toUpperCase());
            }
            if (datDAT_CRE_CTL_SAN != null) {
                ps.setDate(i++, datDAT_CRE_CTL_SAN);
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CTL_SAN_All_View obj = new CTL_SAN_All_View();
                obj.COD_CTL_SAN = rs.getLong(1);
                obj.MTR_DPD = rs.getString(2);
                obj.NOM_DPD = rs.getString(3);
                obj.COG_DPD = rs.getString(4);
                obj.DAT_CRE_CTL_SAN = rs.getDate(5);
                obj.NOM_MED_RSP_CTL_SAN = rs.getString(6);
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
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  CartelleSanitarieBean"/>

