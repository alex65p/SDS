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
        <version number="1.0" date="20/05/2008" author="Giancarlo Servadei">
        <comments>
        <comment date="20/05/2008" author="Giancarlo Servadei">
        <description>Create ContServIspezioniBean_Interfaces.jsp</description>
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
<%@ page import="java.io.*"%>

<%!
    public class ContServIspezioniPK {

        public long COD_SRV;
        public long COD_ISP;

        public ContServIspezioniPK(long lCOD_SRV, long lCOD_ISP) {
            this.COD_SRV = lCOD_SRV;
            this.COD_ISP = lCOD_ISP;
        }

        public int hashCode() {
            return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_ISP)).hashCode();
        }

        public boolean equals(Object other) {
            if (this == other) {
                return true;
            }
            if (!(other instanceof ContServIspezioniPK)) {
                return false;
            }
            ContServIspezioniPK pk = (ContServIspezioniPK) other;
            return (this.COD_SRV == pk.COD_SRV) && (this.COD_ISP == pk.COD_ISP);
        }
    }

//  Interfaccia remota.
    public interface IContServIspezioni extends EJBObject {
        //  Campi obbligatori
        // COD_SRV
        public long getCOD_SRV();
        public void setCOD_SRV(long newCOD_SRV);

        // COD_ISP
        public long getCOD_ISP();
        public void setCOD_ISP(long newCOD_ISP);

        // FILE_NAME
        public String getFILE_NAME();
        public void setFILE_NAME(String newFILE_NAME);
    }

//  Interfaccia Home.
    public interface IContServIspezioniHome extends EJBHome {

        public IContServIspezioni create(
                long lCOD_SRV, 
                String FILE_NAME, 
                String CONTENT_TYPE,
                byte[] FILE_CONTENT) throws CreateException;

        public void remove(Object primaryKey);

        public IContServIspezioni findByPrimaryKey(ContServIspezioniPK primaryKey) throws FinderException;

        public Collection findAll() throws FinderException;

        // Metodi di estrazione dati.
        public Collection findEx_Ispezioni(
                long lCOD_SRV);
        
        public byte[] downloadFile(long lCOD_ISP);
        public Ispezioni_FileInfo getFileInfo(long lCOD_ISP);
    }

    /*public*/
// view metodi
    class Ispezioni_View implements java.io.Serializable {

        long COD_SRV;
        long COD_ISP;
        String FILE_NAME;
        String CONTENT_TYPE;
    }
    
    class Ispezioni_FileInfo{
        public String strName;
        public String strContentType;
    }
%>
