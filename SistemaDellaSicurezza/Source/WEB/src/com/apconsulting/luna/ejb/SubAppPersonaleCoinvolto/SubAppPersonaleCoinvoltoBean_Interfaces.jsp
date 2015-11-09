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
    Document   : SubAppPersonaleCoinvoltoBean_Interfaces
    Created on : 22-mag-2008, 9.31.07
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
public class SubAppPersonaleCoinvoltoPK {
    public long COD_SUB_APP;
    public long COD_PER_COI;
    
    public SubAppPersonaleCoinvoltoPK(long lCOD_SUB_APP, long lCOD_PER_COI) {
        this.COD_SUB_APP = lCOD_SUB_APP;
        this.COD_PER_COI = lCOD_PER_COI;
    }
    
    public int hashCode() {
        return (new Long(COD_SUB_APP)).hashCode() ^ (new Long(COD_PER_COI)).hashCode();
    }
    
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof SubAppPersonaleCoinvoltoPK)) {
            return false;
        }
        SubAppPersonaleCoinvoltoPK pk = (SubAppPersonaleCoinvoltoPK) other;
        return (this.COD_SUB_APP == pk.COD_SUB_APP) && (this.COD_PER_COI == pk.COD_PER_COI);
    }
}

//  Interfaccia remota.
public interface  ISubAppPersonaleCoinvolto extends EJBObject
{
    //  Campi obbligatori
    // COD_SUB_APP
    public long getCOD_SUB_APP();

    // COD_PER_COI
    public long getCOD_PER_COI();

    //  Campi opzionali
    // NOM
    public String getNOM();
    public void setNOM(String newNOM);
    
    // QUA
    public String getQUA();
    public void setQUA(String newQUA);
}

//  Interfaccia Home.
public interface ISubAppPersonaleCoinvoltoHome extends EJBHome
{
    public ISubAppPersonaleCoinvolto create(long lCOD_SUB_APP, String strNOM) throws CreateException;
   
    public void remove(Object primaryKey);
   
    public ISubAppPersonaleCoinvolto findByPrimaryKey
                (SubAppPersonaleCoinvoltoPK primaryKey) throws FinderException;
   
    public Collection findAll() throws FinderException;
  
    public Collection findEx_PersonaleCoinvoltoSubApp(
            long lCOD_SUB_APP,
            long lCOD_PER_COI,
            String strNOM,
            String strQUA,
            int iOrderParameter);
}

// view metodi
class SubAppPersonaleCoinvolto_View implements java.io.Serializable {
        long COD_SUB_APP, COD_PER_COI;
        String NOM, QUA;
}

%>
