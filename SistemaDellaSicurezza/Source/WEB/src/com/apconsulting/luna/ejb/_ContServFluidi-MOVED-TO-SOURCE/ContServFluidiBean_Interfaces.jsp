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

<%
/*
<file>
    <versions>	
        <version number="1.0" date="19/05/2008" author="Giancarlo Servadei">
            <comments>
                <comment date="19/05/2008" author="Giancarlo Servadei">
                    <description>Create ContServFluidiBean_Interfaces.jsp</description>
                </comment>		
            </comments> 
        </version>
    </versions>
</file> 
*/
%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
    public class ContServFluidiPK {

        public long COD_SRV;
        public long COD_FLU;

        public ContServFluidiPK(long lCOD_SRV, long lCOD_FLU) {
            this.COD_SRV = lCOD_SRV;
            this.COD_FLU = lCOD_FLU;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_FLU)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof ContServFluidiPK)) {
                return false;
            }
            ContServFluidiPK pk = (ContServFluidiPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_FLU == pk.COD_FLU);
        }
    }

//  Interfaccia remota.
    public interface IContServFluidi extends EJBObject {
        //  Campi obbligatori

        // COD_SRV
        public long getCOD_SRV();

        // COD_FLU
        public long getCOD_FLU();

        //  Campi opzionali
        // TIP_FLU_DIS
        public String getTIP_FLU_DIS();
        public void setTIP_FLU_DIS(String newTIP_FLU_DIS);

        // LUO_COL
        public String getLUO_COL();
        public void setLUO_COL(String newLUO_COL);

        // DAT_INI_CON
        public java.sql.Date getDAT_INI_CON();
        public void setDAT_INI_CON(java.sql.Date newDAT_INI_CON);

        // DAT_FIN_CON
        public java.sql.Date getDAT_FIN_CON();
        public void setDAT_FIN_CON(java.sql.Date newDAT_FIN_CON);
    }

//  Interfaccia Home.
    public interface IContServFluidiHome extends EJBHome {

        public IContServFluidi create(
                long lCOD_SRV,
                String strTIP_FLU_DIS) throws CreateException;

        public void remove(Object primaryKey);

        public IContServFluidi findByPrimaryKey(ContServFluidiPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public boolean getInfoOnDescFluidi(long SRV_ID);

        public Collection findEx_Fluidi(
                long lCOD_SRV,
                long lCOD_FLU,
                String strTIP_FLU_DIS,
                String strLUO_COL,
                java.sql.Date dtDAT_INI_CON,
                java.sql.Date dtDAT_FIN_CON,
                int iOrderParameter);
    }

    /*public*/
// view metodi
    class Fluidi_View implements java.io.Serializable {

        long COD_SRV, COD_FLU;
        //String PRO_CON, DES_CON;
        String TIP_FLU_DIS, LUO_COL;
        java.sql.Date DAT_INI_CON, DAT_FIN_CON;
    }

%>
