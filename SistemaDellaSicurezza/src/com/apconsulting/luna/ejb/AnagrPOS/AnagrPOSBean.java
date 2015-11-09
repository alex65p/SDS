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
package com.apconsulting.luna.ejb.AnagrPOS;

import java.sql.Date;
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
public class AnagrPOSBean extends BMPEntityBean implements IAnagrPOSHome, IAnagrPOS {

    long lCOD_POS;
    long lCOD_DTE;
    long lCOD_DOC;
    long lCOD_PRO;
    long lCOD_OPE;
    long lCOD_CAN;
    String strTIT;
    String strUFF;
    String strSTA;
    String strFAL;
    String strPRO;
    java.sql.Date datData;
    private static AnagrPOSBean ys = null;

    private AnagrPOSBean() {
    }

    public static AnagrPOSBean getInstance() {
        if (ys == null) {
            ys = new AnagrPOSBean();
        }
        return ys;
    }

    /*    public Collection getRischi_View(long lCOD_POS, long lCOD_AZL) {
    return (new AnagrPOSBean()).ejbGetRischi_View(lCOD_POS, lCOD_AZL);
    }*/
    public IAnagrPOS create(
            long lCOD_DTE, long lCOD_DOC, String strTIT, String strUFF, 
            String strSTA, String strFAL, String strPRO, long lCOD_PRO, 
            long lCOD_OPE, long lCOD_CAN, java.sql.Date datData, long lCOD_AZL
        ) throws CreateException {
        AnagrPOSBean bean = new AnagrPOSBean();
        try {
            Object primaryKey = bean.ejbCreate(
                    lCOD_DTE, lCOD_DOC, strTIT, strUFF, strSTA, strFAL, strPRO, 
                    lCOD_PRO, lCOD_OPE, lCOD_CAN, datData, lCOD_AZL);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(
                    lCOD_DTE, lCOD_DOC, strTIT, strUFF, strSTA, strFAL, strPRO, 
                    lCOD_PRO, lCOD_OPE, lCOD_CAN, datData, lCOD_AZL);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnagrPOSBean bean = new AnagrPOSBean();
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

    public IAnagrPOS findByPrimaryKey(Long primaryKey) throws FinderException {
        AnagrPOSBean bean = new AnagrPOSBean();
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

    public Long ejbCreate(
            long lCOD_DTE, long lCOD_DOC, String strTIT, String strUFF, 
            String strSTA, String strFAL, String strPRO, long lCOD_PRO, 
            long lCOD_OPE, long lCOD_CAN, java.sql.Date datData, long lCOD_AZL) {
        
        this.lCOD_DTE = lCOD_DTE;
        this.lCOD_DOC = lCOD_DOC;
        this.strTIT = strTIT;
        this.strUFF = strUFF;
        this.strSTA = strSTA;
        this.strFAL = strFAL;
        this.strPRO = strPRO;
        this.lCOD_PRO = lCOD_PRO;
        this.lCOD_OPE = lCOD_OPE;
        this.lCOD_CAN = lCOD_CAN;
        this.datData = datData;
        this.lCOD_POS = NEW_ID(); // unic ID

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO ana_pos_tab "
                        + "(cod_pos,cod_doc,cod_dte,titolo,ufficio,stanza,"
                        + "faldone,progressivo,cod_pro,cod_ope,cod_can,data,"
                        + "cod_azl ) "
                    + "VALUES"
                        + "(?,?,?,?,?,?,?,?,?,?,?,?,?)");

            ps.setLong(1, lCOD_POS);
            ps.setLong(2, lCOD_DOC);
            ps.setLong(3, lCOD_DTE);
            ps.setString(4, strTIT);
            ps.setString(5, strUFF);
            ps.setString(6, strSTA);
            ps.setString(7, strFAL);
            ps.setString(8, strPRO);
            ps.setLong(9, lCOD_PRO);
	    if (lCOD_OPE != 0){
                ps.setLong(10, lCOD_OPE);
            } else {
                ps.setNull(10, java.sql.Types.BIGINT);
            }
            ps.setLong(11, lCOD_CAN);
            ps.setDate(12, datData);
            ps.setLong(13, lCOD_AZL);
            
            ps.executeUpdate();
            return new Long(lCOD_POS);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

//-------------------------------------------------------
    public void ejbPostCreate(
            long lCOD_DTE, long lCOD_DOC, String strTIT, String strUFF, 
            String strSTA, String strFAL, String strPRO, long lCOD_PRO, 
            long lCOD_OPE, long lCOD_CAN, java.sql.Date datData, long lCOD_AZL) {
    }

    public long getlCOD_POS() {
        return lCOD_POS;
    }

    public void setlCOD_POS(long newlCOD_POS) {
        if (lCOD_POS == newlCOD_POS) {
            return;
        }
        lCOD_POS = newlCOD_POS;
        setModified();
    }

    public long getlCOD_DTE() {
        return lCOD_DTE;
    }

    public void setlCOD_DTE(long newlCOD_DTE) {
        if (lCOD_DTE == newlCOD_DTE) {
            return;
        }
        lCOD_DTE = newlCOD_DTE;
        setModified();
    }

    public long getlCOD_DOC() {
        return lCOD_DOC;
    }

    public void setlCOD_DOC(long newlCOD_DOC) {
        if (lCOD_DOC == newlCOD_DOC) {
            return;
        }
        lCOD_DOC = newlCOD_DOC;
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

    public long getlCOD_OPE() {
        return lCOD_OPE;
    }

    public void setlCOD_OPE(long newlCOD_OPE) {
        if (lCOD_OPE == newlCOD_OPE) {
            return;
        }
        lCOD_OPE = newlCOD_OPE;
        setModified();
    }

    public long getlCOD_CAN() {
        return lCOD_CAN;
    }

    public void setlCOD_CAN(long newlCOD_CAN) {
        if (lCOD_CAN == newlCOD_CAN) {
            return;
        }
        lCOD_CAN = newlCOD_CAN;
        setModified();
    }

    public String getstrTIT() {
        return strTIT;
    }

    public String getstrUFF() {
        return strUFF;
    }

    public String getstrSTA() {
        return strSTA;
    }

    public String getstrFAL() {
        return strFAL;
    }

    public String getstrPRO() {
        return strPRO;
    }

    public java.sql.Date getdatData() {
        return datData;
    }

    public void setstrTIT(String newstrTIT) {
        if (strTIT != null) {
            if (strTIT.equals(newstrTIT)) {
                return;
            }
        }
        strTIT = newstrTIT;
        setModified();
    }

    public void setstrUFF(String newstrUFF) {
        if (strUFF != null) {
            if (strUFF.equals(newstrUFF)) {
                return;
            }
        }
        strUFF = newstrUFF;
        setModified();
    }

    public void setstrSTA(String newstrSTA) {
        if (strSTA != null) {
            if (strSTA.equals(newstrSTA)) {
                return;
            }
        }
        strSTA = newstrSTA;
        setModified();
    }

    public void setstrFAL(String newstrFAL) {
        if (strFAL != null) {
            if (strFAL.equals(newstrFAL)) {
                return;
            }
        }
        strFAL = newstrFAL;
        setModified();
    }

    public void setstrPRO(String newstrPRO) {
        if (strPRO != null) {
            if (strPRO.equals(newstrPRO)) {
                return;
            }
        }
        strPRO = newstrPRO;
        setModified();
    }

    public void setdatData(Date newdatData) {
        if (datData != null) {
            if (datData.equals(newdatData)) {
                return;
            }
        }
        datData = newdatData;
        setModified();
    }

//--------------------------------------------------
    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT cod_pos FROM ana_pos_tab ");
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

    //-----------------------------------------------------------
    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }
//----------------------------------------------------------

    public void ejbActivate() {
        this.lCOD_POS = ((Long) this.getEntityKey()).longValue();
    }
//----------------------------------------------------------

    public void ejbPassivate() {
        this.lCOD_POS = -1;
    }
//----------------------------------------------------------

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement("SELECT * FROM ana_pos_tab  WHERE cod_pos=? ");
            ps.setLong(1, lCOD_POS);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.lCOD_POS = rs.getLong("COD_POS");
                this.lCOD_DTE = rs.getLong("COD_DTE");
                this.lCOD_DOC = rs.getLong("COD_DOC");
                this.strTIT = rs.getString("TITOLO");
                this.strUFF = rs.getString("UFFICIO");
                this.strSTA = rs.getString("STANZA");
                this.strFAL = rs.getString("FALDONE");
                this.strPRO = rs.getString("PROGRESSIVO");
                this.lCOD_PRO = rs.getLong("COD_PRO");
                this.lCOD_OPE = rs.getLong("COD_OPE");
                this.lCOD_CAN = rs.getLong("COD_CAN");
                this.datData = rs.getDate("DATA");


//----------------------------
            } else {
                throw new NoSuchEntityException("PSC con ID=" + lCOD_POS + " non è trovato");
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
                    + "ana_pos_tab "
                    + "WHERE "
                    + "cod_pos = ? ");
            ps.setLong(1, lCOD_POS);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("AnagrDocumento con ID=" + lCOD_POS + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement(""
                    + "UPDATE ana_pos_tab  "
                    + "SET cod_doc= ?, "
                    + "cod_dte= ?, "
                    + "titolo = ?,"
                    + "ufficio= ?,"
                    + "stanza= ?,"
                    + "faldone= ?,"
                    + "progressivo= ?,"
                    + "cod_pro=?,"
                    + "cod_ope=?,"
                    + "cod_can=?, "
                    + "data= ?  "
                    + "WHERE "
                    + "cod_pos=?");
            ps.setLong(1, lCOD_DOC);
            ps.setLong(2, lCOD_DTE);
            ps.setString(3, strTIT);
            ps.setString(4, strUFF);
            ps.setString(5, strSTA);
            ps.setString(6, strFAL);
            ps.setString(7, strPRO);
            ps.setLong(8, lCOD_PRO);
	    if (lCOD_OPE != 0){
                ps.setLong(9, lCOD_OPE);
            } else {
                ps.setNull(9, java.sql.Types.BIGINT);
            }
            ps.setLong(10, lCOD_CAN);
            ps.setDate(11, datData);
            ps.setLong(12, lCOD_POS);

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
            long lCOD_AZL, long lCOD_DTE, long lCOD_DOC, String strTIT, 
            String strUFF, String strSTA, String strFAL, String strPRO, 
            java.sql.Date datData) {
        return (new AnagrPOSBean()).ejbFindEx(
                lCOD_AZL, lCOD_DTE, lCOD_DOC, strTIT, strUFF, strSTA, strFAL, 
                strPRO, datData);
    }

    public Collection ejbFindEx(
            long lCOD_AZL, long lCOD_DTE, long lCOD_DOC, String strTIT, 
            String strUFF, String strSTA, String strFAL, String strPRO, 
            java.sql.Date datData) {
        BMPConnection bmp = getConnection();
        try {
            String query = "SELECT a.cod_pos, "
                            + "a.cod_dte,"
                            + "a.cod_doc, "
                            + "a.titolo, "
                            + "a.ufficio, "
                            + "a.stanza, "
                            + "a.faldone, "
                            + "a.progressivo, "
                            + "a.data,"
                            + "b.des,"
                            + "c.nom_ope,"
                            + "d.nom_can,"
                            + "e.rag_scl_dte,"
                            + "f.num_doc "
                        + "FROM "
                            + "ana_pos_tab a "
                                + "left outer join "
                                    + "ana_ope_tab c "
                                + "on "
                                    + "c.cod_ope=a.cod_ope, "
                            + "ana_pro_tab b,"
                            + "ana_can_tab d,"
                            + "ana_dte_tab e,"
                            + "ana_doc_ges_can_tab f"
                        + " where "
                            + "a.cod_azl = ? "
                            + " and b.cod_pro=a.cod_pro"
                            + " and d.cod_can=a.cod_can"
                            + " and e.cod_dte=a.cod_dte"
                            + " and f.cod_doc=a.cod_doc";

            if (lCOD_DTE != 0) {
                query += " AND a.cod_dte = ? ";
            }

            if (lCOD_DOC != 0) {
                query += " AND a.cod_doc = ? ";
            }

            if ((strTIT != null) && (!strTIT.trim().equals(""))) {
                query += " AND UPPER(a.titolo) LIKE ?";
            }

            if ((strUFF != null) && (!strUFF.trim().equals(""))) {
                query += " AND UPPER(a.ufficio) LIKE ? ";
            }

            if ((strSTA != null) && (!strSTA.trim().equals(""))) {
                query += " AND UPPER(a.stanza) LIKE ?";
            }

            if ((strFAL != null) && (!strFAL.trim().equals(""))) {
                query += " AND UPPER(a.faldone) LIKE ? ";
            }

            if ((strPRO != null) && (!strPRO.trim().equals(""))) {
                query += " AND UPPER(a.progressivo) LIKE ?";
            }

            if (datData != null) {
                query += " AND (a.data)=? ";
            }

            query += " ORDER BY UPPER(a.titolo)";

            /*if (strNOM_MED_RSP_CTL_SAN != null) {
            query += " AND  UPPER(a.nom_med_rsp_ctl_san)  LIKE ?";
            }
            if (datDAT_CRE_CTL_SAN != null) {
            query += " AND  a.dat_cre_ctl_san = ?";
            }*/

            /*if (lCOD_DPD != null) {
            ps.setLong(i++, lCOD_DPD.longValue());
            }
            if (strNOM_MED_RSP_CTL_SAN != null) {
            ps.setString(i++, strNOM_MED_RSP_CTL_SAN.toUpperCase());
            }
            if (datDAT_CRE_CTL_SAN != null) {
            ps.setDate(i++, datDAT_CRE_CTL_SAN);
            }*/

            int i = 1;
            PreparedStatement ps = bmp.prepareStatement(query);
            ps.setLong(i++, lCOD_AZL);
            
            if (lCOD_DTE != 0) {
                ps.setLong(i++, lCOD_DTE);
            }

            if (lCOD_DOC != 0) {
                ps.setLong(i++, lCOD_DOC);
            }

            if ((strTIT != null) && (!strTIT.trim().equals(""))) {
                ps.setString(i++, strTIT.toUpperCase() + "%");
            }

            if ((strUFF != null) && (!strUFF.trim().equals(""))) {
                ps.setString(i++, strUFF.toUpperCase() + "%");
            }

            if ((strSTA != null) && (!strSTA.trim().equals(""))) {
                ps.setString(i++, strSTA.toUpperCase() + "%");
            }

            if ((strFAL != null) && (!strFAL.trim().equals(""))) {
                ps.setString(i++, strFAL.toUpperCase() + "%");
            }

            if ((strPRO != null) && (!strPRO.trim().equals(""))) {
                ps.setString(i++, strPRO.toUpperCase() + "%");
            }

            if (datData != null) {
                ps.setDate(i++, datData);
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnagrPOS_All_View obj = new AnagrPOS_All_View();
                obj.COD_POS = rs.getLong(1);
                obj.COD_DTE = rs.getLong(2);
                obj.COD_DOC = rs.getLong(3);
                obj.TIT = rs.getString(4);
                obj.UFF = rs.getString(5);
                obj.STA = rs.getString(6);
                obj.FAL = rs.getString(7);
                obj.PRO = rs.getString(8);
                obj.Data = rs.getDate(9);
                obj.PRO = rs.getString(10);
                obj.OPE = rs.getString(11);
                obj.CAN = rs.getString(12);
                obj.IMP = rs.getString(13);
                obj.NUM_DOC = rs.getString(14);
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
}
