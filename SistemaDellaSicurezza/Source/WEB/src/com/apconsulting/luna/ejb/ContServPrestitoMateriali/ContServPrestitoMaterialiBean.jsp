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
    Document   : ContServPrestitoMaterialiBean
    Created on : 22-mag-2008, 14.10.24
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServPrestitoMaterialiBean
            extends BMPEntityBean
            implements IContServPrestitoMateriali,
            IContServPrestitoMaterialiHome {
        // Variabili membro.
        long COD_SRV;
        long COD_PRE_MAT;
        String TIP_MAT;
        String LUO_MES_DIS;
        java.sql.Date DAT_INI_PRE;
        java.sql.Date DAT_FIN_PRE;
        ContServPrestitoMaterialiPK primaryKEY;
        String PRO_CON;
        String DES_CON;

        // Costruttore.
        private ContServPrestitoMaterialiBean() {
        //
        }

        // (Home Intrface) create()
        public IContServPrestitoMateriali create(
                long lCOD_SRV, String strTIP_MAT) throws CreateException {
            ContServPrestitoMaterialiBean bean = new ContServPrestitoMaterialiBean();
            try {
                ContServPrestitoMaterialiPK primaryKey =
                        bean.ejbCreate(lCOD_SRV, strTIP_MAT);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(lCOD_SRV, strTIP_MAT);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            ContServPrestitoMaterialiBean bean = new ContServPrestitoMaterialiBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((ContServPrestitoMaterialiPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IContServPrestitoMateriali findByPrimaryKey(ContServPrestitoMaterialiPK primaryKey) throws FinderException {
            ContServPrestitoMaterialiBean bean = new ContServPrestitoMaterialiBean();
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

        public ContServPrestitoMaterialiPK ejbCreate(
                long lCOD_SRV, String strTIP_MAT) {
            this.COD_SRV = lCOD_SRV;
            this.TIP_MAT = strTIP_MAT;
            this.COD_PRE_MAT = NEW_ID();
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                        "con_ser_pre_mat " +
                        "(cod_srv, " +
                        "tip_mat, " +
                        "cod_pre_mat) " +
                        "VALUES " +
                        "(?,?,?)");
                ps.setLong(1, this.COD_SRV);
                ps.setString(2, this.TIP_MAT);
                ps.setLong(3, this.COD_PRE_MAT);
                ps.executeUpdate();
                return new ContServPrestitoMaterialiPK(COD_SRV, COD_PRE_MAT);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(
                long lCOD_SRV, String strTIP_MAT) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public ContServPrestitoMaterialiPK ejbFindByPrimaryKey(ContServPrestitoMaterialiPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((ContServPrestitoMaterialiPK) this.getEntityKey());
            this.COD_SRV = primaryKEY.COD_SRV;
            this.COD_PRE_MAT = primaryKEY.COD_PRE_MAT;
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
                        "a.cod_pre_mat, " +
                        "a.tip_mat, " +
                        "a.luo_mes_dis, " +
                        "a.dat_ini_pre, " +
                        "a.dat_fin_pre, " +
                        "b.pro_con, " +
                        "b.des_con " +
                        "FROM " +
                            "con_ser_pre_mat a, " +
                            "ana_con_ser b " +
                        "WHERE " +
                            "( b.cod_srv = a.cod_srv ) " +
                        "AND " +
                            "a.cod_srv = ? " +
                        "AND " +
                            "a.cod_pre_mat = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_PRE_MAT);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.TIP_MAT = rs.getString("TIP_MAT");
                    this.LUO_MES_DIS = rs.getString("LUO_MES_DIS");
                    this.DAT_INI_PRE = rs.getDate("DAT_INI_PRE");
                    this.DAT_FIN_PRE = rs.getDate("DAT_FIN_PRE");
                    this.PRO_CON = rs.getString("PRO_CON");
                    this.DES_CON = rs.getString("DES_CON");
                } else {
                    throw new NoSuchEntityException("Prestito materiale con ID=" + COD_SRV + "-" + COD_PRE_MAT + " non trovato.");
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
                        "con_ser_pre_mat  " +
                        "WHERE " +
                        "cod_srv = ? " +
                        "AND " +
                        "cod_pre_mat = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_PRE_MAT);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Prestito materiale con ID=" + COD_SRV + "-" + COD_PRE_MAT + " non trovato.");
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
                        "con_ser_pre_mat " +
                        "SET " +
                        "tip_mat=?, " +
                        "luo_mes_dis=?, " +
                        "dat_ini_pre=?, " +
                        "dat_fin_pre=? " +
                        "WHERE " +
                        "cod_srv = ? " +
                        "AND " +
                        "cod_pre_mat = ?");

                ps.setString(1, TIP_MAT);
                ps.setString(2, LUO_MES_DIS);
                ps.setDate(3, DAT_INI_PRE);
                ps.setDate(4, DAT_FIN_PRE);

                // Clausole di where
                ps.setLong(5, COD_SRV);
                ps.setLong(6, COD_PRE_MAT);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("Prestito materiale con ID=" + COD_SRV + "-" + COD_PRE_MAT + " non trovato.");
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

        // COD_PRE_MAT
        public long getCOD_PRE_MAT() {
            return COD_PRE_MAT;
        }

        // TIP_MAT 
        public void setTIP_MAT(String newTIP_MAT) {
            if (TIP_MAT != null) {
                if (TIP_MAT.equals(newTIP_MAT)) {
                    return;
                }
            }
            TIP_MAT = newTIP_MAT;
            setModified();
        }

        public String getTIP_MAT() {
            return TIP_MAT;
        }
        
        // LUO_MES_DIS
        public void setLUO_MES_DIS(String newLUO_MES_DIS) {
            if (LUO_MES_DIS != null) {
                if (LUO_MES_DIS.equals(newLUO_MES_DIS)) {
                    return;
                }
            }
            LUO_MES_DIS = newLUO_MES_DIS;
            setModified();
        }

        public String getLUO_MES_DIS() {
            return LUO_MES_DIS;
        }

        public java.sql.Date getDAT_INI_PRE() {
            return DAT_INI_PRE;
        }

        public void setDAT_INI_PRE(java.sql.Date newDAT_INI_PRE) {
            if (DAT_INI_PRE != null) {
                if (DAT_INI_PRE.equals(newDAT_INI_PRE)) {
                    return;
                }
            }
            DAT_INI_PRE = newDAT_INI_PRE;
            setModified();
        }

        public java.sql.Date getDAT_FIN_PRE() {
            return DAT_FIN_PRE;
        }

        public void setDAT_FIN_PRE(java.sql.Date newDAT_FIN_PRE) {
            if (DAT_FIN_PRE != null) {
                if (DAT_FIN_PRE.equals(newDAT_FIN_PRE)) {
                    return;
                }
            }
            DAT_FIN_PRE = newDAT_FIN_PRE;
            setModified();
        }
        /*
        public String getPRO_CON() {
            return PRO_CON;
        }

        public String getDES_CON() {
            return DES_CON;
        }
        */
        public boolean getInfoOnDescPrestitoMateriali(long SRV_ID) {
            boolean vuoto = false;
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                        "cod_pre_mat " +
                        "FROM " +
                        "con_ser_pre_mat " +
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

        public Collection findEx_PrestitoMateriali(
                long lCOD_SRV,
                long lCOD_PRE_MAT,
                String strTIP_MAT,
                String strLUO_MES_DIS,
                java.sql.Date dtDAT_INI_PRE,
                java.sql.Date dtDAT_FIN_PRE,
                int iOrderParameter) {
            return (new ContServPrestitoMaterialiBean()).ejbFindEx_PrestitoMateriali(
                    lCOD_SRV,
                    lCOD_PRE_MAT,
                    strTIP_MAT,
                    strLUO_MES_DIS,
                    dtDAT_INI_PRE,
                    dtDAT_FIN_PRE,
                    iOrderParameter);
        }

        public Collection ejbFindEx_PrestitoMateriali(
                long lCOD_SRV,
                long lCOD_PRE_MAT,
                String strTIP_MAT,
                String strLUO_MES_DIS,
                java.sql.Date dtDAT_INI_PRE,
                java.sql.Date dtDAT_FIN_PRE,
                int iOrderParameter //not used for now
                ) {
            String strSql = "SELECT " +
                    "a.cod_srv, " +
                    "a.cod_pre_mat, " +
                    "a.tip_mat, " +
                    "a.luo_mes_dis, " +
                    "a.dat_ini_pre, " +
                    "a.dat_fin_pre " +
                    //"b.pro_con, " +
                    //"b.des_con " +
                    "FROM " +
                    "con_ser_pre_mat a, " +
                    "ana_con_ser b " +
                    "WHERE " +
                    "( b.cod_srv = a.cod_srv ) " +
                    "AND " +
                    "a.cod_srv = ? ";

            strSql += " ORDER BY b.pro_con";

            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SRV);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    PrestitoMateriali_View obj = new PrestitoMateriali_View();
                    obj.COD_SRV = rs.getLong(1);
                    obj.COD_PRE_MAT = rs.getLong(2);
                    obj.TIP_MAT = rs.getString(3);
                    obj.LUO_MES_DIS = rs.getString(4);
                    obj.DAT_INI_PRE = rs.getDate(5);
                    obj.DAT_FIN_PRE = rs.getDate(6);
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
        }/////fine della Collection ejbFindEx_PrestitoMateriali/////
    }/////fine della classe ContServPrestitoMaterialiBean/////
%>
<%
            PseudoContext.bind("ContServPrestitoMaterialiBean", new ContServPrestitoMaterialiBean());
%>
