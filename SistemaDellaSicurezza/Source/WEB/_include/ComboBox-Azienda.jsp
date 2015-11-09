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
String BuildAziendeComboBox(IAziendaHome home, long SELECTED_ID)
{
	StringBuilder str = new StringBuilder();
	java.util.Collection col = home.getAzienda_Name_ByID_View(Security.getAziende());
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Azienda_Name_ByID_View obj=(Azienda_Name_ByID_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_AZL)) strSEL="selected";
                str .append("<option ")
                    .append(strSEL)
                    .append(" value='")
                    .append(Formatter.format(obj.COD_AZL))
                    .append("'>")
                    .append(Formatter.format(obj.RAG_SCL_AZL))
                    .append("</option>");
  	}
	return str.toString();
}
%>
