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
package com.apconsulting.luna.ejb.ContServSubApp;

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
public class ContServSubAppBean extends BMPEntityBean implements IContServSubApp, IContServSubAppHome {
    /* - - - - - Campi obbligatori (NOT NULL nel DB)*/

    long COD_SUB_APP;
    long COD_SRV;
    long COD_DTE;
    long COD_AZL;

    /* - - - - - Campi non obbligatori (possono essere NULL nel DB) presenti nel Form*/
    String DES_CON;
    String TEL;
    String FAX;
    String EMAIL;
    String RES_LOC_NOM;
    String RES_LOC_QUA;
    String RES_LOC_TEL;
    String INT_ASS_DES;
    String ORA_LAV;
    java.sql.Date DAT_INI_LAV;
    java.sql.Date DAT_FIN_LAV;
    String LAV_NOT;
    int COD_CON;
    String CON_DES;
    String PRO_CON;
    String RAG_SCL_DTE;
    String IDZ_DTE;
    // Costruttore.
    private static ContServSubAppBean ys = null;

    private ContServSubAppBean() {
        //
    }

    public static ContServSubAppBean getInstance() {
        if (ys == null) {
            ys = new ContServSubAppBean();
        }
        return ys;
    }

    public IContServSubApp create(
            long lCOD_SRV,
            long lCOD_DTE) throws RemoteException, CreateException {
        ContServSubAppBean bean = new ContServSubAppBean();
        try {
            Object primaryKey = bean.ejbCreate(
                    lCOD_SRV,
                    lCOD_DTE);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(
                    lCOD_SRV,
                    lCOD_DTE);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    @Override
    public void remove(Object primaryKey) {
        ContServSubAppBean bean = new ContServSubAppBean();
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

    public IContServSubApp findByPrimaryKey(Long primaryKey) throws RemoteException, FinderException {
        ContServSubAppBean bean = new ContServSubAppBean();
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
            long lCOD_SRV,
            long lCOD_DTE) {
        this.COD_SRV = lCOD_SRV;
        this.COD_DTE = lCOD_DTE;
        this.COD_SUB_APP = NEW_ID(); //per creare un ID univoco

        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO "
                    + "con_ser_sub_app "
                    + "(cod_sub_app, "
                    + "cod_srv, "
                    + "cod_dte) "
                    + "VALUES(?,?,?)");
            ps.setLong(1, COD_SUB_APP);
            ps.setLong(2, COD_SRV);
            ps.setLong(3, COD_DTE);
            ps.executeUpdate();
            return new Long(COD_SUB_APP);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_SRV,
            long lCOD_DTE) {
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE "
                    + "FROM "
                    + "con_ser_sub_app "
                    + "WHERE "
                    + "cod_sub_app=?");
            ps.setLong(1, COD_SUB_APP);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Subappaltatrice con ID=" + COD_SUB_APP + " non trovata.[ejbRemove]");
            }
        } catch (Exception ex) {
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
                    "SELECT "
                    + "cod_sub_app, "
                    + "cod_srv "
                    + "FROM "
                    + "con_ser_sub_app");
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
        this.COD_SUB_APP = ((Long) (this.getEntityKey())).longValue();
    }

    public void ejbPassivate() {
        this.COD_SUB_APP = -1;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "a.cod_sub_app, "
                    + "b.cod_srv, "
                    + "b.des_con, "
                    + "a.cod_dte, "
                    + "a.tel, "
                    + "a.fax, "
                    + "a.email, "
                    + "a.res_loc_nom, "
                    + "a.res_loc_qua, "
                    + "a.res_loc_tel, "
                    + "a.int_ass_des, "
                    + "a.ora_lav, "
                    + "a.dat_ini_lav, "
                    + "a.dat_fin_lav, "
                    + "a.lav_not, "
                    + "a.cod_con, "
                    + "a.con_des, "
                    + "b.pro_con, "
                    + "c.rag_scl_dte, "
                    + "c.idz_dte "
                    + "FROM "
                    + "con_ser_sub_app a, "
                    + "ana_con_ser b, "
                    + "ana_dte_tab c "
                    + "WHERE "
                    + "(b.cod_srv = a.cod_srv) "
                    + "AND "
                    + "(c.cod_dte = a.cod_dte) "
                    + "AND "
                    + "cod_sub_app=?");//è l'INDEX specificato nella view
            ps.setLong(1, COD_SUB_APP);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.COD_SUB_APP = rs.getLong("COD_SUB_APP");
                this.COD_SRV = rs.getLong("COD_SRV");
                this.DES_CON = rs.getString("DES_CON");
                this.COD_DTE = rs.getLong("COD_DTE");
                this.TEL = rs.getString("TEL");
                this.FAX = rs.getString("FAX");
                this.EMAIL = rs.getString("EMAIL");
                this.RES_LOC_NOM = rs.getString("RES_LOC_NOM");
                this.RES_LOC_QUA = rs.getString("RES_LOC_QUA");
                this.RES_LOC_TEL = rs.getString("RES_LOC_TEL");
                this.INT_ASS_DES = rs.getString("INT_ASS_DES");
                this.ORA_LAV = rs.getString("ORA_LAV");
                this.DAT_INI_LAV = rs.getDate("DAT_INI_LAV");
                this.DAT_FIN_LAV = rs.getDate("DAT_FIN_LAV");
                this.LAV_NOT = rs.getString("LAV_NOT");
                this.COD_CON = rs.getInt("COD_CON");
                this.CON_DES = rs.getString("CON_DES");
                this.PRO_CON = rs.getString("PRO_CON");
                this.RAG_SCL_DTE = rs.getString("RAG_SCL_DTE");
                this.IDZ_DTE = rs.getString("IDZ_DTE");
            } else {
                throw new NoSuchEntityException("Subappaltatrice con ID=" + COD_SUB_APP + " non trovata.[ejbLoad]");
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
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "UPDATE "
                    + "con_ser_sub_app "
                    + "SET "
                    + "cod_srv=?, "
                    + "cod_dte=?, "
                    + "tel=?, "
                    + "fax=?, "
                    + "email=?, "
                    + "res_loc_nom=?, "
                    + "res_loc_qua=?, "
                    + "res_loc_tel=?, "
                    + "int_ass_des=?, "
                    + "ora_lav=?, "
                    + "dat_ini_lav=?, "
                    + "dat_fin_lav=?, "
                    + "lav_not=?, "
                    + "cod_con=?, "
                    + "con_des=? "
                    + "WHERE "
                    + "cod_sub_app=? ");

            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_DTE);
            ps.setString(3, TEL);
            ps.setString(4, FAX);
            ps.setString(5, EMAIL);
            ps.setString(6, RES_LOC_NOM);
            ps.setString(7, RES_LOC_QUA);
            ps.setString(8, RES_LOC_TEL);
            ps.setString(9, INT_ASS_DES);
            ps.setString(10, ORA_LAV);
            ps.setDate(11, DAT_INI_LAV);
            ps.setDate(12, DAT_FIN_LAV);
            ps.setString(13, LAV_NOT);
            if (COD_CON != 0) {
                ps.setInt(14, COD_CON);
            } else {
                ps.setNull(14, java.sql.Types.INTEGER);
            }
            ps.setString(15, CON_DES);
            ps.setLong(16, COD_SUB_APP);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Subappaltatrice con ID=" + COD_SUB_APP + " non trovata.[ejbStore]");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    /* - - - - - Implementazione dei metodi Get per i campi obbligatori del Form*/
    public long getCOD_SUB_APP() {
        return COD_SUB_APP;
    }

    public long getCOD_SRV() {
        return COD_SRV;
    }

    public long getCOD_DTE() {
        return COD_DTE;
    }

    /* - - - - - Implementazione dei metodi Get e Set per i campi non obbligatori del Form*/
    public String getTEL() {
        return TEL;
    }

    public void setTEL(String newTEL) {
        if ((this.TEL != null) && (this.TEL.equals(newTEL))) {
            return;
        }
        this.TEL = newTEL;
        setModified();
    }

    public String getFAX() {
        return FAX;
    }

    public void setFAX(String newFAX) {
        if ((this.FAX != null) && (this.FAX.equals(newFAX))) {
            return;
        }
        this.FAX = newFAX;
        setModified();
    }

    public String getEMAIL() {
        return EMAIL;
    }

    public void setEMAIL(String newEMAIL) {
        if ((this.EMAIL != null) && (this.EMAIL.equals(newEMAIL))) {
            return;
        }
        this.EMAIL = newEMAIL;
        setModified();
    }

    public String getRES_LOC_NOM() {
        return RES_LOC_NOM;
    }

    public void setRES_LOC_NOM(String newRES_LOC_NOM) {
        if ((this.RES_LOC_NOM != null) && (this.RES_LOC_NOM.equals(newRES_LOC_NOM))) {
            return;
        }
        this.RES_LOC_NOM = newRES_LOC_NOM;
        setModified();
    }

    public String getRES_LOC_QUA() {
        return RES_LOC_QUA;
    }

    public void setRES_LOC_QUA(String newRES_LOC_QUA) {
        if ((this.RES_LOC_QUA != null) && (this.RES_LOC_QUA.equals(newRES_LOC_QUA))) {
            return;
        }
        this.RES_LOC_QUA = newRES_LOC_QUA;
        setModified();
    }

    public String getRES_LOC_TEL() {
        return RES_LOC_TEL;
    }

    public void setRES_LOC_TEL(String newRES_LOC_TEL) {
        if ((this.RES_LOC_TEL != null) && (this.RES_LOC_TEL.equals(newRES_LOC_TEL))) {
            return;
        }
        this.RES_LOC_TEL = newRES_LOC_TEL;
        setModified();
    }

    public String getINT_ASS_DES() {
        return INT_ASS_DES;
    }

    public void setINT_ASS_DES(String newINT_ASS_DES) {
        if ((this.INT_ASS_DES != null) && (this.INT_ASS_DES.equals(newINT_ASS_DES))) {
            return;
        }
        this.INT_ASS_DES = newINT_ASS_DES;
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

    public int getCOD_CON() {
        return COD_CON;
    }

    public void setCOD_CON(int newCOD_CON) {
        if (this.COD_CON == newCOD_CON) {
            return;
        }
        this.COD_CON = newCOD_CON;
        setModified();
    }

    public String getCON_DES() {
        return CON_DES;
    }

    public void setCON_DES(String newCON_DES) {
        if ((this.CON_DES != null) && (this.CON_DES.equals(newCON_DES))) {
            return;
        }
        this.CON_DES = newCON_DES;
        setModified();
    }

    public String getDES_CON() {
        return DES_CON;
    }

    public String getPRO_CON() {
        return PRO_CON;
    }

    public String getRAG_SCL_DTE() {
        return RAG_SCL_DTE;
    }

    public String getIDZ_DTE() {
        return IDZ_DTE;
    }

    public long getCodSrvByCodSubApp(long SUB_APP_ID) {
        long CodSrv = 0;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "cod_srv "
                    + "FROM "
                    + "con_ser_sub_app "
                    + "WHERE "
                    + "cod_sub_app = ? ");
            ps.setLong(1, SUB_APP_ID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CodSrv = rs.getLong(1);
            }
            return CodSrv;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // - - - - - Collezione per la costruzione della View e per la il bottone SEARCH
    public Collection findEx_SubApp(
            long AZL_ID,
            long lCOD_SRV,
            long lCOD_DTE,
            String strRES_LOC_NOM,
            int iOrderParameter) {
        return (new ContServSubAppBean()).ejbFindEx_SubApp(
                AZL_ID,
                lCOD_SRV,
                lCOD_DTE,
                strRES_LOC_NOM,
                iOrderParameter);
    }

    public Collection ejbFindEx_SubApp(
            long AZL_ID,
            long lCOD_SRV,
            long lCOD_DTE,
            String strRES_LOC_NOM,
            int iOrderParameter //not used for now
            ) {
        String strSql =
                "SELECT "
                + "a.cod_sub_app, "
                + "a.cod_dte, "
                + "a.res_loc_nom, "
                + "a.int_ass_des, "
                + "a.dat_ini_lav, "
                + "a.dat_fin_lav, "
                + "a.cod_srv, "
                + "b.pro_con, "
                + "c.rag_scl_dte, "
                + "a.tel, "
                + "a.fax, "
                + "a.email, "
                + "a.ora_lav, "
                + "a.lav_not, "
                + "a.res_loc_tel, "
                + "a.res_loc_qua, "
                + "a.cod_con, "
                + "a.con_des "
                + "FROM "
                + "con_ser_sub_app a, "
                + "ana_con_ser b, "
                + "ana_dte_tab c "
                + "WHERE "
                + "(b.cod_srv = a.cod_srv) "
                + "AND "
                + "(c.cod_dte = a.cod_dte) "
                + "AND "
                + "b.cod_azl=?";

        int i = 2;

        int indexCodDte = 0;
        if (lCOD_DTE != 0) {
            strSql += "AND a.cod_dte = ? ";
            indexCodDte = i++;
        }

        int indexResLocNom = 0;
        if (strRES_LOC_NOM != null) {
            strSql += "AND UPPER(a.res_loc_nom) LIKE ? ";
            indexResLocNom = i++;
        }

        int indexCodSrv = 0;
        if (lCOD_SRV != 0) {
            strSql += "AND a.cod_srv = ? ";
            indexCodSrv = i++;
        }

        strSql += " ORDER BY b.pro_con";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, AZL_ID);

            if (indexCodDte != 0) {
                ps.setLong(indexCodDte, lCOD_DTE);
            }
            if (indexResLocNom != 0) {
                ps.setString(indexResLocNom, strRES_LOC_NOM.toUpperCase());
            }
            if (indexCodSrv != 0) {
                ps.setLong(indexCodSrv, lCOD_SRV);
            }

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                SubApp_View obj = new SubApp_View();
                obj.COD_SUB_APP = rs.getLong(1);
                obj.COD_DTE = rs.getLong(2);
                obj.RES_LOC_NOM = rs.getString(3);
                obj.INT_ASS_DES = rs.getString(4);
                obj.DAT_INI_LAV = rs.getDate(5);
                obj.DAT_FIN_LAV = rs.getDate(6);
                obj.COD_SRV = rs.getLong(7);
                obj.PRO_CON = rs.getString(8);
                obj.RAG_SCL_DTE = rs.getString(9);
                obj.TEL = rs.getString(10);
                obj.FAX = rs.getString(11);
                obj.EMAIL = rs.getString(12);
                obj.ORA_LAV = rs.getString(13);
                obj.LAV_NOT = rs.getString(14);
                obj.RES_LOC_TEL = rs.getString(15);
                obj.RES_LOC_QUA = rs.getString(16);
                obj.COD_CON = rs.getByte(17);
                obj.CON_DES = rs.getString(18);
                ar.add(obj);
            }
            return ar;
            //------------------------------------------------------------//
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }/////fine della Collection ejbFindEx_SubApp/////
}/////fine dell'implementazione di AnaContServBean/////

