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
package com.apconsulting.luna.ejb.ContServServiziSanitari;

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
public class ContServServiziSanitariBean
        extends BMPEntityBean
        implements IContServServiziSanitari,
        IContServServiziSanitariHome {
    // Variabili membro.

    long COD_SRV;
    long COD_SRV_SAN;
    String DES_SRV_VIT;
    java.sql.Date DAT_INI_IMP;
    java.sql.Date DAT_FIN_IMP;
    String ORA_IMP;
    ContServServiziSanitariPK primaryKEY;
    String PRO_CON;
    String DES_CON;
    // Costruttore.
    private static ContServServiziSanitariBean ys = null;

    private ContServServiziSanitariBean() {
        //
    }

    public static ContServServiziSanitariBean getInstance() {
        if (ys == null) {
            ys = new ContServServiziSanitariBean();
        }
        return ys;
    }

    // (Home Intrface) create()
    public IContServServiziSanitari create(
            long lCOD_SRV, String strDES_SRV_VIT) throws CreateException {
        ContServServiziSanitariBean bean = new ContServServiziSanitariBean();
        try {
            ContServServiziSanitariPK primaryKey =
                    bean.ejbCreate(lCOD_SRV, strDES_SRV_VIT);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_SRV, strDES_SRV_VIT);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        ContServServiziSanitariBean bean = new ContServServiziSanitariBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((ContServServiziSanitariPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IContServServiziSanitari findByPrimaryKey(ContServServiziSanitariPK primaryKey) throws FinderException {
        ContServServiziSanitariBean bean = new ContServServiziSanitariBean();
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

    public ContServServiziSanitariPK ejbCreate(
            long lCOD_SRV,
            String strDES_SRV_VIT) {
        this.COD_SRV = lCOD_SRV;
        this.DES_SRV_VIT = strDES_SRV_VIT;
        this.COD_SRV_SAN = NEW_ID();
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO "
                    + "con_ser_ser_san "
                    + "(cod_srv, "
                    + "des_srv_vit, "
                    + "cod_srv_san) "
                    + "VALUES "
                    + "(?,?,?)");
            ps.setLong(1, this.COD_SRV);
            ps.setString(2, this.DES_SRV_VIT);
            ps.setLong(3, this.COD_SRV_SAN);
            ps.executeUpdate();
            return new ContServServiziSanitariPK(COD_SRV, COD_SRV_SAN);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_SRV, String strDES_SRV_VIT) {
    }

    public Collection ejbFindAll() {
        return null;
    }

    public ContServServiziSanitariPK ejbFindByPrimaryKey(ContServServiziSanitariPK primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.primaryKEY = ((ContServServiziSanitariPK) this.getEntityKey());
        this.COD_SRV = primaryKEY.COD_SRV;
        this.COD_SRV_SAN = primaryKEY.COD_SRV_SAN;
    }

    public void ejbPassivate() {
        this.primaryKEY = null;
    }

    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "a.cod_srv, "
                    + "a.cod_srv_san, "
                    + "a.des_srv_vit, "
                    + "a.dat_ini_imp, "
                    + "a.dat_fin_imp, "
                    + "a.ora_imp, "
                    + "b.pro_con, "
                    + "b.des_con "
                    + "FROM "
                    + "con_ser_ser_san a, "
                    + "ana_con_ser b "
                    + "WHERE "
                    + "( b.cod_srv = a.cod_srv ) "
                    + "AND "
                    + "a.cod_srv = ? "
                    + "AND "
                    + "a.cod_srv_san = ? ");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_SRV_SAN);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.DES_SRV_VIT = rs.getString("DES_SRV_VIT");
                this.DAT_INI_IMP = rs.getDate("DAT_INI_IMP");
                this.DAT_FIN_IMP = rs.getDate("DAT_FIN_IMP");
                this.ORA_IMP = rs.getString("ORA_IMP");
                this.PRO_CON = rs.getString("PRO_CON");
                this.DES_CON = rs.getString("DES_CON");
            } else {
                throw new NoSuchEntityException("Servizio sanitario con ID=" + COD_SRV + "-" + COD_SRV_SAN + " non trovato.");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbRemove() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "DELETE FROM "
                    + "con_ser_ser_san  "
                    + "WHERE "
                    + "cod_srv = ? "
                    + "AND "
                    + "cod_srv_san = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_SRV_SAN);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Servizio sanitario con ID=" + COD_SRV + "-" + COD_SRV_SAN + " non trovato.");
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
                    + "con_ser_ser_san "
                    + "SET "
                    + "des_srv_vit=?, "
                    + "dat_ini_imp=?, "
                    + "dat_fin_imp=?, "
                    + "ora_imp=? "
                    + "WHERE "
                    + "cod_srv = ? "
                    + "AND "
                    + "cod_srv_san = ?");

            ps.setString(1, DES_SRV_VIT);
            ps.setDate(2, DAT_INI_IMP);
            ps.setDate(3, DAT_FIN_IMP);
            ps.setString(4, ORA_IMP);

            // Clausole di where
            ps.setLong(5, COD_SRV);
            ps.setLong(6, COD_SRV_SAN);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Servizio sanitario con ID=" + COD_SRV + "-" + COD_SRV_SAN + " non trovato.");
            }
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    // Metodi dell'interfaccia remota. (get e set)
    // COD_SRV
    public long getCOD_SRV() {
        return COD_SRV;
    }

    // COD_SRV_SAN
    public long getCOD_SRV_SAN() {
        return COD_SRV_SAN;
    }

    // DES_SRV_VIT
    public void setDES_SRV_VIT(String newDES_SRV_VIT) {
        if (DES_SRV_VIT != null) {
            if (DES_SRV_VIT.equals(newDES_SRV_VIT)) {
                return;
            }
        }
        DES_SRV_VIT = newDES_SRV_VIT;
        setModified();
    }

    public String getDES_SRV_VIT() {
        return DES_SRV_VIT;
    }

    public java.sql.Date getDAT_INI_IMP() {
        return DAT_INI_IMP;
    }

    public void setDAT_INI_IMP(java.sql.Date newDAT_INI_IMP) {
        if (DAT_INI_IMP != null) {
            if (DAT_INI_IMP.equals(newDAT_INI_IMP)) {
                return;
            }
        }
        DAT_INI_IMP = newDAT_INI_IMP;
        setModified();
    }

    public java.sql.Date getDAT_FIN_IMP() {
        return DAT_FIN_IMP;
    }

    public void setDAT_FIN_IMP(java.sql.Date newDAT_FIN_IMP) {
        if (DAT_FIN_IMP != null) {
            if (DAT_FIN_IMP.equals(newDAT_FIN_IMP)) {
                return;
            }
        }
        DAT_FIN_IMP = newDAT_FIN_IMP;
        setModified();
    }

    // ORA_IMP
    public void setORA_IMP(String newORA_IMP) {
        if (ORA_IMP != null) {
            if (ORA_IMP.equals(newORA_IMP)) {
                return;
            }
        }
        ORA_IMP = newORA_IMP;
        setModified();
    }

    public String getORA_IMP() {
        return ORA_IMP;
    }

    public boolean getInfoOnDescServiziSanitari(long SRV_ID) {
        boolean vuoto = false;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "cod_srv_san "
                    + "FROM "
                    + "con_ser_ser_san "
                    + "WHERE "
                    + "cod_srv=?");
            ps.setLong(1, SRV_ID);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                vuoto = true;
            }
            return vuoto;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx_ServiziSanitari(
            long lCOD_SRV,
            long lCOD_SRV_SAN,
            String strDES_SRV_VIT,
            java.sql.Date dtDAT_INI_IMP,
            java.sql.Date dtDAT_FIN_IMP,
            String strORA_IMP,
            int iOrderParameter) {
        return (new ContServServiziSanitariBean()).ejbFindEx_ServiziSanitari(
                lCOD_SRV,
                lCOD_SRV_SAN,
                strDES_SRV_VIT,
                dtDAT_INI_IMP,
                dtDAT_FIN_IMP,
                strORA_IMP,
                iOrderParameter);
    }

    public Collection ejbFindEx_ServiziSanitari(
            long lCOD_SRV,
            long lCOD_SRV_SAN,
            String strDES_SRV_VIT,
            java.sql.Date dtDAT_INI_IMP,
            java.sql.Date dtDAT_FIN_IMP,
            String strORA_IMP,
            int iOrderParameter //not used for now
            ) {
        String strSql =
                "SELECT "
                + "a.cod_srv, "
                + "a.cod_srv_san, "
                + "a.des_srv_vit, "
                + "a.dat_ini_imp, "
                + "a.dat_fin_imp, "
                + "a.ora_imp "
                + "FROM "
                + "con_ser_ser_san a, "
                + "ana_con_ser b "
                + "WHERE "
                + "( b.cod_srv = a.cod_srv ) "
                + "AND "
                + "a.cod_srv = ? ";

        strSql += " ORDER BY b.pro_con";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, lCOD_SRV);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ServiziSanitari_View obj = new ServiziSanitari_View();
                obj.COD_SRV = rs.getLong(1);
                obj.COD_SRV_SAN = rs.getLong(2);
                obj.DES_SRV_VIT = rs.getString(3);
                obj.DAT_INI_IMP = rs.getDate(4);
                obj.DAT_FIN_IMP = rs.getDate(5);
                obj.ORA_IMP = rs.getString(6);
                //obj.PRO_CON = rs.getString(7);
                //obj.DES_CON = rs.getString(8);
                ar.add(obj);
            }
            return ar;
            //------------------------------------------------------------//
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }/////fine della Collection ejbFindEx_ServiziSanitari/////
}/////fine della classe ContServServiziSanitariBean/////

