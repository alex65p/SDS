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
    Document   : ContServDUVRIBean_Interfaces
    Created on : 30-mag-2008, 12.02.36
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
public class ContServDUVRIPK {
    public long COD_SRV;
    public long COD_PRO_DUV;
    
    public ContServDUVRIPK(long lCOD_SRV, long lCOD_PRO_DUV) {
        this.COD_SRV = lCOD_SRV;
        this.COD_PRO_DUV = lCOD_PRO_DUV;
    }
    
    public int hashCode() {
        return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_PRO_DUV)).hashCode();
    }
    
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof ContServDUVRIPK)) {
            return false;
        }
        ContServDUVRIPK pk = (ContServDUVRIPK) other;
        return (this.COD_SRV == pk.COD_SRV) && (this.COD_PRO_DUV == pk.COD_PRO_DUV);
    }
}

//  Interfaccia remota.
public interface  IContServDUVRI extends EJBObject
{
    //  Campi obbligatori
    // COD_SRV
    public long getCOD_SRV();

    // COD_PRO_DUV
    public long getCOD_PRO_DUV();

    //  Campi opzionali
    // PRO_DUV
    public String getPRO_DUV();
    public void setPRO_DUV(String newPRO_DUV);
    
    // DAT_DUV
    public java.sql.Date getDAT_DUV();
    public void setDAT_DUV(java.sql.Date newDAT_DUV);
}

//  Interfaccia Home.
public interface IContServDUVRIHome extends EJBHome
{
    public IContServDUVRI create(
            long lCOD_SRV,
            String strPRO_DUV,
            java.sql.Date dtDAT_DUV,
            byte[] pdfGen,
            byte[] xmlGen) throws CreateException;
   
    public void remove(Object primaryKey);
   
    public IContServDUVRI findByPrimaryKey
                (ContServDUVRIPK primaryKey) throws FinderException;
   
    public Collection findAll() throws FinderException;
    
    // Metodi di estrazione dati.
    public String getProgressivoDUVRI(long lCOD_AZL, long lCOD_SRV, String strPRO_CON);
  
    public Collection findEx_ContServDUVRI(
            long lCOD_SRV);
    
    public byte[] downloadFile(long lCOD_PRO_DUV);
}

// view metodi
class ContServDUVRI_View implements java.io.Serializable {
        long COD_SRV, COD_PRO_DUV;
        String PRO_DUV;
        java.sql.Date DAT_DUV;
}

%>
