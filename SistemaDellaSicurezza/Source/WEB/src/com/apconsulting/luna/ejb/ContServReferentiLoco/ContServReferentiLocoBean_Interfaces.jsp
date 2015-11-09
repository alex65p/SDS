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
    Document   : ContServReferentiLocoBean_Interfaces
    Created on : 27-mag-2008, 10.18.01
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServReferentiLocoPK {

        public long COD_AZL;
        public long COD_SRV;
        public long COD_DPD;
        public String TEL;

        public ContServReferentiLocoPK(long lCOD_AZL, long lCOD_SRV, long lCOD_DPD) {
            this.COD_AZL = lCOD_AZL;
            this.COD_SRV = lCOD_SRV;
            this.COD_DPD = lCOD_DPD;
        }

        public int hashCode() {
            return (new Long(COD_AZL)).hashCode() ^ (new Long(COD_SRV)).hashCode() ^ (new Long(COD_DPD)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof ContServReferentiLocoPK)) {
                return false;
            }
            ContServReferentiLocoPK pk = (ContServReferentiLocoPK) other;
            return (this.COD_AZL == pk.COD_AZL) && (this.COD_SRV == pk.COD_SRV) && (this.COD_DPD == pk.COD_DPD);
        }
    }

//  Interfaccia remota.
    public interface IContServReferentiLoco extends EJBObject {
        //  Campi obbligatori
        // COD_AZL
        public long getCOD_AZL();

        // COD_SRV
        public long getCOD_SRV();

        // COD_DPD
        public long getCOD_DPD();

        //  Campi opzionali
        // TEL
        public String getTEL();

        public void setTEL(String newTEL);

    }

//  Interfaccia Home.
    public interface IContServReferentiLocoHome extends EJBHome {

        public IContServReferentiLoco create(
                long lCOD_AZL,
                long lCOD_SRV,
                long lCOD_DPD) throws CreateException;

        public void remove(Object primaryKey);

        public IContServReferentiLoco findByPrimaryKey(ContServReferentiLocoPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        public Collection findEx_ReferentiLocoCmt(
                long AZL_ID,
                long SRV_ID,
                long lCOD_DPD,
                String strTEL);
    }

// view metodi
    class ComReferentiLoco_View implements java.io.Serializable {

        long COD_AZL;
        long COD_SRV;
        long COD_DPD;
        String COG_DPD;
        String NOM_DPD;
        String NOM_FUZ_AZL;
        String TEL;
    }

%>
