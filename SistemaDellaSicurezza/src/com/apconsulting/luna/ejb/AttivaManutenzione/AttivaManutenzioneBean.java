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
package com.apconsulting.luna.ejb.AttivaManutenzione;

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
public class AttivaManutenzioneBean extends BMPEntityBean implements IAttivaManutenzione, IAttivaManutenzioneHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    //   *require Fields*
    String DES_ATI_MNT_MAC;
    long COD_MAC;
    long COD_MNT_MAC;
    //   * no require Fields*
    String ATI_MNT_PER;
    long PER_ATI_MNT_MES;
    java.sql.Date DAT_PAR_MNT_MAC;
    //</comment>
    long COD_SCH_ATI_MNT;
    String ATI_SVO;
    String ESI_ATI_MNT;
    java.sql.Date DAT_ATI_MNT;
    java.sql.Date DAT_PIF_INR;
////////////////////////// CONSTRUCTOR//////////////////////////////////////////
    private static AttivaManutenzioneBean ys = null;

    private AttivaManutenzioneBean() {
    }

    public static AttivaManutenzioneBean getInstance() {
        if (ys == null) {
            ys = new AttivaManutenzioneBean();
        }
        return ys;
    }
////////////////////////////////////////////////////////////////////////////////

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IAttivaManutenzione create(String strDES_ATI_MNT_MAC, long iCOD_MAC) throws RemoteException, CreateException {
        AttivaManutenzioneBean bean = new AttivaManutenzioneBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_ATI_MNT_MAC, iCOD_MAC);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_ATI_MNT_MAC, iCOD_MAC);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        AttivaManutenzioneBean iAttivaManutenzioneBean = new AttivaManutenzioneBean();
        try {
            Object obj = iAttivaManutenzioneBean.ejbFindByPrimaryKey((Long) primaryKey);
            iAttivaManutenzioneBean.setEntityContext(new EntityContextWrapper(obj));
            iAttivaManutenzioneBean.ejbActivate();
            iAttivaManutenzioneBean.ejbLoad();
            iAttivaManutenzioneBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IAttivaManutenzione findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        AttivaManutenzioneBean bean = new AttivaManutenzioneBean();
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

    // (Home Intrface) VIEWS  getAttivaManutenzione_UserID_View()
    public Collection getAttivaManutenzione_UserID_View() {
        return (new AttivaManutenzioneBean()).ejbGetAttivaManutenzione_UserID_View();
    }
    // (Home Intrface) VIEWS  getAttivaManutenzione_TAB_View(long newCOD_MAC, long newCOD_MNT_MAC)

    public Collection getAttivaManutenzione_TAB_View(long newCOD_MAC, long newCOD_MNT_MAC) {
        return (new AttivaManutenzioneBean()).ejbGetAttivaManutenzione_TAB_View(newCOD_MAC, newCOD_MNT_MAC);
    }

    public Collection getAttivaManutenzioneByMacchina(long lCOD_MAC) {
        return (new AttivaManutenzioneBean()).ejbGetAttivaManutenzioneByMacchina(lCOD_MAC);
    }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</IAttivaManutenzioneHome-implementation>
    public Long ejbCreate(String strDES_ATI_MNT_MAC, long iCOD_MAC) {
        this.COD_MAC = iCOD_MAC;
        this.DES_ATI_MNT_MAC = strDES_ATI_MNT_MAC;
        this.COD_MNT_MAC = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_ati_mnt_mac_tab (cod_mnt_mac,des_ati_mnt_mac,cod_mac) VALUES(?,?,?)");
            ps.setLong(1, COD_MNT_MAC);
            ps.setString(2, DES_ATI_MNT_MAC);
            ps.setLong(3, COD_MAC);
            ps.executeUpdate();
            return new Long(COD_MNT_MAC);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strDES_ATI_MNT_MAC, long iCOD_MAC) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_mnt_mac, cod_mac FROM ana_ati_mnt_mac_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
                al.add(new Long(rs.getLong(2)));
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
        this.COD_MNT_MAC = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_MNT_MAC = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_ati_mnt_mac_tab  WHERE cod_mnt_mac=?");
            ps.setLong(1, COD_MNT_MAC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.DES_ATI_MNT_MAC = rs.getString("DES_ATI_MNT_MAC");
                this.PER_ATI_MNT_MES = rs.getLong("PER_ATI_MNT_MES");
                this.ATI_MNT_PER = rs.getString("ATI_MNT_PER");
                this.COD_MAC = rs.getLong("COD_MAC");
                this.DAT_PAR_MNT_MAC = rs.getDate("DAT_PAR_MNT_MAC");
            } else {
                throw new NoSuchEntityException("AttivaManutenzione con ID=" + COD_MNT_MAC + " non è trovato");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_ati_mnt_mac_tab  WHERE cod_mnt_mac=? AND cod_mac=?");
            ps.setLong(1, COD_MNT_MAC);
            ps.setLong(2, COD_MAC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AttivaManutenzione con ID=" + COD_MNT_MAC + "  non è trovato");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_ati_mnt_mac_tab  SET des_ati_mnt_mac=?, ati_mnt_per=?, per_ati_mnt_mes=?, dat_par_mnt_mac=?, cod_mac=? WHERE cod_mnt_mac=?");
            ps.setString(1, DES_ATI_MNT_MAC);
            ps.setString(2, ATI_MNT_PER);
            ps.setLong(3, PER_ATI_MNT_MES);
            ps.setDate(4, DAT_PAR_MNT_MAC);
            ps.setLong(5, COD_MAC);
            ps.setLong(6, COD_MNT_MAC);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AttivaManutenzione con ID=" + COD_MNT_MAC + " non è trovato");
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
    public long getCOD_MNT_MAC() {
        return COD_MNT_MAC;
    }
    //----2

    public void setDES_ATI_MNT_MAC(String newDES_ATI_MNT_MAC) {
        if (DES_ATI_MNT_MAC.equals(newDES_ATI_MNT_MAC)) {
            return;
        }
        DES_ATI_MNT_MAC = newDES_ATI_MNT_MAC;
        setModified();
    }

    public String getDES_ATI_MNT_MAC() {
        return DES_ATI_MNT_MAC;
    }
    //-----3

    public void setATI_MNT_PER(String newATI_MNT_PER) {
        if ((ATI_MNT_PER != null) && (ATI_MNT_PER.equals(newATI_MNT_PER))) {
            return;
        }
        ATI_MNT_PER = newATI_MNT_PER;
        setModified();
    }

    public String getATI_MNT_PER() {
        return ATI_MNT_PER;
    }
    //-----4

    public void setCOD_MAC(long newCOD_MAC) {
        if (COD_MAC == newCOD_MAC) {
            return;
        }
        COD_MAC = newCOD_MAC;
        setModified();
    }

    public long getCOD_MAC() {
        return COD_MAC;
    }
    //-----5

    public void setPER_ATI_MNT_MES(long newPER_ATI_MNT_MES) {
        if (PER_ATI_MNT_MES == newPER_ATI_MNT_MES) {
            return;
        }
        PER_ATI_MNT_MES = newPER_ATI_MNT_MES;
        setModified();
    }

    public long getPER_ATI_MNT_MES() {
        return PER_ATI_MNT_MES;
    }
    //-----6

    public void setDAT_PAR_MNT_MAC(java.sql.Date newDAT_PAR_MNT_MAC) {
        if (DAT_PAR_MNT_MAC != null) {
            if (DAT_PAR_MNT_MAC.equals(newDAT_PAR_MNT_MAC)) {
                return;
            }
        }
        DAT_PAR_MNT_MAC = newDAT_PAR_MNT_MAC;
        setModified();
    }

    public java.sql.Date getDAT_PAR_MNT_MAC() {
        return DAT_PAR_MNT_MAC;
    }
    //-------------------
    //</comment>
///**********************************************************
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>

    //<comment description="extended setters/getters">
    public Collection ejbGetAttivaManutenzione_UserID_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  a.cod_mnt_mac, a.cod_mac, a.des_ati_mnt_mac, a.per_ati_mnt_mes, ati_mnt_per, a.dat_par_mnt_mac,b.des_mac from    ana_ati_mnt_mac_tab a, ana_mac_tab b where a.cod_mac = b.cod_mac order by a.des_ati_mnt_mac ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivaManutenzione_UserID_View obj = new AttivaManutenzione_UserID_View();
                obj.COD_MNT_MAC = rs.getLong(1);
                obj.COD_MAC = rs.getLong(2);
                obj.DES_ATI_MNT_MAC = rs.getString(3);
                obj.strPER_ATI_MNT_MES = rs.getString(4);
                obj.strATI_MNT_PER = rs.getString(5);
                if (obj.strATI_MNT_PER != null) {
                    if (obj.strATI_MNT_PER.equals("S")) {
                        obj.strNB_ATI_MNT_PER = "SI";
                    } else {
                        obj.strNB_ATI_MNT_PER = "NO";
                    }
                }
                obj.dtDAT_PAR_MNT_MAC = rs.getDate(6);
                obj.strDES_MAC = rs.getString(7);
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

    public Collection ejbGetAttivaManutenzioneByMacchina(long lCOD_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("select  a.cod_mnt_mac, a.cod_mac, a.des_ati_mnt_mac, a.per_ati_mnt_mes, ati_mnt_per, a.dat_par_mnt_mac,b.des_mac from    ana_ati_mnt_mac_tab a, ana_mac_tab b where a.cod_mac = b.cod_mac and a.cod_mac=? ");
            ps.setLong(1, lCOD_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivaManutenzione_UserID_View obj = new AttivaManutenzione_UserID_View();
                obj.COD_MNT_MAC = rs.getLong(1);
                obj.COD_MAC = rs.getLong(2);
                obj.DES_ATI_MNT_MAC = rs.getString(3);
                obj.strPER_ATI_MNT_MES = rs.getString(4);
                obj.strATI_MNT_PER = rs.getString(5);
                if (obj.strATI_MNT_PER.equals("S")) {
                    obj.strNB_ATI_MNT_PER = "SI";
                }
                if (obj.strATI_MNT_PER.equals("N")) {
                    obj.strNB_ATI_MNT_PER = "NO";
                }
                obj.dtDAT_PAR_MNT_MAC = rs.getDate(6);
                obj.strDES_MAC = rs.getString(7);
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

    //----FOR TAB VIEW ---------------
    public Collection ejbGetAttivaManutenzione_TAB_View(long newCOD_MAC, long newCOD_MNT_MAC) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    (SQLContainer.getEjbGetAttivaManutenzione_TAB_View());
            ps.setLong(1, newCOD_MAC);
            ps.setLong(2, newCOD_MNT_MAC);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivaManutenzione_TAB_View obj = new AttivaManutenzione_TAB_View();
                obj.COD_SCH_ATI_MNT = rs.getLong(1);
                obj.ATI_SVO = rs.getString(2);
                obj.ESI_ATI_MNT = rs.getString(3);
                obj.DAT_ATI_MNT = rs.getDate(4);
                obj.DAT_PIF_INR = rs.getDate(5);
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

    public Collection findEx(String strDES_ATI_MNT_MAC,
            Long lCOD_MAC,
            java.sql.Date DAT_PAR_MNT_MAC,
            Long lPER_ATI_MNT_MES,
            String strATI_MNT_PER,
            int iOrderParameter /*not used for now*/) {
        return (new AttivaManutenzioneBean()).ejbFindEx(strDES_ATI_MNT_MAC,
                lCOD_MAC,
                DAT_PAR_MNT_MAC,
                lPER_ATI_MNT_MES,
                strATI_MNT_PER,
                iOrderParameter);
    }

    public Collection ejbFindEx(String DES_ATI_MNT_MAC,
            Long lCOD_MAC,
            java.sql.Date DAT_PAR_MNT_MAC,
            Long PER_ATI_MNT_MES,
            String ATI_MNT_PER,
            int iOrderParameter /*not used for now*/) {

        String strSql = "select  a.cod_mnt_mac, a.cod_mac, a.des_ati_mnt_mac, a.per_ati_mnt_mes, ati_mnt_per, a.dat_par_mnt_mac, b.des_mac FROM ana_ati_mnt_mac_tab a, ana_mac_tab b WHERE a.cod_mac = b.cod_mac ";
        if (DES_ATI_MNT_MAC != null) {
            strSql += " AND UPPER(A.DES_ATI_MNT_MAC) LIKE ?";
        }

        if (PER_ATI_MNT_MES != null) {
            strSql += " AND A.PER_ATI_MNT_MES = ?";
        }

        if (ATI_MNT_PER != null) {
            strSql += " AND UPPER(A.ATI_MNT_PER) LIKE ?";
        }

        if (DAT_PAR_MNT_MAC != null) {
            strSql += " AND A.DAT_PAR_MNT_MAC = ?";
        }

        if (lCOD_MAC != null) {
            strSql += " AND A.COD_MAC = ?";
        }
        strSql += " order by UPPER(a.des_ati_mnt_mac) ";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);

            if (DES_ATI_MNT_MAC != null) {
                ps.setString(i++, DES_ATI_MNT_MAC.toUpperCase());
            }

            if (PER_ATI_MNT_MES != null) {
                ps.setLong(i++, PER_ATI_MNT_MES.longValue());
            }

            if (ATI_MNT_PER != null) {
                ps.setString(i++, ATI_MNT_PER.toUpperCase());
            }

            if (DAT_PAR_MNT_MAC != null) {
                ps.setDate(i++, DAT_PAR_MNT_MAC);
            }

            if (lCOD_MAC != null) {
                ps.setLong(i++, lCOD_MAC.longValue());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AttivaManutenzione_UserID_View obj = new AttivaManutenzione_UserID_View();
                obj.COD_MNT_MAC = rs.getLong(1);
                obj.COD_MAC = rs.getLong(2);
                obj.DES_ATI_MNT_MAC = rs.getString(3);
                obj.strPER_ATI_MNT_MES = rs.getString(4);
                obj.strATI_MNT_PER = rs.getString(5);
                if (obj.strATI_MNT_PER.equals("S")) {
                    obj.strNB_ATI_MNT_PER = "SI";
                }
                if (obj.strATI_MNT_PER.equals("N")) {
                    obj.strNB_ATI_MNT_PER = "NO";
                }
                obj.dtDAT_PAR_MNT_MAC = rs.getDate(6);
                obj.strDES_MAC = rs.getString(7);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  AttivaManutenzioneBean"/>
