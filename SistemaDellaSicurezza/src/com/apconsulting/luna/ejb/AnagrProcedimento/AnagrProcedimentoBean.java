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
package com.apconsulting.luna.ejb.AnagrProcedimento;

import com.apconsulting.luna.ejb.AnagrOpere.Opere_View;
import com.apconsulting.luna.ejb.Cantiere.Cantiere_View;
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
public class AnagrProcedimentoBean extends BMPEntityBean implements IAnagrProcedimentoHome, IAnagrProcedimento {

    long lCOD_PRO;
    long lCOD_AZL;
    String strDES;
    String strNOM_RUP;
    String strCOD;
    java.sql.Date dtDAT_AMM;
    private static AnagrProcedimentoBean ys = null;

    private AnagrProcedimentoBean() {
    }

    public static AnagrProcedimentoBean getInstance() {
        if (ys == null) {
            ys = new AnagrProcedimentoBean();
        }
        return ys;
    }

    public IAnagrProcedimento create(String strDES, String strNOM_RUP, java.sql.Date dtDAT_AMM, String strCOD, long lCOD_AZL) throws CreateException {
        AnagrProcedimentoBean bean = new AnagrProcedimentoBean();
        try {
            Object primaryKey = bean.ejbCreate(strDES, strNOM_RUP, dtDAT_AMM, strCOD, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(strDES, strNOM_RUP, dtDAT_AMM, strCOD, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnagrProcedimentoBean bean = new AnagrProcedimentoBean();
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

    public IAnagrProcedimento findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrProcedimentoBean bean = new AnagrProcedimentoBean();
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

    public void addCOD_CAN(long lCOD_CAN, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO pro_can_tab(cod_pro,cod_can,cod_azl) VALUES(?,?,?)");
            ps.setLong(1, lCOD_PRO);
            ps.setLong(2, lCOD_CAN);
            ps.setLong(3, lCOD_AZL);
            //ps.setString (4, strTPL_CLF_RSO);
            ps.executeUpdate();
        } catch (Exception ex) {
            ex.printStackTrace(System.err);
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbCreate(String strDES, String strNOM_RUP, java.sql.Date dtDAT_AMM, String strCOD, long lCOD_AZL) {
        this.strDES = strDES;
        this.strNOM_RUP = strNOM_RUP;
        this.dtDAT_AMM = dtDAT_AMM;
        this.strCOD = strCOD;
        this.lCOD_AZL = lCOD_AZL;
        this.lCOD_PRO = NEW_ID(); // unic ID
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("INSERT INTO ana_pro_tab (cod_pro,des,nom_rup,dat_amm,cod,cod_azl) VALUES(?,?,?,?,?,?)");

            ps.setLong(1, lCOD_PRO);
            ps.setString(2, strDES);
            ps.setString(3, strNOM_RUP);
            ps.setDate(4, dtDAT_AMM);
            ps.setString(5, strCOD);
            ps.setLong(6, lCOD_AZL);

            ps.executeUpdate();
            return new Long(lCOD_PRO);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(String strDES, String strNOM_RUP, java.sql.Date dtDAT_AMM, String strCOD, long lCOD_AZL) {
    }

    public void setdtDAT_AMM(java.sql.Date newdtDAT_AMM) {
        if (dtDAT_AMM != null) {
            if (dtDAT_AMM.equals(newdtDAT_AMM)) {
                return;
            }
        }
        dtDAT_AMM = newdtDAT_AMM;
        setModified();
    }

    public java.sql.Date getdtDAT_AMM() {
        return dtDAT_AMM;
    }

    public long getlCOD_AZL() {
        return lCOD_AZL;
    }

    public void setlCOD_AZL(long newlCOD_AZL) {
        if (lCOD_AZL == newlCOD_AZL) {
            return;
        }
        lCOD_AZL = newlCOD_AZL;
        setModified();
    }

    public long getlCOD_PRO() {
        return lCOD_PRO;
    }

    public void setlCOD_PRO(long newlCOD_PRO) {
        if (lCOD_PRO == newlCOD_PRO) {
            return;
        }
        lCOD_PRO = newlCOD_PRO;
        setModified();
    }

    public String getstrCOD() {
        return strCOD;
    }

    public void setstrCOD(String newstrCOD) {
        if (strCOD != null) {
            if (strCOD.equals(newstrCOD)) {
                return;
            }
        }
        strCOD = newstrCOD;
        setModified();
    }

    public String getstrDES() {
        return strDES;
    }

    public void setstrDES(String newstrDES) {
        if (strDES != null) {
            if (strDES.equals(newstrDES)) {
                return;
            }
        }
        strDES = newstrDES;
        setModified();
    }

    public String getstrNOM_RUP() {
        return strNOM_RUP;
    }

    public void setstrNOM_RUP(String newstrNOM_RUP) {
        if (strNOM_RUP != null) {
            if (strNOM_RUP.equals(newstrNOM_RUP)) {
                return;
            }
        }
        strNOM_RUP = newstrNOM_RUP;
        setModified();
    }
//--------------------------------------------------

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_psc FROM ana_psc_tab ");
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

    public Collection getCantieri_View(long lCOD_PRO, long lCOD_AZL) {
        return (new AnagrProcedimentoBean()).ejbGetCantieri_View(lCOD_PRO, lCOD_AZL);
    }

    public Collection ejbGetCantieri_View(long lCOD_PRO, long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            //PreparedStatement ps = bmp.prepareStatement("SELECT can.cod_can, can.nom_can FROM ana_can_tab can, ope_can_tab opecan WHERE can.cod_can = opecan.cod_can AND opecan.cod_ope = ? ORDER BY nom_can");
            PreparedStatement ps = bmp.prepareStatement("SELECT can.cod_can, can.nom_can FROM ana_can_tab can, pro_can_tab procan WHERE can.cod_can = procan.cod_can AND procan.cod_pro = ? ORDER BY nom_can");
            ps.setLong(1, lCOD_PRO);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                Cantiere_View obj = new Cantiere_View();
                obj.COD_CAN = rs.getLong(1);
                obj.NOM_CAN = rs.getString(2);

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
        this.lCOD_PRO = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_PRO = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_pro_tab  WHERE cod_pro=? ");
            ps.setLong(1, lCOD_PRO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_PRO = rs.getLong("COD_PRO");				//3
                this.strDES = rs.getString("DES");				//4
                this.strNOM_RUP = rs.getString("NOM_RUP");				//5
                this.dtDAT_AMM = rs.getDate("DAT_AMM");				//6
                this.strCOD = rs.getString("COD");					//7

//----------------------------
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_PRO + " non è trovato");
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
                    + "ana_pro_tab "
                    + "WHERE "
                    + "cod_pro = ? ");
            ps.setLong(1, lCOD_PRO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_PRO + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement("UPDATE ana_pro_tab  SET des=?, nom_rup=?, dat_amm=?, cod=?	 WHERE cod_pro=?");
            ps.setString(1, strDES);
            ps.setString(2, strNOM_RUP);
            ps.setDate(3, dtDAT_AMM);
            ps.setString(4, strCOD);
            ps.setLong(5, lCOD_PRO);
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
            long lCOD_AZL,
            String strDES,
            String strNOM_RUP,
            String dtDAT_AMM,
            String strCOD) {
        return (new AnagrProcedimentoBean()).ejbFindEx(
                lCOD_AZL,
                strDES,
                strNOM_RUP,
                dtDAT_AMM,
                strCOD);
    }

    public Collection ejbFindEx(
            long lCOD_AZL,
            String strDES,
            String strNOM_RUP,
            String dtDAT_AMM,
            String strCOD) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_pro, a.des, a.nom_rup, a.dat_amm, a.cod FROM ana_pro_tab a where cod_azl=?";


            if ((strCOD != null) && (!strCOD.trim().equals(""))) {
                query += " AND UPPER(a.cod)  LIKE ? ";
            }
            if ((strDES != null) && (!strDES.trim().equals(""))) {
                query += " AND  UPPER(a.des) LIKE ? ";
            }
            if ((strNOM_RUP != null) && (!strNOM_RUP.trim().equals(""))) {
                query += " AND  UPPER(a.nom_rup) LIKE ? ";
            }/*if (lCOD_DPD != null) {
            query += " AND  a.cod_dpd = ?";
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
            query += " AND  UPPER(a.nom_med_rsp_ctl_san)  LIKE ?";
            }
            if (datDAT_CRE_CTL_SAN != null) {
            query += " AND  a.dat_cre_ctl_san = ?";
            }*/
            query += " ORDER BY UPPER(des)";

            int i = 1;

            PreparedStatement ps = bmp.prepareStatement(query);

            ps.setLong(i++, lCOD_AZL);

            if ((strCOD != null) && (!strCOD.equals(""))) {
                ps.setString(i++, strCOD.toUpperCase() + "%");
            }
            if ((strDES != null) && (!strDES.equals(""))) {
                ps.setString(i++, strDES.toUpperCase() + "%");
            }
            if ((strNOM_RUP != null) && (!strNOM_RUP.equals(""))) {
                ps.setString(i++, strNOM_RUP.toUpperCase() + "%");
            }
            /*if (lCOD_DPD != null) {
            ps.setLong(i++, lCOD_DPD.longValue());
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
            ps.setString(i++, strNOM_MED_RSP_CTL_SAN.toUpperCase());
            }
            if (datDAT_CRE_CTL_SAN != null) {
            ps.setDate(i++, datDAT_CRE_CTL_SAN);
            }*/

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrProcedimento_All_View obj = new AnagrProcedimento_All_View();
                obj.COD_PRO = rs.getLong(1);
                obj.DES = rs.getString(2);
                obj.NOM_RUP = rs.getString(3);
                obj.DAT_AMM = rs.getString(4);
                obj.COD = rs.getString(5);
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

    public Collection getAnagrProcedimento_All_View(long lCOD_AZL) {
        return (new AnagrProcedimentoBean()).ejbGetANA_PRO_TAB_DES_View(lCOD_AZL);
    }

    public Collection ejbGetANA_PRO_TAB_DES_View(long lCOD_AZL) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "cod_pro, "
                    + "des, "
                    + "cod "
                    + "FROM "
                    + "ana_pro_tab "
                    + "WHERE "
                    + "cod_azl = ? "
                    + "ORDER BY "
                    + "des");
            ps.setLong(1, lCOD_AZL);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrProcedimento_All_View obj = new AnagrProcedimento_All_View();
                obj.COD_PRO = rs.getLong(1);
                obj.DES = rs.getString(2);
                obj.COD = rs.getString(3);
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

    public void deleteCantiere(long lCOD_CAN, long lCOD_PRO) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("DELETE FROM pro_can_tab WHERE cod_can=? AND cod_pro=?");
            ps.setLong(1, lCOD_CAN);
            ps.setLong(2, lCOD_PRO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Cantiere con ID=" + lCOD_CAN + " non e' trovato");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
}
