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
package com.apconsulting.luna.ejb.Ala;

/*
<comment date="11/03/2004" author="Pogrebnoy Yura">
<description> dopolnil Ala_View i getAla_View polem DES_ALA </description>
</comment>
 */
import javax.ejb.*;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

///////////////ATTENTION!!//////////////////////////////////////////////
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
public class AlaBean extends BMPEntityBean implements IAla, IAlaHome {

    long COD_ALA;              //1
    String NOM_ALA;            //2
    //----------------------------
    String DES_ALA;            //3
    
    private static AlaBean ys = null;
    private AlaBean() {
    }
    public static AlaBean getInstance(){
        if (ys==null) ys = new AlaBean();
        return ys;
    }

    // (Home Interface) create()
    public IAla create(String strNOM_ALA) throws CreateException {
        AlaBean bean = new AlaBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_ALA);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_ALA);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AlaBean iAlaBean = new AlaBean();
        try {
            Object obj = iAlaBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAlaBean.setEntityContext(new EntityContextWrapper(obj));
            iAlaBean.ejbActivate();
            iAlaBean.ejbLoad();
            iAlaBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Interface) findByPrimaryKey()
    public IAla findByPrimaryKey(Long primaryKey) throws FinderException {
        AlaBean bean = new AlaBean();
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
    public Collection getAla_View() {
        return (new AlaBean()).ejbGetAla_View();
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IAlaHome-implementation>
    public Long ejbCreate(String strNOM_ALA) {
        this.NOM_ALA = strNOM_ALA;
        this.COD_ALA = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_ala_tab (cod_ala,nom_ala) VALUES(?,?)");
            ps.setLong(1, COD_ALA);
            ps.setString(2, NOM_ALA);
            ps.executeUpdate();
            return new Long(COD_ALA);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_ALA) {
    }
//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ala FROM ana_ala_tab ");
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
        this.COD_ALA = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------
    public void ejbPassivate() {
        this.COD_ALA = -1;
    }
//----------------------------------------------------------
    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_ala_tab  WHERE cod_ala=?");
            ps.setLong(1, COD_ALA);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_ALA = rs.getLong("COD_ALA");
                this.NOM_ALA = rs.getString("NOM_ALA");
                this.DES_ALA = rs.getString("DES_ALA");
            } else {
                throw new NoSuchEntityException("Ala con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_ala_tab  WHERE cod_ala=?");
            ps.setLong(1, COD_ALA);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Ala con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_ala_tab  SET cod_ala=?, nom_ala=?, des_ala=?	 WHERE cod_ala=?");
            ps.setLong(1, COD_ALA);
            ps.setString(2, NOM_ALA);
            ps.setString(3, DES_ALA);
            ps.setLong(4, COD_ALA);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Ala con ID= non è trovata");
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
    public long getCOD_ALA() {
        return COD_ALA;
    }
    //2
    public void setNOM_ALA(String newNOM_ALA) {
        if (NOM_ALA.equals(newNOM_ALA)) {
            return;
        }
        NOM_ALA = newNOM_ALA;
        setModified();
    }

    public String getNOM_ALA() {
        return NOM_ALA;
    }
    //============================================
    // not required field
    //3
    public void setDES_ALA(String newDES_ALA) {
        if (DES_ALA != null) {
            if (DES_ALA.equals(newDES_ALA)) {
                return;
            }
        }
        DES_ALA = newDES_ALA;
        setModified();
    }

    public String getDES_ALA() {
        if (DES_ALA == null) {
            return "";
        }
        return DES_ALA;
    }
    //</comment>
    public Collection ejbGetAla_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ala, nom_ala, des_ala FROM ana_ala_tab ORDER BY nom_ala ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Ala_View obj = new Ala_View();
                obj.COD_ALA = rs.getLong(1);
                obj.NOM_ALA = rs.getString(2);
                obj.DES_ALA = rs.getString(3);
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
    public Collection findEx(String strNOM_ALA, String strDES_ALA, int iOrderParameter) {
        return ejbFindEx(strNOM_ALA, strDES_ALA, iOrderParameter);
    }

    public Collection ejbFindEx(String strNOM_ALA, String strDES_ALA, int iOrderParameter) {
        String strSql = "SELECT cod_ala, nom_ala, des_ala FROM ana_ala_tab ";
        boolean ifWhere = false;
        if (strNOM_ALA != null) {
            strSql += " WHERE UPPER(nom_ala) LIKE ?||'%' ";
            ifWhere = true;
        }
        if (strDES_ALA != null) {
            strSql += (ifWhere) ? " AND " : " WHERE ";
            strSql += "UPPER (des_ala) LIKE ?||'%' ";
        }


        strSql += " ORDER BY 2 ";
//  strSql += " ORDER BY " + ABS(iOrderParameter) + (iOrderParameter > 0 ? " ASC" : " DESC");
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (strNOM_ALA != null) {
                ps.setString(i++, strNOM_ALA);
            }
            if (strDES_ALA != null) {
                ps.setString(i, strDES_ALA);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Ala_View obj = new Ala_View();
                obj.COD_ALA = rs.getLong(1);
                obj.NOM_ALA = rs.getString(2);
                obj.DES_ALA = rs.getString(3);
                ar.add(obj);
            }
            return ar;
        } catch (Exception ex) {
            throw new EJBException("NOM_ALA= " + strNOM_ALA + ";\nDES_ALA= " + strDES_ALA + ";\n" + strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AlaBean"/>
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
// PseudoContext.bind("AlaBean", new AlaBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
