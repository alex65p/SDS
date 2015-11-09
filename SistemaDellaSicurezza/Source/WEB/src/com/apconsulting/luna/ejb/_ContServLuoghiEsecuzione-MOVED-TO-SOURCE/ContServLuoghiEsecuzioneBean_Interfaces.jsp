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
        <version number="1.0" date="12/05/2008" author="Dario Massaroni">
            <comments>
                <comment date="12/05/2008" author="Dario Massaroni">
                    <description>Create ContServLuoghiEsecuzioneBean_Interfaces.jsp</description>
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
public class ContServLuoghiEsecuzionePK {
    public long COD_SRV;
    public long COD_LUO_FSC;
    
    public ContServLuoghiEsecuzionePK(long lCOD_SRV, long lCOD_LUO_FSC) {
        this.COD_SRV = lCOD_SRV;
        this.COD_LUO_FSC = lCOD_LUO_FSC;
    }
    
    public int hashCode() {
        return (new Long(COD_SRV)).hashCode() ^ (new Long(COD_LUO_FSC)).hashCode();
    }
    
    public boolean equals(Object other) {
        if (this == other) {
            return true;
        }
        if (!(other instanceof ContServLuoghiEsecuzionePK)) {
            return false;
        }
        ContServLuoghiEsecuzionePK pk = (ContServLuoghiEsecuzionePK) other;
        return (this.COD_SRV == pk.COD_SRV) && (this.COD_LUO_FSC == pk.COD_LUO_FSC);
    }
}

//  Interfaccia remota.
public interface  IContServLuoghiEsecuzione extends EJBObject
{
    //  Campi obbligatori
    
    // COD_SRV
    public long getCOD_SRV();
    public void setCOD_SRV(long newCOD_SRV);

    // COD_LUO_FSC
    public long getCOD_LUO_FSC();
    public void setCOD_LUO_FSC(long newCOD_LUO_FSC);

    //  Campi opzionali
    
    // DES_SER
    public String getDES_SER();
    public void setDES_SER(String newDES_SER);
}

//  Interfaccia Home.
public interface IContServLuoghiEsecuzioneHome extends EJBHome
{
    public IContServLuoghiEsecuzione create(
                long	lCOD_SRV,
                long	lCOD_LUO_FSC,
                String  DES_SER) throws CreateException;
   
    public void remove(Object primaryKey);
   
    public IContServLuoghiEsecuzione findByPrimaryKey
                (ContServLuoghiEsecuzionePK primaryKey) throws FinderException;
   
    public Collection findAll() throws FinderException;
    
    // Metodi di estrazione dati.
    public Collection getContServLuoghiEsecuzione_View(long lCOD_SRV);
}

/*public*/
// view metodi   
class ContServLuoghiEsecuzione_View implements java.io.Serializable{
	long 	COD_SRV;
	long	COD_LUO_FSC;
        String  NOM_LUO_FSC;
	String	DES_SER;
}
%>
