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
                    <description>Create ContServRischiInterferenzaBean_Interfaces.jsp</description>
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
public class ContServRischiInterferenzaPK {
    public long COD_SRV;
    public long COD_RIS_INT;
    public String FAS_LAV;
    public String TIP_INT;
    public String IMP_INT;
    public String RIS;
    public String MIS_PRE;
    
    public ContServRischiInterferenzaPK(long lCOD_SRV, long lCOD_RIS_INT) {
        this.COD_SRV = lCOD_SRV;
        this.COD_RIS_INT = lCOD_RIS_INT;
    }
    
    public int hashCode() {
        return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_RIS_INT)).hashCode();
    }
    
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof ContServRischiInterferenzaPK)) {
            return false;
        }
        ContServRischiInterferenzaPK pk = (ContServRischiInterferenzaPK) other;
        return (this.COD_SRV == pk.COD_SRV) && (this.COD_RIS_INT == pk.COD_RIS_INT);
    }
}

//  Interfaccia remota.
public interface  IContServRischiInterferenza extends EJBObject
{
    //  Campi obbligatori
    
    // COD_SRV
    public long getCOD_SRV();

    // COD_RIS_INT
    public long getCOD_RIS_INT();
    public void setCOD_RIS_INT(long newCOD_RIS_INT);

    //  Campi opzionali
    
    // FAS_LAV
    public String getFAS_LAV();
    public void setFAS_LAV(String newFAS_LAV);
    
    // TIP_INT
    public String getTIP_INT();
    public void setTIP_INT(String newTIP_INT);

    // IMP_INT
    public String getIMP_INT();
    public void setIMP_INT(String newIMP_INT);
    
    // RIS
    public String getRIS();
    public void setRIS(String newRIS);

    // RIS
    public String getMIS_PRE();
    public void setMIS_PRE(String newMIS_PRE);
}

//  Interfaccia Home.
public interface IContServRischiInterferenzaHome extends EJBHome
{
    public IContServRischiInterferenza create(
                long	lCOD_SRV,
                String  strRIS) throws CreateException;
   
    public void remove(Object primaryKey);
   
    public IContServRischiInterferenza findByPrimaryKey
                (ContServRischiInterferenzaPK primaryKey) throws FinderException;
   
    public Collection findAll() throws FinderException;
    
    // Metodi di estrazione dati.
    public Collection getContServRischiInterferenza_View(long lCOD_SRV);
}

/*public*/
// view metodi   
class ContServRischiInterferenza_View implements java.io.Serializable{
    public long COD_SRV;
    public long COD_RIS_INT;
    public String FAS_LAV;
    public String TIP_INT;
    public String IMP_INT;
    public String RIS;
    public String MIS_PRE;
}
%>
