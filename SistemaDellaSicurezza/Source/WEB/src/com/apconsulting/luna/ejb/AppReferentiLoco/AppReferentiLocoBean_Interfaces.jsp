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
    Document   : AppReferentiLocoBean_Interfaces
    Created on : 28-mag-2008, 08.48.48
    Author     : Giancarlo Servadei
--%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class AppReferentiLocoPK {

        public long COD_SRV;
        public long COD_REF_LOC;

        public AppReferentiLocoPK(long lCOD_SRV, long lCOD_REF_LOC) {
            this.COD_SRV = lCOD_SRV;
            this.COD_REF_LOC = lCOD_REF_LOC;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_REF_LOC)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof AppReferentiLocoPK)) {
                return false;
            }
            AppReferentiLocoPK pk = (AppReferentiLocoPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_REF_LOC == pk.COD_REF_LOC);
        }
    }

//  Interfaccia remota.
    public interface IAppReferentiLoco extends EJBObject {
        //  Campi obbligatori
        // COD_SRV
        public long getCOD_SRV();

        // COD_REF_LOC
        public long getCOD_REF_LOC();

        //  Campi opzionali
        // NOM
        public String getNOM();
        public void setNOM(String newNOM);

        // QUA
        public String getQUA();
        public void setQUA(String newQUA);
        
        // TEL
        public String getTEL();
        public void setTEL(String newTEL);
    }

//  Interfaccia Home.
    public interface IAppReferentiLocoHome extends EJBHome {

        public IAppReferentiLoco create(long lCOD_SRV, String strNOM) throws CreateException;

        public void remove(Object primaryKey);

        public IAppReferentiLoco findByPrimaryKey(AppReferentiLocoPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public Collection findEx_ReferentiLocoApp(
                long lCOD_SRV,
                long lCOD_REF_LOC,
                String strNOM,
                String strQUA,
                String strTEL,
                int iOrderParameter);
    }

    /*public*/
// view metodi
    class AppReferentiLoco_View implements java.io.Serializable {

        long COD_SRV, COD_REF_LOC;
        String NOM, QUA, TEL;
    }

%>
