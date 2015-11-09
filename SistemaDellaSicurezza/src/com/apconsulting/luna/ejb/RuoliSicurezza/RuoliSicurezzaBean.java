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
package com.apconsulting.luna.ejb.RuoliSicurezza;

import java.rmi.RemoteException;
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
public class RuoliSicurezzaBean
        extends BMPEntityBean implements IRuoliSicurezza, IRuoliSicurezzaHome {

    long COD_RUO_SIC;
    String NOM_RUO_SIC;
    String DES_RUO_SIC;
////////////////////// CONSTRUCTOR///////////////////
    private static RuoliSicurezzaBean ys = null;

    private RuoliSicurezzaBean() {
    }

    public static RuoliSicurezzaBean getInstance() {
        if (ys == null) {
            ys = new RuoliSicurezzaBean();
        }
        return ys;
    }

    // (Home Intrface) create()
    public IRuoliSicurezza create(String strNOM_RUO_SIC)
            throws RemoteException, CreateException {
        RuoliSicurezzaBean bean = new RuoliSicurezzaBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_RUO_SIC);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_RUO_SIC);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        RuoliSicurezzaBean iRuoliSicurezzaBean = new RuoliSicurezzaBean();
        try {
            Object obj =
                    iRuoliSicurezzaBean.ejbFindByPrimaryKey((Long) primaryKey);
            iRuoliSicurezzaBean.setEntityContext(new EntityContextWrapper(obj));
            iRuoliSicurezzaBean.ejbActivate();
            iRuoliSicurezzaBean.ejbLoad();
            iRuoliSicurezzaBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IRuoliSicurezza findByPrimaryKey(Long primaryKey)
            throws RemoteException, FinderException {
        RuoliSicurezzaBean bean = new RuoliSicurezzaBean();
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
    public Collection findAll() throws RemoteException, FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    // (Home Intrface) VIEWS  getRuoliSicurezza_Name_View()
    public Collection getRuoliSicurezza_View() {
        return (new RuoliSicurezzaBean()).ejbGetRuoliSicurezza_View();
    }

    public Collection findEx(String NOM, String DES, long iOrderBy) {
        return (new RuoliSicurezzaBean()).ejbfindEx(NOM, DES, iOrderBy);
    }

    //</IAziendaHome-implementation>
    public Long ejbCreate(String strNOM_RUO_SIC) {
        this.COD_RUO_SIC = NEW_ID();
        this.NOM_RUO_SIC = strNOM_RUO_SIC;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO " +
                        "ANA_RUO_SIC_TAB (COD_RUO_SIC, NOM_RUO_SIC) " +
                    "VALUES " +
                        "(?,?)");
            ps.setLong(1, COD_RUO_SIC);
            ps.setString(2, NOM_RUO_SIC);
            ps.executeUpdate();
            return new Long(COD_RUO_SIC);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strNOM_RUO_SIC) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT COD_RUO_SIC FROM ANA_RUO_SIC_TAB ");
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
        this.COD_RUO_SIC = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.COD_RUO_SIC = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "COD_RUO_SIC, NOM_RUO_SIC, DES_RUO_SIC " +
                    "FROM " +
                        "ANA_RUO_SIC_TAB " +
                    "WHERE " +
                        "COD_RUO_SIC=?");
            ps.setLong(1, COD_RUO_SIC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_RUO_SIC = rs.getLong("COD_RUO_SIC");
                this.NOM_RUO_SIC = rs.getString("NOM_RUO_SIC");
                this.DES_RUO_SIC = rs.getString("DES_RUO_SIC");
            } else {
                throw new NoSuchEntityException
                        ("Ruolo per la sicurezza con ID= non trovato");
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
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM ANA_RUO_SIC_TAB  WHERE COD_RUO_SIC=?");
            ps.setLong(1, COD_RUO_SIC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException
                        ("Ruolo per la sicurezza con ID= non trovato");
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
                    "UPDATE " +
                        "ANA_RUO_SIC_TAB " +
                    "SET " +
                        "COD_RUO_SIC=?, " +
                        "NOM_RUO_SIC=?, " +
                        "DES_RUO_SIC=? " +
                    "WHERE " +
                        "COD_RUO_SIC=?");
            ps.setLong(1, COD_RUO_SIC);
            ps.setString(2, NOM_RUO_SIC);
            ps.setString(3, DES_RUO_SIC);
            ps.setLong(4, COD_RUO_SIC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException
                        ("Ruolo per la sicurezza con ID= non trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void Update() {
        setModified();
    }

    public long getCOD_RUO_SIC() {
        return COD_RUO_SIC;
    }

    public String getNOM_RUO_SIC() {
        return NOM_RUO_SIC;
    }

    public void setNOM_RUO_SIC(String newNOM_RUO_SIC) {
        if (NOM_RUO_SIC.equals(newNOM_RUO_SIC)) {
            return;
        }
        NOM_RUO_SIC = newNOM_RUO_SIC;
        setModified();
    }

    public String getDES_RUO_SIC() {
        if (DES_RUO_SIC == null) {
            return "";
        }
        return DES_RUO_SIC;
    }

    public void setDES_RUO_SIC(String newDES_RUO_SIC) {
        if (DES_RUO_SIC != null) {
            if (DES_RUO_SIC.equals(newDES_RUO_SIC)) {
                return;
            }
        }
        DES_RUO_SIC = newDES_RUO_SIC;
        setModified();
    }

    public Collection ejbGetRuoliSicurezza_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "COD_RUO_SIC, NOM_RUO_SIC, DES_RUO_SIC " +
                    "FROM " +
                    "ANA_RUO_SIC_TAB " +
                    "ORDER BY " +
                    "NOM_RUO_SIC");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RuoliSicurezza_View obj = new RuoliSicurezza_View();
                obj.COD_RUO_SIC = rs.getLong(1);
                obj.NOM_RUO_SIC = rs.getString(2);
                obj.DES_RUO_SIC = rs.getString(3);
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

    public Collection ejbfindEx
            (String NOM_RUO_SIC, String DES_RUO_SIC, long iOrderBy) {
        String Sql =
                "SELECT " +
                    "COD_RUO_SIC, NOM_RUO_SIC, DES_RUO_SIC " +
                "FROM " +
                    "ANA_RUO_SIC_TAB ";
        int i = 1;
        int desIndex = 0;
        int nomIndex = 0;
        if (!"".equals(NOM_RUO_SIC)) {
            Sql += " WHERE ";
            Sql += " UPPER(NOM_RUO_SIC) LIKE ? ";
            nomIndex = i++;
        }
        if (!"".equals(DES_RUO_SIC)) {
            if (nomIndex != 0) {
                Sql += " AND ";
            } else {
                Sql += " WHERE ";
            }
            Sql += " UPPER(DES_RUO_SIC) LIKE ? ";
            desIndex = i++;
        }
        Sql += " ORDER BY NOM_RUO_SIC ";    //+ (iOrderBy>0?" ASC": "DESC");
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (nomIndex != 0) {
                ps.setString(nomIndex, (NOM_RUO_SIC + "%").toUpperCase());
            }
            if (desIndex != 0) {
                ps.setString(desIndex, (DES_RUO_SIC + "%").toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RuoliSicurezza_View obj = new RuoliSicurezza_View();
                obj.COD_RUO_SIC = rs.getLong(1);
                obj.NOM_RUO_SIC = rs.getString(2);
                obj.DES_RUO_SIC = rs.getString(3);
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
