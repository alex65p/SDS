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
    Document   : ContServCentriEmergenzaBean_Interfaces
    Created on : 21-mag-2008, 11.14.10
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServCentriEmergenzaPK {

        public long COD_SRV;
        public long COD_CEN_EME;

        public ContServCentriEmergenzaPK(long lCOD_SRV, long lCOD_CEN_EME) {
            this.COD_SRV = lCOD_SRV;
            this.COD_CEN_EME = lCOD_CEN_EME;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_CEN_EME)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof ContServCentriEmergenzaPK)) {
                return false;
            }
            ContServCentriEmergenzaPK pk = (ContServCentriEmergenzaPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_CEN_EME == pk.COD_CEN_EME);
        }
    }

//  Interfaccia remota.
    public interface IContServCentriEmergenza extends EJBObject {
        //  Campi obbligatori
        // COD_SRV
        public long getCOD_SRV();

        // COD_CEN_EME
        public long getCOD_CEN_EME();

        //  Campi opzionali
        // DES
        public String getDES();
        public void setDES(String newDES);

        // RIF
        public String getRIF();
        public void setRIF(String newRIF);
    }

//  Interfaccia Home.
    public interface IContServCentriEmergenzaHome extends EJBHome {

        public IContServCentriEmergenza create(
                long lCOD_SRV, String strRIF) throws CreateException;

        public void remove(Object primaryKey);

        public IContServCentriEmergenza findByPrimaryKey(ContServCentriEmergenzaPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public boolean getInfoOnDescCentriEmergenza(long SRV_ID);

        public Collection findEx_CentriEmergenza(
                long lCOD_SRV,
                long lCOD_CEN_EME,
                String strDES,
                String strRIF,
                int iOrderParameter);
    }

    /*public*/
// view metodi
    class CentriEmergenza_View implements java.io.Serializable {

        long COD_SRV, COD_CEN_EME;
        String DES, RIF;
        //String PRO_CON, DES_CON;
    }

%>
