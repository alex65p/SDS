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
package com.apconsulting.luna.ejb.OpzioniUtilizzatore;

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
import s2s.utils.text.StringManager;

/**
 *
 * @author Dario
 */
public class OpzioniUtilizzatoreBean extends BMPEntityBean implements IOpzioniUtilizzatore, IOpzioniUtilizzatoreHome {

    long COD_USR;
    String OPZ_NOM;
    String OPZ_VAL;
    OpzioniUtilizzatorePK primaryKEY = null;

    public static final String BEAN_NAME = "OpzioniUtilizzatoreBean";
    private static OpzioniUtilizzatoreBean ys = null;

    private OpzioniUtilizzatoreBean() {
    }

    public static OpzioniUtilizzatoreBean getInstance() {
        if (ys == null) {
            ys = new OpzioniUtilizzatoreBean();
        }
        return ys;
    }

    public IOpzioniUtilizzatore create(long lCOD_USR, String strOPZ_NOM) throws CreateException {
        OpzioniUtilizzatoreBean bean = new OpzioniUtilizzatoreBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_USR, strOPZ_NOM);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_USR, strOPZ_NOM);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        OpzioniUtilizzatoreBean iOpzioniUtilizzatoreBean = new OpzioniUtilizzatoreBean();
        try {
            Object obj = iOpzioniUtilizzatoreBean.ejbFindByPrimaryKey((OpzioniUtilizzatorePK) primaryKey);
            iOpzioniUtilizzatoreBean.setEntityContext(new EntityContextWrapper(obj));
            iOpzioniUtilizzatoreBean.ejbActivate();
            iOpzioniUtilizzatoreBean.ejbLoad();
            iOpzioniUtilizzatoreBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public IOpzioniUtilizzatore findByPrimaryKey(OpzioniUtilizzatorePK primaryKey) throws FinderException {
        OpzioniUtilizzatoreBean bean = new OpzioniUtilizzatoreBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public OpzioniUtilizzatorePK ejbCreate(long lCOD_USR, String strOPZ_NOM) {
        this.COD_USR = lCOD_USR;
        this.OPZ_NOM = strOPZ_NOM;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO USR_OPZ_TAB (COD_USR, OPZ_NOM) VALUES (?,?)");
            ps.setLong(1, COD_USR);
            ps.setString(2, OPZ_NOM);
            ps.executeUpdate();
            return new OpzioniUtilizzatorePK(COD_USR, OPZ_NOM);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(long lCOD_USR, String strOPZ_NOM) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT COD_USR, OPZ_NOM FROM USR_OPZ_TAB ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new OpzioniUtilizzatorePK(rs.getLong(1), rs.getString(2)));
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public OpzioniUtilizzatorePK ejbFindByPrimaryKey(OpzioniUtilizzatorePK primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        primaryKEY = (OpzioniUtilizzatorePK) this.getEntityKey();
        this.COD_USR = primaryKEY.COD_USR;
        this.OPZ_NOM = primaryKEY.OPZ_NOM;
    }

    public void ejbPassivate() {
        primaryKEY = null;
        this.COD_USR = -1;
        this.OPZ_NOM = null;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM USR_OPZ_TAB WHERE COD_USR = ? AND OPZ_NOM = ?");
            ps.setLong(1, COD_USR);
            ps.setString(2, OPZ_NOM);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_USR = rs.getLong("COD_USR");
                this.OPZ_NOM = rs.getString("OPZ_NOM");
                this.OPZ_VAL = rs.getString("OPZ_VAL");
            } else {
                throw new NoSuchEntityException("OpzioniUtilizzatore non trovato.");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM USR_OPZ_TAB WHERE COD_USR = ? AND OPZ_NOM = ?");
            ps.setLong(1, COD_USR);
            ps.setString(2, OPZ_NOM);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("OpzioniUtilizzatore non trovato.");
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
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE USR_OPZ_TAB SET "
                    + "COD_USR = ?, OPZ_NOM = ?, OPZ_VAL = ? "
                    + "WHERE COD_USR = ? AND OPZ_NOM = ?");
            ps.setLong(1, COD_USR);
            ps.setString(2, OPZ_NOM);
            ps.setString(3, OPZ_VAL);
            ps.setLong(4, COD_USR);
            ps.setString(5, OPZ_NOM);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("OpzioniUtilizzatore non trovato.");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx(long lCOD_USR, String strOPZ_NOM, String strOPZ_VAL, int iOrderBy) {
        return ejbFindEx(lCOD_USR, strOPZ_NOM, strOPZ_VAL, iOrderBy);
    }

    public Collection ejbFindEx(long lCOD_USR, String strOPZ_NOM, String strOPZ_VAL, int iOrderBy) {
        String strSql = "SELECT COD_USR, OPZ_NOM, OPZ_VAL FROM USR_OPZ_TAB ";
        String whereClause = "";
        if (lCOD_USR > 0) {
            whereClause += "WHERE COD_USR = ?";
        }
        if (StringManager.isNotEmpty(strOPZ_NOM)) {
            whereClause += (StringManager.isEmpty(whereClause) ? "WHERE " : " AND ") + "UPPER(OPZ_NOM) LIKE ?";
        }
        if (StringManager.isNotEmpty(strOPZ_VAL)) {
            whereClause += (StringManager.isEmpty(whereClause) ? "WHERE " : " AND ") + "UPPER(OPZ_VAL) LIKE ?";
        }
        strSql += whereClause;
        strSql += " ORDER BY " + Math.abs(iOrderBy) + (iOrderBy > 0 ? " ASC" : "DESC");

        int index = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (lCOD_USR > 0) {
                ps.setLong(index++, lCOD_USR);
            }
            if (StringManager.isNotEmpty(strOPZ_NOM)) {
                ps.setString(index++, strOPZ_NOM.toUpperCase());
            }
            if (StringManager.isNotEmpty(strOPZ_VAL)) {
                ps.setString(index++, strOPZ_VAL.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList opzioniUtilizzatoreList = new java.util.ArrayList();
            while (rs.next()) {
                OpzioniUtilizzatore_View opzioniUtilizzatoreItem = new OpzioniUtilizzatore_View();
                opzioniUtilizzatoreItem.COD_USR = rs.getLong("COD_USR");
                opzioniUtilizzatoreItem.OPZ_NOM = rs.getString("OPZ_NOM");
                opzioniUtilizzatoreItem.OPZ_VAL = rs.getString("OPZ_VAL");
                opzioniUtilizzatoreList.add(opzioniUtilizzatoreItem);
            }
            return opzioniUtilizzatoreList;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public long getCOD_USR() {
        return COD_USR;
    }

    public void setCOD_USR(long lCOD_USR) {
        if (COD_USR == lCOD_USR) {
            return;
        }
        COD_USR = lCOD_USR;
        setModified();
    }

    public String getOPZ_NOM() {
        return OPZ_NOM;
    }

    public void setOPZ_NOM(String strOPZ_NOM) {
        if (OPZ_NOM.equals(strOPZ_NOM)) {
            return;
        }
        OPZ_NOM = strOPZ_NOM;
        setModified();
    }

    public String getOPZ_VAL() {
        return OPZ_VAL;
    }

    public void setOPZ_VAL(String strOPZ_VAL) {
        if (OPZ_VAL != null && OPZ_VAL.equals(strOPZ_VAL)) {
            return;
        }
        OPZ_VAL = strOPZ_VAL;
        setModified();
    }

}
