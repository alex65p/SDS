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

<%
            /*
            <file>
            <versions>	
            <version number="1.0" date="20/05/2008" author="Giancarlo Servadei">
            <comments>
            <comment date="20/05/2008" author="Giancarlo Servadei">
            <description>Create ContServIspezioniBean.jsp</description>
            </comment>		
            </comments> 
            </version>
            </versions>
            </file> 
             */
%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%@ page import="s2s.ejb.pseudoejb.BMPConnection.*"%>

<%!
    public class ContServIspezioniBean
            extends BMPEntityBean
            implements IContServIspezioni,
            IContServIspezioniHome {

        // Variabili membro.
        ContServIspezioniPK primaryKEY;
        long COD_SRV;
        long COD_ISP;
        String FILE_NAME;

        // Costruttore.
        private ContServIspezioniBean() {
        //
        }

        // (Home Intrface) create()
        public IContServIspezioni create(
                long lCOD_SRV, String strFILE_NAME, String strCONTENT_TYPE, byte[] FILE_CONTENT) 
                throws CreateException {
            ContServIspezioniBean bean = new ContServIspezioniBean();
            try {
                ContServIspezioniPK primaryKey = bean.ejbCreate
                        (lCOD_SRV, strFILE_NAME, strCONTENT_TYPE, FILE_CONTENT);
                bean.setEntityContext(new EntityContextWrapper(primaryKey));
                bean.ejbPostCreate(primaryKey);
                return bean;
            } catch (Exception ex) {
                throw new javax.ejb.CreateException(ex.getMessage());
            }
        }

        // (Home Intrface) remove()
        public void remove(Object primaryKey) {
            ContServIspezioniBean bean = new ContServIspezioniBean();
            try {
                Object obj = bean.ejbFindByPrimaryKey((ContServIspezioniPK) primaryKey);
                bean.setEntityContext(new EntityContextWrapper(obj));
                bean.ejbActivate();
                bean.ejbLoad();
                bean.ejbRemove();
            } catch (Exception ex) {
                throw new EJBException(ex);
            }
        }

        // (Home Intrface) findByPrimaryKey()
        public IContServIspezioni findByPrimaryKey(ContServIspezioniPK primaryKey) throws FinderException {
            ContServIspezioniBean bean = new ContServIspezioniBean();
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

        // IContServIspezioniHome-implementation>
        public ContServIspezioniPK ejbCreate
                (long lCOD_SRV, String strFILE_NAME, String strCONTENT_TYPE, byte[] FILE_CONTENT) {
            this.COD_SRV = lCOD_SRV;
            this.COD_ISP = NEW_ID();
            
            File f = new File(strFILE_NAME);
            this.FILE_NAME = f.getName();
            
            this.unsetModified();
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "INSERT INTO " +
                            "con_ser_isp " +
                                "(cod_srv, " +
                                "cod_isp, " +
                                "file_name," +
                                "file_content," +
                                "content_type) " +
                            "VALUES " +
                                "(?,?,?,?,?)");
                ps.setLong(1, this.COD_SRV);
                ps.setLong(2, this.COD_ISP);
                ps.setString(3, this.FILE_NAME);
                ps.setBytes(4, FILE_CONTENT);
                ps.setString(5, strCONTENT_TYPE);
                
                ps.executeUpdate();
                return new ContServIspezioniPK(COD_SRV, COD_ISP);
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        public void ejbPostCreate(ContServIspezioniPK primaryKeylong) {
        }

        public Collection ejbFindAll() {
            return null;
        }

        public ContServIspezioniPK ejbFindByPrimaryKey(ContServIspezioniPK primaryKey) {
            return primaryKey;
        }

        public void ejbActivate() {
            this.primaryKEY = ((ContServIspezioniPK) this.getEntityKey());
            this.COD_SRV = primaryKEY.COD_SRV;
            this.COD_ISP = primaryKEY.COD_ISP;
        }

        public void ejbPassivate() {
            this.primaryKEY = null;
        }

        public void ejbLoad() {
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(
                        "SELECT " +
                            "cod_srv, " +
                            "cod_isp, " +
                            "file_name " +
                        "FROM " +
                            "con_ser_isp " +
                        "WHERE " +
                            "cod_srv = ? " +
                            "and cod_isp = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_ISP);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    this.FILE_NAME = rs.getString("FILE_NAME");
                } else {
                    throw new NoSuchEntityException("ContServIspezioni con ID=" + COD_SRV + "-" + COD_ISP + " non trovata");
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
                            "con_ser_isp " +
                        "WHERE " +
                            "cod_srv = ? " +
                            "and cod_isp = ?");
                ps.setLong(1, COD_SRV);
                ps.setLong(2, COD_ISP);
                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("ContServIspezioni con ID=" + COD_SRV + "-" + COD_ISP + " non trovata");
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
                            "con_ser_isp " +
                        "SET " +
                            "file_name = ? " +
                        "WHERE " +
                            "cod_srv = ? " +
                            "and cod_isp = ?");
                ps.setString(1, FILE_NAME);

                // Clausole di where
                ps.setLong(2, COD_SRV);
                ps.setLong(3, COD_ISP);

                if (ps.executeUpdate() == 0) {
                    throw new NoSuchEntityException("ContServIspezioni con ID=" + COD_SRV + "-" + COD_ISP + " non trovata");
                }
            } catch (Exception ex) {
                throw new EJBException(ex);
            } finally {
                bmp.close();
            }
        }

        // Metodi dell'interfaccia remota. (get e set)
        // COD_SRV
        public void setCOD_SRV(long newCOD_SRV) {
            COD_SRV = newCOD_SRV;
            setModified();
        }

        public long getCOD_SRV() {
            return COD_SRV;
        }

        // COD_ISP
        public void setCOD_ISP(long newCOD_ISP) {
            COD_ISP = newCOD_ISP;
            setModified();
        }

        public long getCOD_ISP() {
            return COD_ISP;
        }

        // FILE_NAME
        public void setFILE_NAME(String newFILE_NAME) {
            if (FILE_NAME != null) {
                if (FILE_NAME.equals(newFILE_NAME)) {
                    return;
                }
            }
            FILE_NAME = newFILE_NAME;
            setModified();            
        }

        public String getFILE_NAME() {
            return FILE_NAME;
        }

        public Collection findEx_Ispezioni(
                long lCOD_SRV) {
            return (new ContServIspezioniBean()).ejbFindEx_Ispezioni(
                    lCOD_SRV);
        }

        public byte[] downloadFile(long lCOD_ISP){
            BMPConnection bmp=getConnection();
            try{
                byte[] bt=null;
                Blob bb;
                PreparedStatement ps=bmp.prepareStatement(
                        "SELECT " +
                            "file_content " +
                        "FROM " +
                            "con_ser_isp " +
                        "WHERE " +
                            "cod_isp=?");
                ps.setLong(1, lCOD_ISP);
                ResultSet rs=ps.executeQuery();
                if(rs.next()) {
                    if( bmp.getType() == ConnectionType.POSTGRE){
                        bt = rs.getBytes(1);
                    } else
                    if( bmp.getType() == ConnectionType.ORACLE){
                        bb = rs.getBlob(1);
                        if(rs.wasNull())
                            bt = null;
                        else
                            bt = bb.getBytes(1, (int) bb.length());
                    } else
                    if( bmp.getType() == ConnectionType.DB2){
                        bt = rs.getBytes(1);
                    }
                } else {
                    bt = null;
                }
                rs.close();
                ps.close();
                return bt;
            } catch(Exception ex){
                throw new EJBException(ex);
            } finally{
                bmp.close();
            }
        }

        public Ispezioni_FileInfo getFileInfo(long lCOD_ISP) {
            Ispezioni_FileInfo info=null;
            BMPConnection bmp=getConnection();
            try{
                PreparedStatement ps=bmp.prepareStatement(
                        "SELECT " +
                            "file_name, " + 
                            "content_type " + 
                        "FROM " +
                            "con_ser_isp " +
                        "WHERE cod_isp=?");
                ps.setLong(1, lCOD_ISP);
                ResultSet rs=ps.executeQuery();
                if(rs.next()) {
                    info=new Ispezioni_FileInfo();
                    info.strName=rs.getString(1);
                    info.strContentType=rs.getString(2);
                }
                rs.close();
                ps.close();
                return info;
            } catch(Exception ex){
                throw new EJBException(ex);
            } finally{bmp.close();}
        }
               
        public Collection ejbFindEx_Ispezioni(
                long lCOD_SRV) {
            String strSql =
                    "SELECT " +
                        "cod_srv, " +
                        "cod_isp, " +
                        "file_name, " +
                        "content_type " +
                    "FROM " +
                        "con_ser_isp " +
                    "WHERE " +
                        "cod_srv = ? ";
            BMPConnection bmp = getConnection();
            try {
                PreparedStatement ps = bmp.prepareStatement(strSql);
                ps.setLong(1, lCOD_SRV);

                ResultSet rs = ps.executeQuery();
                java.util.ArrayList ar = new java.util.ArrayList();
                while (rs.next()) {
                    Ispezioni_View obj = new Ispezioni_View();
                    obj.COD_SRV = rs.getLong(1);
                    obj.COD_ISP = rs.getLong(2);
                    obj.FILE_NAME = rs.getString(3);
                    obj.CONTENT_TYPE = rs.getString(4);
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
        /////fine della Collection ejbFindEx_Ispezioni/////
    }/////fine della classe ContServIspezioniBean/////
%>
<%
            PseudoContext.bind("ContServIspezioniBean", new ContServIspezioniBean());
%>
