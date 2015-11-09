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
    Document   : SubAppAnalisiRischiBean_Interfaces
    Created on : 29-mag-2008, 08.59.19
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class SubAppAnalisiRischiPK {

        public long COD_SUB_APP;
        public long COD_RSO;
        public String FAS_LAV;
        public String MOD_OPE;
        public String MAT_PRO_IMP;
        public String RIS;
        public String MIS_PRE_PRO;

        public SubAppAnalisiRischiPK(long lCOD_SUB_APP, long lCOD_RSO) {
            this.COD_SUB_APP = lCOD_SUB_APP;
            this.COD_RSO = lCOD_RSO;
        }

        public int hashCode() {
            return (new Long(COD_SUB_APP)).hashCode() ^ (new Long(COD_RSO)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof SubAppAnalisiRischiPK)) {
                return false;
            }
            SubAppAnalisiRischiPK pk = (SubAppAnalisiRischiPK) other;
            return (this.COD_SUB_APP == pk.COD_SUB_APP) && (this.COD_RSO == pk.COD_RSO);
        }
    }

//  Interfaccia remota.
    public interface ISubAppAnalisiRischi extends EJBObject {
        //  Campi obbligatori
        // COD_SUB_APP
        public long getCOD_SUB_APP();
        public void setCOD_SUB_APP(long newCOD_SUB_APP);

        // COD_RSO
        public long getCOD_RSO();

        //  Campi opzionali
        // FAS_LAV
        public String getFAS_LAV();
        public void setFAS_LAV(String newFAS_LAV);

        // MOD_OPE
        public String getMOD_OPE();
        public void setMOD_OPE(String newMOD_OPE);

        // MAT_PRO_IMP
        public String getMAT_PRO_IMP();
        public void setMAT_PRO_IMP(String newMAT_PRO_IMP);

        // RIS
        public String getRIS();
        public void setRIS(String newRIS);

        // MIS_PRE_PRO
        public String getMIS_PRE_PRO();
        public void setMIS_PRE_PRO(String newMIS_PRE_PRO);
    }

//  Interfaccia Home.
    public interface ISubAppAnalisiRischiHome extends EJBHome {

        public ISubAppAnalisiRischi create(
                long lCOD_SUB_APP,
                String strRIS) throws CreateException;

        public void remove(Object primaryKey);

        public ISubAppAnalisiRischi findByPrimaryKey(SubAppAnalisiRischiPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public Collection findEx_AnalisiRischiSubApp(long lCOD_SUB_APP);
    }

// view metodi   
    class AnalisiRischiSubApp_View implements java.io.Serializable {

        public long COD_SUB_APP,  COD_RSO;
        public String FAS_LAV,  MOD_OPE,  MAT_PRO_IMP,  RIS,  MIS_PRE_PRO;
    }
%>
