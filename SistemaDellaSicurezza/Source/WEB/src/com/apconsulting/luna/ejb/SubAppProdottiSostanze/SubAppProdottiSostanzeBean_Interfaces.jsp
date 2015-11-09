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
    Document   : SubAppProdottiSostanzeBean_Interfaces
    Created on : 23-mag-2008, 9.57.47
    Author     : Giancarlo Servadei
--%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
public class SubAppProdottiSostanzePK {
    public long COD_SUB_APP;
    public long COD_PRO_SOS;
    
    public SubAppProdottiSostanzePK(long lCOD_SUB_APP, long lCOD_PRO_SOS) {
        this.COD_SUB_APP = lCOD_SUB_APP;
        this.COD_PRO_SOS = lCOD_PRO_SOS;
    }
    
    public int hashCode() {
        return (new Long(COD_SUB_APP)).hashCode() ^ (new Long(COD_PRO_SOS)).hashCode();
    }
    
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof SubAppProdottiSostanzePK)) {
            return false;
        }
        SubAppProdottiSostanzePK pk = (SubAppProdottiSostanzePK) other;
        return (this.COD_SUB_APP == pk.COD_SUB_APP) && (this.COD_PRO_SOS == pk.COD_PRO_SOS);
    }
}

//  Interfaccia remota.
public interface  ISubAppProdottiSostanze extends EJBObject
{
    //  Campi obbligatori
    // COD_SUB_APP
    public long getCOD_SUB_APP();

    // COD_PRO_SOS
    public long getCOD_PRO_SOS();

    //  Campi opzionali
    // DES
    public String getDES();
    public void setDES(String newDES);
}

//  Interfaccia Home.
public interface ISubAppProdottiSostanzeHome extends EJBHome
{
    public ISubAppProdottiSostanze create(
            long lCOD_SUB_APP,
            String strDES) throws CreateException;
   
    public void remove(Object primaryKey);
   
    public ISubAppProdottiSostanze findByPrimaryKey
                (SubAppProdottiSostanzePK primaryKey) throws FinderException;
   
    public Collection findAll() throws FinderException;
    
    // Metodi di estrazione dati.
    public boolean getInfoOnDescProdottiSostanzeSubApp(long SUB_APP_ID);
    
        public Collection findEx_ProdottiSostanzeSubApp(
            long lCOD_SUB_APP,
            long lCOD_PRO_SOS,
            String strDES,
            int iOrderParameter);
}

class ProdottiSostanzeSubApp_View implements java.io.Serializable {
        long COD_SUB_APP, COD_PRO_SOS;
        String DES;
}

%>
