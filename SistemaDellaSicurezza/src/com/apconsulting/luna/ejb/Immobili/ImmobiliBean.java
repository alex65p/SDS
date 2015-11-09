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
package com.apconsulting.luna.ejb.Immobili;

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
public class ImmobiliBean extends BMPEntityBean implements IImmobili, IImmobiliHome {

    long COD_IMO;          //1
    String NOM_IMO;        //2
    //------------------------
    String DES_IMO;        //3
    private static ImmobiliBean ys = null;

    private ImmobiliBean() {
        //
    }

    public static ImmobiliBean getInstance() {
        if (ys == null) {
            ys = new ImmobiliBean();
        }
        return ys;
    }

    // (Home Interface) create()
    public IImmobili create(String strNOM_IMO) throws CreateException {
        ImmobiliBean bean = new ImmobiliBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_IMO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_IMO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()

    @Override
    public void remove(Object primaryKey) {
        ImmobiliBean iImmobiliBean = new ImmobiliBean();
        try {
            Object obj = iImmobiliBean.ejbFindByPrimaryKey((Long) primaryKey);
            iImmobiliBean.setEntityContext(new EntityContextWrapper(obj));
            iImmobiliBean.ejbActivate();
            iImmobiliBean.ejbLoad();
            iImmobiliBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Interface) findByPrimaryKey()

    public IImmobili findByPrimaryKey(Long primaryKey) throws FinderException {
        ImmobiliBean bean = new ImmobiliBean();
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

    // (Home Intrface) VIEWS
    public Collection getImmobili_View() {
        return (new ImmobiliBean()).ejbGetImmobili_View();
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IImmobiliHome-implementation>
    public Long ejbCreate(String strNOM_IMO) {
        this.NOM_IMO = strNOM_IMO;
        this.COD_IMO = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_imo_tab (cod_imo,nom_imo) VALUES(?,?)");
            ps.setLong(1, COD_IMO);
            ps.setString(2, NOM_IMO);
            ps.executeUpdate();
            return new Long(COD_IMO);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_IMO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_imo FROM ana_imo_tab ");
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
        this.COD_IMO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_IMO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_imo_tab  WHERE cod_imo=?");
            ps.setLong(1, COD_IMO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_IMO = rs.getLong("COD_IMO");
                this.NOM_IMO = rs.getString("NOM_IMO");
                this.DES_IMO = rs.getString("DES_IMO");
            } else {
                throw new NoSuchEntityException("Immobili con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_imo_tab  WHERE cod_imo=?");
            ps.setLong(1, COD_IMO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Immobili con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_imo_tab  SET cod_imo=?, nom_imo=?, des_imo=?	 WHERE cod_imo=?");
            ps.setLong(1, COD_IMO);
            ps.setString(2, NOM_IMO);
            ps.setString(3, DES_IMO);
            ps.setLong(4, COD_IMO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Immobili con ID= non è trovata");
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
//<comment description="Update Method">
    public void Update() {
        setModified();
    }
//<comment

//<comment description="setter/getters">
    //1
    public long getCOD_IMO() {
        return COD_IMO;
    }
    //2

    public void setNOM_IMO(String newNOM_IMO) {
        if (NOM_IMO.equals(newNOM_IMO)) {
            return;
        }
        NOM_IMO = newNOM_IMO;
        setModified();
    }

    public String getNOM_IMO() {
        return NOM_IMO;
    }
    //============================================
    // not required field
    //3

    public void setDES_IMO(String newDES_IMO) {
        if (DES_IMO != null) {
            if (DES_IMO.equals(newDES_IMO)) {
                return;
            }
        }
        DES_IMO = newDES_IMO;
        setModified();
    }

    public String getDES_IMO() {
        if (DES_IMO == null) {
            return "";
        }
        return DES_IMO;
    }
    //</comment>

    public Collection ejbGetImmobili_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_imo, nom_imo, des_imo FROM ana_imo_tab ORDER BY nom_imo ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Immobili_View obj = new Immobili_View();
                obj.COD_IMO = rs.getLong(1);
                obj.NOM_IMO = rs.getString(2);
                obj.DES_IMO = rs.getString(3);
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
    //-------------------

    public Collection findEx(String strNOM_IMO, String strDES_IMO, int iOrderParameter) {
        return ejbFindEx(strNOM_IMO, strDES_IMO, iOrderParameter);
    }

    public Collection ejbFindEx(String strNOM_IMO, String strDES_IMO, int iOrderParameter) {
        String strSql = "SELECT cod_imo, UPPER(nom_imo) AS nom_imo, des_imo FROM ana_imo_tab ";
        boolean ifWhere = false;
        if (strNOM_IMO != null) {
            strSql += " WHERE UPPER(nom_imo) LIKE ? ";
            ifWhere = true;
        }
        if (strDES_IMO != null) {
            strSql += (ifWhere) ? " AND " : " WHERE ";
            strSql += "UPPER (des_imo) LIKE ? ";
        }

        strSql += " ORDER BY 2 ";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (strNOM_IMO != null) {
                ps.setString(i++, strNOM_IMO.toUpperCase());
            }
            if (strDES_IMO != null) {
                ps.setString(i, strDES_IMO.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Immobili_View obj = new Immobili_View();
                obj.COD_IMO = rs.getLong(1);
                obj.NOM_IMO = rs.getString(2);
                obj.DES_IMO = rs.getString(3);
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
}
