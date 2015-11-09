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
    Document   : AppReferentiLocoBean
    Created on : 28-mag-2008, 08.48.54
    Author     : Giancarlo Servadei
--%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class AppReferentiLocoBean
            extends BMPEntityBean
            implements IAppReferentiLoco,
            IAppReferentiLocoHome {

        // Variabili membro.
        long COD_SRV;
        long COD_REF_LOC;
        String NOM;
        String QUA;
        String TEL;
        AppReferentiLocoPK primaryKEY;

        // Costruttore.
        private AppReferentiLocoBean() {
            //
        }

        // (Home Intrface) create()
        public IAppReferentiLoco create(
                long lCOD_SRV, String strNOM) throws CreateException {
            AppReferentiLocoBean bean = new AppReferentiLocoBean();
            try {
                AppReferentiLocoPK primaryKey =
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
            AppReferentiLocoBean bean = new AppReferentiLocoBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((AppReferentiLocoPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IAppReferentiLoco findByPrimaryKey(AppReferentiLocoPK primaryKey) throws FinderException {
            AppReferentiLocoBean bean = new AppReferentiLocoBean();
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

        public AppReferentiLocoPK ejbCreate(
                long lCOD_SRV, String strNOM) {
            this.COD_SRV = lCOD_SRV;
            this.NOM = strNOM;
            this.COD_REF_LOC = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                            "app_ref_loc " +
                            "(cod_srv, " +
                            "nom, " +
                            "cod_ref_loc) " +
                        "VALUES " +
                            "(?,?,?)");
                ps.setLong(1, this.COD_SRV);
                ps.setString(2, this.NOM);
                ps.setLong(3, this.COD_REF_LOC);
                ps.executeUpdate();
                return new AppReferentiLocoPK(COD_SRV, COD_REF_LOC);
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

        public AppReferentiLocoPK ejbFindByPrimaryKey(AppReferentiLocoPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((AppReferentiLocoPK) this.getEntityKey());
            this.COD_SRV = primaryKEY.COD_SRV;
            this.COD_REF_LOC = primaryKEY.COD_REF_LOC;
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
                            "a.cod_ref_loc, " +
                            "a.nom, " +
                            "a.qua, " +
                            "a.tel " +
                        "FROM " +
                            "app_ref_loc a, " +
                            "ana_con_ser b " +
                        "WHERE " +
                            "( b.cod_srv = a.cod_srv ) " +
                        "AND " +
                            "a.cod_srv = ? " +
                        "AND " +
                            "a.cod_ref_loc = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_REF_LOC);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.NOM = rs.getString("NOM");
                    this.QUA = rs.getString("QUA");
                    this.TEL = rs.getString("TEL");
                } else {
                    throw new NoSuchEntityException("Referente in loco con ID=" + COD_SRV + " - " + COD_REF_LOC + " non trovato.");
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
                            "app_ref_loc " +
                        "WHERE " +
                            "cod_srv = ? " +
                        "AND " +
                            "cod_ref_loc = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_REF_LOC);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Referente in loco con ID=" + COD_SRV + " - " + COD_REF_LOC + " non trovato.");
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
                            "app_ref_loc " +
                        "SET " +
                            "nom = ?, " +
                            "qua = ?, " +
                            "tel = ? " +
                        "WHERE " +
                            "cod_srv = ? " +
                        "AND " +
                            "cod_ref_loc = ? ");

                ps.setString(1, NOM);
                ps.setString(2, QUA);
                ps.setString(3, TEL);

                // Clausole di where
                ps.setLong(4, COD_SRV);
                ps.setLong(5, COD_REF_LOC);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Referente in loco con ID=" + COD_SRV + " - " + COD_REF_LOC + " non trovato.");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        // Metodi dell'interfaccia remota. (get e set)
        public long getCOD_SRV() {
            return COD_SRV;
        }
        
        public long getCOD_REF_LOC() {
            return COD_REF_LOC;
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
        
        // TEL
        public void setTEL(String newTEL) {
            if (TEL != null) {
                if (TEL.equals(newTEL)) {
                    return;
                }
            }
            TEL = newTEL;
            setModified();
        }

        public String getTEL() {
            return TEL;
        }

        public Collection findEx_ReferentiLocoApp(
                long lCOD_SRV,
                long lCOD_REF_LOC,
                String strNOM,
                String strQUA,
                String strTEL,
                int iOrderParameter) {
            return (new AppReferentiLocoBean()).ejbFindEx_ReferentiLocoApp(
                    lCOD_SRV,
                    lCOD_REF_LOC,
                    strNOM,
                    strQUA,
                    strTEL,
                    iOrderParameter);
        }

        public Collection ejbFindEx_ReferentiLocoApp(
                long lCOD_SRV,
                long lCOD_REF_LOC,
                String strNOM,
                String strQUA,
                String strTEL,
                int iOrderParameter //not used for now
                ) {
            String strSql =
                    "SELECT " +
                        "a.cod_srv, " +
                        "a.cod_ref_loc, " +
                        "a.nom, " +
                        "a.qua, " +
                        "a.tel " +
                    "FROM " +
                        "app_ref_loc a, " +
                        "ana_con_ser b " +
                    "WHERE " +
                        "( b.cod_srv = a.cod_srv ) " +
                    "AND " +
                        "a.cod_srv = ? ";

            strSql += " ORDER BY a.nom";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SRV);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    AppReferentiLoco_View obj = new AppReferentiLoco_View();
                    obj.COD_SRV = rs.getLong(1);
                    obj.COD_REF_LOC = rs.getLong(2);
                    obj.NOM = rs.getString(3);
                    obj.QUA = rs.getString(4);
                    obj.TEL = rs.getString(5);
                    ar.add(obj);
                }
                return ar;
            //------------------------------------------------------------//
            } catch (Exception ex) {
                throw new EJBException(strSql + "/n" + ex);
            } finally {
                bmp.close();
            }
        }/////fine della Collection ejbFindEx_ReferentiLocoApp/////
    }/////fine della classe AppPersonaleCoinvoltoBean/////
%>
<%
            PseudoContext.bind("AppReferentiLocoBean", new AppReferentiLocoBean());
%>
