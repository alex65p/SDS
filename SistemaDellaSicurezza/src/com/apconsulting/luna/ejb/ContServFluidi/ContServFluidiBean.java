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
package com.apconsulting.luna.ejb.ContServFluidi;

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
public class ContServFluidiBean
        extends BMPEntityBean
        implements IContServFluidi,
        IContServFluidiHome {
    // Variabili membro.

    long COD_SRV;
    long COD_FLU;
    String TIP_FLU_DIS;
    String LUO_COL;
    java.sql.Date DAT_INI_CON;
    java.sql.Date DAT_FIN_CON;
    ContServFluidiPK primaryKEY;
    String PRO_CON;
    String DES_CON;
    // Costruttore.
    private static ContServFluidiBean ys = null;

    private ContServFluidiBean() {
        //
    }

    public static ContServFluidiBean getInstance() {
        if (ys == null) {
            ys = new ContServFluidiBean();
        }
        return ys;
    }

    // (Home Intrface) create()
    public IContServFluidi create(
            long lCOD_SRV, String strTIP_FLU_DIS) throws CreateException {
        ContServFluidiBean bean = new ContServFluidiBean();
        try {
            ContServFluidiPK primaryKey =
                    bean.ejbCreate(lCOD_SRV, strTIP_FLU_DIS);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_SRV, strTIP_FLU_DIS);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }

    // (Home Intrface) remove()
    @Override
    public void remove(Object primaryKey) {
        ContServFluidiBean bean = new ContServFluidiBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((ContServFluidiPK) primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }

    // (Home Intrface) findByPrimaryKey()
    public IContServFluidi findByPrimaryKey(ContServFluidiPK primaryKey) throws FinderException {
        ContServFluidiBean bean = new ContServFluidiBean();
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

    public ContServFluidiPK ejbCreate(
            long lCOD_SRV,
            String strTIP_FLU_DIS) {
        this.COD_SRV = lCOD_SRV;
        this.TIP_FLU_DIS = strTIP_FLU_DIS;
        this.COD_FLU = NEW_ID();
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "INSERT INTO "
                    + "con_ser_flu "
                    + "(cod_srv, "
                    + "tip_flu_dis, "
                    + "cod_flu) "
                    + "VALUES "
                    + "(?,?,?)");
            ps.setLong(1, this.COD_SRV);
            ps.setString(2, this.TIP_FLU_DIS);
            ps.setLong(3, this.COD_FLU);
            ps.executeUpdate();
            return new ContServFluidiPK(COD_SRV, COD_FLU);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_SRV,
            String strTIP_FLU_DIS) {
    }

    public Collection ejbFindAll() {
        return null;
    }

    public ContServFluidiPK ejbFindByPrimaryKey(ContServFluidiPK primaryKey) {
        return primaryKey;
    }

    public void ejbActivate() {
        this.primaryKEY = ((ContServFluidiPK) this.getEntityKey());
        this.COD_SRV = primaryKEY.COD_SRV;
        this.COD_FLU = primaryKEY.COD_FLU;
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
                    + "a.cod_flu, "
                    + "a.tip_flu_dis, "
                    + "a.luo_col, "
                    + "a.dat_ini_con, "
                    + "a.dat_fin_con, "
                    + "b.pro_con, "
                    + "b.des_con "
                    + "FROM "
                    + "con_ser_flu a, "
                    + "ana_con_ser b "
                    + "WHERE "
                    + "( b.cod_srv = a.cod_srv ) "
                    + "AND "
                    + "a.cod_srv = ? "
                    + "AND "
                    + "a.cod_flu = ? ");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_FLU);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.TIP_FLU_DIS = rs.getString("TIP_FLU_DIS");
                this.LUO_COL = rs.getString("LUO_COL");
                this.DAT_INI_CON = rs.getDate("DAT_INI_CON");
                this.DAT_FIN_CON = rs.getDate("DAT_FIN_CON");
                this.PRO_CON = rs.getString("PRO_CON");
                this.DES_CON = rs.getString("DES_CON");
            } else {
                throw new NoSuchEntityException("Fluido con ID=" + COD_SRV + "-" + COD_FLU + " non trovato.[ejbLoad]");
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
                    + "con_ser_flu  "
                    + "WHERE "
                    + "cod_srv = ? "
                    + "AND "
                    + "cod_flu = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_FLU);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Fluido con ID=" + COD_SRV + "-" + COD_FLU + " non trovato.[ejbRemove]");
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
                    + "con_ser_flu "
                    + "SET "
                    + "tip_flu_dis=?, "
                    + "luo_col=?, "
                    + "dat_ini_con=?, "
                    + "dat_fin_con=? "
                    + "WHERE "
                    + "cod_srv = ? "
                    + "AND "
                    + "cod_flu = ?");

            ps.setString(1, TIP_FLU_DIS);
            ps.setString(2, LUO_COL);
            ps.setDate(3, DAT_INI_CON);
            ps.setDate(4, DAT_FIN_CON);

            // Clausole di where
            ps.setLong(5, COD_SRV);
            ps.setLong(6, COD_FLU);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Fluido con ID=" + COD_SRV + "-" + COD_FLU + " non trovato.[ejbStore]");
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

    // COD_FLU
    public long getCOD_FLU() {
        return COD_FLU;
    }

    // TIP_FLU_DIS
    public void setTIP_FLU_DIS(String newTIP_FLU_DIS) {
        if (TIP_FLU_DIS != null) {
            if (TIP_FLU_DIS.equals(newTIP_FLU_DIS)) {
                return;
            }
        }
        TIP_FLU_DIS = newTIP_FLU_DIS;
        setModified();
    }

    public String getTIP_FLU_DIS() {
        return TIP_FLU_DIS;
    }

    // LUO_COL
    public void setLUO_COL(String newLUO_COL) {
        if (LUO_COL != null) {
            if (LUO_COL.equals(newLUO_COL)) {
                return;
            }
        }
        LUO_COL = newLUO_COL;
        setModified();
    }

    public String getLUO_COL() {
        return LUO_COL;
    }

    public java.sql.Date getDAT_INI_CON() {
        return DAT_INI_CON;
    }

    public void setDAT_INI_CON(java.sql.Date newDAT_INI_CON) {
        if (DAT_INI_CON != null) {
            if (DAT_INI_CON.equals(newDAT_INI_CON)) {
                return;
            }
        }
        DAT_INI_CON = newDAT_INI_CON;
        setModified();
    }

    public java.sql.Date getDAT_FIN_CON() {
        return DAT_FIN_CON;
    }

    public void setDAT_FIN_CON(java.sql.Date newDAT_FIN_CON) {
        if (DAT_FIN_CON != null) {
            if (DAT_FIN_CON.equals(newDAT_FIN_CON)) {
                return;
            }
        }
        DAT_FIN_CON = newDAT_FIN_CON;
        setModified();
    }

    public boolean getInfoOnDescFluidi(long SRV_ID) {
        boolean vuoto = false;
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT "
                    + "cod_flu "
                    + "FROM "
                    + "con_ser_flu "
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

    public Collection findEx_Fluidi(
            long lCOD_SRV,
            long lCOD_FLU,
            String strTIP_FLU_DIS,
            String strLUO_COL,
            java.sql.Date dtDAT_INI_CON,
            java.sql.Date dtDAT_FIN_CON,
            int iOrderParameter) {
        return (new ContServFluidiBean()).ejbFindEx_Fluidi(
                lCOD_SRV,
                lCOD_FLU,
                strTIP_FLU_DIS,
                strLUO_COL,
                dtDAT_INI_CON,
                dtDAT_FIN_CON,
                iOrderParameter);
    }

    public Collection ejbFindEx_Fluidi(
            long lCOD_SRV,
            long lCOD_FLU,
            String strTIP_FLU_DIS,
            String strLUO_COL,
            java.sql.Date dtDAT_INI_CON,
            java.sql.Date dtDAT_FIN_CON,
            int iOrderParameter //not used for now
            ) {
        String strSql =
                "SELECT "
                + "a.cod_srv, "
                + "a.cod_flu, "
                + "a.tip_flu_dis, "
                + "a.luo_col, "
                + "a.dat_ini_con, "
                + "a.dat_fin_con "
                + "FROM "
                + "con_ser_flu a, "
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
                Fluidi_View obj = new Fluidi_View();
                obj.COD_SRV = rs.getLong(1);
                obj.COD_FLU = rs.getLong(2);
                obj.TIP_FLU_DIS = rs.getString(3);
                obj.LUO_COL = rs.getString(4);
                obj.DAT_INI_CON = rs.getDate(5);
                obj.DAT_FIN_CON = rs.getDate(6);
                ar.add(obj);
            }
            return ar;
            //------------------------------------------------------------//
        } catch (Exception ex) {
            throw new EJBException(strSql + "/n" + ex);
        } finally {
            bmp.close();
        }
    }/////fine della Collection ejbFindEx_Fluidi/////
}/////fine della classe ContServFluidiBean/////

