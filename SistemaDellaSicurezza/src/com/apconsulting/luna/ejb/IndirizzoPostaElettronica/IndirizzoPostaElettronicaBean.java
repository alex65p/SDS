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
package com.apconsulting.luna.ejb.IndirizzoPostaElettronica;

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
public class IndirizzoPostaElettronicaBean extends BMPEntityBean implements IIndirizzoPostaElettronica, IIndirizzoPostaElettronicaHome {
    //< member-varibles description="Member Variables">

    long lCOD_IDZ_PSA_ELT;
    String strIDZ_PSA_ELT;
    String strDES_IDZ_PSA_ELT;
    long lCOD_FAT_RSO;
    //< /member-varibles>
    //< IIndirizzoPostaElettronicaHome-implementation>
    public static final String BEAN_NAME = "IndirizzoPostaElettronicaBean";
    private static IndirizzoPostaElettronicaBean ys = null;

    private IndirizzoPostaElettronicaBean() {
        //
    }

    public static IndirizzoPostaElettronicaBean getInstance() {
        if (ys == null) {
            ys = new IndirizzoPostaElettronicaBean();
        }
        return ys;
    }

    @Override
    public void remove(Object primaryKey) {
        IndirizzoPostaElettronicaBean bean = new IndirizzoPostaElettronicaBean();
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

    public IIndirizzoPostaElettronica create(String strIDZ_PSA_ELT, long lCOD_FAT_RSO) throws javax.ejb.CreateException {
        IndirizzoPostaElettronicaBean bean = new IndirizzoPostaElettronicaBean();
        try {
            Object primaryKey = bean.ejbCreate(strIDZ_PSA_ELT, lCOD_FAT_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strIDZ_PSA_ELT, lCOD_FAT_RSO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IIndirizzoPostaElettronica findByPrimaryKey(Long primaryKey) throws javax.ejb.FinderException {
        IndirizzoPostaElettronicaBean bean = new IndirizzoPostaElettronicaBean();
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

    public Collection getIndirizzoPostaElettronica_View(String strCOD_FAT_RSO) {
        return (new IndirizzoPostaElettronicaBean()).ejbGetIndirizzoPostaElettronica_View(strCOD_FAT_RSO);
    }

    public Long ejbCreate(String strIDZ_PSA_ELT, long lCOD_FAT_RSO) {
        this.lCOD_IDZ_PSA_ELT = NEW_ID();
        this.strIDZ_PSA_ELT = strIDZ_PSA_ELT;
        this.lCOD_FAT_RSO = lCOD_FAT_RSO;

        this.unsetModified();

        BMPConnection bmp = getConnection();
        try {

            PreparedStatement ps = bmp.prepareStatement("INSERT INTO idz_psa_elt_tab (cod_idz_psa_elt,idz_psa_elt,cod_fat_rso) VALUES(?,?,?)");
            ps.setLong(1, lCOD_IDZ_PSA_ELT);
            ps.setString(2, strIDZ_PSA_ELT);
            ps.setLong(3, lCOD_FAT_RSO);
            ps.executeUpdate();
            return new Long(lCOD_IDZ_PSA_ELT);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(String strIDZ_PSA_ELT, long lCOD_FAT_RSO) {
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_idz_psa_elt FROM idz_psa_elt_tab");
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
        this.lCOD_IDZ_PSA_ELT = ((Long) this.getEntityKey()).longValue();
    }

    public void ejbPassivate() {
        this.lCOD_IDZ_PSA_ELT = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_idz_psa_elt,idz_psa_elt,des_idz_psa_elt,cod_fat_rso FROM idz_psa_elt_tab WHERE cod_idz_psa_elt=?");
            ps.setLong(1, lCOD_IDZ_PSA_ELT);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                lCOD_IDZ_PSA_ELT = rs.getLong(1);
                strIDZ_PSA_ELT = rs.getString(2);
                strDES_IDZ_PSA_ELT = rs.getString(3);
                lCOD_FAT_RSO = rs.getLong(4);
            } else {
                throw new NoSuchEntityException("IndirizzoPostaElettronica with ID=" + lCOD_IDZ_PSA_ELT + " not found");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM idz_psa_elt_tab WHERE cod_idz_psa_elt=?");
            ps.setLong(1, lCOD_IDZ_PSA_ELT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Non e' possibile elliminare la riga");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE idz_psa_elt_tab SET cod_idz_psa_elt=?, idz_psa_elt=?, des_idz_psa_elt=?, cod_fat_rso=? WHERE cod_idz_psa_elt=?");
            ps.setLong(1, lCOD_IDZ_PSA_ELT);
            ps.setString(2, strIDZ_PSA_ELT);
            ps.setString(3, strDES_IDZ_PSA_ELT);
            ps.setLong(4, lCOD_FAT_RSO);
            ps.setLong(5, lCOD_IDZ_PSA_ELT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("IndirizzoPostaElettronica with ID=" + lCOD_IDZ_PSA_ELT + " not found");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    //<setter-getters>
    public long getCOD_IDZ_PSA_ELT() {
        return lCOD_IDZ_PSA_ELT;
    }

    public String getIDZ_PSA_ELT() {
        return strIDZ_PSA_ELT;
    }

    public void setIDZ_PSA_ELT(String strIDZ_PSA_ELT) {
        if ((this.strIDZ_PSA_ELT != null) && (this.strIDZ_PSA_ELT.equals(strIDZ_PSA_ELT))) {
            return;
        }
        this.strIDZ_PSA_ELT = strIDZ_PSA_ELT;
        setModified();
    }

    public String getDES_IDZ_PSA_ELT() {
        return strDES_IDZ_PSA_ELT;
    }

    public void setDES_IDZ_PSA_ELT(String strDES_IDZ_PSA_ELT) {
        if ((this.strDES_IDZ_PSA_ELT != null) && (this.strDES_IDZ_PSA_ELT.equals(strDES_IDZ_PSA_ELT))) {
            return;
        }
        this.strDES_IDZ_PSA_ELT = strDES_IDZ_PSA_ELT;
        setModified();
    }

    public long getCOD_FAT_RSO() {
        return lCOD_FAT_RSO;
    }

    public void setCOD_FAT_RSO(long lCOD_FAT_RSO) {
        if (this.lCOD_FAT_RSO == lCOD_FAT_RSO) {
            return;
        }
        this.lCOD_FAT_RSO = lCOD_FAT_RSO;
        setModified();
    }
    //</setter-getters>

    public Collection ejbGetIndirizzoPostaElettronica_View(String strCOD_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT *  FROM idz_psa_elt_tab WHERE cod_fat_rso=? order by IDZ_PSA_ELT");
            ps.setString(1, strCOD_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                IndirizzoPostaElettronica_View obj = new IndirizzoPostaElettronica_View();
                obj.COD_IDZ_PSA_ELT = rs.getLong(1);
                obj.IDZ_PSA_ELT = rs.getString(2);
                obj.DES_IDZ_PSA_ELT = rs.getString(3);
                obj.COD_FAT_RSO = rs.getString(4);
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
