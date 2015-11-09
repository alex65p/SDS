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
package com.apconsulting.luna.ejb.Capitoli;

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
public class CapitoliBean extends BMPEntityBean implements ICapitoli, ICapitoliHome {
    //<comment description="Member Variables">

    long COD_CPL;
    String NOM_CPL;
    long COD_CPL_R;
    //</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static CapitoliBean ys = null;

    private CapitoliBean() {
        //
    }

    public static CapitoliBean getInstance() {
        if (ys == null) {
            ys = new CapitoliBean();
        }
        return ys;
    }

/////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public ICapitoli create(String strNOM_CPL) throws RemoteException, CreateException {
        CapitoliBean bean = new CapitoliBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_CPL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_CPL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }


    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        CapitoliBean iCapitoliBean = new CapitoliBean();
        try {
            Object obj = iCapitoliBean.ejbFindByPrimaryKey((Long) primaryKey);
            iCapitoliBean.setEntityContext(new EntityContextWrapper(obj));
            iCapitoliBean.ejbActivate();
            iCapitoliBean.ejbLoad();
            iCapitoliBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public ICapitoli findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        CapitoliBean bean = new CapitoliBean();
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

    // (Home Intrface) VIEWS  getCapitoli_UserID_View()
    public Collection getCapitoli_UserID_View() {
        return (new CapitoliBean()).ejbGetCapitoli_UserID_View();
    }

    public Collection getCapitoli_CRM_CPL_View(String strNOM) {
        return (new CapitoliBean()).ejbGetCapitoli_CRM_CPL_View(strNOM);
    }

    public String getCaricaDbCapitoli(long COD_CPL) {
        return (new CapitoliBean()).ejbCaricaDbCapitoli(COD_CPL);
    }

    public String getCaricaRbCapitoli(String strNOM_CPL) {
        return (new CapitoliBean()).ejbCaricaRbCapitoli(strNOM_CPL);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</ICapitoliHome-implementation>
    public Long ejbCreate(String strNOM_CPL) {
        this.NOM_CPL = strNOM_CPL;
        this.COD_CPL = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_cpl_tab (cod_cpl,nom_cpl) VALUES(?,?)");
            ps.setLong(1, COD_CPL);
            ps.setString(2, NOM_CPL);
            ps.executeUpdate();
            return new Long(COD_CPL);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_CPL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cpl, nom_cpl, cod_cpl_r FROM ana_cpl_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
                al.add(new String(rs.getString(2)));
                al.add(new Long(rs.getLong(3)));
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
        this.COD_CPL = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_CPL = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_cpl_tab  WHERE cod_cpl=?");
            ps.setLong(1, COD_CPL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_CPL = rs.getString("NOM_CPL");
                this.COD_CPL_R = rs.getLong("COD_CPL_R");
            } else {
                throw new NoSuchEntityException("Capitoli con ID=" + COD_CPL + " non è trovato");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_cpl_tab  WHERE cod_cpl=?");
            ps.setLong(1, COD_CPL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Capitoli con ID=" + COD_CPL + " non è trovato");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_cpl_tab  SET nom_cpl=?,cod_cpl_r=? WHERE cod_cpl=?");
            ps.setString(1, NOM_CPL);
            //ps.setLong   	(2, COD_CPL_R);
            if (COD_CPL_R == 0) {
                ps.setNull(2, java.sql.Types.BIGINT);
            } else {
                ps.setLong(2, COD_CPL_R);
            }
            ps.setLong(3, COD_CPL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Capitoli con ID=" + COD_CPL + " non è trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!////////////////////////////
//<comment description="Zdes opredeliayutsia metody remote interfeisa"/>

//<comment description="setter/getters">
    //----1
    public long getCOD_CPL() {
        return COD_CPL;
    }
    //----2

    public void setNOM_CPL(String newNOM_CPL) {
        if (NOM_CPL.equals(newNOM_CPL)) {
            return;
        }
        NOM_CPL = newNOM_CPL;
        setModified();
    }

    public String getNOM_CPL() {
        return NOM_CPL;
    }

    public void setCOD_CPL_R(long newCOD_CPL_R) {
        COD_CPL_R = newCOD_CPL_R;
        setModified();
    }
    //-------------------
    //</comment>
///**********************************************************
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>

    //<comment description="extended setters/getters">
    public Collection ejbGetCapitoli_UserID_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  cod_cpl,nom_cpl FROM ana_cpl_tab order by nom_cpl");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Capitoli_UserID_View obj = new Capitoli_UserID_View();
                obj.COD_CPL = rs.getLong(1);
                obj.NOM_CPL = rs.getString(2);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetCapitoli_CRM_CPL_View(String strNOM) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  cod_cpl_r,nom_cpl_r FROM ana_cpl_tab_r WHERE UPPER(nom_cpl_r) LIKE ? AND Cod_cpl_r not in ( select cod_cpl_r from ana_cpl_tab where cod_cpl_r is not null) order by UPPER(nom_cpl_r)");
            ps.setString(1, strNOM != null?strNOM.toUpperCase():strNOM);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Capitoli_CRM_CPL_View obj = new Capitoli_CRM_CPL_View();
                obj.COD_CPL = rs.getLong(1);
                obj.NOM_CPL = rs.getString(2);
                al.add(obj);
            }
            rs.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public String ejbCaricaDbCapitoli(long COD_CPL) {
        String result = "";
        ResultSet rs = null;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  nom_cpl_r FROM ana_cpl_tab_r WHERE cod_cpl_r=?");
            ps.setLong(1, COD_CPL);
            rs = ps.executeQuery();
            if (rs.next()) {
                result = rs.getString(1);
            }
            rs.close();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;
    }

    public String ejbCaricaRbCapitoli(String strNOM_CPL) {
        String result = "";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_cpl_tab_r(nom_cpl_r,cod_cpl_r) VALUES (?,?)");
            ps.setString(1, strNOM_CPL);
            ps.setLong(2, NEW_ID());
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return result;

    }
    //-------------------
    //</comment>

    public Collection findEx(String NOM_CPL, int iOrderParameter) {
        return (new CapitoliBean()).ejbFindEx(NOM_CPL, iOrderParameter);
    }

    public Collection ejbFindEx(String NOM_CPL, int iOrderParameter) {
        String strSql = "SELECT  cod_cpl, UPPER(nom_cpl)  AS nom_cpl FROM ana_cpl_tab ";
        if (NOM_CPL != null) {
            strSql += "WHERE UPPER(nom_cpl) LIKE ?";
        }
        strSql += " ORDER BY 2";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (NOM_CPL != null) {
                ps.setString(1, NOM_CPL);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Capitoli_UserID_View obj = new Capitoli_UserID_View();
                obj.COD_CPL = rs.getLong(1);
                obj.NOM_CPL = rs.getString(2);
                al.add(obj);
            }
            bmp.close();
            return al;
        //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }

///////////ATTENTION!!/////////////////////////////////////////
}//<comment description="end of implementation  CapitoliBean"/>
