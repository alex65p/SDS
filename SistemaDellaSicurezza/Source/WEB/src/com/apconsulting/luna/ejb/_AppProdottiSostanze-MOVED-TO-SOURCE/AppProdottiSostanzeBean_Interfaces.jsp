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
    Document   : AppProdottiSostanzeBean_Interfaces
    Created on : 26-mag-2008, 9.01.00
    Author     : Giancarlo Servadei
--%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
public class AppProdottiSostanzePK {
    public long COD_SRV;
    public long COD_PRO_SOS;
    
    public AppProdottiSostanzePK(long lCOD_SRV, long lCOD_PRO_SOS) {
        this.COD_SRV = lCOD_SRV;
        this.COD_PRO_SOS = lCOD_PRO_SOS;
    }
    
    public int hashCode() {
        return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_PRO_SOS)).hashCode();
    }
    
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof AppProdottiSostanzePK)) {
            return false;
        }
        AppProdottiSostanzePK pk = (AppProdottiSostanzePK) other;
        return (this.COD_SRV == pk.COD_SRV) && (this.COD_PRO_SOS == pk.COD_PRO_SOS);
    }
}

//  Interfaccia remota.
public interface  IAppProdottiSostanze extends EJBObject
{
    //  Campi obbligatori
    // COD_SRV
    public long getCOD_SRV();

    // COD_PRO_SOS
    public long getCOD_PRO_SOS();

    //  Campi opzionali
    // DES
    public String getDES();
    public void setDES(String newDES);
}

//  Interfaccia Home.
public interface IAppProdottiSostanzeHome extends EJBHome
{
    public IAppProdottiSostanze create(
            long lCOD_SRV,
            String strDES) throws CreateException;
   
    public void remove(Object primaryKey);
   
    public IAppProdottiSostanze findByPrimaryKey
                (AppProdottiSostanzePK primaryKey) throws FinderException;
   
    public Collection findAll() throws FinderException;
    
    // Metodi di estrazione dati.
    public boolean getInfoOnDescProdottiSostanzeApp(long SRV_ID);
    
        public Collection findEx_ProdottiSostanzeApp(
            long lCOD_SRV,
            long lCOD_PRO_SOS,
            String strDES,
            int iOrderParameter);
}

class ProdottiSostanzeApp_View implements java.io.Serializable {
        long COD_SRV, COD_PRO_SOS;
        String DES;
}

%>
