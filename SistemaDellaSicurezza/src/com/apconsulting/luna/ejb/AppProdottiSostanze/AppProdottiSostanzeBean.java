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

package com.apconsulting.luna.ejb.AppProdottiSostanze;

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
 public class AppProdottiSostanzeBean
            extends BMPEntityBean
            implements IAppProdottiSostanze,
            IAppProdottiSostanzeHome {

        // Variabili membro.
        long COD_SRV;
        long COD_PRO_SOS;
        String DES;
        AppProdottiSostanzePK primaryKEY;


        private static AppProdottiSostanzeBean ys = null;
        // Costruttore.
        private AppProdottiSostanzeBean() {
            //
        }

    public static AppProdottiSostanzeBean getInstance() {
        if (ys == null) {
            ys = new AppProdottiSostanzeBean();
        }
        return ys;
    }
        // (Home Intrface) create()
        public IAppProdottiSostanze create(
                long lCOD_SRV,
                String strDES) throws CreateException {
            AppProdottiSostanzeBean bean = new AppProdottiSostanzeBean();
            try {
                AppProdottiSostanzePK primaryKey =
                        bean.ejbCreate(lCOD_SRV, strDES);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_SRV, strDES);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            AppProdottiSostanzeBean bean = new AppProdottiSostanzeBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((AppProdottiSostanzePK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IAppProdottiSostanze findByPrimaryKey(AppProdottiSostanzePK primaryKey) throws FinderException {
            AppProdottiSostanzeBean bean = new AppProdottiSostanzeBean();
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

        public AppProdottiSostanzePK ejbCreate(
                long lCOD_SRV,
                String strDES) {
            this.COD_SRV = lCOD_SRV;
            this.DES = strDES;
            this.COD_PRO_SOS = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                            "app_pro_sos " +
                            "(cod_srv, " +
                            "des, " +
                            "cod_pro_sos) " +
                        "VALUES " +
                            "(?,?,?)");
                ps.setLong(1, this.COD_SRV);
                ps.setString(2, this.DES);
                ps.setLong(3, this.COD_PRO_SOS);
                ps.executeUpdate();
                return new AppProdottiSostanzePK(COD_SRV, COD_PRO_SOS);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_SRV, String strDES) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public AppProdottiSostanzePK ejbFindByPrimaryKey(AppProdottiSostanzePK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((AppProdottiSostanzePK) this.getEntityKey());
            this.COD_SRV = primaryKEY.COD_SRV;
            this.COD_PRO_SOS = primaryKEY.COD_PRO_SOS;
        }

        public void ejbPassivate() {
            this.primaryKEY = null;
        }

        public void ejbLoad() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                            "a.cod_srv, " +
                            "a.cod_pro_sos, " +
                            "a.des " +
                        "FROM " +
                            "app_pro_sos a, " +
                            "ana_con_ser b " +
                        "WHERE " +
                            "a.cod_srv = b.cod_srv " +
                        "AND " +
                            "a.cod_srv = ? " +
                        "AND " +
                            "a.cod_pro_sos = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_PRO_SOS);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.DES = rs.getString("DES");
                } else {
                    throw new NoSuchEntityException("Prodotto/Sostanza con ID=" + COD_SRV + " - " + COD_PRO_SOS + " non trovato.");
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
                        "DELETE FROM " +
                            "app_pro_sos " +
                        "WHERE " +
                            "cod_srv = ? " +
                        "AND " +
                            "cod_pro_sos = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_PRO_SOS);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Prodotto/Sostanza con ID=" + COD_SRV + " - " + COD_PRO_SOS + " non trovato.");
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
                        "UPDATE " +
                            "app_pro_sos " +
                        "SET " +
                            "des = ? " +
                        "WHERE " +
                            "cod_srv = ? " +
                        "AND " +
                            "cod_pro_sos = ? ");

                ps.setString(1, DES);

                // Clausole di where
                ps.setLong(2, COD_SRV);
                ps.setLong(3, COD_PRO_SOS);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Prodotto/Sostanza con ID=" + COD_SRV + " - " + COD_PRO_SOS + " non trovato.");
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

        // COD_PRO_SOS
        public long getCOD_PRO_SOS() {
            return COD_PRO_SOS;
        }

        // DES
        public String getDES() {
            return DES;
        }

        public void setDES(String newDES) {
            if (DES != null) {
                if (DES.equals(newDES)) {
                    return;
                }
            }
            DES = newDES;
            setModified();
        }

        public boolean getInfoOnDescProdottiSostanzeApp(long SRV_ID) {
            boolean vuoto = false;
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                            "cod_pro_sos " +
                        "FROM " +
                            "app_pro_sos " +
                        "WHERE " +
                            "cod_srv = ? ");
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

        public Collection findEx_ProdottiSostanzeApp(
                long lCOD_SRV,
                long lCOD_PRO_SOS,
                String strDES,
                int iOrderParameter) {
            return (new AppProdottiSostanzeBean()).ejbFindEx_ProdottiSostanzeApp(
                    lCOD_SRV,
                    lCOD_PRO_SOS,
                    strDES,
                    iOrderParameter);
        }

        public Collection ejbFindEx_ProdottiSostanzeApp(
                long lCOD_SRV,
                long lCOD_PRO_SOS,
                String strDES,
                int iOrderParameter //not used for now
                ) {
            String strSql =
                    "SELECT " +
                        "a.cod_srv, " +
                        "a.cod_pro_sos, " +
                        "a.des " +
                    "FROM " +
                        "app_pro_sos a, " +
                        "ana_con_ser b " +
                    "WHERE " +
                        "( b.cod_srv = a.cod_srv) " +
                    "AND " +
                        "a.cod_srv = ?";

            strSql += " ORDER BY a.cod_pro_sos";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SRV);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    ProdottiSostanzeApp_View obj = new ProdottiSostanzeApp_View();
                    obj.COD_SRV = rs.getLong(1);
                    obj.COD_PRO_SOS = rs.getLong(2);
                    obj.DES = rs.getString(3);
                    ar.add(obj);
                }
                return ar;
            //------------------------------------------------------------//
            } catch (Exception ex) {
                throw new EJBException(strSql + "/n" + ex);
            } finally {
                bmp.close();
            }
        }/////fine della Collection ejbFindEx_ProdottiSostanzeApp/////
    }/////fine della classe AppProdottiSostanzeBean/////
