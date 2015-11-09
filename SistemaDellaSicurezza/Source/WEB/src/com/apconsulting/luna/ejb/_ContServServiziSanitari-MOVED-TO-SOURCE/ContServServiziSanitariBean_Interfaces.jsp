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
    Document   : ContServServiziSanitariBean_Interfaces
    Created on : 21-mag-2008, 12.54.17
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServServiziSanitariPK {

        public long COD_SRV;
        public long COD_SRV_SAN;

        public ContServServiziSanitariPK(long lCOD_SRV, long lCOD_SRV_SAN) {
            this.COD_SRV = lCOD_SRV;
            this.COD_SRV_SAN = lCOD_SRV_SAN;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_SRV_SAN)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof ContServServiziSanitariPK)) {
                return false;
            }
            ContServServiziSanitariPK pk = (ContServServiziSanitariPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_SRV_SAN == pk.COD_SRV_SAN);
        }
    }

//  Interfaccia remota.
    public interface IContServServiziSanitari extends EJBObject {
        //  Campi obbligatori
        // COD_SRV
        public long getCOD_SRV();

        // COD_SRV_SAN
        public long getCOD_SRV_SAN();

        //  Campi opzionali
        // DES_SRV_VIT
        public String getDES_SRV_VIT();
        public void setDES_SRV_VIT(String newDES_SRV_VIT);

        // DAT_INI_IMP
        public java.sql.Date getDAT_INI_IMP();
        public void setDAT_INI_IMP(java.sql.Date newDAT_INI_IMP);

        // DAT_FIN_IMP
        public java.sql.Date getDAT_FIN_IMP();
        public void setDAT_FIN_IMP(java.sql.Date newDAT_FIN_IMP);

        // ORA_IMP
        public String getORA_IMP();
        public void setORA_IMP(String newORA_IMP);
    }

//  Interfaccia Home.
    public interface IContServServiziSanitariHome extends EJBHome {

        public IContServServiziSanitari create(
                long lCOD_SRV, String strDES_SRV_VIT) throws CreateException;

        public void remove(Object primaryKey);

        public IContServServiziSanitari findByPrimaryKey(ContServServiziSanitariPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public boolean getInfoOnDescServiziSanitari(long SRV_ID);

        public Collection findEx_ServiziSanitari(
                long lCOD_SRV,
                long lCOD_SRV_SAN,
                String strDES_SRV_VIT,
                java.sql.Date dtDAT_INI_IMP,
                java.sql.Date dtDAT_FIN_IMP,
                String strORA_IMP,
                int iOrderParameter);
    }

    /*public*/
// view metodi
    class ServiziSanitari_View implements java.io.Serializable {

        long COD_SRV, COD_SRV_SAN;
        String DES_SRV_VIT, ORA_IMP;
        java.sql.Date DAT_INI_IMP, DAT_FIN_IMP;
        //String PRO_CON, DES_CON;
    }

%>
