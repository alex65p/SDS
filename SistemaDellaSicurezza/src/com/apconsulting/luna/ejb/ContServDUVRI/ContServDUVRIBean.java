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
package com.apconsulting.luna.ejb.ContServDUVRI;

import java.sql.Blob;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Collection;
import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.FinderException;
import javax.ejb.NoSuchEntityException;
import s2s.ejb.pseudoejb.BMPConnection;
import s2s.ejb.pseudoejb.BMPConnection.ConnectionType;
import s2s.ejb.pseudoejb.BMPEntityBean;
import s2s.ejb.pseudoejb.EntityContextWrapper;

/**
 *
 * @author Dario
 */
public class ContServDUVRIBean
        extends BMPEntityBean
        implements IContServDUVRI,
        IContServDUVRIHome {

    // Variabili membro.
    long COD_SRV;
    long COD_PRO_DUV;
    String PRO_DUV;
    java.sql.Date DAT_DUV;
    ContServDUVRIPK primaryKEY;
    // Costruttore.
    private static ContServDUVRIBean ys = null;

    private ContServDUVRIBean() {
        //
    }

    public static ContServDUVRIBean getInstance() {
        if (ys == null) {
            ys = new ContServDUVRIBean();
        }
        return ys;
    }

    // (Home Intrface) create()
    public IContServDUVRI create(
            long lCOD_SRV,
            String strPRO_DUV,
            java.sql.Date dtDAT_DUV,
            byte[] pdfGen,
            byte[] xmlGen) throws CreateException {
        ContServDUVRIBean bean = new ContServDUVRIBean();
        try {
            ContServDUVRIPK primaryKey =
                    bean.ejbCreate(lCOD_SRV, strPRO_DUV, dtDAT_DUV, pdfGen, xmlGen);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_SRV, strPRO_DUV, dtDAT_DUV);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        ContServDUVRIBean bean = new ContServDUVRIBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((ContServDUVRIPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IContServDUVRI findByPrimaryKey(ContServDUVRIPK primaryKey) throws FinderException {
        ContServDUVRIBean bean = new ContServDUVRIBean();
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

    public ContServDUVRIPK ejbCreate(
            long lCOD_SRV,
            String strPRO_DUV,
            java.sql.Date dtDAT_DUV,
            byte[] pdfGen,
            byte[] xmlGen) {
        this.COD_SRV = lCOD_SRV;
        this.PRO_DUV = strPRO_DUV;
        this.DAT_DUV = dtDAT_DUV;
        this.COD_PRO_DUV = NEW_ID();
        this.unsetModified();
        BMPConnection bmp = getConnection();
        bmp.beginTrans();

        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO "
                    + "con_ser_duvri "
                    + "(cod_srv, "
                    + "cod_pro_duv, "
                    + "pro_duv, "
                    + "dat_duv, "
                    + "pdf_gen) "
                    + "VALUES "
                    + "(?,?,?,?,?)");
            ps.setLong(1, this.COD_SRV);
            ps.setLong(2, this.COD_PRO_DUV);
            ps.setString(3, this.PRO_DUV);
            ps.setDate(4, this.DAT_DUV);
            ps.setBytes(5, pdfGen);
            ps.executeUpdate();

            // Questo update viene fatto separatamente perchè Oracle ha dei
            // problemi nell'inserire due campi Blob nella stessa operazione.
            ps = bmp.prepareStatement(
                    "UPDATE "
                    + "con_ser_duvri "
                    + "SET "
                    + "xml_gen=?"
                    + "WHERE "
                    + "cod_pro_duv=?");
            ps.setBytes(1, xmlGen);
            ps.setLong(2, COD_PRO_DUV);
            ps.executeUpdate();

            bmp.commitTrans();

            return new ContServDUVRIPK(COD_SRV, COD_PRO_DUV);
        } catch (Exception ex) {
            bmp.rollbackTrans();
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_SRV,
            String strPRO_DUV,
            java.sql.Date dtDAT_DUV) {
    }

    public Collection ejbFindAll() {
        return null;
    }

    public ContServDUVRIPK ejbFindByPrimaryKey(ContServDUVRIPK primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.primaryKEY = ((ContServDUVRIPK) this.getEntityKey());
        this.COD_SRV = primaryKEY.COD_SRV;
        this.COD_PRO_DUV = primaryKEY.COD_PRO_DUV;
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
                    + "a.cod_pro_duv, "
                    + "a.pro_duv, "
                    + "a.dat_duv "
                    + "FROM "
                    + "con_ser_duvri a, "
                    + "ana_con_ser b "
                    + "WHERE "
                    + "( b.cod_srv = a.cod_srv ) "
                    + "AND "
                    + "a.cod_srv = ? "
                    + "AND "
                    + "a.cod_pro_duv = ? ");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_PRO_DUV);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.PRO_DUV = rs.getString("PRO_DUV");
                this.DAT_DUV = rs.getDate("DAT_DUV");
            } else {
                throw new NoSuchEntityException("DUVRI con ID=" + COD_SRV + " - " + COD_PRO_DUV + " non trovato.");
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
                    + "con_ser_duvri "
                    + "WHERE "
                    + "cod_srv = ? "
                    + "AND "
                    + "cod_pro_duv = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_PRO_DUV);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DUVRI con ID=" + COD_SRV + " - " + COD_PRO_DUV + " non trovato.");
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
                    + "con_ser_duvri "
                    + "SET "
                    + "pro_duv = ?, "
                    + "dat_duv = ? "
                    + "WHERE "
                    + "cod_srv = ? "
                    + "AND "
                    + "cod_pro_duv = ? ");

            ps.setString(1, PRO_DUV);
            ps.setDate(2, DAT_DUV);

            // Clausole di where
            ps.setLong(3, COD_SRV);
            ps.setLong(4, COD_PRO_DUV);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("DUVRI con ID=" + COD_SRV + " - " + COD_PRO_DUV + " non trovato.");
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

    // COD_PRO_DUV
    public long getCOD_PRO_DUV() {
        return COD_PRO_DUV;
    }

    // PRO_DUV
    public void setPRO_DUV(String newPRO_DUV) {
        if (PRO_DUV != null) {
            if (PRO_DUV.equals(newPRO_DUV)) {
                return;
            }
        }
        PRO_DUV = newPRO_DUV;
        setModified();
    }

    public String getPRO_DUV() {
        return PRO_DUV;
    }

    // DAT_DUV
    public java.sql.Date getDAT_DUV() {
        return DAT_DUV;
    }

    public void setDAT_DUV(java.sql.Date newDAT_DUV) {
        if (DAT_DUV != null) {
            if (DAT_DUV.equals(newDAT_DUV)) {
                return;
            }
        }
        DAT_DUV = newDAT_DUV;
        setModified();
    }

    public String getProgressivoDUVRI(long lCOD_AZL, long lCOD_SRV, String strPRO_CON) {
        BMPConnection bmp = getConnection();
        try {
            String returnValue = "";
            String max = "1";
            PreparedStatement ps = bmp.prepareStatement(SQLContainer.getProgressivoDUVRI());
            ps.setLong(1, lCOD_AZL);
            ps.setLong(2, lCOD_SRV);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                max = rs.getString(1);
                if (max == null) {
                    max = "1";
                }
            }
            for (int i = 0; i < 2 - max.length(); i++) {
                returnValue += "0";
            }
            return (strPRO_CON + " - " + returnValue + max);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public Collection findEx_ContServDUVRI(
            long lCOD_SRV) {
        return (new ContServDUVRIBean()).ejbFindEx_ContServDUVRI(
                lCOD_SRV);
    }

    public Collection ejbFindEx_ContServDUVRI(
            long lCOD_SRV) {
        String strSql =
                "SELECT "
                + "a.cod_srv, "
                + "a.cod_pro_duv, "
                + "a.pro_duv, "
                + "a.dat_duv "
                + "FROM "
                + "con_ser_duvri a, "
                + "ana_con_ser b "
                + "WHERE "
                + "( b.cod_srv = a.cod_srv ) "
                + "AND "
                + "a.cod_srv = ? ";

        strSql += " ORDER BY a.pro_duv";

        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(strSql);
            ps.setLong(1, lCOD_SRV);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList ar = new java.util.ArrayList();
            while (rs.next()) {
                ContServDUVRI_View obj = new ContServDUVRI_View();
                obj.COD_SRV = rs.getLong(1);
                obj.COD_PRO_DUV = rs.getLong(2);
                obj.PRO_DUV = rs.getString(3);
                obj.DAT_DUV = rs.getDate(4);
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

    public byte[] downloadFile(long lCOD_PRO_DUV) {
        BMPConnection bmp = getConnection();
        try {
            byte[] bt = null;
            Blob bb;
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "pdf_gen "
                    + "FROM "
                    + "con_ser_duvri "
                    + "WHERE "
                    + "cod_pro_duv=?");
            ps.setLong(1, lCOD_PRO_DUV);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (bmp.getType() == ConnectionType.POSTGRE) {
                    bt = rs.getBytes(1);
                } else if (bmp.getType() == ConnectionType.ORACLE) {
                    bb = rs.getBlob(1);
                    if (rs.wasNull()) {
                        bt = null;
                    } else {
                        bt = bb.getBytes(1, (int) bb.length());
                    }
                } else if (bmp.getType() == ConnectionType.DB2) {
                    bt = rs.getBytes(1);
                }
            } else {
                bt = null;
            }
            rs.close();
            ps.close();
            return bt;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }
    /////fine della Collection ejbFindEx_ContServDUVRI/////
}/////fine della classe ContServDUVRIBean/////

