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

<%@page import="com.apconsulting.luna.ejb.AnagrOpere.IAnagrOpere"%>
<%@page import="com.apconsulting.luna.ejb.Cantiere.Cantiere_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrOpere.Opere_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrCantieri.IAnagrCantieriHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %><%!
// ------------ combobox for Classificazione ---------------


String BuildOpereTab(IAnagrCantieriHome home, long lCOD_PRO)
{
	String str = "";
	long lCOD_AZL = Security.getAzienda();
	java.util.Collection col = home.getOpere_View(lCOD_PRO, lCOD_AZL);

	str="<table border='0' align='left' width='665' id='OpereHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='400'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Opere") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='665' id='Opere' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PRO)+"'>";
   str+="<td width='400' class='dataTd'><input type='text' name='NOM_OPE' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Opere_View obj=(Opere_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_PRO)+"' ID='"+obj.COD_OPE+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 663px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_OPE)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

%>
