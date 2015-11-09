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
    Document   : ContServPrestitoMaterialiBean_Interfaces
    Created on : 22-mag-2008, 14.09.27
    Author     : Giancarlo Servadei
--%>

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServPrestitoMaterialiPK {

        public long COD_SRV;
        public long COD_PRE_MAT;

        public ContServPrestitoMaterialiPK(long lCOD_SRV, long lCOD_PRE_MAT) {
            this.COD_SRV = lCOD_SRV;
            this.COD_PRE_MAT = lCOD_PRE_MAT;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_PRE_MAT)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof ContServPrestitoMaterialiPK)) {
                return false;
            }
            ContServPrestitoMaterialiPK pk = (ContServPrestitoMaterialiPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_PRE_MAT == pk.COD_PRE_MAT);
        }
    }

//  Interfaccia remota.
    public interface IContServPrestitoMateriali extends EJBObject {
        //  Campi obbligatori
        // COD_SRV
        public long getCOD_SRV();

        // COD_PRE_MAT
        public long getCOD_PRE_MAT();

        //  Campi opzionali
        // TIP_MAT
        public String getTIP_MAT();
        public void setTIP_MAT(String newTIP_MAT);
        
        // LUO_MES_DIS
        public String getLUO_MES_DIS();
        public void setLUO_MES_DIS(String newLUO_MES_DIS);

        // DAT_INI_PRE
        public java.sql.Date getDAT_INI_PRE();
        public void setDAT_INI_PRE(java.sql.Date newDAT_INI_PRE);

        // DAT_FIN_PRE
        public java.sql.Date getDAT_FIN_PRE();
        public void setDAT_FIN_PRE(java.sql.Date newDAT_FIN_PRE);
    }

//  Interfaccia Home.
    public interface IContServPrestitoMaterialiHome extends EJBHome {

        public IContServPrestitoMateriali create(
                long lCOD_SRV, String strTIP_MAT) throws CreateException;

        public void remove(Object primaryKey);

        public IContServPrestitoMateriali findByPrimaryKey(ContServPrestitoMaterialiPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public boolean getInfoOnDescPrestitoMateriali(long SRV_ID);

        public Collection findEx_PrestitoMateriali(
                long lCOD_SRV,
                long lCOD_PRE_MAT,
                String strTIP_MAT,
                String strLUO_MES_DIS,
                java.sql.Date dtDAT_INI_PRE,
                java.sql.Date dtDAT_FIN_PRE,
                int iOrderParameter);
    }

    /*public*/
// view metodi
    class PrestitoMateriali_View implements java.io.Serializable {

        long COD_SRV, COD_PRE_MAT;
        String TIP_MAT, LUO_MES_DIS;
        java.sql.Date DAT_INI_PRE, DAT_FIN_PRE;
        //String PRO_CON, DES_CON;
    }

%>
