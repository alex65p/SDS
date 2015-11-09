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
    Document   : ContServCentriEmergenzaBean
    Created on : 21-mag-2008, 11.14.16
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServCentriEmergenzaBean
            extends BMPEntityBean
            implements IContServCentriEmergenza,
            IContServCentriEmergenzaHome {
        
        // Variabili membro.
        long COD_SRV;
        long COD_CEN_EME;
        String DES;
        String RIF;
        ContServCentriEmergenzaPK primaryKEY;
        String PRO_CON;
        String DES_CON;

        // Costruttore.
        private ContServCentriEmergenzaBean() {
            //
        }

        // (Home Intrface) create()
        public IContServCentriEmergenza create(
                long lCOD_SRV, String strRIF) throws CreateException {
            ContServCentriEmergenzaBean bean = new ContServCentriEmergenzaBean();
            try {
                ContServCentriEmergenzaPK primaryKey =
                        bean.ejbCreate(lCOD_SRV, strRIF);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_SRV, strRIF);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            ContServCentriEmergenzaBean bean = new ContServCentriEmergenzaBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((ContServCentriEmergenzaPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IContServCentriEmergenza findByPrimaryKey(ContServCentriEmergenzaPK primaryKey) throws FinderException {
            ContServCentriEmergenzaBean bean = new ContServCentriEmergenzaBean();
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

        public ContServCentriEmergenzaPK ejbCreate(
                long lCOD_SRV,
                String strRIF) {
            this.COD_SRV = lCOD_SRV;
            this.RIF = strRIF;
            this.COD_CEN_EME = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                        "con_ser_cen_eme " +
                        "(cod_srv, " +
                        "rif, " +
                        "cod_cen_eme) " +
                        "VALUES " +
                        "(?,?,?)");
                ps.setLong(1, this.COD_SRV);
                ps.setString(2, this.RIF);
                ps.setLong(3, this.COD_CEN_EME);
                ps.executeUpdate();
                return new ContServCentriEmergenzaPK(COD_SRV, COD_CEN_EME);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_SRV, String strRIF) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public ContServCentriEmergenzaPK ejbFindByPrimaryKey(ContServCentriEmergenzaPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((ContServCentriEmergenzaPK) this.getEntityKey());
            this.COD_SRV = primaryKEY.COD_SRV;
            this.COD_CEN_EME = primaryKEY.COD_CEN_EME;
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
                        "a.cod_cen_eme, " +
                        "a.des, " +
                        "a.rif, " +
                        "b.pro_con, " +
                        "b.des_con " +
                        "FROM " +
                        "con_ser_cen_eme a, " +
                        "ana_con_ser b " +
                        "WHERE " +
                        "( b.cod_srv = a.cod_srv ) " +
                        "AND " +
                        "a.cod_srv = ? " +
                        "AND " +
                        "a.cod_cen_eme = ?");

                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_CEN_EME);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.DES = rs.getString("DES");
                    this.RIF = rs.getString("RIF");
                    this.PRO_CON = rs.getString("PRO_CON");
                    this.DES_CON = rs.getString("DES_CON");
                } else {
                    throw new NoSuchEntityException("Centro di emergenza con ID=" + COD_SRV + " - " + COD_CEN_EME + " non trovato.");
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
                        "con_ser_cen_eme  " +
                        "WHERE " +
                        "cod_srv = ? " +
                        "AND " +
                        "cod_cen_eme = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_CEN_EME);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Centro di emergenza con ID=" + COD_SRV + " - " + COD_CEN_EME + " non trovato.");
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
                        "con_ser_cen_eme " +
                        "SET " +
                        "des=?, " +
                        "rif=? " +
                        "WHERE " +
                        "cod_srv = ? " +
                        "AND " +
                        "cod_cen_eme = ?");

                ps.setString(1, DES);
                ps.setString(2, RIF);

                // Clausole di where
                ps.setLong(3, COD_SRV);
                ps.setLong(4, COD_CEN_EME);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Centro di emergenza con ID=" + COD_SRV + " - " + COD_CEN_EME + " non trovato.");
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

        // COD_CEN_EME
        public long getCOD_CEN_EME() {
            return COD_CEN_EME;
        }

        // DES
        public void setDES(String newDES) {
            if (DES != null) {
                if (DES.equals(newDES)) {
                    return;
                }
            }
            DES = newDES;
            setModified();
        }

        public String getDES() {
            return DES;
        }

        // RIF
        public void setRIF(String newRIF) {
            if (RIF != null) {
                if (RIF.equals(newRIF)) {
                    return;
                }
            }
            RIF = newRIF;
            setModified();
        }

        public String getRIF() {
            return RIF;
        }

        public boolean getInfoOnDescCentriEmergenza(long SRV_ID) {
            boolean vuoto = false;
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                        "cod_cen_eme " +
                        "FROM " +
                        "con_ser_cen_eme " +
                        "WHERE " +
                        "cod_srv=?");
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

        public Collection findEx_CentriEmergenza(
                long lCOD_SRV,
                long lCOD_CEN_EME,
                String strDES,
                String strRIF,
                int iOrderParameter) {
            return (new ContServCentriEmergenzaBean()).ejbFindEx_CentriEmergenza(
                    lCOD_SRV,
                    lCOD_CEN_EME,
                    strDES,
                    strRIF,
                    iOrderParameter);
        }

        public Collection ejbFindEx_CentriEmergenza(
                long lCOD_SRV,
                long lCOD_CEN_EME,
                String strDES,
                String strRIF,
                int iOrderParameter //not used for now
                ) {
            String strSql = "SELECT " +
                    "a.cod_srv, " +
                    "a.cod_cen_eme, " +
                    "a.des, " +
                    "a.rif " +
                    //"b.pro_con, " +
                    //"b.des_con " +
                    "FROM " +
                    "con_ser_cen_eme a, " +
                    "ana_con_ser b " +
                    "WHERE " +
                    "( b.cod_srv = a.cod_srv ) " +
                    "AND " +
                    "a.cod_srv =?";

            strSql += " ORDER BY b.pro_con";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SRV);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    CentriEmergenza_View obj = new CentriEmergenza_View();
                    obj.COD_SRV = rs.getLong(1);
                    obj.COD_CEN_EME = rs.getLong(2);
                    obj.DES = rs.getString(3);
                    obj.RIF = rs.getString(4);
                    //obj.PRO_CON = rs.getString(5);
                    //obj.DES_CON = rs.getString(6);
                    ar.add(obj);
                }
                return ar;
            //------------------------------------------------------------//
            } catch (Exception ex) {
                throw new EJBException(strSql + "/n" + ex);
            } finally {
                bmp.close();
            }
        }/////fine della Collection ejbFindEx_CentriEmergenza/////
    }/////fine della classe ContServCentriEmergenzaBean/////
%>
<%
            PseudoContext.bind("ContServCentriEmergenzaBean", new ContServCentriEmergenzaBean());
%>
