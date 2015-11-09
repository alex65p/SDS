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
    Document   : AppPersonaleCoinvoltoBean
    Created on : 23-mag-2008, 22.37.20
    Author     : Giancarlo Servadei
--%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class AppPersonaleCoinvoltoBean
            extends BMPEntityBean
            implements IAppPersonaleCoinvolto,
            IAppPersonaleCoinvoltoHome {

        // Variabili membro.
        long COD_SRV;
        long COD_PER_COI;
        String NOM;
        String QUA;
        AppPersonaleCoinvoltoPK primaryKEY;

        // Costruttore.
        private AppPersonaleCoinvoltoBean() {
            //
        }

        // (Home Intrface) create()
        public IAppPersonaleCoinvolto create(
                long lCOD_SRV, String strNOM) throws CreateException {
            AppPersonaleCoinvoltoBean bean = new AppPersonaleCoinvoltoBean();
            try {
                AppPersonaleCoinvoltoPK primaryKey =
                        bean.ejbCreate(lCOD_SRV, strNOM);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_SRV, strNOM);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            AppPersonaleCoinvoltoBean bean = new AppPersonaleCoinvoltoBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((AppPersonaleCoinvoltoPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IAppPersonaleCoinvolto findByPrimaryKey(AppPersonaleCoinvoltoPK primaryKey) throws FinderException {
            AppPersonaleCoinvoltoBean bean = new AppPersonaleCoinvoltoBean();
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

        public AppPersonaleCoinvoltoPK ejbCreate(
                long lCOD_SRV, String strNOM) {
            this.COD_SRV = lCOD_SRV;
            this.NOM = strNOM;
            this.COD_PER_COI = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                        "app_per_coi " +
                        "(cod_srv, " +
                        "nom, " +
                        "cod_per_coi) " +
                        "VALUES " +
                        "(?,?,?)");
                ps.setLong(1, this.COD_SRV);
                ps.setString(2, this.NOM);
                ps.setLong(3, this.COD_PER_COI);
                ps.executeUpdate();
                return new AppPersonaleCoinvoltoPK(COD_SRV, COD_PER_COI);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_SRV, String strNOM) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public AppPersonaleCoinvoltoPK ejbFindByPrimaryKey(AppPersonaleCoinvoltoPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((AppPersonaleCoinvoltoPK) this.getEntityKey());
            this.COD_SRV = primaryKEY.COD_SRV;
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
                            "a.cod_srv, " +
                            "a.cod_per_coi, " +
                            "a.nom, " +
                            "a.qua " +
                        "FROM " +
                            "app_per_coi a " +
                        "WHERE " +
                            "a.cod_srv = ? " +
                            "AND a.cod_per_coi = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_PER_COI);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.NOM = rs.getString("NOM");
                    this.QUA = rs.getString("QUA");
                } else {
                    throw new NoSuchEntityException("Personale coinvolto con ID=" + COD_SRV + " - " + COD_PER_COI + " non trovato.");
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
                        "app_per_coi " +
                        "WHERE " +
                        "cod_srv = ? " +
                        "AND " +
                        "cod_per_coi = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_PER_COI);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Personale coinvolto con ID=" + COD_SRV + " - " + COD_PER_COI + " non trovato.");
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
                        "app_per_coi " +
                        "SET " +
                        "nom=?, " +
                        "qua=? " +
                        "WHERE " +
                        "cod_srv=? " +
                        "AND " +
                        "cod_per_coi=?");

                ps.setString(1, NOM);
                ps.setString(2, QUA);

                // Clausole di where
                ps.setLong(3, COD_SRV);
                ps.setLong(4, COD_PER_COI);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Personale coinvolto con ID=" + COD_SRV + " - " + COD_PER_COI + " non trovato.");
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

        // COD_PER_COI
        public void setCOD_PER_COI(long newCOD_PER_COI) {
            COD_PER_COI = newCOD_PER_COI;
            setModified();
        }

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

        public Collection findEx_PersonaleCoinvoltoApp(
                long lCOD_SRV,
                long lCOD_PER_COI,
                String strNOM,
                String strQUA,
                int iOrderParameter) {
            return (new AppPersonaleCoinvoltoBean()).ejbFindEx_PersonaleCoinvoltoApp(
                    lCOD_SRV,
                    lCOD_PER_COI,
                    strNOM,
                    strQUA,
                    iOrderParameter);
        }

        public Collection ejbFindEx_PersonaleCoinvoltoApp(
                long lCOD_SRV,
                long lCOD_PER_COI,
                String strNOM,
                String strQUA,
                int iOrderParameter //not used for now
                ) {
            String strSql = 
                    "SELECT " +
                        "a.cod_srv, " +
                        "a.cod_per_coi, " +
                        "a.nom, " +
                        "a.qua " +
                    "FROM " +
                        "app_per_coi a " +
                    "WHERE " +
                        "a.cod_srv = ? " +
                    "ORDER BY " +
                        "a.nom";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SRV);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    AppPersonaleCoinvolto_View obj = new AppPersonaleCoinvolto_View();
                    obj.COD_SRV = rs.getLong(1);
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
        }/////fine della Collection ejbFindEx_PersonaleCoinvoltoApp/////
    }/////fine della classe AppPersonaleCoinvoltoBean/////
%>
<%
            PseudoContext.bind("AppPersonaleCoinvoltoBean", new AppPersonaleCoinvoltoBean());
%>
