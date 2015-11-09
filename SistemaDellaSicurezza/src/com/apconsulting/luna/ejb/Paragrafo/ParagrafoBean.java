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
package com.apconsulting.luna.ejb.Paragrafo;

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
public class ParagrafoBean extends BMPEntityBean implements IParagrafo, IParagrafoHome {
    //<member-varibles description="Member Variables">

    long lCOD_PRG;
    String strNOM_PRG;
    String strDES_PRG;
    long lCOD_ARE;
    long lCOD_AZL;
    long lCOD_CPL;
    long lPRIORITY;
    //</member-varibles>

    //<IParagrafoHome-implementation>
    public static final String BEAN_NAME = "ParagrafoBean";

///////////////////// CONSTRUCTOR///////////////////
    private static ParagrafoBean ys = null;

    private ParagrafoBean() {
        //
    }

    public static ParagrafoBean getInstance() {
        if (ys == null) {
            ys = new ParagrafoBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        ParagrafoBean bean = new ParagrafoBean();
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

    public IParagrafo create(String strNOM_PRG, long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) throws javax.ejb.CreateException {
        ParagrafoBean bean = new ParagrafoBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_PRG, lCOD_ARE, lCOD_AZL, lCOD_CPL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_PRG, lCOD_ARE, lCOD_AZL, lCOD_CPL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IParagrafo findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        ParagrafoBean bean = new ParagrafoBean();
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
    // View

    public Collection getParagrafiNome_byAreCpl_View(long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        return (new ParagrafoBean()).ejbGetParagrafiNome_byAreCpl_View(lCOD_ARE, lCOD_AZL, lCOD_CPL);
    }

    public Collection getParagrafoDocumentiByID_View(long lCOD_PRG) {
        return (new ParagrafoBean()).ejbGetParagrafoDocumentiByID_View(lCOD_PRG);
    }

    //<report>
    public Collection getReportParagrafi_byAreCpl_View(long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        return this.ejbGetReportParagrafi_byAreCpl_View(lCOD_ARE, lCOD_AZL, lCOD_CPL);
    }
    //</report>

    public Collection getParagrafo_View() {
        return (new ParagrafoBean()).ejbGetParagrafo_View();
    }

    public Long ejbCreate(String strNOM_PRG, long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        this.lCOD_PRG = NEW_ID();
        this.strNOM_PRG = strNOM_PRG;
        this.lCOD_ARE = lCOD_ARE;
        this.lCOD_AZL = lCOD_AZL;
        this.lCOD_CPL = lCOD_CPL;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_prg_tab (cod_prg,nom_prg,cod_are,cod_azl,cod_cpl) VALUES(?,?,?,?,?)");
            ps.setLong(1, lCOD_PRG);
            ps.setString(2, strNOM_PRG);
            ps.setLong(3, lCOD_ARE);
            ps.setLong(4, lCOD_AZL);
            ps.setLong(5, lCOD_CPL);
            ps.executeUpdate();
            return new Long(lCOD_PRG);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strNOM_PRG, long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_prg FROM ana_prg_tab");
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
        this.lCOD_PRG = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_PRG = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_prg,nom_prg,des_prg,cod_are,cod_azl,cod_cpl, priority FROM ana_prg_tab WHERE cod_prg=?");
            ps.setLong(1, lCOD_PRG);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_PRG = rs.getLong(1);
                strNOM_PRG = rs.getString(2);
                strDES_PRG = rs.getString(3);
                lCOD_ARE = rs.getLong(4);
                lCOD_AZL = rs.getLong(5);
                lCOD_CPL = rs.getLong(6);
                lPRIORITY = rs.getLong(7);
            } else {
                throw new NoSuchEntityException("Paragrafo with ID=" + lCOD_PRG + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_prg_tab WHERE cod_prg=?");
            ps.setLong(1, lCOD_PRG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Paragrafo with ID=" + lCOD_PRG + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_prg_tab SET cod_prg=?, nom_prg=?, des_prg=?, cod_are=?, cod_azl=?, cod_cpl=?, priority=? WHERE cod_prg=?");
            ps.setLong(1, lCOD_PRG);
            ps.setString(2, strNOM_PRG);
            ps.setString(3, strDES_PRG);
            ps.setLong(4, lCOD_ARE);
            ps.setLong(5, lCOD_AZL);
            ps.setLong(6, lCOD_CPL);
            ps.setLong(7, lPRIORITY);
            ps.setLong(8, lCOD_PRG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Paragrafo with ID=" + lCOD_PRG + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //<setter-getters>
    public long getCOD_PRG() {
        return lCOD_PRG;
    }

    public String getNOM_PRG() {
        return strNOM_PRG;
    }

    public void setNOM_PRG(String strNOM_PRG) {
        if ((this.strNOM_PRG != null) && (this.strNOM_PRG.equals(strNOM_PRG))) {
            return;
        }
        this.strNOM_PRG = strNOM_PRG;
        setModified();
    }

    public String getDES_PRG() {
        return strDES_PRG;
    }

    public void setDES_PRG(String strDES_PRG) {
        if ((this.strDES_PRG != null) && (this.strDES_PRG.equals(strDES_PRG))) {
            return;
        }
        this.strDES_PRG = strDES_PRG;
        setModified();
    }

    public long getCOD_ARE() {
        return lCOD_ARE;
    }

    public void setCOD_ARE(long lCOD_ARE) {
        if (this.lCOD_ARE == lCOD_ARE) {
            return;
        }
        this.lCOD_ARE = lCOD_ARE;
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

    public long getCOD_CPL() {
        return lCOD_CPL;
    }

    public void setCOD_CPL(long lCOD_CPL) {
        if (this.lCOD_CPL == lCOD_CPL) {
            return;
        }
        this.lCOD_CPL = lCOD_CPL;
        setModified();
    }

    public long getPRIORITY() {
        return lPRIORITY;
    }

    public void setPRIORITY(long lPRIORITY) {
        if ((this.lPRIORITY == lPRIORITY)) {
            return;
        }
        this.lPRIORITY = lPRIORITY;
        setModified();
    }


    //</setter-getters>
    //-----------------------------#############################################
    // %%%Link%%% Table DOC_ANA_PRG_TAB
    public void addCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO doc_ana_prg_tab (cod_doc,cod_prg) VALUES(?,?)");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_PRG);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    // %%%UNLink%%% Table DOC_ANA_PRG_TAB

    public void removeCOD_DOC(long newCOD_DOC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM doc_ana_prg_tab  WHERE cod_doc=? AND cod_prg=?");
            ps.setLong(1, newCOD_DOC);
            ps.setLong(2, lCOD_PRG);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Sezioni con ID=" + newCOD_DOC + " non &egrave trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //-----------------------------#############################################

    public Collection ejbGetParagrafoDocumentiByID_View(long lCOD_PRG) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "ana_doc_tab.cod_doc, "
                        + "tit_doc, "
                        + "rsp_doc, "
                        + "dat_rev_doc "
                    + "FROM "
                        + "ana_doc_tab, "
                        + "doc_ana_prg_tab "
                    + "WHERE "
                        + "ana_doc_tab.cod_doc = doc_ana_prg_tab.cod_doc "
                        + "AND doc_ana_prg_tab.cod_prg=? "
                    + "order by "
                        + "tit_doc");
            ps.setLong(1, lCOD_PRG);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ParagrafoDocumentiByID_View obj = new ParagrafoDocumentiByID_View();
                obj.COD_PRG = lCOD_PRG;
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

    public Collection ejbGetParagrafiNome_byAreCpl_View(long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_prg, nom_prg FROM ana_prg_tab WHERE cod_are=? AND cod_azl=? AND cod_cpl=? ORDER BY priority ");
            ps.setLong(1, lCOD_ARE);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_CPL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ParagrafiNome_byAreCpl_View obj = new ParagrafiNome_byAreCpl_View();
                obj.COD_PRG = rs.getLong(1);
                obj.NOM_PRG = rs.getString(2);
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
    public Collection ejbGetReportParagrafi_byAreCpl_View(long lCOD_ARE, long lCOD_AZL, long lCOD_CPL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_prg, "
                        + "nom_prg, "
                        + "des_prg "
                    + "FROM "
                        + "ana_prg_tab "
                    + "WHERE "
                        + "cod_are=? "
                        + "AND cod_azl=? "
                        + "AND cod_cpl=? "
                    + "ORDER BY "
                        + "priority ");
            ps.setLong(1, lCOD_ARE);
            ps.setLong(2, lCOD_AZL);
            ps.setLong(3, lCOD_CPL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ReportParagrafi_byAreCpl_View obj = new ReportParagrafi_byAreCpl_View();
                obj.COD_PRG = rs.getLong(1);
                obj.NOM_PRG = rs.getString(2);
                obj.DES_PRG = rs.getString(3);
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

    public Collection ejbGetParagrafo_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_prg, nom_prg, des_prg FROM ana_prg_tab ORDER BY nom_prg ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Paragrafo_View obj = new Paragrafo_View();
                obj.COD_PRG = rs.getLong(1);
                obj.NOM_PRG = rs.getString(2);
                obj.DES_PRG = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx(long lCOD_AZL,
            String strNOM_PRG,
            String strDES_PRG,
            Long lCOD_CPL,
            Long lCOD_ARE,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(lCOD_AZL, strNOM_PRG, strDES_PRG, lCOD_CPL, lCOD_ARE, iOrderParameter);
    }

    public Collection ejbFindEx(long lCOD_AZL,
            String strNOM_PRG,
            String strDES_PRG,
            Long lCOD_CPL,
            Long lCOD_ARE,
            int iOrderParameter /*not used for now*/) {
        String strSql = "SELECT  cod_prg,nom_prg,des_prg,cod_cpl,cod_are FROM ana_prg_tab WHERE cod_azl = ? ";

        if (strNOM_PRG != null && strDES_PRG == null) {
            strSql += " AND UPPER(nom_prg) LIKE ? ";
        }
        if (strNOM_PRG != null && strDES_PRG != null) {
            strSql += " AND UPPER(nom_prg) LIKE ?";
            strSql += " AND UPPER(des_prg) LIKE ?";
        }
        if (strNOM_PRG == null && strDES_PRG != null) {
            strSql += " AND UPPER(des_prg) LIKE ?";
        }
        if (lCOD_ARE != null) {
            strSql += " AND cod_are=? ";
        }
        if (lCOD_CPL != null) {
            strSql += " AND cod_cpl=? ";
        }
        if (iOrderParameter == 0) {
            strSql += " ORDER BY UPPER(nom_prg) ";
        } else {
            strSql += " ORDER BY UPPER(nom_prg) " + (iOrderParameter > 0 ? " ASC" : "DESC");
        }
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, lCOD_AZL);

            if (strNOM_PRG != null && strDES_PRG == null) {
                ps.setString(i++, strNOM_PRG.toUpperCase());
            }
            if (strNOM_PRG != null && strDES_PRG != null) {
                ps.setString(i++, strNOM_PRG.toUpperCase());
                ps.setString(i++, strDES_PRG.toUpperCase());
            }
            if (strNOM_PRG == null && strDES_PRG != null) {
                ps.setString(i++, strDES_PRG.toUpperCase());
            }
            if (lCOD_ARE != null) {
                ps.setLong(i++, lCOD_ARE.longValue());
            }
            if (lCOD_CPL != null) {
                ps.setLong(i++, lCOD_CPL.longValue());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Paragrafo_View v = new Paragrafo_View();
                v.COD_PRG = rs.getLong(1);
                v.NOM_PRG = rs.getString(2);
                v.DES_PRG = rs.getString(3);
                ar.add(v);
            }
            return ar;
        //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
}

