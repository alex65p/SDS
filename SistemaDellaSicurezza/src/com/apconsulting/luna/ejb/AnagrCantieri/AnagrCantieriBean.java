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
package com.apconsulting.luna.ejb.AnagrCantieri;

import com.apconsulting.luna.ejb.AnagrOpere.Opere_View;
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
 * @author Alessandro
 */
public class AnagrCantieriBean extends BMPEntityBean implements IAnagrCantieriHome, IAnagrCantieri {

    long lCOD_CAN;
    String strDES_CAN;
    String strNOM_CAN;
    private static AnagrCantieriBean ys = null;

    private AnagrCantieriBean() {
    }

    public static AnagrCantieriBean getInstance() {
        if (ys == null) {
            ys = new AnagrCantieriBean();
        }
        return ys;
    }

    //   public Collection getRischi_View(long lCOD_CST, long lCOD_AZL) {
    //      return (new AnagrConstatazioniBean()).ejbGetRischi_View(lCOD_CST, lCOD_AZL);
    //  }
    public IAnagrCantieri create(String strDES_CAN, String strNOM_CAN, long lCOD_AZL) throws CreateException {
        AnagrCantieriBean bean = new AnagrCantieriBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES_CAN, strNOM_CAN, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES_CAN);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnagrCantieriBean bean = new AnagrCantieriBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex.getMessage());
        }
    }

    public IAnagrCantieri findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrCantieriBean bean = new AnagrCantieriBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Long ejbCreate(String strDES_CAN, String strNOM_CAN, long lCOD_AZL) {
        this.lCOD_CAN = NEW_ID(); // unic ID    
        this.strNOM_CAN = strNOM_CAN;
        this.strDES_CAN = strDES_CAN;

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_can_tab "
                    + "(cod_can, des_can, nom_can, cod_azl) "
                    + "VALUES"
                    + "(?,?,?,?)");

            ps.setLong(1, lCOD_CAN);
            ps.setString(2, strDES_CAN);
            ps.setString(3, strNOM_CAN);
            ps.setLong(4, lCOD_AZL);

            ps.executeUpdate();
            return new Long(lCOD_CAN);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strDES_CAN) {
    }

    public long getlCOD_CAN() {
        return lCOD_CAN;
    }

    public void setlCOD_CAN(long newlCOD_PRO) {
        if (lCOD_CAN == newlCOD_PRO) {
            return;
        }
        lCOD_CAN = newlCOD_PRO;
        setModified();
    }

    public String getstrDES_CAN() {
        return strDES_CAN;
    }

    public String getstrNOM_CAN() {
        return strNOM_CAN;
    }

    public void setstrDES_CAN(String newstrDES_CAN) {
        if (strDES_CAN != null) {
            if (strDES_CAN.equals(newstrDES_CAN)) {
                return;
            }
        }
        strDES_CAN = newstrDES_CAN;
        setModified();
    }

    public void setstrNOM_CAN(String newstrNOM_CAN) {
        if (strNOM_CAN != null) {
            if (strNOM_CAN.equals(newstrNOM_CAN)) {
                return;
            }
        }
        strNOM_CAN = newstrNOM_CAN;
        setModified();
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
            rs.close();
            ps.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void addCOD_OPE(long lCOD_OPE, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO can_ope_tab(cod_can,cod_ope) VALUES(?,?)");
            ps.setLong(1, lCOD_CAN);
            ps.setLong(2, lCOD_OPE);
            //ps.setString (4, strTPL_CLF_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* public void addCOD_RSO(long lCOD_RSO, long lCOD_AZL) {
    BMPConnection bmp = getConnection();
    try {
    PreparedStatement ps = bmp.prepareStatement("INSERT INTO cst_rso_tab(cod_cst,cod_rso,cod_azl) VALUES(?,?,?)");
    ps.setLong(1, lCOD_CST);
    ps.setLong(2, lCOD_RSO);
    ps.setLong(3, lCOD_AZL);
    //ps.setString (4, strTPL_CLF_RSO);
    ps.executeUpdate();
    } catch (Exception ex) {
    ex.printStackTrace(System.err);
    throw new EJBException(ex);
    } finally {
    bmp.close();
    }
    }*/
    /*     public Collection ejbGetRischi_View(long lCOD_CST, long lCOD_AZL) {
    BMPConnection bmp = getConnection();
    try {
    PreparedStatement ps = bmp.prepareStatement("SELECT rso.cod_rso, rso.nom_rso, fat.nom_fat_rso FROM ana_rso_tab rso, cst_rso_tab cstrso, ana_fat_rso_tab fat WHERE rso.cod_rso = cstrso.cod_rso AND cstrso.cod_azl = rso.cod_azl AND cstrso.cod_azl = ? AND cstrso.cod_cst = ? AND rso.cod_fat_rso = fat.cod_fat_rso ORDER BY nom_rso");
    ps.setLong(1, lCOD_AZL);
    ps.setLong(2, lCOD_CST);            
    ResultSet rs = ps.executeQuery();
    java.util.ArrayList al = new java.util.ArrayList();
    while (rs.next()) {
    Rischi_View obj = new Rischi_View();
    obj.COD_RSO = rs.getLong(1);
    obj.NOM_RSO = rs.getString(2);
    obj.NOM_FAT_RSO = rs.getString(3);
    
    al.add(obj);
    }
    bmp.close();
    return al;
    } catch (Exception ex) {
    ex.printStackTrace(System.err);
    throw new EJBException(ex);
    } finally {
    bmp.close();
    }
    }
     * 
     */
    public void deleteOpera(long lCOD_OPE, long lCOD_CAN) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM can_ope_tab WHERE cod_ope=? AND cod_can=?");
            ps.setLong(1, lCOD_OPE);
            ps.setLong(2, lCOD_CAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Opera con ID=" + lCOD_OPE + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getOpere_View(long lCOD_PRO, long lCOD_AZL) {
        return (new AnagrCantieriBean()).ejbGetOpere_View(lCOD_PRO, lCOD_AZL);
    }

    public Collection ejbGetOpere_View(long lCOD_PRO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT ope.cod_ope, ope.nom_ope, ope.des_ope FROM ana_ope_tab ope, can_ope_tab canope WHERE ope.cod_ope = canope.cod_ope AND canope.cod_can = ? ORDER BY nom_ope");
            //ps.setLong(1, lCOD_AZL);
            ps.setLong(1, lCOD_PRO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Opere_View obj = new Opere_View();
                obj.COD_OPE = rs.getLong(1);
                obj.NOM_OPE = rs.getString(2);
                obj.DES_OPE = rs.getString(3);

                al.add(obj);
            }
            bmp.close();
            return al;

        } catch (Exception ex) {
            ex.printStackTrace(System.err);
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
        this.lCOD_CAN = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_CAN = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_can_tab  WHERE cod_can=? ");
            ps.setLong(1, lCOD_CAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_CAN = rs.getLong("COD_CAN");
                this.strDES_CAN = rs.getString("DES_CAN");
                this.strNOM_CAN = rs.getString("NOM_CAN");


//----------------------------
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_CAN + " non è trovato");
            }
            rs.close();
            ps.close();
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
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE "
                    + "FROM "
                    + "ana_can_tab "
                    + "WHERE "
                    + "cod_can = ? ");
            ps.setLong(1, lCOD_CAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_CAN + " non è trovata");
            }
            ps.close();
            //    deleteFile();
            //    deleteFileLink();
        } catch (Exception ex) {
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
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_can_tab  SET des_can=?, nom_can=? WHERE cod_can=?");
            ps.setString(1, strDES_CAN);
            ps.setString(2, strNOM_CAN);
            ps.setLong(3, lCOD_CAN);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID= non è trovata");
            }
            ps.close();
            bmp.commitTrans();
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
//-------------------------------------------------------------

    public Collection findEx(
            String strDES, String strNOM, long lCOD_AZL) {
        return (new AnagrCantieriBean()).ejbFindEx(
                strDES, strNOM, lCOD_AZL);
    }

    public Collection ejbFindEx(
            String strDES_CAN, String strNOM_CAN, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_can, a.des_can, a.nom_can FROM ana_can_tab a where cod_azl=?";

            if ((strDES_CAN != null) && (!strDES_CAN.trim().equals(""))) {
                query += " AND UPPER(a.des_can) LIKE ? ";
            }
            if ((strNOM_CAN != null) && (!strNOM_CAN.trim().equals(""))) {
                query += " AND UPPER(a.nom_can) LIKE ?";
            }

            query += " ORDER BY UPPER(a.nom_can)";

            /*if (strNOM_MED_RSP_CTL_SAN != null) {
            query += " AND  UPPER(a.nom_med_rsp_ctl_san)  LIKE ?";
            }
            if (datDAT_CRE_CTL_SAN != null) {
            query += " AND  a.dat_cre_ctl_san = ?";
            }*/
            //query += " ORDER BY UPPER(des)";


            /*if (lCOD_DPD != null) {
            ps.setLong(i++, lCOD_DPD.longValue());
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
            ps.setString(i++, strNOM_MED_RSP_CTL_SAN.toUpperCase());
            }
            if (datDAT_CRE_CTL_SAN != null) {
            ps.setDate(i++, datDAT_CRE_CTL_SAN);
            }*/

            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(1, lCOD_AZL);
            int i = 2;

            if ((strDES_CAN != null) && (!strDES_CAN.trim().equals(""))) {
                ps.setString(i++, strDES_CAN.toUpperCase() + "%");
            }

            if ((strNOM_CAN != null) && (!strNOM_CAN.trim().equals(""))) {
                ps.setString(i++, strNOM_CAN.toUpperCase() + "%");
            }



            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrCantieri_All_View obj = new AnagrCantieri_All_View();
                obj.COD_CAN = rs.getLong(1);
                obj.DES_CAN = rs.getString(2);
                obj.NOM_CAN = rs.getString(3);

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

    public Collection getAnagrProcedimento_All_View() {
        return (new AnagrCantieriBean()).ejbGetANA_PRO_TAB_DES_View();
    }

    public void deleteRischio(long lCOD_RSO, long lCOD_CST) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM cst_rso_tab WHERE cod_rso=? AND cod_cst=?");
            ps.setLong(1, lCOD_RSO);
            ps.setLong(2, lCOD_CST);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Rischio con ID=" + lCOD_RSO + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection getAnagrCantieri_List_View(long lCOD_AZL) {
        return (new AnagrCantieriBean()).ejbGetAnagrCantieri_List_View(lCOD_AZL);
    }

    public Collection ejbGetAnagrCantieri_List_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "distinct a.cod_can, "
                    + "a.nom_can "
                    + "FROM "
                    + "ANA_CAN_TAB a "
                    + "WHERE "
                    + "a.cod_azl = ? "
                    + "ORDER BY 2 ");
            ps.setLong(1, lCOD_AZL);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrCantieri_All_View obj = new AnagrCantieri_All_View();
                obj.COD_CAN = rs.getLong(1);
                obj.NOM_CAN = rs.getString(2);
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

    public Collection ejbGetANA_PRO_TAB_DES_View() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pro, des FROM ana_pro_tab ORDER BY des");
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrCantieri_All_View obj = new AnagrCantieri_All_View();
                obj.COD_CAN = rs.getLong(1);
                obj.DES_CAN = rs.getString(2);
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

    public Collection getAnagr_All_View() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
