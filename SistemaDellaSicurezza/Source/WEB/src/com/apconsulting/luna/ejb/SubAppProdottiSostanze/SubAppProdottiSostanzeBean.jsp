<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<%-- 
    Document   : SubAppProdottiSostanzeBean
    Created on : 23-mag-2008, 9.57.53
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class SubAppProdottiSostanzeBean
            extends BMPEntityBean
            implements ISubAppProdottiSostanze,
            ISubAppProdottiSostanzeHome {
        
        // Variabili membro.
        long COD_SUB_APP;
        long COD_PRO_SOS;
        String DES;
        SubAppProdottiSostanzePK primaryKEY;

        // Costruttore.
        private SubAppProdottiSostanzeBean() {
            //
        }

        // (Home Intrface) create()
        public ISubAppProdottiSostanze create(
                long lCOD_SUB_APP,
                String strDES) throws CreateException {
            SubAppProdottiSostanzeBean bean = new SubAppProdottiSostanzeBean();
            try {
                SubAppProdottiSostanzePK primaryKey =
                        bean.ejbCreate(lCOD_SUB_APP, strDES);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_SUB_APP, strDES);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            SubAppProdottiSostanzeBean bean = new SubAppProdottiSostanzeBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((SubAppProdottiSostanzePK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public ISubAppProdottiSostanze findByPrimaryKey(SubAppProdottiSostanzePK primaryKey) throws FinderException {
            SubAppProdottiSostanzeBean bean = new SubAppProdottiSostanzeBean();
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

        public SubAppProdottiSostanzePK ejbCreate(
                long lCOD_SUB_APP,
                String strDES) {
            this.COD_SUB_APP = lCOD_SUB_APP;
            this.DES = strDES;
            this.COD_PRO_SOS = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                            "sub_app_pro_sos " +
                            "(cod_sub_app, " +
                            "des, " +
                            "cod_pro_sos) " +
                        "VALUES " +
                            "(?,?,?)");
                ps.setLong(1, this.COD_SUB_APP);
                ps.setString(2, this.DES);
                ps.setLong(3, this.COD_PRO_SOS);
                ps.executeUpdate();
                return new SubAppProdottiSostanzePK(COD_SUB_APP, COD_PRO_SOS);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_SUB_APP, String strDES) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public SubAppProdottiSostanzePK ejbFindByPrimaryKey(SubAppProdottiSostanzePK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((SubAppProdottiSostanzePK) this.getEntityKey());
            this.COD_SUB_APP = primaryKEY.COD_SUB_APP;
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
                            "a.cod_sub_app, " +
                            "a.cod_pro_sos, " +
                            "a.des " +
                        "FROM " +
                            "sub_app_pro_sos a, " +
                            "con_ser_sub_app b " +
                        "WHERE " +
                            "a.cod_sub_app = b.cod_sub_app " +
                        "AND " +
                            "a.cod_sub_app = ? " +
                        "AND " +
                            "a.cod_pro_sos = ?");
                ps.setLong(1, COD_SUB_APP);
                ps.setLong(2, COD_PRO_SOS);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.DES = rs.getString("DES");
                } else {
                    throw new NoSuchEntityException("Prodotto/Sostanza con ID=" + COD_SUB_APP + " - " + COD_PRO_SOS + " non trovato.");
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
                        "sub_app_pro_sos " +
                        "WHERE " +
                        "cod_sub_app = ? " +
                        "AND " +
                        "cod_pro_sos = ?");
                ps.setLong(1, COD_SUB_APP);
                ps.setLong(2, COD_PRO_SOS);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Prodotto/Sostanza con ID=" + COD_SUB_APP + " - " + COD_PRO_SOS + " non trovato.");
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
                        "sub_app_pro_sos " +
                        "SET " +
                        "des=? " +
                        "WHERE " +
                        "cod_sub_app=? " +
                        "AND " +
                        "cod_pro_sos=?");

                ps.setString(1, DES);

                // Clausole di where
                ps.setLong(2, COD_SUB_APP);
                ps.setLong(3, COD_PRO_SOS);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Prodotto/Sostanza con ID=" + COD_SUB_APP + " - " + COD_PRO_SOS + " non trovato.");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        // Metodi dell'interfaccia remota. (get e set)

        // COD_SUB_APP
        public long getCOD_SUB_APP() {
            return COD_SUB_APP;
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
        
        public boolean getInfoOnDescProdottiSostanzeSubApp(long SUB_APP_ID) {
            boolean vuoto = false;
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                            "cod_pro_sos " +
                        "FROM " +
                            "sub_app_pro_sos " +
                        "WHERE " +
                            "cod_sub_app = ? ");
                ps.setLong(1, SUB_APP_ID);
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

        public Collection findEx_ProdottiSostanzeSubApp(
                long lCOD_SUB_APP,
                long lCOD_PRO_SOS,
                String strDES,
                int iOrderParameter) {
            return (new SubAppProdottiSostanzeBean()).ejbFindEx_ProdottiSostanzeSubApp(
                    lCOD_SUB_APP,
                    lCOD_PRO_SOS,
                    strDES,
                    iOrderParameter);
        }

        public Collection ejbFindEx_ProdottiSostanzeSubApp(
                long lCOD_SUB_APP,
                long lCOD_PRO_SOS,
                String strDES,
                int iOrderParameter //not used for now
                ) {
            String strSql =
                    "SELECT " +
                        "a.cod_sub_app, " +
                        "a.cod_pro_sos, " +
                        "a.des " +
                    "FROM " +
                        "sub_app_pro_sos a, " +
                        "con_ser_sub_app b " +
                    "WHERE " +
                        "( b.cod_sub_app = a.cod_sub_app) " +
                    "AND " +
                        "a.cod_sub_app = ?";

            strSql += " ORDER BY a.cod_pro_sos";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SUB_APP);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    ProdottiSostanzeSubApp_View obj = new ProdottiSostanzeSubApp_View();
                    obj.COD_SUB_APP = rs.getLong(1);
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
        }/////fine della Collection ejbFindEx_ProdottiSostanzeSubApp/////
    }/////fine della classe SubAppProdottiSostanzeBean/////
%>
<%
            PseudoContext.bind("SubAppProdottiSostanzeBean", new SubAppProdottiSostanzeBean());
%>
