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
package com.apconsulting.luna.ejb.TipologiaContratti;

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
public class TipologiaContrattiBean extends BMPEntityBean implements ITipologiaContratti, ITipologiaContrattiHome {
    //----------------------------

    long COD_TPL_CON;          //1
    String NOM_TPL_CON;        //2
    //----------------------------
    String DES_TPL_CON;        //3
    //< ITipologiaContrattiHome-implementation>
    public static final String BEAN_NAME = "TipologiaContrattiBean";
    private static TipologiaContrattiBean ys = null;

    private TipologiaContrattiBean() {
    }

    public static TipologiaContrattiBean getInstance() {
        if (ys == null) {
            ys = new TipologiaContrattiBean();
        }
        return ys;
    }

    // (Home Interface) create()
    public ITipologiaContratti create(String strNOM_TPL_CON) throws CreateException {
        TipologiaContrattiBean bean = new TipologiaContrattiBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_TPL_CON);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_TPL_CON);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        TipologiaContrattiBean iTipologiaContrattiBean = new TipologiaContrattiBean();
        try {
            Object obj = iTipologiaContrattiBean.ejbFindByPrimaryKey((Long) primaryKey);
            iTipologiaContrattiBean.setEntityContext(new EntityContextWrapper(obj));
            iTipologiaContrattiBean.ejbActivate();
            iTipologiaContrattiBean.ejbLoad();
            iTipologiaContrattiBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Interface) findByPrimaryKey()

    public ITipologiaContratti findByPrimaryKey(Long primaryKey) throws FinderException {
        TipologiaContrattiBean bean = new TipologiaContrattiBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    //-----------------------------------------------------------
    public Collection getComboView() {
        return (new TipologiaContrattiBean()).ejbGetComboView();
    }
    // (Home Intrface) findAll()

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection getTipologiaByDescription_View(String strDecription) {
        return (new TipologiaContrattiBean()).ejbGetTipologiaByDescription_View(strDecription);
    }

    public Collection getTipologia_View() {
        return (new TipologiaContrattiBean()).ejbGetTipologia_View();
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</ITipologiaContrattiHome-implementation>
    public Long ejbCreate(String strNOM_TPL_CON) {
        this.NOM_TPL_CON = strNOM_TPL_CON;
        this.COD_TPL_CON = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO TPL_CON_tab (cod_TPL_CON,nom_TPL_CON) VALUES(?,?)");
            ps.setLong(1, COD_TPL_CON);
            ps.setString(2, NOM_TPL_CON);
            ps.executeUpdate();
            return new Long(COD_TPL_CON);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------

    public void ejbPostCreate(String strNOM_TPL_CON) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_TPL_CON FROM TPL_CON_tab ");
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
        this.COD_TPL_CON = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_TPL_CON = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM TPL_CON_tab  WHERE cod_TPL_CON=?");
            ps.setLong(1, COD_TPL_CON);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_TPL_CON = rs.getLong("COD_TPL_CON");
                this.NOM_TPL_CON = rs.getString("NOM_TPL_CON");
                this.DES_TPL_CON = rs.getString("DES_TPL_CON");
            } else {
                throw new NoSuchEntityException("TipologiaContratti con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM TPL_CON_tab  WHERE cod_TPL_CON=?");
            ps.setLong(1, COD_TPL_CON);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("TipologiaContratti con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE TPL_CON_tab  SET cod_TPL_CON=?, nom_TPL_CON=?, des_TPL_CON=?	 WHERE cod_TPL_CON=?");
            ps.setLong(1, COD_TPL_CON);
            ps.setString(2, NOM_TPL_CON);
            ps.setString(3, DES_TPL_CON);
            ps.setLong(4, COD_TPL_CON);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("TipologiaContratti con ID= non è trovata");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

    public Collection ejbGetComboView() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_TPL_CON, nom_TPL_CON, des_TPL_CON FROM TPL_CON_tab ORDER BY nom_TPL_CON");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                TipologiaContratti_View w = new TipologiaContratti_View();
                w.lCOD_TPL_CON = rs.getLong("COD_TPL_CON");
                w.strNOM_TPL_CON = rs.getString("NOM_TPL_CON");
                w.strDES_TPL_CON = rs.getString("DES_TPL_CON");
                ar.add(w);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //<search>

    public Collection findEx(String NOM_TPL_CON, String DES_TPL_CON, int iOrderBy) {
        return ejbFindEx(NOM_TPL_CON, DES_TPL_CON, iOrderBy);
    }

    public Collection ejbFindEx(String NOM_TPL_CON, String DES_TPL_CON, int iOrderBy) {
        String strSql = "SELECT cod_TPL_CON, nom_TPL_CON, des_TPL_CON FROM TPL_CON_tab ";
        if (NOM_TPL_CON != null) {
            strSql += " WHERE UPPER(NOM_TPL_CON) LIKE ?";
        }
        if (DES_TPL_CON != null) {
            if (NOM_TPL_CON != null) {
                strSql += " AND ";
            } else {
                strSql += " WHERE ";
            }
            strSql += " UPPER(DES_TPL_CON) LIKE ?";
        }

        strSql += " ORDER BY " + Math.abs(iOrderBy) + (iOrderBy > 0 ? " ASC" : "DESC");
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);

            if (NOM_TPL_CON != null) {
                ps.setString(i++, NOM_TPL_CON.toUpperCase());
            }
            if (DES_TPL_CON != null) {
                ps.setString(i++, DES_TPL_CON.toUpperCase());
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                TipologiaContratti_View w = new TipologiaContratti_View();
                w.lCOD_TPL_CON = rs.getLong("COD_TPL_CON");
                w.strNOM_TPL_CON = rs.getString("NOM_TPL_CON");
                w.strDES_TPL_CON = rs.getString("DES_TPL_CON");
                ar.add(w);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //</search>

//-------------------------------------------------------------
/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>
//<comment description="setter/getters">
    //1
    public long getCOD_TPL_CON() {
        return COD_TPL_CON;
    }
    //2

    public void setNOM_TPL_CON(String newNOM_TPL_CON) {
        if (NOM_TPL_CON.equals(newNOM_TPL_CON)) {
            return;
        }
        NOM_TPL_CON = newNOM_TPL_CON;
        setModified();
    }

    public String getNOM_TPL_CON() {
        return NOM_TPL_CON;
    }
    //============================================
    // not required field
    //3

    public void setDES_TPL_CON(String newDES_TPL_CON) {
        if (DES_TPL_CON != null) {
            if (DES_TPL_CON.equals(newDES_TPL_CON)) {
                return;
            }
        }
        DES_TPL_CON = newDES_TPL_CON;
        setModified();
    }

    public String getDES_TPL_CON() {
        if (DES_TPL_CON == null) {
            return "";
        }
        return DES_TPL_CON;
    }
    //4

    //</comment>

    public Collection ejbGetTipologiaByDescription_View(String strDecription) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_tpl_con, des_tpl_con  from tpl_con_tab where des_tpl_con like ? order by  des_tpl_con ");
            ps.setString(1, strDecription);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                TipologiaContratti_View obj = new TipologiaContratti_View();
                obj.lCOD_TPL_CON = rs.getLong(1);
                obj.strDES_TPL_CON = rs.getString(2);
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

    public Collection ejbGetTipologia_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select cod_tpl_con, nom_tpl_con, des_tpl_con from tpl_con_tab  order by  nom_tpl_con ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                TipologiaContratti_View obj = new TipologiaContratti_View();
                obj.lCOD_TPL_CON = rs.getLong(1);
                obj.strNOM_TPL_CON = rs.getString(2);
                obj.strDES_TPL_CON = rs.getString(3);
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
}
