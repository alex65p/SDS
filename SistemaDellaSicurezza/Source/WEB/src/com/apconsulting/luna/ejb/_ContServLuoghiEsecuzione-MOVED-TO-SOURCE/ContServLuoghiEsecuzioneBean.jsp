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
        <version number="1.0" date="13/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="13/05/2008" author="Dario Massaroni">
                    <description>Create ContServLuoghiEsecuzioneBean.jsp</description>
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
public class ContServLuoghiEsecuzioneBean 
                extends BMPEntityBean 
                implements  IContServLuoghiEsecuzione, 
                            IContServLuoghiEsecuzioneHome
{
    // Variabili membro.
    long    COD_SRV;
    long    COD_LUO_FSC;
    String  DES_SER;
    ContServLuoghiEsecuzionePK primaryKEY;
 
    // Costruttore.
    private ContServLuoghiEsecuzioneBean()
    {
        //
    }

    // (Home Intrface) create()
    public IContServLuoghiEsecuzione create(
                long	lCOD_SRV,
                long	lCOD_LUO_FSC,
                String  strDES_SER) throws CreateException
    {
        ContServLuoghiEsecuzioneBean bean = new ContServLuoghiEsecuzioneBean();
        try {
            ContServLuoghiEsecuzionePK primaryKey = 
                    bean.ejbCreate(lCOD_SRV, lCOD_LUO_FSC, strDES_SER);
            bean.setEntityContext(new EntityContextWrapper(primaryKey));
            bean.ejbPostCreate(lCOD_SRV, lCOD_LUO_FSC, strDES_SER);
            return bean;
        } catch (Exception ex) {
            throw new javax.ejb.CreateException(ex.getMessage());
        }
    }
  
    // (Home Intrface) remove()
    public void remove(Object primaryKey) {
        ContServLuoghiEsecuzioneBean bean = new ContServLuoghiEsecuzioneBean();
        try {
            Object obj = bean.ejbFindByPrimaryKey((ContServLuoghiEsecuzionePK)primaryKey);
            bean.setEntityContext(new EntityContextWrapper(obj));
            bean.ejbActivate();
            bean.ejbLoad();
            bean.ejbRemove();
        } catch (Exception ex) {
            throw new EJBException(ex);
        }
    }
    
    // (Home Intrface) findByPrimaryKey()
    public IContServLuoghiEsecuzione findByPrimaryKey(ContServLuoghiEsecuzionePK primaryKey) throws FinderException {
        ContServLuoghiEsecuzioneBean bean = new ContServLuoghiEsecuzioneBean();
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
 
    public Collection getContServLuoghiEsecuzione_View(long lCOD_SRV) {
        return (new ContServLuoghiEsecuzioneBean()).ejbGetContServLuoghiEsecuzione_View(lCOD_SRV);
    }
  
    // IContServLuoghiEsecuzioneHome-implementation>
    public ContServLuoghiEsecuzionePK ejbCreate(
            long lCOD_SRV,
            long lCOD_LUO_FSC,
            String strDES_SER) {
        this.COD_SRV = lCOD_SRV;
        this.COD_LUO_FSC = lCOD_LUO_FSC;
        this.DES_SER = strDES_SER;
        this.unsetModified();
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement
                    ("INSERT INTO " +
                        "con_ser_luo_ese (cod_srv, cod_luo_fsc, des_ser) " +
                    "VALUES " +
                        "(?,?,?)");
            ps.setLong(1, this.COD_SRV);
            ps.setLong(2, this.COD_LUO_FSC);
            ps.setString(3, this.DES_SER);
            ps.executeUpdate();
            return new ContServLuoghiEsecuzionePK(COD_SRV, COD_LUO_FSC);
        } catch (Exception ex) {
            throw new EJBException(ex);
        } finally {
            bmp.close();
        }
    }

    public void ejbPostCreate(
            long lCOD_SRV,
            long lCOD_LUO_FSC,
            String strDES_SER) {
    }
    
    public Collection ejbFindAll() {
        return null;
    }

    public ContServLuoghiEsecuzionePK ejbFindByPrimaryKey(ContServLuoghiEsecuzionePK primaryKey) {
        return primaryKey;
    }
    
    public void ejbActivate() {
        this.primaryKEY = ((ContServLuoghiEsecuzionePK) this.getEntityKey());
        this.COD_SRV = primaryKEY.COD_SRV;
        this.COD_LUO_FSC = primaryKEY.COD_LUO_FSC;
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
                        "cod_luo_fsc, " +
                        "des_ser " +
                    "FROM " +
                        "con_ser_luo_ese " +
                    "WHERE " +
                        "cod_srv = ? " +
                        "and cod_luo_fsc = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_LUO_FSC);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.DES_SER = rs.getString("DES_SER");
            } else {
                throw new NoSuchEntityException("ContServLuoghiEsecuzione con ID=" + COD_SRV + "-" + COD_LUO_FSC + " non è trovata");
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
                        "con_ser_luo_ese  " +
                    "WHERE " +
                       "cod_srv = ? " +
                       "and cod_luo_fsc = ?");
            ps.setLong(1, COD_SRV);
            ps.setLong(2, COD_LUO_FSC);
            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ContServLuoghiEsecuzione con ID=" + COD_SRV + "-" + COD_LUO_FSC + " non è trovata");
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
                        "con_ser_luo_ese " +
                    "SET " +
                        "des_ser = ? " +
                    "WHERE " +
                        "cod_srv = ? " +
                        "and cod_luo_fsc = ?");

            ps.setString(1, DES_SER);
            
            // Clusole di where
            ps.setLong(2, COD_SRV);
            ps.setLong(3, COD_LUO_FSC);

            if (ps.executeUpdate() == 0) {
                throw new NoSuchEntityException("ContServLuoghiEsecuzione con ID=" + COD_SRV + "-" + COD_LUO_FSC + " non è trovata");
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

    // COD_LUO_FSC
    public void setCOD_LUO_FSC(long newCOD_LUO_FSC) {
        COD_LUO_FSC = newCOD_LUO_FSC;
        setModified();
    }

    public long getCOD_LUO_FSC() {
        return COD_LUO_FSC;
    }

    // DES_SER
    public void setDES_SER(String newDES_SER) {
        if (DES_SER != null) {
            if (DES_SER.equals(newDES_SER)) {
                return;
            }
        }
        DES_SER = newDES_SER;
        setModified();
    }

    public String getDES_SER() {
        return DES_SER;
    }

    public Collection ejbGetContServLuoghiEsecuzione_View(long lCOD_SRV) {
        BMPConnection bmp = getConnection();
        try {
            PreparedStatement ps = bmp.prepareStatement(
                    "SELECT " +
                        "a.cod_srv, " +
                        "a.cod_luo_fsc, " +
                        "b.nom_luo_fsc, " +
                        "a.des_ser " +
                    "FROM " +
                        "con_ser_luo_ese a, " +
                        "ana_luo_fsc_tab b " +
                    "WHERE " +
                        "a.cod_luo_fsc = b.cod_luo_fsc " +    
                        "and cod_srv = ? " +
                        "order by b.nom_luo_fsc");
            ps.setLong(1, lCOD_SRV);

            ResultSet rs = ps.executeQuery();
            java.util.ArrayList al = new java.util.ArrayList();
            while (rs.next()) {
                ContServLuoghiEsecuzione_View obj = new ContServLuoghiEsecuzione_View();
                obj.COD_SRV = rs.getLong(1);
                obj.COD_LUO_FSC = rs.getLong(2);
                obj.NOM_LUO_FSC = rs.getString(3);
                obj.DES_SER = rs.getString(4);
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
    PseudoContext.bind("ContServLuoghiEsecuzioneBean", new ContServLuoghiEsecuzioneBean());
%>
