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
    Document   : ContServReferentiLocoBean
    Created on : 27-mag-2008, 10.18.21
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServReferentiLocoBean
            extends BMPEntityBean
            implements IContServReferentiLoco,
            IContServReferentiLocoHome {
        // Variabili membro.
        long COD_AZL;
        long COD_SRV;
        long COD_DPD;
        String TEL;
        ContServReferentiLocoPK primaryKEY;
        String COG_DPD;
        String NOM_DPD;
        String NOM_FUZ_AZL;

        // Costruttore.
        private ContServReferentiLocoBean() {
        //
        }

        // (Home Intrface) create()
        public IContServReferentiLoco create(
                long lCOD_AZL,
                long lCOD_SRV,
                long lCOD_DPD) throws CreateException {
            ContServReferentiLocoBean bean = new ContServReferentiLocoBean();
            try {
                ContServReferentiLocoPK primaryKey =
                        bean.ejbCreate(lCOD_AZL, lCOD_SRV, lCOD_DPD);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_AZL, lCOD_SRV, lCOD_DPD);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            ContServReferentiLocoBean bean = new ContServReferentiLocoBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((ContServReferentiLocoPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IContServReferentiLoco findByPrimaryKey(ContServReferentiLocoPK primaryKey) throws FinderException {
            ContServReferentiLocoBean bean = new ContServReferentiLocoBean();
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

        public ContServReferentiLocoPK ejbCreate(
                long lCOD_AZL,
                long lCOD_SRV,
                long lCOD_DPD) {
            this.COD_AZL = lCOD_AZL;
            this.COD_SRV = lCOD_SRV;
            this.COD_DPD = lCOD_DPD;
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                            "con_ser_ref_loc " +
                            "(cod_azl, " +
                            "cod_srv, " +
                            "cod_dpd) " +
                            "VALUES " +
                            "(?,?,?)");
                ps.setLong(1, this.COD_AZL);
                ps.setLong(2, this.COD_SRV);
                ps.setLong(3, this.COD_DPD);
                ps.executeUpdate();
                return new ContServReferentiLocoPK(COD_AZL, COD_SRV, COD_DPD);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_AZL,
                long lCOD_SRV,
                long lCOD_DPD) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public ContServReferentiLocoPK ejbFindByPrimaryKey(ContServReferentiLocoPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((ContServReferentiLocoPK) this.getEntityKey());
            this.COD_AZL = primaryKEY.COD_AZL;
            this.COD_SRV = primaryKEY.COD_SRV;
            this.COD_DPD = primaryKEY.COD_DPD;
        }

        public void ejbPassivate() {
            this.primaryKEY = null;
        }

        public void ejbLoad() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "a.cod_azl, " +
                        "a.cod_srv, " +
                        "a.cod_dpd, " +
                        "b.cog_dpd, " +
                        "b.nom_dpd, " +
                        "c.nom_fuz_azl, " +
                        "a.tel " +
                    "FROM " +
                        "con_ser_ref_loc a, " +
                        "view_ana_dpd_tab b, " +
                        "ana_fuz_azl_tab c " +
                    "WHERE " +
                        "a.cod_dpd = b.cod_dpd " +
                        "AND b.cod_fuz_azl = c.cod_fuz_azl " +
                        "AND a.cod_srv = ? " +
                        "AND a.cod_azl = ? " +
                        "AND a.cod_dpd = ? ");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_AZL);
                ps.setLong(3, COD_DPD);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.TEL = rs.getString("TEL");
                } else {
                    throw new NoSuchEntityException("Referente in loco con ID=" + COD_AZL + "-" + COD_SRV + "-" + COD_DPD + " non trovato.");
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
                            "con_ser_ref_loc  " +
                        "WHERE " +
                            "cod_azl = ? " +
                        "AND " +
                            "cod_srv = ? " +
                        "AND " +
                            "cod_dpd = ?");
                ps.setLong(1, COD_AZL);
                ps.setLong(2, COD_SRV);
                ps.setLong(3, COD_DPD);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Referente in loco con ID=" + COD_AZL + "-" + COD_SRV + "-" + COD_DPD + " non trovato.");
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
                            "con_ser_ref_loc " +
                        "SET " +
                            "tel = ? " +
                        "WHERE " +
                            "cod_azl = ? " +
                        "AND " +
                            "cod_srv = ? " +
                        "AND " +
                            "cod_dpd = ?");

                ps.setString(1, TEL);

                // Clausole di where
                ps.setLong(2, COD_AZL);
                ps.setLong(3, COD_SRV);
                ps.setLong(4, COD_DPD);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Referente in loco con ID=" + COD_AZL + "-" + COD_SRV + "-" + COD_DPD + " non trovato.");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        // Metodi dell'interfaccia remota. (get e set)
        public long getCOD_AZL() {
            return COD_AZL;
        }
        
        public long getCOD_SRV() {
            return COD_SRV;
        }

        public long getCOD_DPD() {
            return COD_DPD;
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


        public Collection findEx_ReferentiLocoCmt(
                long AZL_ID,
                long SRV_ID,
                long lCOD_DPD,
                String strTEL) {
            return (new ContServReferentiLocoBean()).ejbFindEx_ReferentiLocoCmt(
                AZL_ID,
                SRV_ID,
                lCOD_DPD,
                strTEL);
        }

        public Collection ejbFindEx_ReferentiLocoCmt(
                long AZL_ID,
                long SRV_ID,
                long lCOD_DPD,
                String strTEL) {
                String strSql = 
                    "SELECT " +
                        "a.cod_srv, " +
                        "a.cod_azl, " +
                        "a.cod_dpd, " +
                        "b.cog_dpd, " +
                        "b.nom_dpd, " +
                        "c.nom_fuz_azl, " +
                        "a.tel " +
                    "FROM " +
                        "con_ser_ref_loc a, " +
                        "view_ana_dpd_tab b, " +
                        "ana_fuz_azl_tab c " +
                    "WHERE " +
                        "a.cod_dpd = b.cod_dpd " +
                        "AND b.cod_fuz_azl = c.cod_fuz_azl " +
                        "AND a.cod_srv = ? " +
                        "AND a.cod_azl = ? " +
                    "ORDER BY " +
                            "b.cog_dpd";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, SRV_ID);
                ps.setLong(2, AZL_ID);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    ComReferentiLoco_View obj = new ComReferentiLoco_View();
                    obj.COD_SRV = rs.getLong(1);
                    obj.COD_AZL = rs.getLong(2);
                    obj.COD_DPD = rs.getLong(3);
                    obj.COG_DPD = rs.getString(4);
                    obj.NOM_DPD = rs.getString(5);
                    obj.NOM_FUZ_AZL = rs.getString(6);
                    obj.TEL = rs.getString(7);
                    ar.add(obj);
                }
                return ar;
            //------------------------------------------------------------//
            } catch (Exception ex) {
                throw new EJBException(strSql + "/n" + ex);
            } finally {
                bmp.close();
            }
        }/////fine della Collection ejbFindEx_ReferentiLocoCmt/////
    }/////fine della classe ContServReferentiLocoBean/////
%>
<%
            PseudoContext.bind("ContServReferentiLocoBean", new ContServReferentiLocoBean());
%>
