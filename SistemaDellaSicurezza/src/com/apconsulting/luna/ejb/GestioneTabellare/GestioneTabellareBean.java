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
package com.apconsulting.luna.ejb.GestioneTabellare;

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
public class GestioneTabellareBean extends BMPEntityBean implements IGestioneTabellare, IGestioneTabellareHome {
    //< member-varibles description="Member Variables">

    long lCOD_TAB_UTN;
    String strTIT_TAB;
    long lNUM_CLN;
    long lCOD_PRG;
    String strNOM_TIT_1;
    String strNOM_TIT_2;
    String strNOM_TIT_3;
    String strNOM_TIT_4;
    String strNOM_TIT_5;
    //< /member-varibles>

    //< IGestioneTabellareHome-implementation>
    public static final String BEAN_NAME = "GestioneTabellareBean";

////////////////////// CONSTRUCTOR///////////////////
    private static GestioneTabellareBean ys = null;

    private GestioneTabellareBean() {
        //
    }

    public static GestioneTabellareBean getInstance() {
        if (ys == null) {
            ys = new GestioneTabellareBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        GestioneTabellareBean bean = new GestioneTabellareBean();
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

    public IGestioneTabellare create(long lNUM_CLN, long lCOD_PRG) throws javax.ejb.CreateException {
        GestioneTabellareBean bean = new GestioneTabellareBean();
        try {
            Object primaryKey = bean.ejbCreate(lNUM_CLN, lCOD_PRG);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lNUM_CLN, lCOD_PRG);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IGestioneTabellare findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        GestioneTabellareBean bean = new GestioneTabellareBean();
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
    // (Home Intrface) VIEWS

    public Collection getGestioneTabellare_View(long lCOD_PRG) {
        return (new GestioneTabellareBean()).ejbGetGestioneTabellare_View(lCOD_PRG);
    }

    public Collection getGestioneTabellare_ViewbyAZL(long lCOD_AZL) {
        return (new GestioneTabellareBean()).ejbGetGestioneTabellare_View(lCOD_AZL);
    }

    public Collection getCLN_View(long lCOD_TAB_UTN) {
        return (new GestioneTabellareBean()).ejbCLN_View(lCOD_TAB_UTN);
    }

    public Long ejbCreate(long lNUM_CLN, long lCOD_PRG) {
        this.lCOD_TAB_UTN = NEW_ID();
        this.lNUM_CLN = lNUM_CLN;
        this.lCOD_PRG = lCOD_PRG;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_tab_utn_tab (cod_tab_utn,num_cln,cod_prg) VALUES(?,?,?)");
            ps.setLong(1, lCOD_TAB_UTN);
            ps.setLong(2, lNUM_CLN);
            ps.setLong(3, lCOD_PRG);
            ps.executeUpdate();
            return new Long(lCOD_TAB_UTN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lNUM_CLN, long lCOD_PRG) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_tab_utn FROM ana_tab_utn_tab");
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
        this.lCOD_TAB_UTN = ((Long) this.getEntityKey()).longValue();
    }
    ;

    public void ejbPassivate() {
        this.lCOD_TAB_UTN = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_tab_utn,tit_tab,num_cln,cod_prg,nom_tit_1,nom_tit_2,nom_tit_3,nom_tit_4,nom_tit_5 FROM ana_tab_utn_tab WHERE cod_tab_utn=?");
            ps.setLong(1, lCOD_TAB_UTN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_TAB_UTN = rs.getLong(1);
                strTIT_TAB = rs.getString(2);
                lNUM_CLN = rs.getLong(3);
                lCOD_PRG = rs.getLong(4);
                strNOM_TIT_1 = rs.getString(5);
                strNOM_TIT_2 = rs.getString(6);
                strNOM_TIT_3 = rs.getString(7);
                strNOM_TIT_4 = rs.getString(8);
                strNOM_TIT_5 = rs.getString(9);
            } else {
                throw new NoSuchEntityException("GestioneTabellare with ID=" + lCOD_TAB_UTN + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_tab_utn_tab WHERE cod_tab_utn=?");
            ps.setLong(1, lCOD_TAB_UTN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("GestioneTabellare with ID=" + lCOD_TAB_UTN + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_tab_utn_tab SET cod_tab_utn=?, tit_tab=?, num_cln=?, cod_prg=?, nom_tit_1=?, nom_tit_2=?, nom_tit_3=?, nom_tit_4=?, nom_tit_5=? WHERE cod_tab_utn=?");
            ps.setLong(1, lCOD_TAB_UTN);
            ps.setString(2, strTIT_TAB);
            ps.setLong(3, lNUM_CLN);
            ps.setLong(4, lCOD_PRG);
            ps.setString(5, strNOM_TIT_1);
            ps.setString(6, strNOM_TIT_2);
            ps.setString(7, strNOM_TIT_3);
            ps.setString(8, strNOM_TIT_4);
            ps.setString(9, strNOM_TIT_5);
            ps.setLong(10, lCOD_TAB_UTN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("GestioneTabellare with ID=" + lCOD_TAB_UTN + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }


    //< setter-getters>
    public long getCOD_TAB_UTN() {
        return lCOD_TAB_UTN;
    }

    public String getTIT_TAB() {
        return strTIT_TAB;
    }

    public void setTIT_TAB(String strTIT_TAB) {
        if ((this.strTIT_TAB != null) && (this.strTIT_TAB.equals(strTIT_TAB))) {
            return;
        }
        this.strTIT_TAB = strTIT_TAB;
        setModified();
    }

    public long getNUM_CLN() {
        return lNUM_CLN;
    }

    public void setNUM_CLN(long lNUM_CLN) {
        if (this.lNUM_CLN == lNUM_CLN) {
            return;
        }
        this.lNUM_CLN = lNUM_CLN;
        setModified();
    }

    public long getCOD_PRG() {
        return lCOD_PRG;
    }

    public void setCOD_PRG(long lCOD_PRG) {
        if (this.lCOD_PRG == lCOD_PRG) {
            return;
        }
        this.lCOD_PRG = lCOD_PRG;
        setModified();
    }

    public String getNOM_TIT_1() {
        return strNOM_TIT_1;
    }

    public void setNOM_TIT_1(String strNOM_TIT_1) {
        if ((this.strNOM_TIT_1 != null) && (this.strNOM_TIT_1.equals(strNOM_TIT_1))) {
            return;
        }
        this.strNOM_TIT_1 = strNOM_TIT_1;
        setModified();
    }

    public String getNOM_TIT_2() {
        return strNOM_TIT_2;
    }

    public void setNOM_TIT_2(String strNOM_TIT_2) {
        if ((this.strNOM_TIT_2 != null) && (this.strNOM_TIT_2.equals(strNOM_TIT_2))) {
            return;
        }
        this.strNOM_TIT_2 = strNOM_TIT_2;
        setModified();
    }

    public String getNOM_TIT_3() {
        return strNOM_TIT_3;
    }

    public void setNOM_TIT_3(String strNOM_TIT_3) {
        if ((this.strNOM_TIT_3 != null) && (this.strNOM_TIT_3.equals(strNOM_TIT_3))) {
            return;
        }
        this.strNOM_TIT_3 = strNOM_TIT_3;
        setModified();
    }

    public String getNOM_TIT_4() {
        return strNOM_TIT_4;
    }

    public void setNOM_TIT_4(String strNOM_TIT_4) {
        if ((this.strNOM_TIT_4 != null) && (this.strNOM_TIT_4.equals(strNOM_TIT_4))) {
            return;
        }
        this.strNOM_TIT_4 = strNOM_TIT_4;
        setModified();
    }

    public String getNOM_TIT_5() {
        return strNOM_TIT_5;
    }

    public void setNOM_TIT_5(String strNOM_TIT_5) {
        if ((this.strNOM_TIT_5 != null) && (this.strNOM_TIT_5.equals(strNOM_TIT_5))) {
            return;
        }
        this.strNOM_TIT_5 = strNOM_TIT_5;
        setModified();
    }

    public void delCLN(long lCOD_TAB_UTN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_rec_tab WHERE cod_tab_utn=?");
            ps.setLong(1, lCOD_TAB_UTN);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void setCLN(String[] arr, long lCOD_REC) {
        BMPConnection bmp = getConnection();
        try {
            lCOD_REC = NEW_ID();
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_rec_tab  (cod_rec,cod_tab_utn,nom_cln_1,nom_cln_2,nom_cln_3,nom_cln_4,nom_cln_5) VALUES(?,?,?,?,?,?,?)");
            ps.setLong(1, lCOD_REC);
            ps.setLong(2, lCOD_TAB_UTN);
            ps.setString(3, arr[0]);
            ps.setString(4, arr[1]);
            ps.setString(5, arr[2]);
            ps.setString(6, arr[3]);
            ps.setString(7, arr[4]);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //< /setter-getters>
    public Collection ejbGetGestioneTabellare_ViewbyAZL(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        String strCOD_PRG = Long.toString(lCOD_PRG);
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT *  FROM ana_tab_utn_tab WHERE cod_azl=?");
            ps.setLong(1, lCOD_PRG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioneTabellare_View obj = new GestioneTabellare_View();
                obj.COD_TAB_UTN = rs.getLong(1);
                obj.TIT_TAB = rs.getString(2);
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

    public Collection ejbGetGestioneTabellare_View(long lCOD_PRG) {
        BMPConnection bmp = getConnection();
        String strCOD_PRG = Long.toString(lCOD_PRG);
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "* "
                    + "FROM "
                        + "ana_tab_utn_tab "
                    + "WHERE "
                        + "cod_prg=? "
                    + "order by "
                        + "TIT_TAB");
            ps.setString(1, strCOD_PRG);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                GestioneTabellare_View obj = new GestioneTabellare_View();
                obj.COD_TAB_UTN = rs.getLong(1);
                obj.TIT_TAB = rs.getString(2);
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

    public Collection ejbCLN_View(long lCOD_TAB_UTN) {
        BMPConnection bmp = getConnection();
        String strCOD_TAB_UTN = Long.toString(lCOD_TAB_UTN);
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT *  FROM ana_rec_tab WHERE cod_tab_utn=?");
            ps.setString(1, strCOD_TAB_UTN);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CLN_View obj = new CLN_View();
                obj.COD_REC = rs.getLong(2);
                obj.NOM_CLN_1 = rs.getString(3);
                obj.NOM_CLN_2 = rs.getString(4);
                obj.NOM_CLN_3 = rs.getString(5);
                obj.NOM_CLN_4 = rs.getString(6);
                obj.NOM_CLN_5 = rs.getString(7);
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
