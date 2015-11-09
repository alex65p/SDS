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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.apconsulting.luna.ejb.CategoriaAgeMateriale;

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
//public class CategoriaAgeMaterialeBean extends BMPEntityBean implements IAgenteMaterialeRemote
public class CategoriaAgeMaterialeBean extends BMPEntityBean implements ICategoriaAgeMaterialeHome, ICategoriaAgeMateriale {

    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">
    long COD_CAG_AGE_MAT;           //1
    String NOM_CAG_AGE_MAT;         //2
    //----------------------------

    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static CategoriaAgeMaterialeBean ys = null;

    private CategoriaAgeMaterialeBean() {
        //
    }

    public static CategoriaAgeMaterialeBean getInstance() {
        if (ys == null) {
            ys = new CategoriaAgeMaterialeBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public ICategoriaAgeMateriale create(String strNOM_CAG_AGE_MAT) throws CreateException {
        CategoriaAgeMaterialeBean bean = new CategoriaAgeMaterialeBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_CAG_AGE_MAT);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_CAG_AGE_MAT);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        CategoriaAgeMaterialeBean iCategoriaAgeMaterialeBean = new CategoriaAgeMaterialeBean();
        try {
            Object obj = iCategoriaAgeMaterialeBean.ejbFindByPrimaryKey((Long) primaryKey);
            iCategoriaAgeMaterialeBean.setEntityContext(new EntityContextWrapper(obj));
            iCategoriaAgeMaterialeBean.ejbActivate();
            iCategoriaAgeMaterialeBean.ejbLoad();
            iCategoriaAgeMaterialeBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public ICategoriaAgeMateriale findByPrimaryKey(Long primaryKey) throws FinderException {
        CategoriaAgeMaterialeBean bean = new CategoriaAgeMaterialeBean();
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
    public Collection getCategoriaAge_Materiali_View() {
        return (new CategoriaAgeMaterialeBean()).ejbGetCategoriaAge_Materiali_View();
    }
    //

    public Collection findEx(String NOM, long iOrderBy) {
        return (new CategoriaAgeMaterialeBean()).ejbfindEx(NOM, iOrderBy);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IAgenteMaterialeHome-implementation>
    public Long ejbCreate(String strNOM_CAG_AGE_MAT) {
        this.NOM_CAG_AGE_MAT = strNOM_CAG_AGE_MAT;
        this.COD_CAG_AGE_MAT = NEW_ID();
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cag_age_mat_tab (cod_cag_age_mat,nom_cag_age_mat) VALUES(?,?)");
            ps.setLong(1, COD_CAG_AGE_MAT);
            ps.setString(2, NOM_CAG_AGE_MAT);
            ps.executeUpdate();
            return new Long(COD_CAG_AGE_MAT);
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------   
    public void ejbPostCreate(String strNOM_CAG_AGE_MAT) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cag_age_mat FROM cag_age_mat_tab ");
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
        this.COD_CAG_AGE_MAT = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_CAG_AGE_MAT = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM cag_age_mat_tab  WHERE cod_cag_age_mat=?");
            ps.setLong(1, COD_CAG_AGE_MAT);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_CAG_AGE_MAT = rs.getString("NOM_CAG_AGE_MAT");
                this.COD_CAG_AGE_MAT = rs.getLong("COD_CAG_AGE_MAT");
            } else {
                throw new NoSuchEntityException("AgenteMateriale con ID=" + COD_CAG_AGE_MAT + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cag_age_mat_tab  WHERE cod_cag_age_mat=?");
            ps.setLong(1, COD_CAG_AGE_MAT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("CategoriaAgeMateriale con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE cag_age_mat_tab  SET nom_cag_age_mat=? WHERE cod_cag_age_mat=?");
            ps.setString(1, NOM_CAG_AGE_MAT);
            ps.setLong(2, COD_CAG_AGE_MAT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("CategoriaAgeMateriale con ID= non è trovata");
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
    public void setNOM_CAG_AGE_MAT(String newNOM_CAG_AGE_MAT) {
        if (NOM_CAG_AGE_MAT.equals(newNOM_CAG_AGE_MAT)) {
            return;
        }
        NOM_CAG_AGE_MAT = newNOM_CAG_AGE_MAT;
        setModified();
    }

    public String getNOM_CAG_AGE_MAT() {
        if (NOM_CAG_AGE_MAT == null) {
            return "";
        } else {
            return NOM_CAG_AGE_MAT;
        }
    }

    //2
    public void setCOD_CAG_AGE_MAT(long newCOD_CAG_AGE_MAT) {
        if (COD_CAG_AGE_MAT == newCOD_CAG_AGE_MAT) {
            return;
        }
        COD_CAG_AGE_MAT = newCOD_CAG_AGE_MAT;
        setModified();
    }

    public long getCOD_CAG_AGE_MAT() {
        return COD_CAG_AGE_MAT;
    }
  //=====================================================================<br>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>

    //<comment description="extended setters/getters">
    public Collection ejbGetCategoriaAge_Materiali_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cag_age_mat ,nom_cag_age_mat FROM  cag_age_mat_tab ORDER BY nom_cag_age_mat");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategoriaAge_Materiali_View obj = new CategoriaAge_Materiali_View();
                obj.COD_CAG_AGE_MAT = rs.getLong(1);
                obj.NOM_CAG_AGE_MAT = rs.getString(2);
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
        String Sql = " SELECT cod_cag_age_mat ,nom_cag_age_mat FROM  cag_age_mat_tab ";
        if (NOM != null) {
            Sql += " WHERE UPPER(nom_cag_age_mat) LIKE ? ";
        }
        Sql += " ORDER BY UPPER(nom_cag_age_mat) ";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (NOM != null) {
                ps.setString(1, NOM + "%".toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategoriaAge_Materiali_View obj = new CategoriaAge_Materiali_View();
                obj.COD_CAG_AGE_MAT = rs.getLong(1);
                obj.NOM_CAG_AGE_MAT = rs.getString(2);
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
///////////ATTENTION!!////////////////////////////////////////
}
