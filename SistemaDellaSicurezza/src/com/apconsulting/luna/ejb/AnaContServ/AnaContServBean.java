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
package com.apconsulting.luna.ejb.AnaContServ;

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
public class AnaContServBean extends BMPEntityBean implements IAnaContServ, IAnaContServHome {
    /* - - - - - Campi obbligatori (NOT NULL nel DB)*/

    long COD_SRV;
    long COD_AZL;
    String PRO_CON;
    long APP_COD_DTE;

    /* - - - - - Campi non obbligatori (possono essere NULL nel DB) presenti nel Form*/
    String DES_CON;
    String RIF_CON;
    long COD_UNI_ORG;
    java.sql.Date DAT_INI_LAV;
    java.sql.Date DAT_FIN_LAV;
    String ORA_LAV;
    String LAV_NOT;
    int NUM_LAV_PRE;
    long COM_COD_DPD;
    String COM_RES_TEL;
    long COD_DPD;
    String NOM_FUZ_AZL;
    String APP_TEL;
    String APP_FAX;
    String APP_EMAIL;
    String APP_RES_NOM;
    String APP_RES_QUA;
    String APP_RES_TEL;
    String APP_INT_ASS_DES;
    String APP_INT_ASS_ORA_LAV;
    int APP_INT_ASS_COD_CON;
    String APP_INT_ASS_CON_DES;
    String RAG_SCL_DTE;
    String IDZ_DTE;
    String CEN_EME_DES;
    String SER_SAN_DES_1;
    String SER_SAN_DES_2;
    String SER_SAN_DES_3;
    String FLU_DES_1;
    String FLU_DES_2;
    String PRE_MAT_DES_1;
    String PRE_MAT_DES_2;
    String PRE_MAT_ASS_APP_RAD;
    String PRE_MAT_ASS_TEL_CEL;
    String PRO_SOS_DES;
    String PRO_SOS_SUB_APP_DES;

    /* - - - - - Costruttore*/
    private static AnaContServBean ys = null;
    
    private AnaContServBean() {
    }
    
    public static AnaContServBean getInstance(){
        if (ys==null) ys = new AnaContServBean();
        return ys;
    }

    public IAnaContServ create(
            long lCOD_AZL,
            String strPRO_CON,
            long lAPP_COD_DTE) throws RemoteException, CreateException {
        AnaContServBean bean = new AnaContServBean();
        try {
            Object primaryKey = bean.ejbCreate(
                    lCOD_AZL,
                    strPRO_CON,
                    lAPP_COD_DTE);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(
                    lCOD_AZL,
                    strPRO_CON,
                    lAPP_COD_DTE);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        AnaContServBean bean = new AnaContServBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((Long) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    public IAnaContServ findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        AnaContServBean bean = new AnaContServBean();
        try {
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbActivate();
            bean.ejbLoad();
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Collection findAll() throws RemoteException, FinderException {
        try {
            return this.ejbFindAll();
        } catch (Exception ex) {
            throw new javax.ejb.FinderException(ex.getMessage());
        }
    }

    public Long ejbCreate(
            long lCOD_AZL,
            String strPRO_CON,
            long lAPP_COD_DTE) {
        this.COD_AZL = lCOD_AZL;
        this.PRO_CON = strPRO_CON;
        this.APP_COD_DTE = lAPP_COD_DTE;
        this.COD_SRV = NEW_ID();//per creare un ID univoco

        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO " +
                    "ana_con_ser " +
                    "(cod_srv, " +
                    "cod_azl, " +
                    "pro_con, " +
                    "app_cod_dte) " +
                    "VALUES(?,?,?,?)");
            PreparedStatement ps2 = bmp.prepareStatement(
                    "INSERT INTO " +
                    "con_ser_des " +
                    "(cod_srv) " +
                    "VALUES(?)");
            // Set dello statement 1
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_AZL);
            ps.setString(3, PRO_CON);
            ps.setLong(4, APP_COD_DTE);

            // Set dello statement 2
            ps2.setLong(1, COD_SRV);
            if (ps.executeUpdate() != 0) {
                if (ps2.executeUpdate() != 0) {
                    bmp.commitTrans();
                } else {
                    throw new NoSuchEntityException("Servizio con ID" + " non trovato.");
                }
            } else {
                throw new NoSuchEntityException("Servizio con ID" + " non trovato.");
            }
            return new Long(COD_SRV);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_AZL,
            String strPRO_CON,
            long lAPP_COD_DTE) {
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            Long appCOD_SRV = null;
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE " +
                    "FROM " +
                    "con_ser_des b " +
                    "WHERE " +
                    "b.cod_srv=?");
            PreparedStatement ps2 = bmp.prepareStatement(
                    "DELETE " +
                    "FROM " +
                    "ana_con_ser a " +
                    "WHERE " +
                    "a.cod_srv=?");
            // Set dello statement 1		
            ps.setLong(1, COD_SRV);
            // Set dello statement 2
            ps2.setLong(1, COD_SRV);

            if (ps.executeUpdate() != 0) {
                if (ps2.executeUpdate() != 0) {
                    bmp.commitTrans();
                    appCOD_SRV = new Long(COD_SRV);
                } else {
                    throw new NoSuchEntityException("Utente con ID=" + COD_SRV + " non trovato.");
                }
            } else {
                throw new NoSuchEntityException("Utente con ID=" + COD_SRV + " non trovato.");
            }
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Long ejbFindByPrimaryKey(Long primaryKey) {
        return primaryKey;
    }

    public Collection ejbFindAll() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "a.cod_srv, " +
                    "a.cod_azl " +
                    "FROM " +
                    "ana_con_ser a");
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

    public void ejbActivate() {
        this.COD_SRV = ((Long) (this.getEntityKey())).longValue();
    }

    public void ejbPassivate() {
        this.COD_SRV = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "a.cod_srv, " +
                    "a.cod_azl, " +
                    "a.pro_con, " +
                    "a.des_con, " +
                    "a.rif_con, " +
                    "a.cod_uni_org, " +
                    "a.dat_ini_lav, " +
                    "a.dat_fin_lav, " +
                    "a.ora_lav, " +
                    "a.lav_not, " +
                    "a.num_lav_pre, " +
                    "a.app_cod_dte, " +
                    "a.com_cod_dpd, " +
                    "a.com_res_tel, " +
                    "a.app_tel, " +
                    "a.app_fax, " +
                    "a.app_email, " +
                    "a.app_res_nom, " +
                    "a.app_res_qua, " +
                    "a.app_res_tel, " +
                    "a.app_int_ass_des, " +
                    "a.app_int_ass_ora_lav, " +
                    "a.app_int_ass_cod_con, " +
                    "a.app_int_ass_con_des, " +
                    "b.rag_scl_dte, " +
                    "b.idz_dte, " +
                    "c.cen_eme_des, " +
                    "c.ser_san_des_1, " +
                    "c.ser_san_des_2, " +
                    "c.ser_san_des_3, " +
                    "c.flu_des_1, " +
                    "c.flu_des_2, " +
                    "c.pre_mat_des_1, " +
                    "c.pre_mat_des_2, " +
                    "c.pre_mat_ass_app_rad, " +
                    "c.pre_mat_ass_tel_cel, " +
                    "c.pro_sos_des, " +
                    "c.pro_sos_sub_app_des " +
                    "FROM " +
                    "ana_con_ser a, " +
                    "ana_dte_tab b, " +
                    "con_ser_des c " +
                    "WHERE " +
                    "b.cod_dte = a.app_cod_dte " +
                    "AND " +
                    "c.cod_srv = a.cod_srv " +
                    "AND " +
                    "a.cod_srv=?");
            ps.setLong(1, COD_SRV);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_SRV = rs.getLong("COD_SRV");
                this.COD_AZL = rs.getLong("COD_AZL");
                this.PRO_CON = rs.getString("PRO_CON");
                this.DES_CON = rs.getString("DES_CON");
                this.RIF_CON = rs.getString("RIF_CON");
                this.COD_UNI_ORG = rs.getLong("COD_UNI_ORG");
                this.DAT_INI_LAV = rs.getDate("DAT_INI_LAV");
                this.DAT_FIN_LAV = rs.getDate("DAT_FIN_LAV");
                this.ORA_LAV = rs.getString("ORA_LAV");
                this.LAV_NOT = rs.getString("LAV_NOT");
                this.NUM_LAV_PRE = rs.getInt("NUM_LAV_PRE");
                this.APP_COD_DTE = rs.getLong("APP_COD_DTE");
                this.COM_COD_DPD = rs.getLong("COM_COD_DPD");
                this.COM_RES_TEL = rs.getString("COM_RES_TEL");
                this.APP_TEL = rs.getString("APP_TEL");
                this.APP_FAX = rs.getString("APP_FAX");
                this.APP_EMAIL = rs.getString("APP_EMAIL");
                this.APP_RES_NOM = rs.getString("APP_RES_NOM");
                this.APP_RES_QUA = rs.getString("APP_RES_QUA");
                this.APP_RES_TEL = rs.getString("APP_RES_TEL");
                this.APP_INT_ASS_DES = rs.getString("APP_INT_ASS_DES");
                this.APP_INT_ASS_ORA_LAV = rs.getString("APP_INT_ASS_ORA_LAV");
                this.APP_INT_ASS_COD_CON = rs.getInt("APP_INT_ASS_COD_CON");
                this.APP_INT_ASS_CON_DES = rs.getString("APP_INT_ASS_CON_DES");
                this.RAG_SCL_DTE = rs.getString("RAG_SCL_DTE");
                this.IDZ_DTE = rs.getString("IDZ_DTE");
                this.CEN_EME_DES = rs.getString("CEN_EME_DES");
                this.SER_SAN_DES_1 = rs.getString("SER_SAN_DES_1");
                this.SER_SAN_DES_2 = rs.getString("SER_SAN_DES_2");
                this.SER_SAN_DES_3 = rs.getString("SER_SAN_DES_3");
                this.FLU_DES_1 = rs.getString("FLU_DES_1");
                this.FLU_DES_2 = rs.getString("FLU_DES_2");
                this.PRE_MAT_DES_1 = rs.getString("PRE_MAT_DES_1");
                this.PRE_MAT_DES_2 = rs.getString("PRE_MAT_DES_2");
                this.PRE_MAT_ASS_APP_RAD = rs.getString("PRE_MAT_ASS_APP_RAD");
                this.PRE_MAT_ASS_TEL_CEL = rs.getString("PRE_MAT_ASS_TEL_CEL");
                this.PRO_SOS_DES = rs.getString("PRO_SOS_DES");
                this.PRO_SOS_SUB_APP_DES = rs.getString("PRO_SOS_SUB_APP_DES");
            } else {
                throw new NoSuchEntityException("Utente con ID=" + COD_SRV + " non trovato.");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbStore() {
        if (!isModified()) {
            return;
        }
        BMPConnection bmp = getConnection();
        bmp.beginTrans();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "ana_con_ser " +
                    "SET " +
                    "cod_azl=?, " +
                    "pro_con=?, " +
                    "des_con=?, " +
                    "rif_con=?, " +
                    "cod_uni_org=?, " +
                    "dat_ini_lav=?, " +
                    "dat_fin_lav=?, " +
                    "ora_lav=?, " +
                    "lav_not=?, " +
                    "num_lav_pre=?, " +
                    "app_cod_dte=?, " +
                    "com_cod_dpd=?, " +
                    "com_res_tel=?, " +
                    "app_tel=?, " +
                    "app_fax=?, " +
                    "app_email=?, " +
                    "app_res_nom=?, " +
                    "app_res_qua=?, " +
                    "app_res_tel=?, " +
                    "app_int_ass_des=?, " +
                    "app_int_ass_ora_lav=?, " +
                    "app_int_ass_cod_con=?, " +
                    "app_int_ass_con_des=? " +
                    "WHERE " +
                    "cod_srv=? ");
            PreparedStatement ps2 = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "cen_eme_des=?, " +
                    "ser_san_des_1=?, " +
                    "ser_san_des_2=?, " +
                    "ser_san_des_3=?, " +
                    "flu_des_1=?, " +
                    "flu_des_2=?, " +
                    "pre_mat_des_1=?, " +
                    "pre_mat_des_2=?, " +
                    "pre_mat_ass_app_rad=?, " +
                    "pre_mat_ass_tel_cel=?, " +
                    "pro_sos_des=?, " +
                    "pro_sos_sub_app_des=? " +
                    "WHERE " +
                    "cod_srv=?");

            // Set dello statement 1
            ps.setLong(1, COD_AZL);
            ps.setString(2, PRO_CON);
            ps.setString(3, DES_CON);
            ps.setString(4, RIF_CON);
            if (COD_UNI_ORG != 0) {
                ps.setLong(5, COD_UNI_ORG);
            } else {
                ps.setNull(5, java.sql.Types.BIGINT);

            }
            ps.setDate(6, DAT_INI_LAV);
            ps.setDate(7, DAT_FIN_LAV);
            ps.setString(8, ORA_LAV);
            ps.setString(9, LAV_NOT);
            if (NUM_LAV_PRE != 0) {
                ps.setInt(10, NUM_LAV_PRE);
            } else {
                ps.setNull(10, java.sql.Types.INTEGER);
            }
            ps.setLong(11, APP_COD_DTE);
            if (COM_COD_DPD != 0) {
                ps.setLong(12, COM_COD_DPD);
            } else {
                ps.setNull(12, java.sql.Types.BIGINT);
            }
            ps.setString(13, COM_RES_TEL);
            ps.setString(14, APP_TEL);
            ps.setString(15, APP_FAX);
            ps.setString(16, APP_EMAIL);
            ps.setString(17, APP_RES_NOM);
            ps.setString(18, APP_RES_QUA);
            ps.setString(19, APP_RES_TEL);
            ps.setString(20, APP_INT_ASS_DES);
            ps.setString(21, APP_INT_ASS_ORA_LAV);
            if (APP_INT_ASS_COD_CON != 0) {
                ps.setInt(22, APP_INT_ASS_COD_CON);
            } else {
                ps.setNull(22, java.sql.Types.INTEGER);
            }
            ps.setString(23, APP_INT_ASS_CON_DES);
            ps.setLong(24, COD_SRV);

            // Set dello statement 2
            ps2.setString(1, CEN_EME_DES);
            ps2.setString(2, SER_SAN_DES_1);
            ps2.setString(3, SER_SAN_DES_2);
            ps2.setString(4, SER_SAN_DES_3);
            ps2.setString(5, FLU_DES_1);
            ps2.setString(6, FLU_DES_2);
            ps2.setString(7, PRE_MAT_DES_1);
            ps2.setString(8, PRE_MAT_DES_2);
            ps2.setString(9, PRE_MAT_ASS_APP_RAD);
            ps2.setString(10, PRE_MAT_ASS_TEL_CEL);
            ps2.setString(11, PRO_SOS_DES);
            ps2.setString(12, PRO_SOS_SUB_APP_DES);
            ps2.setLong(13, COD_SRV);

            if (ps.executeUpdate() != 0) {
                if (ps2.executeUpdate() != 0) {
                    bmp.commitTrans();
                } else {
                    throw new NoSuchEntityException("Utente con ID=" + COD_SRV + " non trovato.");
                }
            } else {
                throw new NoSuchEntityException("Utente con ID=" + COD_SRV + " non trovato.");
            }
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* - - - - - Implementazione dei metodi Get e Set per i campi obbligatori del Form*/
    public long getCOD_SRV() {
        return COD_SRV;
    }

    public long getCOD_AZL() {
        return COD_AZL;
    }

    public String getPRO_CON() {
        return PRO_CON;
    }

    public void setPRO_CON(String newPRO_CON) {
        if ((this.PRO_CON != null) && (this.PRO_CON.equals(newPRO_CON))) {
            return;
        }
        this.PRO_CON = newPRO_CON;
        setModified();
    }

    public long getAPP_COD_DTE() {
        return APP_COD_DTE;
    }

    public void setAPP_COD_DTE(long newAPP_COD_DTE) {
        if (APP_COD_DTE == newAPP_COD_DTE) {
            return;
        }
        APP_COD_DTE = newAPP_COD_DTE;
        setModified();
    }

    /* - - - - - Implementazione dei metodi Get e Set per i campi non obbligatori del Form*/
    public String getDES_CON() {
        return DES_CON;
    }

    public void setDES_CON(String newDES_CON) {
        if ((this.DES_CON != null) && (this.DES_CON.equals(newDES_CON))) {
            return;
        }
        this.DES_CON = newDES_CON;
        setModified();
    }

    public String getRIF_CON() {
        return RIF_CON;
    }

    public void setRIF_CON(String newRIF_CON) {
        if ((this.RIF_CON != null) && (this.RIF_CON.equals(newRIF_CON))) {
            return;
        }
        this.RIF_CON = newRIF_CON;
        setModified();
    }

    public long getCOD_UNI_ORG() {
        return COD_UNI_ORG;
    }

    public void setCOD_UNI_ORG(long newCOD_UNI_ORG) {
        if (this.COD_UNI_ORG == newCOD_UNI_ORG) {
            return;
        }
        this.COD_UNI_ORG = newCOD_UNI_ORG;
        setModified();
    }

    public java.sql.Date getDAT_INI_LAV() {
        return DAT_INI_LAV;
    }

    public void setDAT_INI_LAV(java.sql.Date newDAT_INI_LAV) {
        if (DAT_INI_LAV != null) {
            if (DAT_INI_LAV.equals(newDAT_INI_LAV)) {
                return;
            }
        }
        DAT_INI_LAV = newDAT_INI_LAV;
        setModified();
    }

    public java.sql.Date getDAT_FIN_LAV() {
        return DAT_FIN_LAV;
    }

    public void setDAT_FIN_LAV(java.sql.Date newDAT_FIN_LAV) {
        if (DAT_FIN_LAV != null) {
            if (DAT_FIN_LAV.equals(newDAT_FIN_LAV)) {
                return;
            }
        }
        DAT_FIN_LAV = newDAT_FIN_LAV;
        setModified();
    }

    public String getORA_LAV() {
        return ORA_LAV;
    }

    public void setORA_LAV(String newORA_LAV) {
        if ((this.ORA_LAV != null) && (this.ORA_LAV.equals(newORA_LAV))) {
            return;
        }
        this.ORA_LAV = newORA_LAV;
        setModified();
    }

    public String getLAV_NOT() {
        return LAV_NOT;
    }

    public void setLAV_NOT(String newLAV_NOT) {
        if ((this.LAV_NOT != null) && (this.LAV_NOT.equals(newLAV_NOT))) {
            return;
        }
        this.LAV_NOT = newLAV_NOT;
        setModified();
    }

    public int getNUM_LAV_PRE() {
        return NUM_LAV_PRE;
    }

    public void setNUM_LAV_PRE(int newNUM_LAV_PRE) {
        if (this.NUM_LAV_PRE == newNUM_LAV_PRE) {
            return;
        }
        this.NUM_LAV_PRE = newNUM_LAV_PRE;
        setModified();
    }

    public long getCOM_COD_DPD() {
        return COM_COD_DPD;
    }

    public void setCOM_COD_DPD(long newCOM_COD_DPD) {
        if (COM_COD_DPD == newCOM_COD_DPD) {
            return;
        }
        COM_COD_DPD = newCOM_COD_DPD;
        setModified();
    }

    public String getCOM_RES_TEL() {
        return COM_RES_TEL;
    }

    public void setCOM_RES_TEL(String newCOM_RES_TEL) {
        if ((this.COM_RES_TEL != null) && (this.COM_RES_TEL.equals(newCOM_RES_TEL))) {
            return;
        }
        this.COM_RES_TEL = newCOM_RES_TEL;
        setModified();
    }

    public long getCOD_DPD() {
        return COD_DPD;
    }

    public void setCOD_DPD(long newCOD_DPD) {
        if (this.COD_DPD == newCOD_DPD) {
            return;
        }
        this.COD_DPD = newCOD_DPD;
        setModified();
    }

    public String getNOM_FUZ_AZL() {
        return NOM_FUZ_AZL;
    }

    public void setNOM_FUZ_AZL(String newNOM_FUZ_AZL) {
        if ((this.NOM_FUZ_AZL != null) && (this.NOM_FUZ_AZL.equals(newNOM_FUZ_AZL))) {
            return;
        }
        this.NOM_FUZ_AZL = newNOM_FUZ_AZL;
        setModified();
    }

    public String getAPP_TEL() {
        return APP_TEL;
    }

    public void setAPP_TEL(String newAPP_TEL) {
        if ((this.APP_TEL != null) && (this.APP_TEL.equals(newAPP_TEL))) {
            return;
        }
        this.APP_TEL = newAPP_TEL;
        setModified();
    }

    public String getAPP_FAX() {
        return APP_FAX;
    }

    public void setAPP_FAX(String newAPP_FAX) {
        if ((this.APP_FAX != null) && (this.APP_FAX.equals(newAPP_FAX))) {
            return;
        }
        this.APP_FAX = newAPP_FAX;
        setModified();
    }

    public String getAPP_EMAIL() {
        return APP_EMAIL;
    }

    public void setAPP_EMAIL(String newAPP_EMAIL) {
        if ((this.APP_EMAIL != null) && (this.APP_EMAIL.equals(newAPP_EMAIL))) {
            return;
        }
        this.APP_EMAIL = newAPP_EMAIL;
        setModified();
    }

    public String getAPP_RES_NOM() {
        return APP_RES_NOM;
    }

    public void setAPP_RES_NOM(String newAPP_RES_NOM) {
        if ((this.APP_RES_NOM != null) && (this.APP_RES_NOM.equals(newAPP_RES_NOM))) {
            return;
        }
        this.APP_RES_NOM = newAPP_RES_NOM;
        setModified();
    }

    public String getAPP_RES_QUA() {
        return APP_RES_QUA;
    }

    public void setAPP_RES_QUA(String newAPP_RES_QUA) {
        if ((this.APP_RES_QUA != null) && (this.APP_RES_QUA.equals(newAPP_RES_QUA))) {
            return;
        }
        this.APP_RES_QUA = newAPP_RES_QUA;
        setModified();
    }

    public String getAPP_RES_TEL() {
        return APP_RES_TEL;
    }

    public void setAPP_RES_TEL(String newAPP_RES_TEL) {
        if ((this.APP_RES_TEL != null) && (this.APP_RES_TEL.equals(newAPP_RES_TEL))) {
            return;
        }
        this.APP_RES_TEL = newAPP_RES_TEL;
        setModified();
    }

    public String getAPP_INT_ASS_DES() {
        return APP_INT_ASS_DES;
    }

    public void setAPP_INT_ASS_DES(String newAPP_INT_ASS_DES) {
        if ((this.APP_INT_ASS_DES != null) && (this.APP_INT_ASS_DES.equals(newAPP_INT_ASS_DES))) {
            return;
        }
        this.APP_INT_ASS_DES = newAPP_INT_ASS_DES;
        setModified();
    }

    public String getAPP_INT_ASS_ORA_LAV() {
        return APP_INT_ASS_ORA_LAV;
    }

    public void setAPP_INT_ASS_ORA_LAV(String newAPP_INT_ASS_ORA_LAV) {
        if ((this.APP_INT_ASS_ORA_LAV != null) && (this.APP_INT_ASS_ORA_LAV.equals(newAPP_INT_ASS_ORA_LAV))) {
            return;
        }
        this.APP_INT_ASS_ORA_LAV = newAPP_INT_ASS_ORA_LAV;
        setModified();
    }

    public int getAPP_INT_ASS_COD_CON() {
        return APP_INT_ASS_COD_CON;
    }

    public void setAPP_INT_ASS_COD_CON(int newAPP_INT_ASS_COD_CON) {
        if (this.APP_INT_ASS_COD_CON == newAPP_INT_ASS_COD_CON) {
            return;
        }
        this.APP_INT_ASS_COD_CON = newAPP_INT_ASS_COD_CON;
        setModified();
    }

    public String getAPP_INT_ASS_CON_DES() {
        return APP_INT_ASS_CON_DES;
    }

    public void setAPP_INT_ASS_CON_DES(String newAPP_INT_ASS_CON_DES) {
        if ((this.APP_INT_ASS_CON_DES != null) && (this.APP_INT_ASS_CON_DES.equals(newAPP_INT_ASS_CON_DES))) {
            return;
        }
        this.APP_INT_ASS_CON_DES = newAPP_INT_ASS_CON_DES;
        setModified();
    }

    public String getRAG_SCL_DTE() {
        return RAG_SCL_DTE;
    }

    public String getIDZ_DTE() {
        return IDZ_DTE;
    }

    public String getCEN_EME_DES() {
        return CEN_EME_DES;
    }

    public void setCEN_EME_DES(String newCEN_EME_DES) {
        if ((this.CEN_EME_DES != null) && (this.CEN_EME_DES.equals(newCEN_EME_DES))) {
            return;
        }
        this.CEN_EME_DES = newCEN_EME_DES;
        setModified();
    }

    public String getSER_SAN_DES_1() {
        return SER_SAN_DES_1;
    }

    public void setSER_SAN_DES_1(String newSER_SAN_DES_1) {
        if ((this.SER_SAN_DES_1 != null) && (this.SER_SAN_DES_1.equals(newSER_SAN_DES_1))) {
            return;
        }
        this.SER_SAN_DES_1 = newSER_SAN_DES_1;
        setModified();
    }

    public String getSER_SAN_DES_2() {
        return SER_SAN_DES_2;
    }

    public void setSER_SAN_DES_2(String newSER_SAN_DES_2) {
        if ((this.SER_SAN_DES_2 != null) && (this.SER_SAN_DES_2.equals(newSER_SAN_DES_2))) {
            return;
        }
        this.SER_SAN_DES_2 = newSER_SAN_DES_2;
        setModified();
    }

    public String getSER_SAN_DES_3() {
        return SER_SAN_DES_3;
    }

    public void setSER_SAN_DES_3(String newSER_SAN_DES_3) {
        if ((this.SER_SAN_DES_3 != null) && (this.SER_SAN_DES_3.equals(newSER_SAN_DES_3))) {
            return;
        }
        this.SER_SAN_DES_3 = newSER_SAN_DES_3;
        setModified();
    }

    public String getFLU_DES_1() {
        return FLU_DES_1;
    }

    public void setFLU_DES_1(String newFLU_DES_1) {
        if ((this.FLU_DES_1 != null) && (this.FLU_DES_1.equals(newFLU_DES_1))) {
            return;
        }
        this.FLU_DES_1 = newFLU_DES_1;
        setModified();
    }

    public String getFLU_DES_2() {
        return FLU_DES_2;
    }

    public void setFLU_DES_2(String newFLU_DES_2) {
        if ((this.FLU_DES_2 != null) && (this.FLU_DES_2.equals(newFLU_DES_2))) {
            return;
        }
        this.FLU_DES_2 = newFLU_DES_2;
        setModified();
    }

    public String getPRE_MAT_DES_1() {
        return PRE_MAT_DES_1;
    }

    public void setPRE_MAT_DES_1(String newPRE_MAT_DES_1) {
        if ((this.PRE_MAT_DES_1 != null) && (this.PRE_MAT_DES_1.equals(newPRE_MAT_DES_1))) {
            return;
        }
        this.PRE_MAT_DES_1 = newPRE_MAT_DES_1;
        setModified();
    }

    public String getPRE_MAT_DES_2() {
        return PRE_MAT_DES_2;
    }

    public void setPRE_MAT_DES_2(String newPRE_MAT_DES_2) {
        if ((this.PRE_MAT_DES_2 != null) && (this.PRE_MAT_DES_2.equals(newPRE_MAT_DES_2))) {
            return;
        }
        this.PRE_MAT_DES_2 = newPRE_MAT_DES_2;
        setModified();
    }

    public String getPRE_MAT_ASS_APP_RAD() {
        return PRE_MAT_ASS_APP_RAD;
    }

    public void setPRE_MAT_ASS_APP_RAD(String newPRE_MAT_ASS_APP_RAD) {
        if ((this.PRE_MAT_ASS_APP_RAD != null) && (this.PRE_MAT_ASS_APP_RAD.equals(newPRE_MAT_ASS_APP_RAD))) {
            return;
        }
        this.PRE_MAT_ASS_APP_RAD = newPRE_MAT_ASS_APP_RAD;
        setModified();
    }

    public String getPRE_MAT_ASS_TEL_CEL() {
        return PRE_MAT_ASS_TEL_CEL;
    }

    public void setPRE_MAT_ASS_TEL_CEL(String newPRE_MAT_ASS_TEL_CEL) {
        if ((this.PRE_MAT_ASS_TEL_CEL != null) && (this.PRE_MAT_ASS_TEL_CEL.equals(newPRE_MAT_ASS_TEL_CEL))) {
            return;
        }
        this.PRE_MAT_ASS_TEL_CEL = newPRE_MAT_ASS_TEL_CEL;
        setModified();
    }

    public String getPRO_SOS_DES() {
        return PRO_SOS_DES;
    }

    public void setPRO_SOS_DES(String newPRO_SOS_DES) {
        if ((this.PRO_SOS_DES != null) && (this.PRO_SOS_DES.equals(newPRO_SOS_DES))) {
            return;
        }
        this.PRO_SOS_DES = newPRO_SOS_DES;
        setModified();
    }

    public String getPRO_SOS_SUB_APP_DES() {
        return PRO_SOS_SUB_APP_DES;
    }

    public void setPRO_SOS_SUB_APP_DES(String newPRO_SOS_SUB_APP_DES) {
        if ((this.PRO_SOS_SUB_APP_DES != null) && (this.PRO_SOS_SUB_APP_DES.equals(newPRO_SOS_SUB_APP_DES))) {
            return;
        }
        this.PRO_SOS_SUB_APP_DES = newPRO_SOS_SUB_APP_DES;
        setModified();
    }

    //per la comboBox 'Copia da'
    public Collection getCopiaDa_Form(long AZL_ID) {
        return (new AnaContServBean()).ejbGetCopiaDa_Form(AZL_ID);
    }

    public Collection ejbGetCopiaDa_Form(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "a.cod_srv, " +
                    "a.pro_con, " +
                    "a.des_con " +
                    "FROM " +
                    "ana_con_ser a " +
                    "WHERE " +
                    "a.cod_azl=? " +
                    "ORDER BY " +
                    "a.pro_con");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnaContServ_CopiaDa_Form obj = new AnaContServ_CopiaDa_Form();
                obj.COD_SRV = rs.getLong(1);
                obj.PRO_CON = rs.getString(2);
                obj.DES_CON = rs.getString(3);
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

    public Collection getDesConOnProCon(long AZL_ID) {
        return (new AnaContServBean()).ejbGetDesConOnProCon(AZL_ID);
    }

    public Collection ejbGetDesConOnProCon(long AZL_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "a.cod_srv, " +
                    "a.pro_con, " +
                    "a.des_con " +
                    "FROM " +
                    "ana_con_ser a " +
                    "WHERE " +
                    "a.cod_azl=? " +
                    "ORDER BY " +
                    "a.pro_con");
            ps.setLong(1, AZL_ID);
            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnaContServ_DesConOnProCon obj = new AnaContServ_DesConOnProCon();
                obj.COD_SRV = rs.getLong(1);
                obj.PRO_CON = rs.getString(2);
                obj.DES_CON = rs.getString(3);
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

    public String getProConOnCodSrv(long AZL_ID, long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                    "pro_con " +
                    "FROM " +
                    "ana_con_ser " +
                    "WHERE " +
                    "cod_azl = ? " +
                    "AND " +
                    "cod_srv = ? ");
            ps.setLong(1, AZL_ID);
            ps.setLong(2, SRV_ID);
            String pro_con_str = "";
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pro_con_str = rs.getString(1);
            }
            bmp.close();
            return pro_con_str;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDescFluidi(long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "flu_des_1=?, " +
                    "flu_des_2=? " +
                    "WHERE " +
                    "cod_srv=?");

            ps.setNull(1, java.sql.Types.VARCHAR);
            ps.setNull(2, java.sql.Types.VARCHAR);
            ps.setLong(3, SRV_ID);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDescCentriEmergenza(long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "cen_eme_des=? " +
                    "WHERE " +
                    "cod_srv=?");

            ps.setNull(1, java.sql.Types.VARCHAR);
            ps.setLong(2, SRV_ID);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDescServiziSanitari(long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "ser_san_des_1=?, " +
                    "ser_san_des_2=?, " +
                    "ser_san_des_3=? " +
                    "WHERE " +
                    "cod_srv=?");

            ps.setNull(1, java.sql.Types.VARCHAR);
            ps.setNull(2, java.sql.Types.VARCHAR);
            ps.setNull(3, java.sql.Types.VARCHAR);
            ps.setLong(4, SRV_ID);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDescPrestitoMateriali(long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "pre_mat_des_1=?, " +
                    "pre_mat_des_2=?, " +
                    "pre_mat_ass_app_rad=?, " +
                    "pre_mat_ass_tel_cel=? " +
                    "WHERE " +
                    "cod_srv=?");

            ps.setNull(1, java.sql.Types.VARCHAR);
            ps.setNull(2, java.sql.Types.VARCHAR);
            ps.setNull(3, java.sql.Types.VARCHAR);
            ps.setNull(4, java.sql.Types.VARCHAR);
            ps.setLong(5, SRV_ID);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDescProdottiSostanzeApp(long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "pro_sos_des = ? " +
                    "WHERE " +
                    "cod_srv = ? ");

            ps.setNull(1, java.sql.Types.VARCHAR);
            ps.setLong(2, SRV_ID);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void deleteDescProdottiSostanzeSubApp(long SRV_ID) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE " +
                    "con_ser_des " +
                    "SET " +
                    "pro_sos_sub_app_des=? " +
                    "WHERE " +
                    "cod_srv=?");

            ps.setNull(1, java.sql.Types.VARCHAR);
            ps.setLong(2, SRV_ID);
            ps.executeUpdate();
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* - - - - - Collezione per la costruzione della View e per la il bottone SEARCH*/
    public Collection findEx_AnaContServ(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON,
            String strRIF_CON,
            long lCOD_UNI_ORG,
            java.sql.Date dtDAT_INI_LAV,
            java.sql.Date dtDAT_FIN_LAV,
            String strORA_LAV,
            String strLAV_NOT,
            int iNUM_LAV_PRE,
            long lAPP_COD_DTE,
            int iOrderParameter) {
        return (new AnaContServBean()).ejbFindEx_AnaContServ(
                AZL_ID,
                strPRO_CON,
                strDES_CON,
                strRIF_CON,
                lCOD_UNI_ORG,
                dtDAT_INI_LAV,
                dtDAT_FIN_LAV,
                strORA_LAV,
                strLAV_NOT,
                iNUM_LAV_PRE,
                lAPP_COD_DTE,
                iOrderParameter);
    }

    public Collection ejbFindEx_AnaContServ(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON,
            String strRIF_CON,
            long lCOD_UNI_ORG,
            java.sql.Date dtDAT_INI_LAV,
            java.sql.Date dtDAT_FIN_LAV,
            String strORA_LAV,
            String strLAV_NOT,
            int iNUM_LAV_PRE,
            long lAPP_COD_DTE,
            int iOrderParameter //not used for now
            ) {
        String strSql = "SELECT " +
                "a.cod_srv, " +
                "a.pro_con, " +
                "a.des_con, " +
                "a.rif_con, " +
                "a.cod_uni_org, " +
                "a.dat_ini_lav, " +
                "a.dat_fin_lav, " +
                "a.ora_lav, " +
                "a.lav_not, " +
                "a.num_lav_pre, " +
                "a.app_cod_dte, " +
                "b.rag_scl_dte " +
                "FROM " +
                "ana_con_ser a, " +
                "ana_dte_tab b " +
                "WHERE " +
                "a.app_cod_dte = b.cod_dte " +
                "AND " +
                "a.cod_azl=?";

        int i = 2;
        int indexPro = 0;
        if (strPRO_CON != null) {
            strSql += " AND UPPER(a.pro_con) LIKE ? ";
            indexPro = i++;
        }

        int indexDes = 0;
        if (strDES_CON != null) {
            strSql += " AND UPPER(a.des_con) LIKE ? ";
            indexDes = i++;
        }

        int indexRif = 0;
        if (strRIF_CON != null) {
            strSql += " AND UPPER(a.rif_con) LIKE ? ";
            indexRif = i++;
        }

        int indexCodUni = 0;
        if (lCOD_UNI_ORG != 0) {
            strSql += " AND a.cod_uni_org = ? ";
            indexCodUni = i++;
        }

        int indexDatIni = 0;
        if (dtDAT_INI_LAV != null) {
            strSql += " AND a.dat_ini_lav = ? ";
            indexDatIni = i++;
        }

        int indexDatFin = 0;
        if (dtDAT_FIN_LAV != null) {
            strSql += " AND a.dat_fin_lav = ? ";
            indexDatFin = i++;
        }

        int indexOraLav = 0;
        if (strORA_LAV != null) {
            strSql += " AND UPPER(a.ora_lav) LIKE ? ";
            indexOraLav = i++;
        }

        int indexLavNot = 0;
        if (strLAV_NOT != null) {
            strSql += " AND a.lav_not LIKE ? ";
            indexLavNot = i++;
        }

        int indexNumLav = 0;
        if (iNUM_LAV_PRE != 0) {
            strSql += " AND a.num_lav_pre = ? ";
            indexNumLav = i++;
        }

        int indexCodFor = 0;
        if (lAPP_COD_DTE != 0) {
            strSql += " AND a.app_cod_dte = ? ";
            indexCodFor = i++;
        }

        strSql += " ORDER BY a.pro_con";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, AZL_ID);

            if (indexPro != 0) {
                ps.setString(indexPro, strPRO_CON.toUpperCase());
            }
            if (indexDes != 0) {
                ps.setString(indexDes, strDES_CON.toUpperCase());
            }
            if (indexRif != 0) {
                ps.setString(indexRif, strRIF_CON.toUpperCase());
            }
            if (indexCodUni != 0) {
                ps.setLong(indexCodUni, lCOD_UNI_ORG);
            }
            if (indexDatIni != 0) {
                ps.setDate(indexDatIni, dtDAT_INI_LAV);
            }
            if (indexDatFin != 0) {
                ps.setDate(indexDatFin, dtDAT_FIN_LAV);
            }
            if (indexOraLav != 0) {
                ps.setString(indexOraLav, strORA_LAV.toUpperCase());
            }
            if (indexLavNot != 0) {
                ps.setString(indexLavNot, strLAV_NOT);
            }
            if (indexNumLav != 0) {
                ps.setInt(indexNumLav, iNUM_LAV_PRE);
            }
            if (indexCodFor != 0) {
                ps.setLong(indexCodFor, lAPP_COD_DTE);
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                AnaContServ_View obj = new AnaContServ_View();
                obj.COD_SRV = rs.getLong(1);
                obj.PRO_CON = rs.getString(2);
                obj.DES_CON = rs.getString(3);
                obj.RIF_CON = rs.getString(4);
                obj.COD_UNI_ORG = rs.getLong(5);
                obj.DAT_INI_LAV = rs.getDate(6);
                obj.DAT_FIN_LAV = rs.getDate(7);
                obj.ORA_LAV = rs.getString(8);
                obj.LAV_NOT = rs.getString(9);
                obj.NUM_LAV_PRE = rs.getInt(10);
                obj.APP_COD_DTE = rs.getLong(11);
                obj.RAG_SCL_DTE = rs.getString(12);
                ar.add(obj);
            }
            return ar;
        //------------------------------------------------------------//
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }/////fine della Collection ejbFindEx_AnaContServ/////
    /* DET_CMT:- - - Collezione per la costruzione della View e per la il bottone SEARCH*/
    public Collection findEx_DettComm(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON,
            long lCOD_DPD,
            String strCOM_RES_TEL,
            int jOrderParameter) {
        return (new AnaContServBean()).ejbFindEx_DettComm(
                AZL_ID,
                strPRO_CON,
                strDES_CON,
                lCOD_DPD,
                strCOM_RES_TEL,
                jOrderParameter);
    }

    public Collection ejbFindEx_DettComm(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON,
            long lCOD_DPD,
            String strCOM_RES_TEL,
            int jOrderParameter //not used for now
            ) {
        String strSql =
                "SELECT " +
                "a.cod_srv, " +
                "a.pro_con, " +
                "a.des_con, " +
                "a.dat_ini_lav, " +
                "a.dat_fin_lav," +
                "a.com_cod_dpd, " +
                "b.cod_dpd, " +
                "b.cog_dpd, " +
                "b.nom_dpd, " +
                "b.mtr_dpd, " +
                "UPPER(c.nom_fuz_azl), " +
                "a.com_res_tel, " +
                "a.app_cod_dte, " +
                "d.rag_scl_dte " +
                "FROM " +
                "ana_con_ser a " +
                "LEFT OUTER JOIN view_ana_dpd_tab b " +
                "ON (b.cod_dpd = a.com_cod_dpd) " +
                "LEFT OUTER JOIN ana_fuz_azl_tab c " +
                "ON (c.cod_fuz_azl = b.cod_fuz_azl) " +
                "LEFT OUTER JOIN ana_dte_tab d " +
                "ON (d.cod_dte = a.app_cod_dte) " +
                "WHERE " +
                "a.cod_azl=?";

        int i = 2;
        int indexPro = 0;
        if (strPRO_CON != null) {
            strSql += " AND UPPER(a.pro_con) LIKE ? ";
            indexPro = i++;
        }

        int indexDes = 0;
        if (strDES_CON != null) {
            strSql += " AND UPPER(a.des_con) LIKE ? ";
            indexDes = i++;
        }

        int indexCodDpd = 0;
        if (lCOD_DPD != 0) {
            strSql += " AND a.com_cod_dpd = ? ";
            indexCodDpd = i++;
        }

        int indexComResTel = 0;
        if (strCOM_RES_TEL != null) {
            strSql += " AND a.com_res_tel LIKE ? ";
            indexComResTel = i++;
        }

        strSql += " ORDER BY a.pro_con";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, AZL_ID);

            if (indexPro != 0) {
                ps.setString(indexPro, strPRO_CON.toUpperCase());
            }
            if (indexDes != 0) {
                ps.setString(indexDes, strDES_CON.toUpperCase());
            }
            if (indexCodDpd != 0) {
                ps.setLong(indexCodDpd, lCOD_DPD);
            }
            if (indexComResTel != 0) {
                ps.setString(indexComResTel, strCOM_RES_TEL);
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                DettComm_View obj = new DettComm_View();
                obj.COD_SRV = rs.getLong(1);
                obj.PRO_CON = rs.getString(2);
                obj.DES_CON = rs.getString(3);
                obj.DAT_INI_LAV = rs.getDate(4);
                obj.DAT_FIN_LAV = rs.getDate(5);
                obj.COM_COD_DPD = rs.getLong(6);
                obj.COD_DPD = rs.getLong(7);
                obj.COG_DPD = rs.getString(8);
                obj.NOM_DPD = rs.getString(9);
                obj.MTR_DPD = rs.getString(10);
                obj.NOM_FUZ_AZL = rs.getString(11);
                obj.COM_RES_TEL = rs.getString(12);
                obj.APP_COD_DTE = rs.getLong(13);
                obj.RAG_SCL_DTE = rs.getString(14);
                ar.add(obj);
            }
            return ar;
        //------------------------------------------------------------//
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }/////fine della Collection ejbFindEx_DettComm/////
/* DET_CMT:- - - Collezione per la costruzione della View e per la il bottone SEARCH*/
    public Collection findEx_DettAppal(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON) {
        return (new AnaContServBean()).ejbFindEx_DettAppal(
                AZL_ID,
                strPRO_CON,
                strDES_CON);
    }
    /* DET_APL:- - - Collezione per la costruzione della View e per la il bottone SEARCH*/

    public Collection ejbFindEx_DettAppal(
            long AZL_ID,
            String strPRO_CON,
            String strDES_CON) {
        String strSql =
                "SELECT " +
                "a.cod_srv, " +
                "a.pro_con, " +
                "a.des_con, " +
                "a.dat_ini_lav, " +
                "a.dat_fin_lav," +
                "a.app_tel," +
                "a.app_fax," +
                "a.app_email," +
                "a.app_res_nom," +
                "a.app_res_qua," +
                "a.app_res_tel," +
                "a.app_int_ass_des," +
                "a.app_int_ass_ora_lav," +
                "a.app_int_ass_cod_con," +
                "a.app_int_ass_con_des," +
                "a.app_cod_dte, " +
                "b.rag_scl_dte, " +
                "b.idz_dte " +
                "FROM " +
                "ana_con_ser a, " +
                "ana_dte_tab b " +
                "WHERE " +
                "a.app_cod_dte = b.cod_dte " +
                "AND " +
                "a.cod_azl=?";

        int i = 2;
        int indexPro = 0;
        if (strPRO_CON != null) {
            strSql += " AND UPPER(a.pro_con) LIKE ? ";
            indexPro = i++;
        }

        int indexDes = 0;
        if (strDES_CON != null) {
            strSql += " AND UPPER(a.des_con) LIKE ? ";
            indexDes = i++;
        }

        strSql += " ORDER BY a.pro_con";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, AZL_ID);

            if (indexPro != 0) {
                ps.setString(indexPro, strPRO_CON.toUpperCase());
            }
            if (indexDes != 0) {
                ps.setString(indexDes, strDES_CON.toUpperCase());
            }


            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                DettAppal_View obj = new DettAppal_View();
                obj.COD_SRV = rs.getLong(1);
                obj.PRO_CON = rs.getString(2);
                obj.DES_CON = rs.getString(3);
                obj.DAT_INI_LAV = rs.getDate(4);
                obj.DAT_FIN_LAV = rs.getDate(5);
                obj.APP_TEL = rs.getString(6);
                obj.APP_FAX = rs.getString(7);
                obj.APP_EMAIL = rs.getString(8);
                obj.APP_RES_NOM = rs.getString(9);
                obj.APP_RES_QUA = rs.getString(10);
                obj.APP_RES_TEL = rs.getString(11);
                obj.APP_INT_ASS_DES = rs.getString(12);
                obj.APP_INT_ASS_ORA_LAV = rs.getString(13);
                obj.APP_INT_ASS_COD_CON = rs.getInt(14);
                obj.APP_INT_ASS_CON_DES = rs.getString(15);
                obj.APP_COD_DTE = rs.getLong(16);
                obj.RAG_SCL_DTE = rs.getString(17);
                obj.IDZ_DTE = rs.getString(18);
                ar.add(obj);
            }
            return ar;
        //------------------------------------------------------------//
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }

    public String getProgressivoContratto(long lCOD_AZL, String strANNO) {
        BMPConnection bmp = getConnection();
        try {
            String returnValue = "";
            String max = "1";
            PreparedStatement ps = bmp.prepareStatement(SQLContainer.getProgressivoContratto());
            ps.setLong(1, lCOD_AZL);
            ps.setString(2, strANNO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                max = rs.getString(1);
                if (max == null) {
                    max = "1";
                }
            }
            for (int i = 0; i < 3 - max.length(); i++) {
                returnValue += "0";
            }
            return returnValue + max + "/" + strANNO;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }/////fine della Collection ejbFindEx_DettAppal/////
}/////fine dell'implementazione di AnaContServBean/////

