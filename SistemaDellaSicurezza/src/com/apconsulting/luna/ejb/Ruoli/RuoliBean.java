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
package com.apconsulting.luna.ejb.Ruoli;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import java.util.Iterator;
import java.util.Vector;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;
import s2s.utils.plain.Formatter;

/**
 *
 * @author Dario
 */
public class RuoliBean extends BMPEntityBean implements IRuoli, IRuoliHome {
    //<comment description="Member Variables">

    long COD_RUO;          //1
    String NOM_RUO;          //2
    String DES_RUO;          //3
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static RuoliBean ys = null;

    private RuoliBean() {
        //
    }

    public static RuoliBean getInstance() {
        if (ys == null) {
            ys = new RuoliBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!///////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public IRuoli create(String strNOM_RUO, String strDES_RUO) throws CreateException {
        RuoliBean bean = new RuoliBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_RUO, strDES_RUO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_RUO, strDES_RUO);
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        RuoliBean iRuoliBean = new RuoliBean();
        try {
            Object obj = iRuoliBean.ejbFindByPrimaryKey((Long) primaryKey);
            iRuoliBean.setEntityContext(new EntityContextWrapper(obj));
            iRuoliBean.ejbActivate();
            iRuoliBean.ejbLoad();
            iRuoliBean.ejbRemove();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public IRuoli findByPrimaryKey(Long primaryKey) throws FinderException {
        RuoliBean bean = new RuoliBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    // (Home Intrface) findAll()

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }
    // (Home Intrface) VIEWS  getRuoliByID_View()

    public Collection getRuoliByID_View() {
        return (new RuoliBean()).ejbGetRuoliByID_View();
    }
    // (Home Intrface) VIEWS  getDES_FUZ_LNG_ByID_View(long lCOD_RUO)

    public Collection getDES_FUZ_LNG_ByID_View(long lCOD_RUO) {
        return (new RuoliBean()).ejbGetDES_FUZ_LNG_ByID_View(lCOD_RUO);
    }
    // (Home Intrface) VIEWS  getTIP_ACE_ByID_View(long COD_FUZ, long lCOD_RUO)

    public Collection getTIP_ACE_ByID_View(long COD_FUZ, long lCOD_RUO) {
        return (new RuoliBean()).ejbGetTIP_ACE_ByID_View(COD_FUZ, lCOD_RUO);
    }
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

    public String getRecurseFuz(long lCOD_RUO, long id, int iLev, Collection aVals) {
        String str = "";
        Iterator it_des = aVals.iterator();
        while (it_des.hasNext()) {
            DES_FUZ_LNG_ByID_View obj_des = (DES_FUZ_LNG_ByID_View) it_des.next();
            if (obj_des.COD_ASC == id) {
                String checkedG = "";
                String checkedL = "";
                String checkedN = "";
                if ("XXXXXXXXXXX0000".equals(obj_des.TIP_ACE)) {
                    checkedG = "checked";
                } else if ("X0X000XX0XX0000".equals(obj_des.TIP_ACE)) {
                    checkedL = "checked";
                } else {
                    checkedN = "checked";
                }
                str += "<tr INDEX='" + lCOD_RUO + "' ID='" + obj_des.COD_FUZ + "'>";

                str += "<td class='dataTd' nowrap>&nbsp;";
                for (int i = 0; i < iLev; i++) {
                    str += "&nbsp;&nbsp;&nbsp;&nbsp;";
                }

                String TEMP_DESC = "";
                try {
                    TEMP_DESC = ApplicationConfigurator.LanguageManager.getString(obj_des.DES_FUZ);
                } catch (Exception E) {
                    TEMP_DESC = obj_des.DES_FUZ + "*";
                }

                //str+=iLev+"&nbsp;<input name='DEZ_FUZ'  type='text' size=50 readonly  value=\""+Formatter.format(obj_des.DES_FUZ)+"\"></td>";
                str += "-&nbsp;" + Formatter.format(TEMP_DESC) + "</td>";

                str += "<td class='dataTd' align='center' width='100'><input id='" + obj_des.COD_FUZ + "T' name='" + obj_des.COD_FUZ + "T' class='checkbox' " + checkedG + " type='radio'   value=\"G\"></td>";
                str += "<td class='dataTd' align='center' width='100'><input id='" + obj_des.COD_FUZ + "T' name='" + obj_des.COD_FUZ + "T' class='checkbox' " + checkedL + " type='radio'   value=\"L\"></td>";
                str += "<td class='dataTd' align='center' width='100'><input id='" + obj_des.COD_FUZ + "T' name='" + obj_des.COD_FUZ + "T' class='checkbox' " + checkedN + " type='radio'   value=\"N\"></td>";
                str += "</tr>";

                str += getRecurseFuz(lCOD_RUO, obj_des.COD_FUZ, iLev + 1, aVals);
            }
        }
        return str;
    }

    private String excludedByModule(){
        String excludedFunction = "";
        if (ApplicationConfigurator.isModuleEnabled(MODULES.LUOGHI_FISICI_3_LIVELLI)){
            // Nel caso della gestione dei luoghi fisici su 3 livelli,
            // è disabilitata la voce immobili relativa alla gestione
            // degli stessi su 2 livelli.
            excludedFunction += "18";
        } else {
            // Nel caso della gestione dei luoghi fisici su 2 livelli,
            // è disabilitata la voce immobili relativa alla gestione
            // degli stessi su 3 livelli.
            excludedFunction += "132";
        }
        return !excludedFunction.equals("")
                ?" and ana_fuz_tab.cod_fuz not in (" + excludedFunction + ") ":"";
    }

    //</IRuoliHome-implementation>
    public Long ejbCreate(String strNOM_RUO, String strDES_RUO) {
        this.NOM_RUO = strNOM_RUO;
        this.DES_RUO = strDES_RUO;
        this.COD_RUO = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_ruo_tab (cod_ruo,nom_ruo,des_ruo) VALUES(?,?,?)");
            ps.setLong(1, COD_RUO);
            ps.setString(2, NOM_RUO);
            ps.setString(3, DES_RUO);
            ps.executeUpdate();
            return new Long(COD_RUO);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_RUO, String strDES_RUO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_ruo FROM ana_ruo_tab ");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                al.add(new Long(rs.getLong(1)));
            }
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
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
        this.COD_RUO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_RUO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_ruo_tab  WHERE cod_ruo=?");
            ps.setLong(1, COD_RUO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_RUO = rs.getString("NOM_RUO");
                this.DES_RUO = rs.getString("DES_RUO");
            } else {
                throw new NoSuchEntityException("Ruoli con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
            String sql1 = "DELETE FROM fuz_ruo_tab  WHERE cod_ruo=? ";
            String sql = "DELETE FROM ana_ruo_tab  WHERE cod_ruo=?";
            PreparedStatement ps1 = bmp.prepareStatement(sql1);
            PreparedStatement ps = bmp.prepareStatement(sql);
            ps1.setLong(1, this.COD_RUO);
            ps.setLong(1, this.COD_RUO);
            if (ps1.executeUpdate() != 0) {
                if (ps.executeUpdate() != 0) {
                    bmp.commitTrans();
                } else {
                    throw new NoSuchEntityException("Servizio con ID" + " non trovato.");
                }
            } else {
                throw new NoSuchEntityException("Servizio con ID" + " non trovato.");
            }
        } catch (Exception ex) {
            bmp.rollbackTrans();
            ex.printStackTrace();
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_ruo_tab  SET nom_ruo=?, des_ruo=? WHERE cod_ruo=?");
            ps.setString(1, NOM_RUO);
            ps.setString(2, DES_RUO);
            ps.setLong(3, COD_RUO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Ruoli con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
    public void setNOM_RUO(String newNOM_RUO) {
        if (NOM_RUO.equals(newNOM_RUO)) {
            return;
        }
        NOM_RUO = newNOM_RUO;
        setModified();
    }

    public String getNOM_RUO() {
        return NOM_RUO;
    }
    //2

    public void setDES_RUO(String newDES_RUO) {
        if (DES_RUO.equals(newDES_RUO)) {
            return;
        }
        DES_RUO = newDES_RUO;
        setModified();
    }

    public String getDES_RUO() {
        return DES_RUO;
    }
    //3

    public long getCOD_RUO() {
        return COD_RUO;
    }
    //</comment>
//------------------------------------------------------------------------------

    public Collection ejbGetRuoliByID_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT cod_ruo, nom_ruo, des_ruo  FROM  ana_ruo_tab order by nom_ruo");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                RuoliByID_View obj = new RuoliByID_View();
                obj.COD_RUO = rs.getLong(1);
                obj.NOM_RUO = rs.getString(2);
                obj.DES_RUO = rs.getString(3);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetDES_FUZ_LNG_ByID_View(long lCOD_RUO) {
        BMPConnection bmp = getConnection();
        try {
            String SQL =
                    "Select "
                    + "ana_fuz_tab.cod_fuz, "
                    + "des_fuz, "
                    + "tip_ace, "
                    + "cod_fuz_asc "
                    + "From "
                    + "ana_fuz_tab, "
                    + "fuz_ruo_tab, "
                    + "des_fuz_lng_tab "
                    + "Where "
                    + "ana_fuz_tab.cod_fuz = des_fuz_lng_tab.cod_fuz "
                    + "and ana_fuz_tab.cod_fuz = fuz_ruo_tab.cod_fuz "
                    + this.excludedByModule()
                    + "and cod_ruo = ? "
                    + "order by "
                    + "fnz_order";
            PreparedStatement ps = bmp.prepareStatement(SQL);
            ps.setLong(1, lCOD_RUO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                DES_FUZ_LNG_ByID_View obj = new DES_FUZ_LNG_ByID_View();
                obj.COD_FUZ = rs.getLong("cod_fuz");
                obj.DES_FUZ = rs.getString("des_fuz");
                obj.TIP_ACE = rs.getString("tip_ace");
                obj.COD_ASC = rs.getLong("cod_fuz_asc");
                if (rs.wasNull()) {
                    obj.COD_ASC = 0;
                }
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetTIP_ACE_ByID_View(long lCOD_FUZ, long lCOD_RUO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT tip_ace  FROM  fuz_ruo_tab WHERE cod_fuz=? AND cod_ruo=? ");
            ps.setLong(1, lCOD_FUZ);
            ps.setLong(2, lCOD_RUO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                TIP_ACE_ByID_View obj = new TIP_ACE_ByID_View();
                obj.TIP_ACE = rs.getString(1);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%Add to table FUZ_RUO_TAB%%%
    public void addTIP_ACE(long newCOD_RUO, long lCOD_FUZ, String strTIP_ACE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO fuz_ruo_tab (cod_ruo,cod_fuz,tip_ace) VALUES(?,?,?)");
            ps.setLong(1, newCOD_RUO);
            ps.setLong(2, lCOD_FUZ);
            ps.setString(3, strTIP_ACE);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%Set to table FUZ_RUO_TAB%%%
    public void setTIP_ACE(long newCOD_RUO, long lCOD_FUZ, String strTIP_ACE) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE fuz_ruo_tab  SET tip_ace=?  WHERE cod_ruo=? AND cod_fuz=?");
            ps.setString(1, strTIP_ACE);
            ps.setLong(2, newCOD_RUO);
            ps.setLong(3, lCOD_FUZ);
            long nUpd = ps.executeUpdate();
            if (nUpd == 0) {
                throw new NoSuchEntityException("Ruoli con ID= non è trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // %%%Delete from table FUZ_RUO_TAB%%%
    public void removeTIP_ACE(long newCOD_RUO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM fuz_ruo_tab  WHERE cod_ruo=? ");
            ps.setLong(1, newCOD_RUO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Ruoli con ID=" + newCOD_RUO + " non &egrave trovata");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Vector getCODFUZList() {
        Vector aRes = new Vector();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "Select "
                        + "COD_FUZ "
                    + "FROM "
                        + "ana_fuz_tab "
                    + "WHERE "
                        + "1=1 "
                        + this.excludedByModule()
                    + "Order by "
                        + "cod_fuz");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                aRes.add(new Long(rs.getLong("cod_fuz")));
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
        return aRes;
    }
///////////ATTENTION!!////////////////////////////////////////
}
