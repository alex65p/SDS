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
package com.apconsulting.luna.ejb.Piano;

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
public class PianoBean extends BMPEntityBean implements IPiano, IPianoHome {
    //<comment description="Member Variables">

    long COD_PNO;            	//1
    String NOM_PNO;            	//2
    //-------------------------------
    String DES_PNO;            	//3
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static PianoBean ys = null;

    private PianoBean() {
        //
    }

    public static PianoBean getInstance() {
        if (ys == null) {
            ys = new PianoBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!///////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IPiano create(String strNOM_PNO) throws CreateException {
        PianoBean bean = new PianoBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_PNO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_PNO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        PianoBean iPianoBean = new PianoBean();
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

    public IPiano findByPrimaryKey(Long primaryKey) throws FinderException {
        PianoBean bean = new PianoBean();
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
    public Collection getPiano_View() {
        return (new PianoBean()).ejbGetPiano_View();
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IPianoHome-implementation>
    public Long ejbCreate(String strNOM_PNO) {
        this.NOM_PNO = strNOM_PNO;
        this.COD_PNO = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_pno_tab (cod_pno,nom_pno) VALUES(?,?)");
            ps.setLong(1, COD_PNO);
            ps.setString(2, NOM_PNO);
            ps.executeUpdate();
            return new Long(COD_PNO);
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
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pno FROM ana_pno_tab ");
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
        this.COD_PNO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_PNO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_pno_tab  WHERE cod_pno=?");
            ps.setLong(1, COD_PNO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_PNO = rs.getString("NOM_PNO");
                this.DES_PNO = rs.getString("DES_PNO");
            } else {
                throw new NoSuchEntityException("Piano con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_pno_tab  WHERE cod_pno=?");
            ps.setLong(1, COD_PNO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Piano con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_pno_tab  SET nom_pno=?, des_pno=? WHERE cod_pno=?");
            ps.setString(1, NOM_PNO);
            ps.setString(2, DES_PNO);
            ps.setLong(3, COD_PNO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Piano con ID= non è trovata");
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
    public void setNOM_PNO(String newNOM_PNO) {
        if (NOM_PNO.equals(newNOM_PNO)) {
            return;
        }
        NOM_PNO = newNOM_PNO;
        setModified();
    }

    public String getNOM_PNO() {
        return NOM_PNO;
    }
    //2

    public long getCOD_PNO() {
        return COD_PNO;
    }
    //============================================
    // not required field
    //3

    public void setDES_PNO(String newDES_PNO) {
        if (DES_PNO != null) {
            if (DES_PNO.equals(newDES_PNO)) {
                return;
            }
        }
        DES_PNO = newDES_PNO;
        setModified();
    }

    public String getDES_PNO() {
        if (DES_PNO == null) {
            return "";
        }
        return DES_PNO;
    }

    //</comment>
    public Collection ejbGetPiano_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pno, nom_pno, des_pno FROM ana_pno_tab ORDER BY nom_pno ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Piano_View obj = new Piano_View();
                obj.COD_PNO = rs.getLong(1);
                obj.NOM_PNO = rs.getString(2);
                obj.DES_PNO = rs.getString(3);
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
    //</comment>
// ============= by Juli==== SEARCH==

    public Collection findEx(
            String strNOM_PNO,
            String strDES_PNO,
            int iOrderParameter /*not used for now*/) {
        return ejbFindEx(strNOM_PNO, strDES_PNO, iOrderParameter);
    }

    public Collection ejbFindEx(
            String strNOM_PNO,
            String strDES_PNO,
            int iOrderBy /*not used for now*/) {
        String strSql = " SELECT cod_pno, nom_pno, des_pno FROM ana_pno_tab WHERE ";
        if (strNOM_PNO != null) {
            strSql += " upper(nom_pno) LIKE ?  AND   ";
        }
        if (strDES_PNO != null) {
            strSql += " upper(des_pno) LIKE ?  AND   ";
        }
        strSql = strSql.substring(1, strSql.length() - 6);
        strSql += " ORDER BY UPPER(nom_pno) " + (iOrderBy > 0 ? " ASC" : "DESC");
        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            if (strNOM_PNO != null) {
                ps.setString(i++, strNOM_PNO + "%".toUpperCase());
            }
            if (strDES_PNO != null) {
                ps.setString(i++, strDES_PNO + "%".toUpperCase());
            }
            //----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                Piano_View v = new Piano_View();
                v.COD_PNO = rs.getLong(1);
                v.NOM_PNO = rs.getString(2);
                v.DES_PNO = rs.getString(3);
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
