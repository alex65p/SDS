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
    Document   : AppPersonaleCoinvoltoBean_Interfaces
    Created on : 23-mag-2008, 22.37.14
    Author     : Giancarlo Servadei
--%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class AppPersonaleCoinvoltoPK {

        public long COD_SRV;
        public long COD_PER_COI;

        public AppPersonaleCoinvoltoPK(long lCOD_SRV, long lCOD_PER_COI) {
            this.COD_SRV = lCOD_SRV;
            this.COD_PER_COI = lCOD_PER_COI;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_PER_COI)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof AppPersonaleCoinvoltoPK)) {
                return false;
            }
            AppPersonaleCoinvoltoPK pk = (AppPersonaleCoinvoltoPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_PER_COI == pk.COD_PER_COI);
        }
    }

//  Interfaccia remota.
    public interface IAppPersonaleCoinvolto extends EJBObject {
        //  Campi obbligatori
        // COD_SRV

        public long getCOD_SRV();

        // COD_PER_COI
        public long getCOD_PER_COI();
        public void setCOD_PER_COI(long newCOD_PER_COI);

        //  Campi opzionali
        // NOM
        public String getNOM();
        public void setNOM(String newNOM);

        // QUA
        public String getQUA();
        public void setQUA(String newQUA);
    }

//  Interfaccia Home.
    public interface IAppPersonaleCoinvoltoHome extends EJBHome {

        public IAppPersonaleCoinvolto create(long lCOD_SRV, String strNOM) throws CreateException;

        public void remove(Object primaryKey);

        public IAppPersonaleCoinvolto findByPrimaryKey(AppPersonaleCoinvoltoPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public Collection findEx_PersonaleCoinvoltoApp(
                long lCOD_SRV,
                long lCOD_PER_COI,
                String strNOM,
                String strQUA,
                int iOrderParameter);
    }

    /*public*/
// view metodi
    class AppPersonaleCoinvolto_View implements java.io.Serializable {

        long COD_SRV, COD_PER_COI;
        String NOM, QUA;
    }

%>
