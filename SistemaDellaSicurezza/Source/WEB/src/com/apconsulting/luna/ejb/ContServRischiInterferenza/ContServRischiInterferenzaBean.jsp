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
        <version number="1.0" date="16/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="16/05/2008" author="Dario Massaroni">
                    <description>Create ContServRischiInterferenzaBean.jsp</description>
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

<%!
public class ContServRischiInterferenzaBean 
                extends BMPEntityBean 
                implements  IContServRischiInterferenza, 
                            IContServRischiInterferenzaHome
{
    // Variabili membro.
    long    COD_SRV;
    long    COD_RIS_INT;
    String  FAS_LAV;
    String  TIP_INT;
    String  IMP_INT;
    String  RIS;
    String  MIS_PRE;
    ContServRischiInterferenzaPK primaryKEY;
 
    // Costruttore.
    private ContServRischiInterferenzaBean()
    {
        //
    }

    // (Home Intrface) create()
    public IContServRischiInterferenza create(
                long	lCOD_SRV,
                String  strRIS) throws CreateException
    {
        ContServRischiInterferenzaBean bean = new ContServRischiInterferenzaBean();
        try {
            ContServRischiInterferenzaPK primaryKey = bean.ejbCreate(lCOD_SRV, strRIS);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_SRV, strRIS);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
  
    // (Home Intrface) remove()
    public void remove(Object primaryKey) {
        ContServRischiInterferenzaBean bean = new ContServRischiInterferenzaBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((ContServRischiInterferenzaPK)primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    
    // (Home Intrface) findByPrimaryKey()
    public IContServRischiInterferenza findByPrimaryKey(ContServRischiInterferenzaPK primaryKey) throws FinderException {
        ContServRischiInterferenzaBean bean = new ContServRischiInterferenzaBean();
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
 
    public Collection getContServRischiInterferenza_View(long lCOD_SRV) {
        return (new ContServRischiInterferenzaBean()).ejbGetContServRischiInterferenza_View(lCOD_SRV);
    }
  
    // IContServRischiInterferenzaHome-implementation>
    public ContServRischiInterferenzaPK ejbCreate(
            long lCOD_SRV,
            String strRIS) {
        this.COD_SRV = lCOD_SRV;
        this.COD_RIS_INT = NEW_ID();
        this.RIS = strRIS;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("INSERT INTO " +
                        "con_ser_ris_int (cod_srv, cod_ris_int, ris) " +
                    "VALUES " +
                        "(?,?,?)");
            ps.setLong(1, this.COD_SRV);
            ps.setLong(2, this.COD_RIS_INT);
            ps.setString(3, this.RIS);
            ps.executeUpdate();
            return new ContServRischiInterferenzaPK(COD_SRV, COD_RIS_INT);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_SRV,
            String strRIS) {
    }
    
    public Collection ejbFindAll() {
        return null;
    }

    public ContServRischiInterferenzaPK ejbFindByPrimaryKey(ContServRischiInterferenzaPK primaryKey) {
        return primaryKey;
    }
    
    public void ejbActivate() {
        this.primaryKEY = ((ContServRischiInterferenzaPK) this.getEntityKey());
        this.COD_SRV = primaryKEY.COD_SRV;
        this.COD_RIS_INT = primaryKEY.COD_RIS_INT;
    }
    
    public void ejbPassivate() {
        this.primaryKEY = null;
    }
    
    public void ejbLoad() {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("SELECT " +
                        "cod_srv, " +
                        "cod_ris_int, " +
                        "fas_lav, " +
                        "tip_int, " +
                        "imp_int, " +
                        "ris, " +
                        "mis_pre " +
                    "FROM " +
                        "con_ser_ris_int " +
                    "WHERE " +
                        "cod_srv = ? " +
                        "and cod_ris_int = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_RIS_INT);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.FAS_LAV = rs.getString("FAS_LAV");
                this.TIP_INT = rs.getString("TIP_INT");
                this.IMP_INT = rs.getString("IMP_INT");
                this.RIS = rs.getString("RIS");
                this.MIS_PRE = rs.getString("MIS_PRE");
            } else {
                throw new NoSuchEntityException("ContServRischiInterferenza con ID=" + COD_SRV + "-" + COD_RIS_INT + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement
                    ("DELETE FROM " +
                        "con_ser_ris_int  " +
                    "WHERE " +
                       "cod_srv = ? " +
                       "and cod_ris_int = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_RIS_INT);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ContServRischiInterferenza con ID=" + COD_SRV + "-" + COD_RIS_INT + " non è trovata");
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
            PreparedStatement ps = bmp.prepareStatement
                    ("UPDATE " +
                        "con_ser_ris_int " +
                    "SET " +
                        "fas_lav = ?, " +
                        "tip_int = ?, " +
                        "imp_int = ?, " +
                        "ris = ?, " +
                        "mis_pre = ? " +
                    "WHERE " +
                        "cod_srv = ? " +
                        "and cod_ris_int = ?");

            ps.setString(1, FAS_LAV);
            ps.setString(2, TIP_INT);
            ps.setString(3, IMP_INT);
            ps.setString(4, RIS);
            ps.setString(5, MIS_PRE);
            
            // Clusole di where
            ps.setLong(6, COD_SRV);
            ps.setLong(7, COD_RIS_INT);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ContServRischiInterferenza con ID=" + COD_SRV + "-" + COD_RIS_INT + " non è trovata");
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

    // COD_RIS_INT
    public void setCOD_RIS_INT(long newCOD_RIS_INT) {
        COD_RIS_INT = newCOD_RIS_INT;
        setModified();
    }

    public long getCOD_RIS_INT() {
        return COD_RIS_INT;
    }

    // FAS_LAV
    public void setFAS_LAV(String newFAS_LAV) {
        if (FAS_LAV != null) {
            if (FAS_LAV.equals(newFAS_LAV)) {
                return;
            }
        }
        FAS_LAV = newFAS_LAV;
        setModified();
    }

    public String getFAS_LAV() {
        return FAS_LAV;
    }

    // TIP_INT
    public void setTIP_INT(String newTIP_INT) {
        if (TIP_INT != null) {
            if (TIP_INT.equals(newTIP_INT)) {
                return;
            }
        }
        TIP_INT = newTIP_INT;
        setModified();
    }

    public String getTIP_INT() {
        return TIP_INT;
    }
    
    // IMP_INT
    public void setIMP_INT(String newIMP_INT) {
        if (IMP_INT != null) {
            if (IMP_INT.equals(newIMP_INT)) {
                return;
            }
        }
        IMP_INT = newIMP_INT;
        setModified();
    }

    public String getIMP_INT() {
        return IMP_INT;
    }

    // RIS
    public void setRIS(String newRIS) {
        if (RIS != null) {
            if (RIS.equals(newRIS)) {
                return;
            }
        }
        RIS = newRIS;
        setModified();
    }

    public String getRIS() {
        return RIS;
    }
       
    // MIS_PRE
    public void setMIS_PRE(String newMIS_PRE) {
        if (MIS_PRE != null) {
            if (MIS_PRE.equals(newMIS_PRE)) {
                return;
            }
        }
        MIS_PRE = newMIS_PRE;
        setModified();
    }

    public String getMIS_PRE() {
        return MIS_PRE;
    }
    
    public Collection ejbGetContServRischiInterferenza_View(long lCOD_SRV) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "cod_srv, " +
                        "cod_ris_int, " +
                        "fas_lav, " +
                        "tip_int, " +
                        "imp_int, " +
                        "ris, " +
                        "mis_pre " +
                    "FROM " +
                        "con_ser_ris_int " +
                    "WHERE " +
                        "cod_srv = ? ");
            ps.setLong(1, lCOD_SRV);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ContServRischiInterferenza_View obj = new ContServRischiInterferenza_View();
                obj.COD_SRV = rs.getLong(1);
                obj.COD_RIS_INT = rs.getLong(2);
                obj.FAS_LAV = rs.getString(3);
                obj.TIP_INT = rs.getString(4);
                obj.IMP_INT = rs.getString(5);
                obj.RIS = rs.getString(6);
                obj.MIS_PRE = rs.getString(7);
                al.add(obj);
            }
            bmp.close();
            return al;
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

}
%>
<%
    PseudoContext.bind("ContServRischiInterferenzaBean", new ContServRischiInterferenzaBean());
%>
