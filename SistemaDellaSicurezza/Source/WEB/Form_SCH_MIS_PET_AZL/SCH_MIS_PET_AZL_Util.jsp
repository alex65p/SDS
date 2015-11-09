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
String BuildAziendeComboBox(IAziendaHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getAzienda_Name_ByID_View(Security.getAziende());
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Azienda_Name_ByID_View obj=(Azienda_Name_ByID_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_AZL)) strSEL="selected";
	    str=str+"<option "+strSEL+" value=\""+Formatter.format(obj.COD_AZL)+"\">"+Formatter.format(obj.RAG_SCL_AZL)+"</option>";
  	}
	return str;
}

String BuildMisureLOV(IMisurePreventProtettiveAzHome home, String strAPL_A)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Misura") + "</strong></td>";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>";
	str=str+" <td width=\"10%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Versione") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getMisureComboView(strAPL_A);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MPAZ_MisureComboView obj=(MPAZ_MisureComboView)it.next();

		str=str+"<tr valign='top' class=\"VIEW_TR\" INDEX=\""+Formatter.format(obj.lCOD_MIS_PET_AZL)+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str=str+" <td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_MIS_PET)+"</td>";
		str=str+" <td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>";
		str=str+" <td width=\"10%\">&nbsp;"+Formatter.format(obj.lVER_MIS_PET)+"</td>";
		str=str+"</tr>";
  	}
	return str;
}

String BuildTplMisureComboBox(IMisurePreventiveHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getMisurePreventive_ForTPL_PET_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MisurePreventive_ForTPL_PET_View obj=(MisurePreventive_ForTPL_PET_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_TPL_MIS_PET)) strSEL="selected";
	    str=str+"<option "+strSEL+" value=\""+Formatter.format(obj.DES_TPL_MIS_PET)+"\">"+Formatter.format(obj.DES_TPL_MIS_PET)+"</option>";
  	}
	return str;
}

String BuildMisureLuoFscLOV(IMisurePreventiveHome home, String WHE_IN_AZL)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"55%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.fisico") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getMisurePrev_LuogiFsc_View(WHE_IN_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MisurePrev_LuogiFsc_View obj=(MisurePrev_LuogiFsc_View)it.next();

		str=str+"<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.COD_MIS_RSO_LUO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str=str+" <td width=\"55%\">&nbsp;"+Formatter.format(obj.NOM_MIS_PET)+"</td>";
		str=str+" <td width=\"45%\">&nbsp;"+Formatter.format(obj.NOM_LUO_FSC)+"</td>";
		str=str+"</tr>";
  	}
	return str;
}

String BuildMisureManLOV(IAssMisuraAttivitaHome home, String WHE_IN_AZL)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"55%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.mansione") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getAssMP_Man_View(WHE_IN_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		AssMP_Man_View obj=(AssMP_Man_View)it.next();

		str=str+"<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.COD_MIS_PET_MAN+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str=str+" <td width=\"55%\">&nbsp;"+Formatter.format(obj.NOM_MIS_PET)+"</td>";
		str=str+" <td width=\"45%\">&nbsp;"+Formatter.format(obj.NOM_MAN)+"</td>";
		str=str+"</tr>";
  	}
	return str;
}

String BuildRischiLOV(IRischioHome home, long lCOD_AZL, String strAPL_A, long lCOD_MIS_PET_LUO_MAN)
{
	String str="";
	str=str+"<tr class=\"VIEW_HEADER_TR\">";
	str=str+" <td width=\"55%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>";
	str=str+" <td width=\"45%\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.mansione") + "</strong></td>";
	str=str+"</tr>";

	java.util.Collection col = home.getRischio_Elenco_View(lCOD_AZL, strAPL_A, lCOD_MIS_PET_LUO_MAN);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischio_Elenco_View obj=(Rischio_Elenco_View)it.next();

		str=str+"<tr valign='top' class=\"VIEW_TR\" INDEX=\""+obj.lCOD_RSO+"\" onclick=\"g_Handler.OnRowClick(this)\" ondblclick=\"g_Handler.OnRowDblClick(this)\">";	
		str=str+" <td width=\"55%\">&nbsp;"+Formatter.format(obj.strNOM_RSO)+"</td>";
		str=str+" <td width=\"45%\">&nbsp;"+Formatter.format(obj.strNOM_RIL_RSO)+"</td>";
		str=str+"</tr>";
  	}
	return str;
}
%>
