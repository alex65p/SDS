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
package com.apconsulting.luna.ejb.SediAziendali;

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
public class SitaAziendeBean extends BMPEntityBean implements ISitaAziendeHome, ISitaAziende {
//  Zdes opredeliajutsia peremennie EJB obiekta
//<comment description="Member Variables">

    long COD_SIT_AZL;      //1
    long COD_AZL;          //2
    String NOM_SIT_AZL;    //3
    String IDZ_SIT_AZL;    //4
    String CIT_SIT_AZL;    //5
//------------------------
    String NUM_CIC_SIT_AZL;//6
    String PRV_SIT_AZL;    //7
    String CAP_SIT_AZL;    //8
//</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static SitaAziendeBean ys = null;

    private SitaAziendeBean() {
    }

    public static SitaAziendeBean getInstance() {
        if (ys == null) {
            ys = new SitaAziendeBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
// (Home Intrface) create()
    public ISitaAziende create(long lCOD_AZL, String strNOM_SIT_AZL, String strIDZ_SIT_AZL, String strCIT_SIT_AZL) throws CreateException {
        SitaAziendeBean bean = new SitaAziendeBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_AZL, strNOM_SIT_AZL, strIDZ_SIT_AZL, strCIT_SIT_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_AZL, strNOM_SIT_AZL, strIDZ_SIT_AZL, strCIT_SIT_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    public ISitaAziende create(long lCOD_SIT_AZL, long lCOD_AZL, String strNOM_SIT_AZL, String strIDZ_SIT_AZL, String strCIT_SIT_AZL) throws CreateException {
        SitaAziendeBean bean = new SitaAziendeBean();
        try {
            Object primaryKey = bean.ejbCreate(lCOD_SIT_AZL, lCOD_AZL, strNOM_SIT_AZL, strIDZ_SIT_AZL, strCIT_SIT_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_AZL, strNOM_SIT_AZL, strIDZ_SIT_AZL, strCIT_SIT_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

// (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        SitaAziendeBean iSitaAziendeBean = new SitaAziendeBean();
        try {
            Object obj = iSitaAziendeBean.ejbFindByPrimaryKey((Long) primaryKey);
            iSitaAziendeBean.setEntityContext(new EntityContextWrapper(obj));
            iSitaAziendeBean.ejbActivate();
            iSitaAziendeBean.ejbLoad();
            iSitaAziendeBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
// (Home Intrface) findByPrimaryKey()

    public ISitaAziende findByPrimaryKey(Long primaryKey) throws FinderException {
        SitaAziendeBean bean = new SitaAziendeBean();
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
    public Collection getSiteAziendaleByAZLID_View(long AZL_ID) {
        return (new SitaAziendeBean()).ejbGetSiteAziendaleByAZLID_View(AZL_ID);
    }

//<report>
    public Collection getNonEmptySiteAziendaleByAZLID_View(long AZL_ID) {
        return this.ejbGetNonEmptySiteAziendaleByAZLID_View(AZL_ID);
    }

//</report>
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
//</IAziendaHome-implementation>
    public Long ejbCreate(long lCOD_AZL, String strNOM_SIT_AZL, String strIDZ_SIT_AZL, String strCIT_SIT_AZL) {
        this.COD_AZL = lCOD_AZL;
        this.NOM_SIT_AZL = strNOM_SIT_AZL;
        this.IDZ_SIT_AZL = strIDZ_SIT_AZL;
        this.CIT_SIT_AZL = strCIT_SIT_AZL;
        this.COD_SIT_AZL = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_sit_azl_tab (cod_sit_azl,cod_azl,nom_sit_azl, idz_sit_azl, cit_sit_azl) VALUES(?,?,?,?,?)");
            ps.setLong(1, COD_SIT_AZL);
            ps.setLong(2, COD_AZL);
            ps.setString(3, NOM_SIT_AZL);
            ps.setString(4, IDZ_SIT_AZL);
            ps.setString(5, CIT_SIT_AZL);
            ps.executeUpdate();
            return new Long(COD_SIT_AZL);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbCreate(long lCOD_SIT_AZL, long lCOD_AZL, String strNOM_SIT_AZL, String strIDZ_SIT_AZL, String strCIT_SIT_AZL) {
        this.COD_AZL = lCOD_AZL;
        this.NOM_SIT_AZL = strNOM_SIT_AZL;
        this.IDZ_SIT_AZL = strIDZ_SIT_AZL;
        this.CIT_SIT_AZL = strCIT_SIT_AZL;
        this.COD_SIT_AZL = lCOD_SIT_AZL; // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_sit_azl_tab (cod_sit_azl,cod_azl,nom_sit_azl, idz_sit_azl, cit_sit_azl) VALUES(?,?,?,?,?)");
            ps.setLong(1, COD_SIT_AZL);
            ps.setLong(2, COD_AZL);
            ps.setString(3, NOM_SIT_AZL);
            ps.setString(4, IDZ_SIT_AZL);
            ps.setString(5, CIT_SIT_AZL);
            ps.executeUpdate();
            return new Long(COD_SIT_AZL);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(long lCOD_AZL, String strNOM_SIT_AZL, String strIDZ_SIT_AZL, String strCIT_SIT_AZL) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_sit_azl FROM ana_sit_azl_tab ");
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
        this.COD_SIT_AZL = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_SIT_AZL = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_sit_azl_tab  WHERE cod_sit_azl=?");
            ps.setLong(1, COD_SIT_AZL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_SIT_AZL = rs.getLong("COD_SIT_AZL");   //1
                this.COD_AZL = rs.getLong("COD_AZL");           //2
                this.NOM_SIT_AZL = rs.getString("NOM_SIT_AZL"); //3
                this.IDZ_SIT_AZL = rs.getString("IDZ_SIT_AZL"); //4
                this.CIT_SIT_AZL = rs.getString("CIT_SIT_AZL"); //5
//-------------------------
                this.NUM_CIC_SIT_AZL = rs.getString("NUM_CIC_SIT_AZL");//6
                this.PRV_SIT_AZL = rs.getString("PRV_SIT_AZL");        //7
                this.CAP_SIT_AZL = rs.getString("CAP_SIT_AZL");        //8

            } else {
                throw new NoSuchEntityException("SitaAziende con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM ana_sit_azl_tab  WHERE cod_sit_azl=?");
            ps.setLong(1, COD_SIT_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("SitaAziende con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_sit_azl_tab  SET cod_azl=?, nom_sit_azl=?, idz_sit_azl=?,num_cic_sit_azl=?,cit_sit_azl=?,prv_sit_azl=?,cap_sit_azl=?  WHERE cod_sit_azl=?");
            ps.setLong(1, COD_AZL);
            ps.setString(2, NOM_SIT_AZL);
            ps.setString(3, IDZ_SIT_AZL);
            ps.setString(4, NUM_CIC_SIT_AZL);
            ps.setString(5, CIT_SIT_AZL);
            ps.setString(6, PRV_SIT_AZL);
            ps.setString(7, CAP_SIT_AZL);
//---------------------------
            ps.setLong(8, COD_SIT_AZL);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("SitaAziende con ID= non è trovata");
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
//------------------------
    public void setCOD_AZL_NOM_SIT_AZL(long newCOD_AZL, String newNOM_SIT_AZL) {
        if ((COD_AZL == newCOD_AZL) & (NOM_SIT_AZL.equals(newNOM_SIT_AZL))) {
            return;
        }
        COD_AZL = newCOD_AZL;
        NOM_SIT_AZL = newNOM_SIT_AZL;
        setModified();
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }
//2

    public String getNOM_SIT_AZL() {
        if (NOM_SIT_AZL == null) {
            return "";
        } else {
            return NOM_SIT_AZL;
        }
    }
//3

    public void setIDZ_SIT_AZL(String newIDZ_SIT_AZL) {
        if (IDZ_SIT_AZL.equals(newIDZ_SIT_AZL)) {
            return;
        }
        IDZ_SIT_AZL = newIDZ_SIT_AZL;
        setModified();
    }

    public String getIDZ_SIT_AZL() {
        if (IDZ_SIT_AZL == null) {
            return "";
        } else {
            return IDZ_SIT_AZL;
        }
    }
//4

    public void setCIT_SIT_AZL(String newCIT_SIT_AZL) {
        if (CIT_SIT_AZL.equals(newCIT_SIT_AZL)) {
            return;
        }
        CIT_SIT_AZL = newCIT_SIT_AZL;
        setModified();
    }

    public String getCIT_SIT_AZL() {
        if (CIT_SIT_AZL == null) {
            return "";
        } else {
            return CIT_SIT_AZL;
        }
    }

    public long getCOD_SIT_AZL() {
        return COD_SIT_AZL;
    }
//============================================
// not required field

//5
    public void setNUM_CIC_SIT_AZL(String newNUM_CIC_SIT_AZL) {
        if (NUM_CIC_SIT_AZL != null) {
            if (NUM_CIC_SIT_AZL.equals(newNUM_CIC_SIT_AZL)) {
                return;
            }
        }
        NUM_CIC_SIT_AZL = newNUM_CIC_SIT_AZL;
        setModified();
    }

    public String getNUM_CIC_SIT_AZL() {
        if (NUM_CIC_SIT_AZL == null) {
            return "";
        } else {
            return NUM_CIC_SIT_AZL;
        }
    }

//6
    public void setPRV_SIT_AZL(String newPRV_SIT_AZL) {
        if (PRV_SIT_AZL != null) {
            if (PRV_SIT_AZL.equals(newPRV_SIT_AZL)) {
                return;
            }
        }
        PRV_SIT_AZL = newPRV_SIT_AZL;
        setModified();
    }

    public String getPRV_SIT_AZL() {
        if (PRV_SIT_AZL == null) {
            return "";
        } else {
            return PRV_SIT_AZL;
        }
    }
//7

    public void setCAP_SIT_AZL(String newCAP_SIT_AZL) {
        if (CAP_SIT_AZL != null) {
            if (CAP_SIT_AZL.equals(newCAP_SIT_AZL)) {
                return;
            }
        }
        CAP_SIT_AZL = newCAP_SIT_AZL;
        setModified();
    }

    public String getCAP_SIT_AZL() {
        if (CAP_SIT_AZL == null) {
            return "";
        } else {
            return CAP_SIT_AZL;
        }
    }

//</comment>
///////////ATTENTION!!//////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody-views"/>
//<comment description="extended setters/getters">
    public Collection ejbGetSiteAziendaleByAZLID_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "cod_sit_azl, "
                        + "nom_sit_azl, "
                        + "idz_sit_azl, "
                        + "num_cic_sit_azl, "
                        + "cit_sit_azl, "
                        + "prv_sit_azl, "
                        + "cap_sit_azl "
                    + "FROM "
                        + "ana_sit_azl_tab "
                    + "WHERE "
                        + "cod_azl=? "
                    + "ORDER BY "
                        + "nom_sit_azl");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SiteAziendaleByAZLID_View obj = new SiteAziendaleByAZLID_View();
                obj.COD_SIT_AZL = rs.getLong(1);
                obj.NOM_SIT_AZL = rs.getString(2);
                obj.IDZ_SIT_AZL = rs.getString(3);
                obj.NUM_CIC_SIT_AZL = rs.getString(4);
                obj.CIT_SIT_AZL = rs.getString(5);
                obj.PRV_SIT_AZL = rs.getString(6);
                obj.CAP_SIT_AZL = rs.getString(7);
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

//<comment description="extended setters/getters">
    public Collection ejbGetNonEmptySiteAziendaleByAZLID_View(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                        + "a.COD_SIT_AZL, "
                        + "a.NOM_SIT_AZL "
                    + "FROM "
                        + "ANA_SIT_AZL_TAB a "
                    + "WHERE "
                        + "A.COD_AZL = ? "
                        + "AND EXISTS "
                            + "(SELECT "
                                + "'x' "
                            + "FROM "
                                + "ana_luo_fsc_tab b "
                            + "WHERE "
                                + "b.cod_sit_azl = a.cod_sit_azl "
                                + "AND B.COD_AZL = ?) " +
                    "ORDER BY 2");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SiteAziendaleByAZLID_View obj = new SiteAziendaleByAZLID_View();
                obj.COD_SIT_AZL = rs.getLong(1);
                obj.NOM_SIT_AZL = rs.getString(2);
                /*
                obj.IDZ_SIT_AZL=rs.getString(3);
                obj.NUM_CIC_SIT_AZL=rs.getString(4);
                obj.CIT_SIT_AZL=rs.getString(5);
                obj.PRV_SIT_AZL=rs.getString(6);
                obj.CAP_SIT_AZL=rs.getString(7);
                 */
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

    public Collection findEx(long AZL_ID,
            String NOM_SIT_AZL,
            String IDZ_SIT_AZL,
            String NUM_CIC_SIT_AZL,
            String CIT_SIT_AZL,
            String PRV_SIT_AZL,
            String CAP_SIT_AZL,
            int iOrderParameter) {
        return (new SitaAziendeBean()).ejbFindEx(AZL_ID,
                NOM_SIT_AZL,
                IDZ_SIT_AZL,
                NUM_CIC_SIT_AZL,
                CIT_SIT_AZL,
                PRV_SIT_AZL,
                CAP_SIT_AZL,
                iOrderParameter);
    }

    public Collection ejbFindEx(long AZL_ID,
            String NOM_SIT_AZL,
            String IDZ_SIT_AZL,
            String NUM_CIC_SIT_AZL,
            String CIT_SIT_AZL,
            String PRV_SIT_AZL,
            String CAP_SIT_AZL,
            int iOrderParameter) {

        String strSql = 
                "SELECT "
                    + "cod_sit_azl, "
                    + "UPPER(nom_sit_azl) AS nom_sit_azl, "
                    + "idz_sit_azl, "
                    + "num_cic_sit_azl, "
                    + "cit_sit_azl, "
                    + "prv_sit_azl, "
                    + "cap_sit_azl  "
                + "FROM "
                    + "ana_sit_azl_tab b "
                + "WHERE "
                    + "b.cod_azl=?";

        if (NOM_SIT_AZL != null) {
            strSql = strSql + " AND UPPER(b.nom_sit_azl) LIKE ?";
        }

        if (IDZ_SIT_AZL != null) {
            strSql = strSql + " AND UPPER(b.idz_sit_azl) LIKE ?";
        }

        if (NUM_CIC_SIT_AZL != null) {
            strSql = strSql + " AND UPPER(b.num_cic_sit_azl) LIKE ?";
        }

        if (CIT_SIT_AZL != null) {
            strSql = strSql + " AND UPPER(b.cit_sit_azl) LIKE ?";
        }

        if (PRV_SIT_AZL != null) {
            strSql = strSql + " AND UPPER(b.prv_sit_azl) LIKE ?";
        }

        if (CAP_SIT_AZL != null) {
            strSql = strSql + " AND UPPER(b.cap_sit_azl) LIKE ?";
        }
        strSql += " ORDER BY 2";

        int i = 1;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(i++, AZL_ID);

            if (NOM_SIT_AZL != null) {
                ps.setString(i++, NOM_SIT_AZL.toUpperCase());
            }

            if (IDZ_SIT_AZL != null) {
                ps.setString(i++, IDZ_SIT_AZL.toUpperCase());
            }

            if (NUM_CIC_SIT_AZL != null) {
                ps.setString(i++, NUM_CIC_SIT_AZL.toUpperCase());
            }

            if (CIT_SIT_AZL != null) {
                ps.setString(i++, CIT_SIT_AZL.toUpperCase());
            }

            if (PRV_SIT_AZL != null) {
                ps.setString(i++, PRV_SIT_AZL.toUpperCase());
            }

            if (CAP_SIT_AZL != null) {
                ps.setString(i++, CAP_SIT_AZL.toUpperCase());
            }
//----------------------------------------------------------------------
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                SiteAziendaleByAZLID_View obj = new SiteAziendaleByAZLID_View();
                obj.COD_SIT_AZL = rs.getLong(1);
                obj.NOM_SIT_AZL = rs.getString(2);
                obj.IDZ_SIT_AZL = rs.getString(3);
                obj.NUM_CIC_SIT_AZL = rs.getString(4);
                obj.CIT_SIT_AZL = rs.getString(5);
                obj.PRV_SIT_AZL = rs.getString(6);
                obj.CAP_SIT_AZL = rs.getString(7);
                al.add(obj);
            }
            return al;
//----------------------------------------------------------------------
        } catch (Exception ex) {
            throw new EJBException(strSql + "\n" + ex);
        } finally {
            bmp.close();
        }
    }
///////////ATTENTION!!////////////////////////////////////////
}
