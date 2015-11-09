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

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//===============================================================================================================
// ------------ combobox for Capitoli---------------
String BuildCapitoliComboBox(ICapitoliHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getCapitoli_UserID_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Capitoli_UserID_View obj=(Capitoli_UserID_View)it.next();
		String strSEL="";
		if(SELECTED_ID==obj.COD_CPL) strSEL="selected";
	    str=str+"<option "+strSEL+" value=\""+Formatter.format(obj.COD_CPL)+"\">"+Formatter.format(obj.NOM_CPL)+"</option>";
  	}
	return str;
}
//----------------------------------------

//---------------FUNCTIONS FOR TABS-------------------------

/* 	--- Paragrafi
	IParagrafoHome home = Home intarface of Paragrafi
	long lCOD_ARE, long lCOD_AZL, long lCOD_CPL
*/
String BuildParagrafiTab(IParagrafoHome home, long lCOD_ARE, long lCOD_AZL, long lCOD_CPL)
{
	String str;
	java.util.Collection col = home.getParagrafiNome_byAreCpl_View(lCOD_ARE, lCOD_AZL, lCOD_CPL);
	
	str="<table border='0' id='ParagrafiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td width='100%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='1' id='Paragrafi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(lCOD_ARE)/*+"_"+Formatter.format(lCOD_CPL)*/+"\">";
	str+="<td width='100%' class='dataTd'><input type='text' name='NOM_PRG' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	if ( lCOD_ARE!=0 && lCOD_AZL!=0 && lCOD_CPL!=0 ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			ParagrafiNome_byAreCpl_View obj = (ParagrafiNome_byAreCpl_View)it.next();
		    str+="<tr INDEX=\""+Formatter.format(lCOD_ARE)/*+"_"+Formatter.format(lCOD_CPL)*/+"\" ID=\""+obj.COD_PRG+"\">";
			str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NOM_PRG)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	
	return str;
}
%>
