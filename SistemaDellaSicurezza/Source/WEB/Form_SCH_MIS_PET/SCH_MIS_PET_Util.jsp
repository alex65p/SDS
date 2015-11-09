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

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %><%
/*
<file>
  <versions>	
    <version number="1.0" date="01/03/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="01/03/2004" author="Alexey Kolesnik">
				   <description> ComboBox functions </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%!
String BuildMisuraLOV(IMisuraPreventivaHome home,long lCOD_AZL)
{
	StringBuffer str = new StringBuffer();
	str.append("<tr class=\"VIEW_HEADER_TR\">");
	str.append("<td width=\"50%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Misura") + "</strong></td>");
	str.append("<td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>");
	str.append("<td width=\"5%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Versione") + "</strong></td>");
	str.append("</tr>");

	java.util.Collection col = home.getMisureComboView(lCOD_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MisureComboView obj=(MisureComboView)it.next();

		str.append("<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_MIS_PET+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">");	
		str.append(" <td width=\"50%\">&nbsp;"+Formatter.format(obj.strNOM_MIS_PET)+"</td>");
		str.append(" <td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>");
		str.append(" <td width=\"5%\">&nbsp;"+Formatter.format(obj.lVER_MIS_PET)+"</td>");
		str.append("</tr>");
  	}
	return str.toString();
}

String BuildMisuraLuoLOV(IMisuraPreventivaHome home, String strCOD_AZL)
{
	StringBuffer str = new StringBuffer();
	str.append("<tr class=\"VIEW_HEADER_TR\">");
	str.append(" <td width=\"100%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.fisico") + "</strong></td>");
	str.append("</tr>");

	java.util.Collection col = home.getMisureLuoManComboView("L", strCOD_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MisureLuoManComboView obj=(MisureLuoManComboView)it.next();

		str.append("<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_MIS+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">");	
		str.append(" <td width=\"100%\">&nbsp;"+Formatter.format(obj.strNOM_MIS)+"</td>");
		str.append("</tr>");
  	}
	return str.toString();
}

String BuildMisuraManLOV(IMisuraPreventivaHome home, String strCOD_AZL)
{
	StringBuffer str = new StringBuffer();
	str.append("<tr class=\"VIEW_HEADER_TR\">");
	str.append(" <td width=\"50%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>");
	str.append(" <td width=\"50%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.mansione") + "</strong></td>");
	str.append("</tr>");

	java.util.Collection col = home.getMisureLuoManComboView("M", strCOD_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MisureLuoManComboView obj=(MisureLuoManComboView)it.next();

		str.append("<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_MIS+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">");	
		str.append(" <td width=\"50%\">&nbsp;"+Formatter.format(obj.strNOM_MIS)+"</td>");
		str.append(" <td width=\"50%\">&nbsp;"+Formatter.format(obj.strNOM_MAN)+"</td>");
		str.append("</tr>");
  	}
	return str.toString();
}

String BuildRischiLOV(IMisuraPreventivaHome home, String strCOD_AZL, String strType)
{
	StringBuffer str = new StringBuffer();
	str.append("<tr class=\"VIEW_HEADER_TR\">");
	str.append(" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>");
	str.append(" <td width=\"55%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.mansione") + "</strong></td>");
	str.append("</tr>");

	java.util.Collection col = home.getRischiComboView(strType, strCOD_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		RischiComboView obj=(RischiComboView)it.next();

		str.append("<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_RSO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">");	
		str.append(" <td width=\"50%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>");
		str.append(" <td width=\"50%\">&nbsp;"+Formatter.format(obj.strNOM_MIS_PET)+"</td>");
		str.append("</tr>");
  	}
	return str.toString();
}

%>
