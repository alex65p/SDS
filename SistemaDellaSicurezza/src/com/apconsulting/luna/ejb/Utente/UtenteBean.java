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
package com.apconsulting.luna.ejb.Utente;

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
//public class UtenteBean extends BMPEntityBean implements IUtenteRemote
public class UtenteBean extends BMPEntityBean implements IUtente, IUtenteHome {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">
//   *require Fields*

    long COD_UTN;
    String USD_UTN;
    String PSW_UTN;
    String STA_UTN;
    long COD_DPD;
    long COD_AZL;
//   *Not require Fields*
    java.sql.Date DAT_ATT;
    java.sql.Date DAT_DIS;
//</comment>

////////////////////// CONSTRUCTOR///////////////////
    private static UtenteBean ys = null;

    private UtenteBean() {
        //
    }

    public static UtenteBean getInstance() {
        if (ys == null) {
            ys = new UtenteBean();
        }
        return ys;
    }
////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()

    public IUtente create(String strUSD_UTN, String strPSW_UTN, String strSTA_UTN, long lCOD_DPD, long lCOD_AZL) throws RemoteException, CreateException {
        UtenteBean bean = new UtenteBean();
        try {
            Object primaryKey = bean.ejbCreate(strUSD_UTN, strPSW_UTN, strSTA_UTN, lCOD_DPD, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strUSD_UTN, strPSW_UTN, strSTA_UTN, lCOD_DPD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public IUtente create(String strUSD_UTN, String strPSW_UTN, String strSTA_UTN, long lCOD_DPD, long lCOD_AZL, boolean simpleID) throws RemoteException, CreateException {
        UtenteBean bean = new UtenteBean();
        try {
            Object primaryKey = null;
            if (simpleID) {
                primaryKey = bean.ejbCreate(strUSD_UTN, strPSW_UTN, strSTA_UTN, lCOD_DPD, lCOD_AZL, simpleID);
            } else {
                primaryKey = bean.ejbCreate(strUSD_UTN, strPSW_UTN, strSTA_UTN, lCOD_DPD, lCOD_AZL);
            }
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strUSD_UTN, strPSW_UTN, strSTA_UTN, lCOD_DPD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        UtenteBean iUtenteBean = new UtenteBean();
        try {
            Object obj = iUtenteBean.ejbFindByPrimaryKey((Long) primaryKey);
            iUtenteBean.setEntityContext(new EntityContextWrapper(obj));
            iUtenteBean.ejbActivate();
            iUtenteBean.ejbLoad();
            iUtenteBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
// (Home Intrface) findByPrimaryKey()

    public IUtente findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        UtenteBean bean = new UtenteBean();
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

// (Home Intrface) VIEWS  getUtente_DPD_View()
    public Collection getUtente_DPD_View(long AZL_ID) {
        return (new UtenteBean()).ejbGetUtente_DPD_View(AZL_ID);
    }

    public Collection getUtente_CAG_DOC_TAB_View(long UTN_ID) {
        return (new UtenteBean()).ejbGetUtente_CAG_DOC_TAB_View(UTN_ID);
    }

    public Collection getUtente_TPL_DOC_TAB_View(long UTN_ID) {
        return (new UtenteBean()).ejbGetUtente_TPL_DOC_TAB_View(UTN_ID);
    }

    public Collection getUtente_RUO_TAB_View(long UTN_ID) {
        return (new UtenteBean()).ejbGetUtente_RUO_TAB_View(UTN_ID);
    }
//--- by Juli

    public Collection getUtente_View(long COD_AZL) {
        return (new UtenteBean()).ejbGetUtente_View(COD_AZL);
    }

    public Collection findEx(long COD_AZL, long lCOD_DPD, String USD_UTN, String STA_UTN, java.sql.Date DAT_ATT, java.sql.Date DAT_DIS, long iOrderBy) {
        return (new UtenteBean()).ejbfindEx(COD_AZL, lCOD_DPD, USD_UTN, STA_UTN, DAT_ATT, DAT_DIS, iOrderBy);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IUtenteHome-implementation>
    public Long ejbCreate(String strUSD_UTN, String strPSW_UTN, String strSTA_UTN, long lCOD_DPD, long lCOD_AZL) {
        this.USD_UTN = strUSD_UTN;
        this.PSW_UTN = strPSW_UTN;
        this.STA_UTN = strSTA_UTN;
        this.COD_DPD = lCOD_DPD;
        this.COD_AZL = lCOD_AZL;
        this.COD_UTN = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_utn_tab (cod_utn,usd_utn,psw_utn,sta_utn,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?)");
            ps.setLong(1, COD_UTN);
            ps.setString(2, USD_UTN);
            ps.setString(3, PSW_UTN);
            ps.setString(4, STA_UTN);
            ps.setLong(5, COD_DPD);
            ps.setLong(6, COD_AZL);

            ps.executeUpdate();
            return new Long(COD_UTN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbCreate(String strUSD_UTN, String strPSW_UTN, String strSTA_UTN, long lCOD_DPD, long lCOD_AZL, boolean simpleID) {
        this.USD_UTN = strUSD_UTN;
        this.PSW_UTN = strPSW_UTN;
        this.STA_UTN = strSTA_UTN;
        this.COD_DPD = lCOD_DPD;
        this.COD_AZL = lCOD_AZL;
        this.COD_UTN = NEW_SIMPLE_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_utn_tab (cod_utn,usd_utn,psw_utn,sta_utn,cod_dpd,cod_azl) VALUES(?,?,?,?,?,?)");
            ps.setLong(1, COD_UTN);
            ps.setString(2, USD_UTN);
            ps.setString(3, PSW_UTN);
            ps.setString(4, STA_UTN);
            ps.setLong(5, COD_DPD);
            ps.setLong(6, COD_AZL);

            ps.executeUpdate();
            return new Long(COD_UTN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strUSD_UTN, String strPSW_UTN, String strSTA_UTN, long lCOD_DPD, long lCOD_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_utn FROM ana_utn_tab ");
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
        this.COD_UTN = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_UTN = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_utn_tab  WHERE cod_utn=?");
            ps.setLong(1, COD_UTN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.USD_UTN = rs.getString("USD_UTN");
                this.PSW_UTN = rs.getString("PSW_UTN");
                this.STA_UTN = rs.getString("STA_UTN");
                this.DAT_ATT = rs.getDate("DAT_ATT");
                this.DAT_DIS = rs.getDate("DAT_DIS");
                this.COD_DPD = rs.getLong("COD_DPD");
                this.COD_AZL = rs.getLong("COD_AZL");
            } else {
                throw new NoSuchEntityException("Utente con ID=" + COD_UTN + " non è trovato");
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
        bmp.beginTrans();
        try {
            // Elimino le opzioni dell'utente
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "usr_opz_tab "
                    + "WHERE "
                        + "cod_usr = ?");
            ps.setLong(1, COD_UTN);
            ps.executeUpdate();

            // Elimino l'utente
            ps = bmp.prepareStatement(
                    "DELETE FROM "
                        + "ana_utn_tab "
                    + "WHERE "
                        + "cod_utn = ?");
            ps.setLong(1, COD_UTN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Utente con ID=" + COD_UTN + " non è stato trovato");
            }
            
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_utn_tab  SET usd_utn=?, psw_utn=?, sta_utn=?, dat_att=?, dat_dis=?, cod_dpd=?, cod_azl=? WHERE cod_utn=?");

            ps.setString(1, USD_UTN);
            ps.setString(2, PSW_UTN);
            ps.setString(3, STA_UTN);
            ps.setDate(4, DAT_ATT);
            ps.setDate(5, DAT_DIS);
            ps.setLong(6, COD_DPD);
            ps.setLong(7, COD_AZL);
            ps.setLong(8, COD_UTN);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Utente con ID=" + COD_UTN + " non è trovato");
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
    public long getCOD_UTN() {
        return COD_UTN;
    }
//----2

    public void setUSD_UTN(String newUSD_UTN) {
        if (USD_UTN.equals(newUSD_UTN)) {
            return;
        }
        USD_UTN = newUSD_UTN;
        setModified();
    }

    public String getUSD_UTN() {
        return USD_UTN;
    }
//----3

    public void setPSW_UTN(String newPSW_UTN) {
        if (PSW_UTN.equals(newPSW_UTN)) {
            return;
        }
        PSW_UTN = newPSW_UTN;
        setModified();
    }

    public String getPSW_UTN() {
        return PSW_UTN;
    }
//----4

    public void setSTA_UTN(String newSTA_UTN) {
        if (STA_UTN.equals(newSTA_UTN)) {
            return;
        }
        STA_UTN = newSTA_UTN;
        setModified();
    }

    public String getSTA_UTN() {
        return STA_UTN;
    }
//---5

    public void setCOD_DPD(long newCOD_DPD) {
        if (COD_DPD == newCOD_DPD) {
            return;
        }
        COD_DPD = newCOD_DPD;
        setModified();
    }

    public long getCOD_DPD() {
        return COD_DPD;
    }
//---6

    public void setCOD_AZL(long newCOD_AZL) {
        if (COD_AZL == newCOD_AZL) {
            return;
        }
        COD_AZL = newCOD_AZL;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }
//--- not request
//---7 DAT_ATT

    public void setDAT_ATT(java.sql.Date newDAT_ATT) {
        if (DAT_ATT != null) {
            if (DAT_ATT.equals(newDAT_ATT)) {
                return;
            }
        }
        DAT_ATT = newDAT_ATT;
        setModified();
    }

    public java.sql.Date getDAT_ATT() {
        return DAT_ATT;
    }
//---8 DAT_DIS

    public void setDAT_DIS(java.sql.Date newDAT_DIS) {
        if (DAT_DIS != null) {
            if (DAT_DIS.equals(newDAT_DIS)) {
                return;
            }
        }
        DAT_DIS = newDAT_DIS;
        setModified();
    }

    public java.sql.Date getDAT_DIS() {
        return DAT_DIS;
    }
//-------------------
//</comment>
///**********************************************************
///////////ATTENTION!!//////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody-views"/>

//<comment description="extended setters/getters">
    public Collection ejbGetUtente_DPD_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  cod_dpd,mtr_dpd,UPPER(cog_dpd),UPPER(nom_dpd) FROM view_ana_dpd_tab WHERE cod_azl=? order by cog_dpd");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Utente_DPD_View obj = new Utente_DPD_View();
                obj.COD_DPD = rs.getLong(1);
                obj.MTR_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.NOM_DPD = rs.getString(4);
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

    public Collection ejbGetUtente_CAG_DOC_TAB_View(long UTN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  a.cod_cag_doc,a.nom_cag_doc FROM cag_doc_tab a, cag_doc_utn_tab b WHERE b.cod_cag_doc=a.cod_cag_doc AND b.cod_utn=? order by a.nom_cag_doc");
            ps.setLong(1, UTN_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Utente_CAG_DOC_TAB_View obj = new Utente_CAG_DOC_TAB_View();
                obj.COD_CAG_DOC = rs.getLong(1);
                obj.NOM_CAG_DOC = rs.getString(2);
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

    public Collection ejbGetUtente_TPL_DOC_TAB_View(long UTN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  a.cod_tpl_doc,a.nom_tpl_doc FROM tpl_doc_tab a, tpl_doc_utn_tab b WHERE b.cod_tpl_doc=a.cod_tpl_doc AND b.cod_utn=? order by a.nom_tpl_doc");
            ps.setLong(1, UTN_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Utente_TPL_DOC_TAB_View obj = new Utente_TPL_DOC_TAB_View();
                obj.COD_TPL_DOC = rs.getLong(1);
                obj.NOM_TPL_DOC = rs.getString(2);
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

    public Collection ejbGetUtente_RUO_TAB_View(long UTN_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  a.cod_ruo,a.des_ruo FROM ana_ruo_tab a, ruo_utn_tab b WHERE b.cod_ruo=a.cod_ruo AND b.cod_utn=? order by a.des_ruo");
            ps.setLong(1, UTN_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Utente_RUO_TAB_View obj = new Utente_RUO_TAB_View();
                obj.COD_RUO = rs.getLong(1);
                obj.DES_RUO = rs.getString(2);
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

    public void addCOD_CAG_DOC(long CAG_DOC_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cag_doc_utn_tab (cod_cag_doc,cod_utn) VALUES(?,?)");
            ps.setLong(1, CAG_DOC_ID);
            ps.setLong(2, COD_UTN);
            ps.executeUpdate();
//return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_TPL_DOC(long TPL_DOC_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO tpl_doc_utn_tab (cod_tpl_doc,cod_utn) VALUES(?,?)");
            ps.setLong(1, TPL_DOC_ID);
            ps.setLong(2, COD_UTN);
            ps.executeUpdate();
//return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_RUO(long RUO_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ruo_utn_tab (cod_ruo,cod_utn) VALUES(?,?)");
            ps.setLong(1, RUO_ID);
            ps.setLong(2, COD_UTN);
            ps.executeUpdate();
//return new Long(COD_DMD);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_CAG_DOC(long CAG_DOC_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cag_doc_utn_tab  WHERE cod_utn=? AND cod_cag_doc=?");
            ps.setLong(1, COD_UTN);
            ps.setLong(2, CAG_DOC_ID);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento con ID=" + CAG_DOC_ID + " non &egrave trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_TPL_DOC(long TPL_DOC_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM tpl_doc_utn_tab  WHERE cod_utn=? AND cod_tpl_doc=?");
            ps.setLong(1, COD_UTN);
            ps.setLong(2, TPL_DOC_ID);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento con ID=" + TPL_DOC_ID + " non &egrave trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void removeCOD_RUO(long RUO_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ruo_utn_tab  WHERE cod_utn=? AND cod_ruo=?");
            ps.setLong(1, COD_UTN);
            ps.setLong(2, RUO_ID);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Documento con ID=" + RUO_ID + " non &egrave trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------
//</comment>

//<comment description="Create View for Utente by Juli"/>
    public Collection ejbGetUtente_View(long COD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT  a.cod_utn,a.usd_utn FROM ana_utn_tab a WHERE a.cod_azl=? ORDER BY a.usd_utn ");
            ps.setLong(1, COD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Utente_View obj = new Utente_View();
                obj.COD_UTN = rs.getLong(1);
                obj.USD_UTN = rs.getString(2);
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
//</comment>

    // Metodo Aggiunto per la gestione degli accessi con WAS
    // (WebSphere Application Server)
    public Collection getUserSecurityRoles(String user){
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "role " +
                    "FROM " +
                        "view_sc_user_roles " +
                    "WHERE " +
                        "login=?");
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                view_sc_users obj = new view_sc_users();
                obj.ROLE = rs.getString(1).trim();
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//<comment description="Create View for Search by Yuriy Kushkarov"/>
    public Collection ejbfindEx(long COD_AZL, long lCOD_DPD, String USD_UTN, String STA_UTN, java.sql.Date DAT_ATT, java.sql.Date DAT_DIS, long iOrderBy) {
        String Sql = "SELECT b.mtr_dpd, b.nom_dpd, b.cog_dpd, " +
                "a.cod_utn,a.usd_utn,a.sta_utn, " +
                "a.dat_att, " +
                "a.dat_dis, a.cod_dpd, a.cod_azl " +
                "FROM  ana_utn_tab a, " +
                "view_ana_dpd_tab b " +
                "WHERE a.cod_dpd = b.cod_dpd " +
                "AND a.cod_azl = ? ";
        int i = 2;
        int indexDpd = 0;
        if (lCOD_DPD != 0) {
            Sql += " AND b.cod_dpd = ? ";
            indexDpd = i++;
        }
        int indexUsd = 0;
        if (USD_UTN != null) {
            Sql += " AND UPPER(a.usd_utn) LIKE ? ";
            indexUsd = i++;
        }
        int indexSta = 0;
        if (STA_UTN != null) {
            Sql += " AND UPPER(a.sta_utn) LIKE ? ";
            indexSta = i++;
        }
        int indexAtt = 0;
        if (DAT_ATT != null) {
            Sql += " AND a.dat_att = ? ";
            indexAtt = i++;
        }
        int indexDis = 0;
        if (DAT_DIS != null) {
            Sql += " AND a.dat_dis = ? ";
            indexDis = i++;
        }
        Sql += " ORDER BY b.cog_dpd ";
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(Sql);
            ps.setLong(1, COD_AZL);
            if (indexDpd != 0) {
                ps.setLong(indexDpd, lCOD_DPD);
            }
            if (indexUsd != 0) {
                ps.setString(indexUsd, USD_UTN.toUpperCase() + "%");
            }
            if (indexSta != 0) {
                ps.setString(indexSta, STA_UTN.toUpperCase() + "%");
            }
            if (indexAtt != 0) {
                ps.setDate(indexAtt, DAT_ATT);
            }
            if (indexDis != 0) {
                ps.setDate(indexDis, DAT_DIS);
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                findEx_utn obj = new findEx_utn();
                obj.MTR_DPD = rs.getString(1);
                obj.NOM_DPD = rs.getString(2);
                obj.COG_DPD = rs.getString(3);
                obj.COD_UTN = rs.getLong(4);
                obj.USD_UTN = rs.getString(5);
                obj.STA_UTN = rs.getString(6);
                obj.DAT_ATT = rs.getDate(7);
                obj.DAT_DIS = rs.getDate(8);
                obj.COD_DPD = rs.getLong(9);
                obj.COD_AZL = rs.getLong(10);
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

    public Collection getUserS2S(String user) {
        BMPConnection bmp = getConnection();
        boolean result = false;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "   codice, " +
                    "   login, " +
                    "   password, " +
                    "   cod_dpd, " +
                    "   login_as " +
                    "FROM " +
                    "   view_sc_users " +
                    "WHERE " +
                    "   login=? " +
                    "ORDER BY " +
                    "   login_as");
            ps.setString(1, user);
            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                view_sc_users obj = new view_sc_users();
                obj.CODICE = rs.getLong(1);
                obj.LOGIN = rs.getString(2);
                obj.PASSWORD = rs.getString(3);
                obj.COD_DPD = rs.getLong(4);
                obj.LOGIN_AS = rs.getString(5);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getUserS2S(String user, String password) {
        BMPConnection bmp = getConnection();
        boolean result = false;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "   codice, " +
                    "   login, " +
                    "   password, " +
                    "   cod_dpd, " +
                    "   login_as " +
                    "FROM " +
                    "   view_sc_users " +
                    "WHERE " +
                    "   login=? and " +
                    "   password=? ");
            ps.setString(1, user);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                view_sc_users obj = new view_sc_users();
                obj.CODICE = rs.getLong(1);
                obj.LOGIN = rs.getString(2);
                obj.PASSWORD = rs.getString(3);
                obj.COD_DPD = rs.getLong(4);
                obj.LOGIN_AS = rs.getString(5);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public int deleteUserS2S(String user) {
        BMPConnection bmp = getConnection();
        int rowDeleted = 0;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM " +
                    "   ana_utn_tab " +
                    "WHERE " +
                    "   usd_utn=? ");
            ps.setString(1, user);
            rowDeleted = ps.executeUpdate();
            return rowDeleted;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public int deleteUserS2S(String user, String password) {
        BMPConnection bmp = getConnection();
        int rowDeleted = 0;
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM " +
                    "   ana_utn_tab " +
                    "WHERE " +
                    "   usd_utn=? and " +
                    "   psw_utn=? ");
            ps.setString(1, user);
            ps.setString(2, password);
            rowDeleted = ps.executeUpdate();
            return rowDeleted;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//</comment>
///////////ATTENTION!!////////////////////////////////////////
}
