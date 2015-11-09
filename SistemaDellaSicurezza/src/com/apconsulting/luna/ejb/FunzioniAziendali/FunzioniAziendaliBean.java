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
package com.apconsulting.luna.ejb.FunzioniAziendali;

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
public class FunzioniAziendaliBean extends BMPEntityBean implements IFunzioniAziendali, IFunzioniAziendaliHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    long COD_FUZ_AZL;     //1
    String NOM_FUZ_AZL; //2
    //----------------------------
    String DES_FUZ_AZL;            //3
    //</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static FunzioniAziendaliBean ys = null;

    private FunzioniAziendaliBean() {
    }

    public static FunzioniAziendaliBean getInstance() {
        if (ys == null) {
            ys = new FunzioniAziendaliBean();
        }
        return ys;
    }

    //System.err.println("FunzioniAziendaliBean constructor<br>");
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

    // (Home Intrface) create()
    public IFunzioniAziendali create(String strNOM_FUZ_AZL) throws RemoteException, CreateException {
        FunzioniAziendaliBean bean = new FunzioniAziendaliBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_FUZ_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_FUZ_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }


    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        FunzioniAziendaliBean iFunzioniAziendaliBean = new FunzioniAziendaliBean();
        try {
            Object obj = iFunzioniAziendaliBean.ejbFindByPrimaryKey((Long) primaryKey);
            iFunzioniAziendaliBean.setEntityContext(new EntityContextWrapper(obj));
            iFunzioniAziendaliBean.ejbActivate();
            iFunzioniAziendaliBean.ejbLoad();
            iFunzioniAziendaliBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IFunzioniAziendali findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        FunzioniAziendaliBean bean = new FunzioniAziendaliBean();
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


    // (Home Intrface) VIEWS  getFunzioniAziendali_Name_View()
    public Collection getFunzioniAziendali_Name_View() {
        return (new FunzioniAziendaliBean()).ejbGetFunzioniAziendali_Name_View();
    }

    public Collection getFunzioniAziendali_View() {
        return (new FunzioniAziendaliBean()).ejbGetFunzioniAziendali_View();
    }

    public Collection findEx(String NOM, String DES, long iOrderBy) {
        return (new FunzioniAziendaliBean()).ejbfindEx(NOM, DES, iOrderBy);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    //</IAziendaHome-implementation>
    public Long ejbCreate(String strNOM_FUZ_AZL) {
        this.NOM_FUZ_AZL = strNOM_FUZ_AZL;
        //  this.DES_FUZ_AZL=strDES_FUZ_AZL;
        this.COD_FUZ_AZL = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_fuz_azl_tab (cod_fuz_azl,nom_fuz_azl) VALUES(?,?)");
            ps.setLong(1, COD_FUZ_AZL);
            ps.setString(2, NOM_FUZ_AZL);
            // ps.setString (3, DES_FUZ_AZL);
            ps.executeUpdate();
            return new Long(COD_FUZ_AZL);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_FUZ_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fuz_azl FROM ana_fuz_azl_tab ");
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
        this.COD_FUZ_AZL = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_FUZ_AZL = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_fuz_azl_tab  WHERE cod_fuz_azl=?");
            ps.setLong(1, COD_FUZ_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_FUZ_AZL = rs.getLong("COD_FUZ_AZL");
                this.NOM_FUZ_AZL = rs.getString("NOM_FUZ_AZL");
                this.DES_FUZ_AZL = rs.getString("DES_FUZ_AZL");
            } else {
                throw new NoSuchEntityException("Funzioni Azienda con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_fuz_azl_tab  WHERE cod_fuz_azl=?");
            ps.setLong(1, COD_FUZ_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Funzioni Azienda con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_fuz_azl_tab  SET cod_fuz_azl=?, nom_fuz_azl=?, des_fuz_azl=? WHERE cod_fuz_azl=?");
            ps.setLong(1, COD_FUZ_AZL);
            ps.setString(2, NOM_FUZ_AZL);
            ps.setString(3, DES_FUZ_AZL);
            ps.setLong(4, COD_FUZ_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Funzioni Azienda con ID= non è trovata");
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
    public void setNOM_FUZ_AZL(String newNOM_FUZ_AZL) {
        if (NOM_FUZ_AZL.equals(newNOM_FUZ_AZL)) {
            return;
        }
        NOM_FUZ_AZL = newNOM_FUZ_AZL;
        setModified();
    }

    public String getNOM_FUZ_AZL() {
        return NOM_FUZ_AZL;
    }

    public long getCOD_FUZ_AZL() {
        return COD_FUZ_AZL;
    }
    //2

    public void setDES_FUZ_AZL(String newDES_FUZ_AZL) {
        if (DES_FUZ_AZL != null) {
            if (DES_FUZ_AZL.equals(newDES_FUZ_AZL)) {
                return;
            }
        }
        DES_FUZ_AZL = newDES_FUZ_AZL;
        setModified();
    }

    public String getDES_FUZ_AZL() {
        if (DES_FUZ_AZL == null) {
            return "";
        }
        return DES_FUZ_AZL;
    }
    //</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>

    //<comment description="extended setters/getters">

    /* Added by Mike Kondratyuk 09/03/2003 */
    public Collection ejbGetFunzioniAziendali_Name_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_fuz_azl, " +
                        "nom_fuz_azl " +
                    "FROM " +
                        "ana_fuz_azl_tab " +
                    "ORDER BY " +
                        "nom_fuz_azl");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FunzioniAziendali_Name_View obj = new FunzioniAziendali_Name_View();
                obj.COD_FUZ_AZL = rs.getLong(1);
                obj.NOM_FUZ_AZL = rs.getString(2);
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

    public Collection ejbGetFunzioniAziendali_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_fuz_azl,nom_fuz_azl,des_fuz_azl FROM ana_fuz_azl_tab ORDER BY nom_fuz_azl");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FunzioniAziendali_View obj = new FunzioniAziendali_View();
                obj.COD_FUZ_AZL = rs.getLong(1);
                obj.NOM_FUZ_AZL = rs.getString(2);
                obj.DES_FUZ_AZL = rs.getString(3);
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

    /* /Added by Mike Kondratyuk 09/03/2003 */
    public Collection ejbfindEx(String NOM, String DES, long iOrderBy) {
        String Sql = "SELECT cod_fuz_azl, nom_fuz_azl, des_fuz_azl FROM ana_fuz_azl_tab  ";
        int i = 1;
        int desIndex = 0;
        int nomIndex = 0;
        if (!"".equals(NOM)) {
            Sql += " WHERE ";
            Sql += " UPPER(nom_fuz_azl) LIKE ? ";
            nomIndex = i++;
        }
        if (!"".equals(DES)) {
            if (nomIndex != 0) {
                Sql += " AND ";
            } else {
                Sql += " WHERE ";
            }
            Sql += " UPPER(des_fuz_azl) LIKE ? ";
            desIndex = i++;
        }
        Sql += " ORDER BY nom_fuz_azl ";//+ (iOrderBy>0?" ASC": "DESC");
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            if (nomIndex != 0) {
                ps.setString(nomIndex, (NOM + "%").toUpperCase());
            }
            if (desIndex != 0) {
                ps.setString(desIndex, (DES + "%").toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                FunzioniAziendali_View obj = new FunzioniAziendali_View();
                obj.COD_FUZ_AZL = rs.getLong(1);
                obj.NOM_FUZ_AZL = rs.getString(2);
                obj.DES_FUZ_AZL = rs.getString(3);
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

///////////ATTENTION!!////////////////////////////////////////
}
