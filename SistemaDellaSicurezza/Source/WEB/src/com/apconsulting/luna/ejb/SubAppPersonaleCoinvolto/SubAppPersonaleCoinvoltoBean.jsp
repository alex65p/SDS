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
    Document   : SubAppPersonaleCoinvoltoBean
    Created on : 22-mag-2008, 9.31.32
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class SubAppPersonaleCoinvoltoBean
            extends BMPEntityBean
            implements ISubAppPersonaleCoinvolto,
            ISubAppPersonaleCoinvoltoHome {
        
        // Variabili membro.
        long COD_SUB_APP;
        long COD_PER_COI;
        String NOM;
        String QUA;
        SubAppPersonaleCoinvoltoPK primaryKEY;

        // Costruttore.
        private SubAppPersonaleCoinvoltoBean() {
            //
        }

        // (Home Intrface) create()
        public ISubAppPersonaleCoinvolto create(
                long lCOD_SUB_APP, String strNOM) throws CreateException {
            SubAppPersonaleCoinvoltoBean bean = new SubAppPersonaleCoinvoltoBean();
            try {
                SubAppPersonaleCoinvoltoPK primaryKey =
                        bean.ejbCreate(lCOD_SUB_APP, strNOM);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_SUB_APP, strNOM);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            SubAppPersonaleCoinvoltoBean bean = new SubAppPersonaleCoinvoltoBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((SubAppPersonaleCoinvoltoPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public ISubAppPersonaleCoinvolto findByPrimaryKey(SubAppPersonaleCoinvoltoPK primaryKey) throws FinderException {
            SubAppPersonaleCoinvoltoBean bean = new SubAppPersonaleCoinvoltoBean();
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

        public SubAppPersonaleCoinvoltoPK ejbCreate(
                long lCOD_SUB_APP, String strNOM) {
            this.COD_SUB_APP = lCOD_SUB_APP;
            this.NOM = strNOM;
            this.COD_PER_COI = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                        "sub_app_per_coi " +
                        "(cod_sub_app, " +
                        "nom, " +
                        "cod_per_coi) " +
                        "VALUES " +
                        "(?,?,?)");
                ps.setLong(1, this.COD_SUB_APP);
                ps.setString(2, this.NOM);
                ps.setLong(3, this.COD_PER_COI);
                ps.executeUpdate();
                return new SubAppPersonaleCoinvoltoPK(COD_SUB_APP, COD_PER_COI);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_SUB_APP, String strNOM) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public SubAppPersonaleCoinvoltoPK ejbFindByPrimaryKey(SubAppPersonaleCoinvoltoPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((SubAppPersonaleCoinvoltoPK) this.getEntityKey());
            this.COD_SUB_APP = primaryKEY.COD_SUB_APP;
            this.COD_PER_COI = primaryKEY.COD_PER_COI;
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
                            "a.cod_per_coi, " +
                            "a.nom, " +
                            "a.qua " +
                        "FROM " +
                            "sub_app_per_coi a, " +
                            "con_ser_sub_app b " +
                        "WHERE " +
                            "( b.cod_sub_app = a.cod_sub_app ) " +
                        "AND " +
                            "a.cod_sub_app = ? " +
                        "AND " +
                            "a.cod_per_coi = ? ");
                ps.setLong(1, COD_SUB_APP);
                ps.setLong(2, COD_PER_COI);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.NOM = rs.getString("NOM");
                    this.QUA = rs.getString("QUA");
                } else {
                    throw new NoSuchEntityException("Personale coinvolto con ID=" + COD_SUB_APP + " - " + COD_PER_COI + " non trovato.");
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
                        "sub_app_per_coi " +
                        "WHERE " +
                        "cod_sub_app = ? " +
                        "AND " +
                        "cod_per_coi = ?");
                ps.setLong(1, COD_SUB_APP);
                ps.setLong(2, COD_PER_COI);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Personale coinvolto con ID=" + COD_SUB_APP + " - " + COD_PER_COI + " non trovato.");
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
                        "sub_app_per_coi " +
                        "SET " +
                        "nom=?, " +
                        "qua=? " +
                        "WHERE " +
                        "cod_sub_app=? " +
                        "AND " +
                        "cod_per_coi=?");

                ps.setString(1, NOM);
                ps.setString(2, QUA);

                // Clausole di where
                ps.setLong(3, COD_SUB_APP);
                ps.setLong(4, COD_PER_COI);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Personale coinvolto con ID=" + COD_SUB_APP + " - " + COD_PER_COI + " non trovato.");
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

        // COD_PER_COI
        public long getCOD_PER_COI() {
            return COD_PER_COI;
        }

        // NOM
        public void setNOM(String newNOM) {
            if (NOM != null) {
                if (NOM.equals(newNOM)) {
                    return;
                }
            }
            NOM = newNOM;
            setModified();
        }

        public String getNOM() {
            return NOM;
        }

        // QUA
        public void setQUA(String newQUA) {
            if (QUA != null) {
                if (QUA.equals(newQUA)) {
                    return;
                }
            }
            QUA = newQUA;
            setModified();
        }

        public String getQUA() {
            return QUA;
        }

        public Collection findEx_PersonaleCoinvoltoSubApp(
                long lCOD_SUB_APP,
                long lCOD_PER_COI,
                String strNOM,
                String strQUA,
                int iOrderParameter) {
            return (new SubAppPersonaleCoinvoltoBean()).ejbFindEx_PersonaleCoinvoltoSubApp(
                    lCOD_SUB_APP,
                    lCOD_PER_COI,
                    strNOM,
                    strQUA,
                    iOrderParameter);
        }

        public Collection ejbFindEx_PersonaleCoinvoltoSubApp(
                long lCOD_SUB_APP,
                long lCOD_PER_COI,
                String strNOM,
                String strQUA,
                int iOrderParameter //not used for now
                ) {
            String strSql = "SELECT " +
                    "a.cod_sub_app, " +
                    "a.cod_per_coi, " +
                    "a.nom, " +
                    "a.qua " +
                    "FROM " +
                    "sub_app_per_coi a, " +
                    "con_ser_sub_app b " +
                    "WHERE " +
                    "( b.cod_sub_app = a.cod_sub_app ) " +
                    "AND " +
                    "a.cod_sub_app = ? ";

            strSql += " ORDER BY a.nom";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SUB_APP);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    SubAppPersonaleCoinvolto_View obj = new SubAppPersonaleCoinvolto_View();
                    obj.COD_SUB_APP = rs.getLong(1);
                    obj.COD_PER_COI = rs.getLong(2);
                    obj.NOM = rs.getString(3);
                    obj.QUA = rs.getString(4);
                    ar.add(obj);
                }
                return ar;
            //------------------------------------------------------------//
            } catch (Exception ex) {
                throw new EJBException(strSql + "/n" + ex);
            } finally {
                bmp.close();
            }
        }/////fine della Collection ejbFindEx_PersonaleCoinvoltoSubApp/////
    }/////fine della classe SubAppPersonaleCoinvoltoBean/////
%>
<%
            PseudoContext.bind("SubAppPersonaleCoinvoltoBean", new SubAppPersonaleCoinvoltoBean());
%>
