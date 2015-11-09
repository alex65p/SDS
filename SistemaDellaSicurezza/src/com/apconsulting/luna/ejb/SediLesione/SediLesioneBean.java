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
package com.apconsulting.luna.ejb.SediLesione;

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
public class SediLesioneBean extends BMPEntityBean implements ISediLesione, ISediLesioneHome {
    //<comment description="Member Variables">

    long COD_SED_LES;            //1
    String NOM_SED_LES;            //2
    String TPL_SED_LES;            //3
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static SediLesioneBean ys = null;

    private SediLesioneBean() {
        //
    }

    public static SediLesioneBean getInstance() {
        if (ys == null) {
            ys = new SediLesioneBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!///////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public ISediLesione create(String strNOM_SED_LES, String strTPL_SED_LES) throws CreateException {
        SediLesioneBean bean = new SediLesioneBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_SED_LES, strTPL_SED_LES);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_SED_LES, strTPL_SED_LES);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        SediLesioneBean iSediLesioneBean = new SediLesioneBean();
        try {
            Object obj = iSediLesioneBean.ejbFindByPrimaryKey((Long) primaryKey);
            iSediLesioneBean.setEntityContext(new EntityContextWrapper(obj));
            iSediLesioneBean.ejbActivate();
            iSediLesioneBean.ejbLoad();
            iSediLesioneBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public ISediLesione findByPrimaryKey(Long primaryKey) throws FinderException {
        SediLesioneBean bean = new SediLesioneBean();
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

    public Collection getANA_SED_LES_TAB_ByNOM_View() {
        return (new SediLesioneBean()).ejbGetANA_SED_LES_TAB_ByNOM_View();
    }

    public Collection findEx(String NOM, long iOrderBy) {
        return (new SediLesioneBean()).ejbfindEx(NOM, iOrderBy);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</ISediLesioneHome-implementation>
    public Long ejbCreate(String strNOM_SED_LES, String strTPL_SED_LES) {
        this.NOM_SED_LES = strNOM_SED_LES;
        this.TPL_SED_LES = strTPL_SED_LES;
        this.COD_SED_LES = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_sed_les_tab (cod_sed_les,nom_sed_les,tpl_sed_les) VALUES(?,?,?)");
            ps.setLong(1, COD_SED_LES);
            ps.setString(2, NOM_SED_LES);
            ps.setString(3, TPL_SED_LES);
            ps.executeUpdate();
            return new Long(COD_SED_LES);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_SED_LES, String strTPL_SED_LES) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sed_les FROM ana_sed_les_tab ");
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
        this.COD_SED_LES = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_SED_LES = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_sed_les_tab  WHERE cod_sed_les=?");
            ps.setLong(1, COD_SED_LES);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_SED_LES = rs.getString("NOM_SED_LES");
                this.TPL_SED_LES = rs.getString("TPL_SED_LES");
            } else {
                throw new NoSuchEntityException("SediLesione con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_sed_les_tab  WHERE cod_sed_les=?");
            ps.setLong(1, COD_SED_LES);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("SediLesione con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_sed_les_tab  SET nom_sed_les=?, tpl_sed_les=? WHERE cod_sed_les=?");
            ps.setString(1, NOM_SED_LES);
            ps.setString(2, TPL_SED_LES);
            ps.setLong(3, COD_SED_LES);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("SediLesione con ID= non è trovata");
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
    //1
    public void setNOM_SED_LES(String newNOM_SED_LES) {
        if (NOM_SED_LES.equals(newNOM_SED_LES)) {
            return;
        }
        NOM_SED_LES = newNOM_SED_LES;
        setModified();
    }

    public String getNOM_SED_LES() {
        return NOM_SED_LES;
    }
    //2

    public void setTPL_SED_LES(String newTPL_SED_LES) {
        if (TPL_SED_LES.equals(newTPL_SED_LES)) {
            return;
        }
        TPL_SED_LES = newTPL_SED_LES;
        setModified();
    }

    public String getTPL_SED_LES() {
        return TPL_SED_LES;
    }
    //3

    public long getCOD_SED_LES() {
        return COD_SED_LES;
    }
    //============================================
    //</comment>

// Views by Pogrebnoy Yura
    public Collection ejbGetANA_SED_LES_TAB_ByNOM_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sed_les, nom_sed_les, tpl_sed_les FROM ana_sed_les_tab ORDER BY nom_sed_les");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ANA_SED_LES_TAB_ByNOM_View obj = new ANA_SED_LES_TAB_ByNOM_View();
                obj.COD_SED_LES = rs.getLong(1);
                obj.NOM_SED_LES = rs.getString(2);
                obj.TPL_SED_LES = rs.getString(3);
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

    public Collection ejbfindEx(String NOM, long iOrderBy) {
        String Sql = "SELECT cod_sed_les, nom_sed_les, tpl_sed_les FROM ana_sed_les_tab ";
        if (NOM != null) {
            Sql += " WHERE UPPER(nom_sed_les) LIKE ? ";
        }
        Sql += " ORDER BY nom_sed_les";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (NOM != null) {
                ps.setString(1, NOM.toUpperCase() + "%");
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findEx_sed_les obj = new findEx_sed_les();
                obj.COD_SED_LES = rs.getLong(1);
                obj.NOM_SED_LES = rs.getString(2);
                obj.TPL_SED_LES = rs.getString(3);
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
///////////ATTENTION!!////////////////////////////////////////////
}//<comment description="end of implementation  SediLesioneBean"/>

