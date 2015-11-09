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
package com.apconsulting.luna.ejb.Cantiere;

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

public class CantiereBean extends BMPEntityBean implements ICantiere, ICantiereHome {

    long COD_CAN;
    String NOM_CAN;
    String DES_CAN;
    private static CantiereBean ys = null;

    private CantiereBean() {
    }

    public static CantiereBean getInstance() {
        if (ys == null) {
            ys = new CantiereBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!///////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public ICantiere create(String strNOM_CAN) throws CreateException {
        CantiereBean bean = new CantiereBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_CAN);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_CAN);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        CantiereBean iPianoBean = new CantiereBean();
        try {
            Object obj = iPianoBean.ejbFindByPrimaryKey((Long) primaryKey);
            iPianoBean.setEntityContext(new EntityContextWrapper(obj));
            iPianoBean.ejbActivate();
            iPianoBean.ejbLoad();
            iPianoBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public ICantiere findByPrimaryKey(Long primaryKey) throws FinderException {
        CantiereBean bean = new CantiereBean();
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
    public Collection getCantiere_View(Long lCOD_PRO, Long lCOD_AZL) {
        return (new CantiereBean()).ejbGetCantiere_View(lCOD_PRO,lCOD_AZL);
    }

    public Collection ejbGetCantiere_View(Long lCOD_PRO, Long lCOD_AZL) {
        java.util.ArrayList al = new java.util.ArrayList();
	BMPConnection bmp = getConnection();
        try {
            String sq=
                    "SELECT "
                        + "ana_can.cod_can, "
                        + "ana_can.nom_can, "
                        + "ana_can.des_can "
                    + "FROM "
                        + "pro_can_tab pro_can, "
                        + "ana_can_tab ana_can "
                    + "WHERE "
                        + "pro_can.cod_can = ana_can.cod_can "
                        + "and pro_can.cod_azl = ana_can.cod_azl "
                        + "and pro_can.cod_pro = ? "
                        + "and pro_can.cod_azl = ? "
                    + "ORDER BY "
                        + "UPPER(ana_can.nom_can) ASC";
            
	    PreparedStatement ps = bmp.prepareStatement(sq);
            ps.setLong(1, lCOD_PRO);
            ps.setLong(2, lCOD_AZL);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cantiere_View obj = new Cantiere_View();
                obj.COD_CAN = rs.getLong(1);
                obj.NOM_CAN = rs.getString(2);
                obj.DES_CAN = rs.getString(3);
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
    
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IPianoHome-implementation>
    public Long ejbCreate(String strNOM_CAN) {
        this.NOM_CAN = strNOM_CAN;
        this.COD_CAN = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_can_tab (cod_can,nom_can) VALUES(?,?)");
            ps.setLong(1, COD_CAN);
            ps.setString(2, NOM_CAN);
            ps.executeUpdate();
            return new Long(COD_CAN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_PNO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_can FROM ana_can_tab ");
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
        this.COD_CAN = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_CAN = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_can_tab  WHERE cod_can=? ORDER BY UPPER(nom_can) ASC ");
            ps.setLong(1, COD_CAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_CAN = rs.getString("NOM_CAN");
                this.DES_CAN = rs.getString("DES_CAN");
            } else {
                throw new NoSuchEntityException("Cantiere con ID=" + COD_CAN + " non trovato");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_can_tab WHERE cod_can=?");
            ps.setLong(1, COD_CAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Cantiere con ID=" + COD_CAN + " non trovato");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_can_tab SET nom_can=?, des_can=? WHERE cod_can=?");
            ps.setString(1, NOM_CAN);
            ps.setString(2, DES_CAN);
            ps.setLong(3, COD_CAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Cantiere con ID=" + COD_CAN + " non trovato");
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
    public void setNOM_CAN(String newNOM_CAN) {
        if (NOM_CAN.equals(newNOM_CAN)) {
            return;
        }
        NOM_CAN = newNOM_CAN;
        setModified();
    }

    public String getNOM_CAN() {
        return NOM_CAN;
    }
    //2

    public long getCOD_CAN() {
        return COD_CAN;
    }
    //============================================
    // not required field
    //3

    public void setDES_CAN(String newDES_CAN) {
        if (DES_CAN != null) {
            if (DES_CAN.equals(newDES_CAN)) {
                return;
            }
        }
        DES_CAN = newDES_CAN;
        setModified();
    }

    public String getDES_CAN() {
        if (DES_CAN == null) {
            return "";
        }
        return DES_CAN;
    }

    public Collection findEx(
            Long lCOD_CAN,
            String strNOM_CAN) {
        return ejbFindEx(lCOD_CAN, strNOM_CAN);
    }

    public Collection ejbFindEx(
            Long lCOD_CAN,
            String strNOM_CAN) {
        String strSql = " SELECT cod_can, nom_can, des_can FROM ana_can_tab WHERE 0 = 0";
        if (strNOM_CAN != null) {
            strSql += " upper(nom_can) LIKE ?  AND   ";
        }
        strSql += " ORDER BY UPPER(nom_can) ASC";
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (strNOM_CAN != null) {
                ps.setString(i++, strNOM_CAN + "%".toUpperCase());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Cantiere_View v = new Cantiere_View();
                v.COD_CAN = rs.getLong(1);
                v.NOM_CAN = rs.getString(2);
                v.DES_CAN = rs.getString(3);
                ar.add(v);
            }
            return ar;
            //----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//===================================
///////////ATTENTION!!////////////////////////////////////////
}
