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
package com.apconsulting.luna.ejb.Corsi;

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
public class CorsiBean extends BMPEntityBean implements ICorsi, ICorsiHome {
    //<member-varibles description="Member Variables">

    long lCOD_COR;
    long lDUR_COR_GOR;
    String strNOM_COR;
    String strDES_COR;
    String strUSO_ATE_FRE_COR;
    String strUSO_PTG_COR;
    long lCOD_TPL_COR;
    //</member-varibles>
    //<ICorsiHome-implementation>
    public static final String BEAN_NAME = "CorsiBean";
    // Costruttore.
    private static CorsiBean ys = null;

    private CorsiBean() {
        //
    }

    public static CorsiBean getInstance() {
        if (ys == null) {
            ys = new CorsiBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        CorsiBean bean = new CorsiBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        }
    }

    public ICorsi create(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) throws javax.ejb.CreateException {
        CorsiBean bean = new CorsiBean();
        try {
            Object primaryKey = bean.ejbCreate(lDUR_COR_GOR, strNOM_COR, lCOD_TPL_COR);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lDUR_COR_GOR, strNOM_COR, lCOD_TPL_COR);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public ICorsi findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        CorsiBean bean = new CorsiBean();
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
    //
    // (Home Intrface) VIEWS  getTipologiaCorsi_Name_Address_View()

    public Collection getCorsi_All_View() {
        return (new CorsiBean()).ejbGetCorsi_All_View();
    }

    public Collection getTestVerifica_View(long lCOD_COR) {
        return (new CorsiBean()).ejbGetTestVerifica_View(lCOD_COR);
    }

    public Collection getMaterialeCorso_View(long lCOD_COR) {
        return (new CorsiBean()).ejbGetMaterialeCorso_View(lCOD_COR);
    }
    ///==================Added by Podmasteriev=========================================\\\

    public Collection getCorsoNome_VIEW(long lCOD_AZL) {
        return (new CorsiBean()).ejbGetCorsoNome_VIEW(lCOD_AZL);
    }
    //==================================================================\\\

    public Long ejbCreate(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) {
        this.lCOD_COR = NEW_ID();
        this.lDUR_COR_GOR = lDUR_COR_GOR;
        this.strNOM_COR = strNOM_COR;
        this.lCOD_TPL_COR = lCOD_TPL_COR;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_cor_tab (cod_cor,dur_cor_gor,nom_cor,cod_tpl_cor) VALUES(?,?,?,?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, lDUR_COR_GOR);
            ps.setString(3, strNOM_COR);
            ps.setLong(4, lCOD_TPL_COR);
            ps.executeUpdate();
            return new Long(lCOD_COR);
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lDUR_COR_GOR, String strNOM_COR, long lCOD_TPL_COR) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cor FROM ana_cor_tab");
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
        this.lCOD_COR = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_COR = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cor,dur_cor_gor,nom_cor,des_cor,uso_ate_fre_cor,uso_ptg_cor,cod_tpl_cor FROM ana_cor_tab WHERE cod_cor=?");
            ps.setLong(1, lCOD_COR);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_COR = rs.getLong(1);
                lDUR_COR_GOR = rs.getLong(2);
                strNOM_COR = rs.getString(3);
                strDES_COR = rs.getString(4);
                strUSO_ATE_FRE_COR = rs.getString(5);
                strUSO_PTG_COR = rs.getString(6);
                lCOD_TPL_COR = rs.getLong(7);
            } else {
                throw new NoSuchEntityException("Corsi with ID=" + lCOD_COR + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_cor_tab WHERE cod_cor=?");
            ps.setLong(1, lCOD_COR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corsi with ID=" + lCOD_COR + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_cor_tab SET cod_cor=?, dur_cor_gor=?, nom_cor=?, des_cor=?, uso_ate_fre_cor=?, uso_ptg_cor=?, cod_tpl_cor=? WHERE cod_cor=?");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, lDUR_COR_GOR);
            ps.setString(3, strNOM_COR);
            ps.setString(4, strDES_COR);
            ps.setString(5, strUSO_ATE_FRE_COR);
            ps.setString(6, strUSO_PTG_COR);
            ps.setLong(7, lCOD_TPL_COR);
            ps.setLong(8, lCOD_COR);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corsi with ID=" + lCOD_COR + " not found");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<setter-getters>
    public long getCOD_COR() {
        return lCOD_COR;
    }

    public long getDUR_COR_GOR() {
        return lDUR_COR_GOR;
    }

    public void setDUR_COR_GOR(long lDUR_COR_GOR) {
        if (this.lDUR_COR_GOR == lDUR_COR_GOR) {
            return;
        }
        this.lDUR_COR_GOR = lDUR_COR_GOR;
        // Correzione Bug 1.96
        setModified();
    }

    public String getNOM_COR() {
        return strNOM_COR;
    }

    public void setNOM_COR(String strNOM_COR) {
        if ((this.strNOM_COR != null) && (this.strNOM_COR.equals(strNOM_COR))) {
            return;
        }
        this.strNOM_COR = strNOM_COR;
        setModified();
    }

    public String getDES_COR() {
        return strDES_COR;
    }

    public void setDES_COR(String strDES_COR) {
        if ((this.strDES_COR != null) && (this.strDES_COR.equals(strDES_COR))) {
            return;
        }
        this.strDES_COR = strDES_COR;
        setModified();
    }

    public String getUSO_ATE_FRE_COR() {
        return strUSO_ATE_FRE_COR;
    }

    public void setUSO_ATE_FRE_COR(String strUSO_ATE_FRE_COR) {
        if ((this.strUSO_ATE_FRE_COR != null) && (this.strUSO_ATE_FRE_COR.equals(strUSO_ATE_FRE_COR))) {
            return;
        }
        this.strUSO_ATE_FRE_COR = strUSO_ATE_FRE_COR;
        setModified();
    }

    public String getUSO_PTG_COR() {
        return strUSO_PTG_COR;
    }

    public void setUSO_PTG_COR(String strUSO_PTG_COR) {
        if ((this.strUSO_PTG_COR != null) && (this.strUSO_PTG_COR.equals(strUSO_PTG_COR))) {
            return;
        }
        this.strUSO_PTG_COR = strUSO_PTG_COR;
        setModified();
    }

    public long getCOD_TPL_COR() {
        return lCOD_TPL_COR;
    }

    public void setCOD_TPL_COR(long lCOD_TPL_COR) {
        if (this.lCOD_TPL_COR == lCOD_TPL_COR) {
            return;
        }
        this.lCOD_TPL_COR = lCOD_TPL_COR;
        setModified();
    }

    //</setter-getters>
    public Collection ejbGetTestVerifica_View(long lCOD_COR) {
        BMPConnection bmp = getConnection();
        try {
            //PreparedStatement ps=bmp.prepareStatement("SELECT ana_tes_vrf_tab.cod_tes_vrf, ana_tes_vrf_tab.nom_tes_vrf, ana_tes_vrf_tab. num_min_ptg, ana_tes_vrf_tab.num_max_ptg FROM ana_tes_vrf_tab, dmd_tes_vrf_tab, tes_vrf_cor_tab WHERE ana_tes_vrf_tab.cod_tes_vrf = tes_vrf_cor_tab.cod_tes_vrf AND tes_vrf_cor_tab.cod_cor = ? GROUP BY ana_tes_vrf_tab.cod_tes_vrf, ana_tes_vrf_tab.nom_tes_vrf, ana_tes_vrf_tab.num_min_ptg, ana_tes_vrf_tab.num_max_ptg ORDER BY ana_tes_vrf_tab.nom_tes_vrf ");
            PreparedStatement ps = bmp.prepareStatement("SELECT ana_tes_vrf_tab.cod_tes_vrf, ana_tes_vrf_tab.nom_tes_vrf, ana_tes_vrf_tab. num_min_ptg, ana_tes_vrf_tab.num_max_ptg FROM ana_tes_vrf_tab, tes_vrf_cor_tab WHERE ana_tes_vrf_tab.cod_tes_vrf = tes_vrf_cor_tab.cod_tes_vrf AND tes_vrf_cor_tab.cod_cor = ? GROUP BY ana_tes_vrf_tab.cod_tes_vrf, ana_tes_vrf_tab.nom_tes_vrf, ana_tes_vrf_tab.num_min_ptg, ana_tes_vrf_tab.num_max_ptg ORDER BY ana_tes_vrf_tab.nom_tes_vrf ");
            ps.setLong(1, lCOD_COR);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                TestVerifica_View obj = new TestVerifica_View();
                obj.COD_TES_VRF = rs.getLong(1);
                obj.NOM_TES_VRF = rs.getString(2);
                obj.NUM_MIN_PTG = rs.getLong(3);
                obj.NUM_MAX_PTG = rs.getLong(4);
                PreparedStatement ps1 = bmp.prepareStatement("SELECT count(dmd_tes_vrf_tab.cod_dmd) FROM dmd_tes_vrf_tab WHERE dmd_tes_vrf_tab.cod_tes_vrf=? ");
                ps1.setLong(1, rs.getLong(1));
                ResultSet rs1 = ps1.executeQuery();
                if (rs1.next()) {
                    obj.TOT_DMD = rs1.getLong(1);
                } else {
                    obj.TOT_DMD = 0;
                }
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

    public Collection ejbGetMaterialeCorso_View(long lCOD_COR) {
        BMPConnection bmp = getConnection();
        try {
            // PreparedStatement ps=bmp.prepareStatement("SELECT ana_doc_tab.cod_doc, rsp_doc, dat_rev_doc, tit_doc, documents.name FROM ana_doc_tab LEFT OUTER JOIN documents ON (ana_doc_tab.cod_doc = documents.cod_doc AND documents.cod_azl = ana_doc_tab.cod_azl ), mat_cor_tab WHERE ana_doc_tab.cod_doc = mat_cor_tab.cod_doc AND mat_cor_tab.cod_cor = ?");
            PreparedStatement ps = bmp.prepareStatement(SQLContainer.getEjbGetMaterialeCorso_View());
            ps.setLong(1, lCOD_COR);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                MaterialeCorso_View obj = new MaterialeCorso_View();
                obj.COD_DOC = rs.getLong(1);
                obj.RSP_DOC = rs.getString(2);
                obj.DAT_REV_DOC = rs.getDate(3);
                obj.TIT_DOC = rs.getString(4);
                obj.NOME_FILE = rs.getString(5);
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
///=======Added  VIEW by Podmaster==========================================================

    public Collection ejbGetCorsoNome_VIEW(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT DISTINCT ana_cor_tab.cod_cor, ana_cor_tab.nom_cor FROM ana_cor_tab, sch_egz_cor_tab WHERE ana_cor_tab.cod_cor = sch_egz_cor_tab.cod_cor AND sch_egz_cor_tab.cod_azl = ?");
            ps.setLong(1, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CorsoNome_VIEW obj = new CorsoNome_VIEW();
                obj.COD_COR = rs.getLong(1);
                obj.NOM_COR = rs.getString(2);
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

    ///==================================================================================
    public void removeLUO_FSC_COR() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cor_luo_fsc_tab  WHERE cod_cor=? ");
            ps.setLong(1, lCOD_COR);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeGEST_MAN_COR() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cor_man_tab WHERE cod_cor=? ");
            ps.setLong(1, lCOD_COR);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_TES_VRF(long newCOD_TES_VRF) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO tes_vrf_cor_tab (cod_cor,cod_tes_vrf) VALUES(?,?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, newCOD_TES_VRF);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_TES_VRF(long newCOD_TES_VRF) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM tes_vrf_cor_tab  WHERE cod_cor=? AND cod_tes_vrf=?");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, newCOD_TES_VRF);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corsi con ID=" + lCOD_COR + " non e' trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO mat_cor_tab (cod_cor,cod_doc) VALUES(?,?)");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, newCOD_DOC);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM mat_cor_tab  WHERE cod_cor=? AND cod_doc=?");
            ps.setLong(1, lCOD_COR);
            ps.setLong(2, newCOD_DOC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Corsi con ID=" + lCOD_COR + " non e' trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//--------------------------------------------------------------

    public Collection ejbGetCorsi_All_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cor,dur_cor_gor,nom_cor,des_cor,cod_tpl_cor, uso_ate_fre_cor, uso_ptg_cor FROM ana_cor_tab ORDER BY nom_cor ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Corsi_All_View obj = new Corsi_All_View();
                obj.COD_COR = rs.getLong(1);
                obj.DUR_COR_COG = rs.getLong(2);
                obj.NOM_COR = rs.getString(3);
                obj.DES_COR = rs.getString(4);
                obj.COD_TPL_COR = rs.getLong(5);
                obj.USO_ATE_FRE_COR = rs.getString(6);
                obj.USO_PTG_COR = rs.getString(7);
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

//--- REPORTS ---
    public Collection getDocCorsoMateriali_List_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT b.cod_doc, b.tit_doc, b.dat_rev_doc "
                    + "FROM ana_doc_tab b, mat_cor_tab a "
                    + "WHERE (a.cod_cor=? AND b.cod_doc=a.cod_doc )");
            ps.setLong(1, this.lCOD_COR);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DOC_CorsoMateriali_View obj = new DOC_CorsoMateriali_View();
                obj.COD_DOC = rs.getLong(1);
                obj.TIT_DOC = rs.getString(2);
                obj.DAT_REV_DOC = rs.getDate(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-----------------------------------------------------------------

    public Collection getDocentiForCorso_List_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_dct_cor, nom_dct, dat_inz, dat_fie "
                    + "FROM dct_cor_tab WHERE cod_cor=? ");
            ps.setLong(1, this.lCOD_COR);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DocentiForCorso_List_View obj = new DocentiForCorso_List_View();
                obj.COD_DCT_COR = rs.getLong(1);
                obj.NOM_DCT = rs.getString(2);
                obj.DAT_INZ = rs.getDate(3);
                obj.DAT_FIE = rs.getDate(4);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //--------------------------------------------------------------------

    public Collection getErogazioneForCorso_List_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.cod_sch_egz_cor, "
                        + "a.dat_pif_egz_cor, "
                        + "a.dat_eft_egz_cor, "
                        + "C.COG_DPD, "
                        + "c.NOM_DPD, "
                        + "CASE a.sta_egz_cor "
                            + "WHEN 'P' THEN 'PIANIFICATA' "
                            + "WHEN 'I' THEN 'IN CORSO' "
                            + "WHEN 'C' THEN 'CONCLUSA' "
                            + "ELSE NULL "
                        + "END AS STATO_EROGAZIONE "
                    + "FROM "
                        + "sch_egz_cor_tab a, "
                        + "isc_cor_tab b, "
                        + "ana_dpd_tab c, "
                        + "ana_azl_tab d "
                    + "WHERE "
                        + "a.COD_SCH_EGZ_COR = b.COD_SCH_EGZ_COR "
                        + "AND a.COD_AZL = b.COD_AZL "
                        + "AND b.COD_DPD = c.COD_DPD "
                        + "AND b.COD_AZL = c.COD_AZL "
                        + "AND c.COD_AZL = d.COD_AZL "
                        + "AND a.COD_COR = ? "
                        + "AND d.COD_AZL = ? "
                    + "ORDER BY "
                        + "a.dat_pif_egz_cor desc, "
                        + "a.dat_eft_egz_cor desc, "
                        + "C.COG_DPD, "
                        + "c.NOM_DPD");
            ps.setLong(1, this.lCOD_COR);
            ps.setLong(2, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ErogazioneForCorso_List_View obj = new ErogazioneForCorso_List_View();
                obj.COD_SCH_EGZ_COR = rs.getLong(1);
                obj.DAT_PIF_EGZ_COR = rs.getDate(2);
                obj.DAT_EFT_EGZ_COR = rs.getDate(3);
                obj.COG_DPD = rs.getString(4);
                obj.NOM_DPD = rs.getString(5);
                obj.STA_EGZ_COR = rs.getString(6);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //--------------------------------------------------------------------

    public String getCorsoTipologia() {
        BMPConnection bmp = getConnection();
        String result = "";
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT nom_tpl_cor FROM tpl_cor_tab WHERE cod_tpl_cor = ? ");
            ps.setLong(1, this.lCOD_TPL_COR);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                result = rs.getString(1);
            }
            return result;
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//=====by Juli==========
    //--------------------------------
    public Collection findEx(Long lDUR_COR_GOR,
            String strNOM_COR,
            String strDES_COR,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(lDUR_COR_GOR, strNOM_COR, strDES_COR, iOrderParameter);
    }

    public Collection ejbFindEx(Long lDUR_COR_GOR,
            String strNOM_COR,
            String strDES_COR,
            int iOrderParameter /*not used for now*/) {
        String strSql = "";
        strSql = " SELECT cod_cor,nom_cor,uso_ate_fre_cor,uso_ptg_cor,dur_cor_gor,des_cor FROM ana_cor_tab WHERE ";

        if (lDUR_COR_GOR != null) {
            strSql += " dur_cor_gor = ? AND   ";
        }
        if (strNOM_COR != null) {
            strSql += " UPPER(nom_cor) LIKE ? AND   ";
        }
        if (strDES_COR != null) {
            strSql += " UPPER(des_cor) LIKE ? AND   ";
        }
        strSql = strSql.substring(1, strSql.length() - 6);

        strSql += " ORDER BY UPPER(nom_cor)";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (lDUR_COR_GOR != null) {
                ps.setLong(i++, lDUR_COR_GOR.longValue());
            }
            if (strNOM_COR != null) {
                ps.setString(i++, strNOM_COR.toUpperCase());
            }
            if (strDES_COR != null) {
                ps.setString(i++, strDES_COR.toUpperCase());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Corsi_All_View v = new Corsi_All_View();
                v.COD_COR = rs.getLong(1);
                v.NOM_COR = rs.getString(2);
                v.USO_ATE_FRE_COR = rs.getString(3);
                v.USO_PTG_COR = rs.getString(4);
                v.DUR_COR_COG = rs.getLong(5);
                v.DES_COR = rs.getString(6);
                ar.add(v);
            }
            return ar;
            //----------------------------------------------------------------------
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
}
