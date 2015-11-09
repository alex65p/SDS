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
package com.apconsulting.luna.ejb.CategorieFattoreRischio;

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
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
//public class CategorioRischioBean extends BMPEntityBean implements ICategorioRischioRemote
public class CategorioRischioBean extends BMPEntityBean implements ICategorioRischio, ICategorioRischioHome {
    //  Zdes opredeliajutsia peremennie EJB obiekta
    //<comment description="Member Variables">

    String NOM_CAG_FAT_RSO;     //1
    long COD_CAG_FAT_RSO;        //2
    //----------------------------
    String DES_CAG_FAT_RSO;     //3
    //</comment>
////////////////////// CONSTRUCTOR///////////////////
    private static CategorioRischioBean ys = null;

    private CategorioRischioBean() {
        //
    }

    public static CategorioRischioBean getInstance() {
        if (ys == null) {
            ys = new CategorioRischioBean();
        }
        return ys;
    }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>
    // (Home Intrface) create()
    public ICategorioRischio create(String strNOM_CAG_FAT_RSO) throws CreateException {
        CategorioRischioBean bean = new CategorioRischioBean();
        try {
            Object primaryKey = bean.ejbCreate(strNOM_CAG_FAT_RSO);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strNOM_CAG_FAT_RSO);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        CategorioRischioBean iCategorioRischioBean = new CategorioRischioBean();
        try {
            Object obj = iCategorioRischioBean.ejbFindByPrimaryKey((Long) primaryKey);
            iCategorioRischioBean.setEntityContext(new EntityContextWrapper(obj));
            iCategorioRischioBean.ejbActivate();
            iCategorioRischioBean.ejbLoad();
            iCategorioRischioBean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    // (Home Intrface) findByPrimaryKey()

    public ICategorioRischio findByPrimaryKey(Long primaryKey) throws FinderException {
        CategorioRischioBean bean = new CategorioRischioBean();
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

    // (Home Intrface) VIEWS  getCategorioRischio_Name_Address_View()
    public Collection getCategorioRischio_Name_Address_View() {
        return (new CategorioRischioBean()).ejbGetCategorioRischio_Name_Address_View();
    }

    public Collection getCategorio_FattoriRischio_View(long COD_CAG_FAT_RSO) {
        return (new CategorioRischioBean()).ejbGetCategorio_FattoriRischio_View(COD_CAG_FAT_RSO);
    }

    //<report>
    public Collection getCategorioRischio_LuogiFisici_View(long lCOD_AZL, long lCOD_UNI_ORG, long COD_CAG_FAT_RSO) {
        return this.ejbGetCategorioRischio_LuogiFisici_View(lCOD_AZL, lCOD_UNI_ORG, COD_CAG_FAT_RSO);
    }

    public Collection getCategorioRischio_Rischio_View(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_CAG_FAT_RSO) {
        return this.ejbGetCategorioRischio_Rischio_View(lCOD_AZL, lCOD_LUO_FSC, lCOD_CAG_FAT_RSO);
    }

    public Collection getCategorieWithRischi_View(long lCOD_AZL) {
        return this.ejbGetCategorieWithRischi_View(lCOD_AZL);
    }

    public Collection findEx(String strNOM_CAG_RSO, int iOrderParameter /*not used for now*/) {
        return (new CategorioRischioBean()).ejbFindEx(strNOM_CAG_RSO, iOrderParameter);
    }
    //</report>

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>
    //</ICategorioRischioHome-implementation>
    public Long ejbCreate(String strNOM_CAG_FAT_RSO) {
        this.NOM_CAG_FAT_RSO = strNOM_CAG_FAT_RSO;
        this.COD_CAG_FAT_RSO = NEW_ID(); // unic ID
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO cag_fat_rso_tab (cod_cag_fat_rso,nom_cag_fat_rso) VALUES(?,?)");
            ps.setLong(1, COD_CAG_FAT_RSO);
            ps.setString(2, NOM_CAG_FAT_RSO);
            ps.executeUpdate();
            return new Long(COD_CAG_FAT_RSO);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strNOM_CAG_FAT_RSO) {
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cag_fat_rso FROM cag_fat_rso_tab ");
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
        this.COD_CAG_FAT_RSO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.COD_CAG_FAT_RSO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM cag_fat_rso_tab  WHERE cod_cag_fat_rso=?");
            ps.setLong(1, COD_CAG_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.NOM_CAG_FAT_RSO = rs.getString("NOM_CAG_FAT_RSO");
                this.DES_CAG_FAT_RSO = rs.getString("DES_CAG_FAT_RSO");
            } else {
                throw new NoSuchEntityException("CategorioRischio con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cag_fat_rso_tab  WHERE cod_cag_fat_rso=?");
            ps.setLong(1, COD_CAG_FAT_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("CategorioRischio con ID= non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE cag_fat_rso_tab  SET nom_cag_fat_rso=?, des_cag_fat_rso=? WHERE cod_cag_fat_rso=?");
            ps.setString(1, NOM_CAG_FAT_RSO);
            ps.setString(2, DES_CAG_FAT_RSO);
            ps.setLong(3, COD_CAG_FAT_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("CategorioRischio con ID= non è trovata");
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
    public void setNOM_CAG_FAT_RSO(String newNOM_CAG_FAT_RSO) {
        if (NOM_CAG_FAT_RSO.equals(newNOM_CAG_FAT_RSO)) {
            return;
        }
        NOM_CAG_FAT_RSO = newNOM_CAG_FAT_RSO;
        setModified();
    }

    public String getNOM_CAG_FAT_RSO() {
        return NOM_CAG_FAT_RSO;
    }
    //2

    public long getCOD_CAG_FAT_RSO() {
        return COD_CAG_FAT_RSO;
    }
    //============================================
    // not required field
    //3

    public void setDES_CAG_FAT_RSO(String newDES_CAG_FAT_RSO) {
        if (DES_CAG_FAT_RSO != null) {
            if (DES_CAG_FAT_RSO.equals(newDES_CAG_FAT_RSO)) {
                return;
            }
        }
        DES_CAG_FAT_RSO = newDES_CAG_FAT_RSO;
        setModified();
    }

    public String getDES_CAG_FAT_RSO() {
        return DES_CAG_FAT_RSO;
    }

    //</comment>
    ///////////ATTENTION!!//////////////////////////////////////
    //<comment description="Zdes opredeliayutsia metody-views"/>
    //<comment description="extended setters/getters">
    public Collection ejbGetCategorioRischio_Name_Address_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_cag_fat_rso,nom_cag_fat_rso,des_cag_fat_rso FROM cag_fat_rso_tab ORDER BY nom_cag_fat_rso");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategorioRischio_Name_Address_View obj = new CategorioRischio_Name_Address_View();
                obj.COD_CAG_FAT_RSO = rs.getLong(1);
                obj.NOM_CAG_FAT_RSO = rs.getString(2);
                obj.DES_CAG_FAT_RSO = rs.getString(3);
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

    public Collection ejbFindEx(String strNOM_CAG_RSO,
            int iOrderParameter /*not used for now*/) {
        String strSQL = "SELECT cod_cag_fat_rso,nom_cag_fat_rso,des_cag_fat_rso FROM cag_fat_rso_tab WHERE 1<>2";
        if (strNOM_CAG_RSO != null) {
            strSQL += " AND UPPER(nom_cag_fat_rso) LIKE ?";
        }
        strSQL += " ORDER BY nom_cag_fat_rso";
        BMPConnection bmp = getConnection();
        int i = 0;
        try {
            PreparedStatement ps = bmp.prepareStatement(strSQL);
            if (strNOM_CAG_RSO != null) {
                ps.setString(1, strNOM_CAG_RSO.toUpperCase());
            }
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategorioRischio_Name_Address_View obj = new CategorioRischio_Name_Address_View();
                obj.COD_CAG_FAT_RSO = rs.getLong(1);
                obj.NOM_CAG_FAT_RSO = rs.getString(2);
                obj.DES_CAG_FAT_RSO = rs.getString(3);
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

    public Collection ejbGetCategorio_FattoriRischio_View(long lCOD_CAG_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT nom_cag_fat_rso FROM cag_fat_rso_tab WHERE cod_cag_fat_rso=? ");
            ps.setLong(1, lCOD_CAG_FAT_RSO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Categorio_FattoriRischio_View obj = new Categorio_FattoriRischio_View();
                obj.NOM_CAG_FAT_RSO = rs.getString(1);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    //<report>

    public Collection ejbGetCategorioRischio_LuogiFisici_View(long lCOD_AZL, long lCOD_UNI_ORG, long lCOD_CAG_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT " +
                    " b.cod_luo_fsc, " +
                    " B.NOM_LUO_FSC, " +
                    " P.NOM_PNO  " +
                    " FROM " +
                    " RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B LEFT OUTER JOIN ANA_PNO_TAB P ON (b.cod_pno=P.cod_pno), UNI_ORG_LUO_FSC_TAB A, ANA_RSO_TAB F " +
                    " WHERE " +
                    " C.PRS_RSO = 'S' " +
                    " AND C.COD_LUO_FSC = B.COD_LUO_FSC " +
                    " AND A.COD_LUO_FSC = B.COD_LUO_FSC " +
                    " AND F.cod_rso=C.COD_RSO " +
                    " AND F.cod_azl=C.cod_azl " +
                    " AND C.COD_AZL =? " +
                    " AND COD_UNI_ORG=? " +
                    " AND F.cod_rso=? " +
                    " ORDER BY B.NOM_LUO_FSC ");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_UNI_ORG);
            ps.setLong(3, lCOD_CAG_FAT_RSO);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategorioRischio_LuogiFisici_View obj = new CategorioRischio_LuogiFisici_View();
                obj.lCOD_LUO_FSC = rs.getLong(1);
                obj.strNOM_LUO_FSC = rs.getString(2);
                obj.strNOM_PNO = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection ejbGetCategorioRischio_Rischio_View(long lCOD_AZL, long lCOD_LUO_FSC, long lCOD_CAG_FAT_RSO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT DISTINCT " +
                    " F.cod_rso, " +
                    " F.nom_rso, " +
                    " F.des_rso, " +
                    " F.PRB_EVE_LES," +
                    " F.ENT_DAN," +
                    " F.STM_NUM_RSO" +
                    " FROM  " +
                    " RSO_LUO_FSC_TAB C, ANA_LUO_FSC_TAB B, UNI_ORG_LUO_FSC_TAB A, ANA_FAT_RSO_TAB D, ANA_RSO_TAB F " +
                    " WHERE  " +
                    " C.PRS_RSO = 'S' " +
                    " AND C.COD_LUO_FSC = B.COD_LUO_FSC " +
                    " AND A.COD_LUO_FSC = B.COD_LUO_FSC " +
                    " AND F.cod_fat_rso=D.cod_fat_rso " +
                    " AND F.cod_rso=C.COD_RSO " +
                    " AND F.cod_azl=C.cod_azl " +
                    " AND C.COD_AZL =? " +
                    " AND D.cod_cag_fat_rso=? " +
                    " AND B.COD_LUO_FSC=? " +
                    " ORDER BY F.nom_rso ");
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_CAG_FAT_RSO);
            ps.setLong(3, lCOD_LUO_FSC);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategorioRischio_Rischio_View obj = new CategorioRischio_Rischio_View();
                obj.lCOD_RSO = rs.getLong(1);
                obj.strNOM_RSO = rs.getString(2);
                obj.strDES_RSO = rs.getString(3);
                obj.lPRB_EVE_LES = rs.getLong(4);
                obj.lENT_DAN = rs.getLong(5);
                obj.lSTM_NUM_RSO = rs.getLong(6);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    public Collection ejbGetCategorieWithRischi_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "select distinct "
                        + "cag_fat_rso.cod_cag_fat_rso, "
                        + "cag_fat_rso.nom_cag_fat_rso, "
                        + "cag_fat_rso.des_cag_fat_rso "
                    + "from "
                        + "cag_fat_rso_tab cag_fat_rso, "
                        + "ana_fat_rso_tab fat_rso, "
                        + "ana_rso_tab rso "
                    + "where "
                        + "cag_fat_rso.cod_cag_fat_rso = fat_rso.cod_cag_fat_rso "
                        + "and fat_rso.cod_fat_rso = rso.cod_fat_rso "
                        + "and rso.cod_azl = ? "
                    + "order by "
                        + "cag_fat_rso.nom_cag_fat_rso");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                CategorioRischio_Name_Address_View obj = new CategorioRischio_Name_Address_View();
                obj.COD_CAG_FAT_RSO = rs.getLong(1);
                obj.NOM_CAG_FAT_RSO = rs.getString(2);
                obj.DES_CAG_FAT_RSO = rs.getString(3);
                al.add(obj);
            }
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    
    //</report>
    //-------------------
    //</comment>
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  CategorioRischioBean"/>

