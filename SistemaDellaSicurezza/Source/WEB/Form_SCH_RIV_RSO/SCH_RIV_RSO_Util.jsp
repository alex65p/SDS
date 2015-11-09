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
String BuildFattoreRischioComboBox(IRischioHome home, long SELECTED_ID, long FILTER_ID)
{
	String str = "";

	java.util.Collection col = home.getRischio_Nome_Fattore_ComboBox(FILTER_ID);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_Nome_Fattore_ComboBox obj = (Rischio_Nome_Fattore_ComboBox)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.lCOD_FAT_RSO) strSEL="selected";
	    str=str+"<option " + strSEL + " value=\"" + Formatter.format(obj.lCOD_FAT_RSO) + "\">" + Formatter.format(obj.strNOM_FAT_RSO) + "</option>";
  	}
	
	return str;
}

String BuildRischio_MAN_Lov(IRischioHome home, long lAzienda, String strNOM, String strCLF)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str=str+" <td width=\"30%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Classificazione") + "</strong></td>";
	str=str+" <td width=\"25%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getRischio_MAN_ComboBox(lAzienda, strNOM, strCLF);
	
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_MAN_LUO_FSC_ComboBox obj=(Rischio_MAN_LUO_FSC_ComboBox)it.next();
		str += "<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_RSO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str += "<td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>";
		str += "<td width=\"30%\">&nbsp;"+Formatter.format(obj.strCLF_RSO)+"</td>";
		str += "<td width=\"25%\">&nbsp;"+Formatter.format(obj.strNOM_LUO_FSC_MAN)+"</td>";
		str += "</tr>";
  }
	return str;
}

String BuildRischio_LUO_FSC_Lov(IRischioHome home, long lAzienda, String strNOM, String strCLF)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str=str+" <td width=\"30%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Classificazione") + "</strong></td>";
	str=str+" <td width=\"25%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.fisico") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getRischio_LUO_FSC_ComboBox(lAzienda, strNOM, strCLF);
	
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_MAN_LUO_FSC_ComboBox obj=(Rischio_MAN_LUO_FSC_ComboBox)it.next();
		str += "<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_RSO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str += "<td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>";
		str += "<td width=\"30%\">&nbsp;"+Formatter.format(obj.strCLF_RSO)+"</td>";
		str += "<td width=\"25%\">&nbsp;"+Formatter.format(obj.strNOM_LUO_FSC_MAN)+"</td>";
		str += "<td>&nbsp;"+Formatter.format(obj.lCOD_RSO)+"</td>";
		str += "</tr>";
  }
	return str;
}
String BuildRischio_LUO_FSC_MAN_Lov(IRischioHome home, long lAzienda){
	String str="";
	str+="<tr class=\"VIEW_HEADER_TR\">";
	str+=" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str+=" <td width=\"30%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Classificazione") + "</strong></td>";
	str+=" <td width=\"25%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.lavorativa/Luogo.fisico") + "</strong></td>";
	str+="</tr>";

	java.util.Collection col = home.getRischio_MAN_LUO_FSC_ComboBox(lAzienda);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_MAN_LUO_FSC_ComboBox obj=(Rischio_MAN_LUO_FSC_ComboBox)it.next();
		str+="<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_RSO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str+="<td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>";
		str+="<td width=\"30%\">&nbsp;"+Formatter.format(obj.strCLF_RSO)+"</td>";
		str+="<td width=\"25%\">&nbsp;"+Formatter.format(obj.strNOM_LUO_FSC_MAN)+"</td>";
		str+="</tr>";
  }
	return str;
}

%>
