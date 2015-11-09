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

<%!
String BuildNonConformitaComboBox(IInterventoAudutHome home, long SELECTED_ID, long AZL_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getGestioneInterventoAudit_ForSelectDPI_View(AZL_ID);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		GestioneInterventoAudit_ForSelectDPI_View  dt = (GestioneInterventoAudit_ForSelectDPI_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_INR_ADT){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+dt.COD_INR_ADT+"'>"+dt.DES_INR_ADT+"</option>";
  	}
	//out.print("<script>parent.alert(\""+str+"\")</script>");
	return str;
}
%>
	
