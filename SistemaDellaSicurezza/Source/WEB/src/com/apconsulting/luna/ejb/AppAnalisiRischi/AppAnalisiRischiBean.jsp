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
    Document   : AppAnalisiRischiBean
    Created on : 28-mag-2008, 14.43.16
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
public class AppAnalisiRischiBean 
                extends BMPEntityBean 
                implements  IAppAnalisiRischi, 
                            IAppAnalisiRischiHome
{
    // Variabili membro.
    long    COD_SRV;
    long    COD_RSO;
    String  FAS_LAV;
    String  MOD_OPE;
    String  MAT_PRO_IMP;
    String  RIS;
    String  MIS_PRE_PRO;
    AppAnalisiRischiPK primaryKEY;
 
    // Costruttore.
    private AppAnalisiRischiBean()
    {
        //
    }

    // (Home Intrface) create()
    public IAppAnalisiRischi create(
                long	lCOD_SRV,
                String  strRIS) throws CreateException
    {
        AppAnalisiRischiBean bean = new AppAnalisiRischiBean();
        try {
            AppAnalisiRischiPK primaryKey = bean.ejbCreate(lCOD_SRV, strRIS);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_SRV, strRIS);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
  
    // (Home Intrface) remove()
    public void remove(Object primaryKey) {
        AppAnalisiRischiBean bean = new AppAnalisiRischiBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((AppAnalisiRischiPK)primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    
    // (Home Intrface) findByPrimaryKey()
    public IAppAnalisiRischi findByPrimaryKey(AppAnalisiRischiPK primaryKey) throws FinderException {
        AppAnalisiRischiBean bean = new AppAnalisiRischiBean();
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
 
    public Collection findEx_AnalisiRischiApp(long lCOD_SRV) {
        return (new AppAnalisiRischiBean()).ejbFindEx_AnalisiRischiApp(lCOD_SRV);
    }
  
    // IAppAnalisiRischiHome-implementation>
    public AppAnalisiRischiPK ejbCreate(
            long lCOD_SRV,
            String strRIS) {
        this.COD_SRV = lCOD_SRV;
        this.COD_RSO = NEW_ID();
        this.RIS = strRIS;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("INSERT INTO " +
                        "app_rso " +
                        "(cod_srv, " +
                        "cod_rso, " +
                        "ris) " +
                     "VALUES " +
                        "(?,?,?) ");
            ps.setLong(1, this.COD_SRV);
            ps.setLong(2, this.COD_RSO);
            ps.setString(3, this.RIS);
            ps.executeUpdate();
            return new AppAnalisiRischiPK(COD_SRV, COD_RSO);
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

    public AppAnalisiRischiPK ejbFindByPrimaryKey(AppAnalisiRischiPK primaryKey) {
        return primaryKey;
    }
    
    public void ejbActivate() {
        this.primaryKEY = ((AppAnalisiRischiPK) this.getEntityKey());
        this.COD_SRV = primaryKEY.COD_SRV;
        this.COD_RSO = primaryKEY.COD_RSO;
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
                        "cod_rso, " +
                        "fas_lav, " +
                        "mod_ope, " +
                        "mat_pro_imp, " +
                        "ris, " +
                        "mis_pre_pro " +
                     "FROM " +
                        "app_rso " +
                     "WHERE " +
                        "cod_srv = ? " +
                     "AND " +
                        "cod_rso = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_RSO);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.FAS_LAV = rs.getString("FAS_LAV");
                this.MOD_OPE = rs.getString("MOD_OPE");
                this.MAT_PRO_IMP = rs.getString("MAT_PRO_IMP");
                this.RIS = rs.getString("RIS");
                this.MIS_PRE_PRO = rs.getString("MIS_PRE_PRO");
            } else {
                throw new NoSuchEntityException("Analisi del rischio con ID=" + COD_SRV + "-" + COD_RSO + " non è trovata");
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
                        "app_rso " +
                     "WHERE " +
                       "cod_srv = ? " +
                     "AND " +
                       "cod_rso = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_RSO);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Analisi del rischio con ID=" + COD_SRV + "-" + COD_RSO + " non è trovata");
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
                        "app_rso " +
                     "SET " +
                        "fas_lav = ?, " +
                        "mod_ope = ?, " +
                        "mat_pro_imp = ?, " +
                        "ris = ?, " +
                        "mis_pre_pro = ? " +
                     "WHERE " +
                        "cod_srv = ? " +
                     "AND " +
                        "cod_rso = ?");

            ps.setString(1, FAS_LAV);
            ps.setString(2, MOD_OPE);
            ps.setString(3, MAT_PRO_IMP);
            ps.setString(4, RIS);
            ps.setString(5, MIS_PRE_PRO);
            
            // Clusole di where
            ps.setLong(6, COD_SRV);
            ps.setLong(7, COD_RSO);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("Analisi del rischio con ID=" + COD_SRV + "-" + COD_RSO + " non è trovata");
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

    // COD_RSO
    public long getCOD_RSO() {
        return COD_RSO;
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

    // MOD_OPE
    public void setMOD_OPE(String newMOD_OPE) {
        if (MOD_OPE != null) {
            if (MOD_OPE.equals(newMOD_OPE)) {
                return;
            }
        }
        MOD_OPE = newMOD_OPE;
        setModified();
    }

    public String getMOD_OPE() {
        return MOD_OPE;
    }
    
    // MAT_PRO_IMP
    public void setMAT_PRO_IMP(String newMAT_PRO_IMP) {
        if (MAT_PRO_IMP != null) {
            if (MAT_PRO_IMP.equals(newMAT_PRO_IMP)) {
                return;
            }
        }
        MAT_PRO_IMP = newMAT_PRO_IMP;
        setModified();
    }

    public String getMAT_PRO_IMP() {
        return MAT_PRO_IMP;
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
       
    // MIS_PRE_PRO
    public void setMIS_PRE_PRO(String newMIS_PRE_PRO) {
        if (MIS_PRE_PRO != null) {
            if (MIS_PRE_PRO.equals(newMIS_PRE_PRO)) {
                return;
            }
        }
        MIS_PRE_PRO = newMIS_PRE_PRO;
        setModified();
    }

    public String getMIS_PRE_PRO() {
        return MIS_PRE_PRO;
    }
    
    public Collection ejbFindEx_AnalisiRischiApp(long lCOD_SRV) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("SELECT " +
                        "cod_srv, " +
                        "cod_rso, " +
                        "fas_lav, " +
                        "mod_ope, " +
                        "mat_pro_imp, " +
                        "ris, " +
                        "mis_pre_pro " +
                     "FROM " +
                        "app_rso " +
                     "WHERE " +
                        "cod_srv = ? ");
            ps.setLong(1, lCOD_SRV);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                AnalisiRischiApp_View obj = new AnalisiRischiApp_View();
                obj.COD_SRV = rs.getLong(1);
                obj.COD_RSO = rs.getLong(2);
                obj.FAS_LAV = rs.getString(3);
                obj.MOD_OPE = rs.getString(4);
                obj.MAT_PRO_IMP = rs.getString(5);
                obj.RIS = rs.getString(6);
                obj.MIS_PRE_PRO = rs.getString(7);
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
    PseudoContext.bind("AppAnalisiRischiBean", new AppAnalisiRischiBean());
%>
