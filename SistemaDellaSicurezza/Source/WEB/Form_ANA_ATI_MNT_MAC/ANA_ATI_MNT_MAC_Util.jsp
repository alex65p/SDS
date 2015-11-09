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
    <version number="1.0" date="30/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="30/01/2004" author="Podmasteriev Alexandr">
				   <description>ANA_ATI_MNT_MAC_Util.jsp-functions for ANA_ATI_MNT_MAC</description>
				   <description>Functions for comboboxes and tab</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//===================== combobox ===================
//====================================================
// ------------ combobox for fornitore ---------------
String BuildMacchinaComboBox(IMacchinaHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	long lCOD_AZL=Security.getAzienda();
	java.util.Collection col = home.getMacchina_Name_Desc_View(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Macchina_Name_Desc_View   dt = (Macchina_Name_Desc_View )it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_MAC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_MAC)+"'>"+Formatter.format(dt.DES_MAC)+"</option>";
  	}
	return str;
}
//---------------FUNCTIONS FOR TABS-------------------------
String BuildResTab(IAttivaManutenzioneHome home_a, long COD_MAC, long COD_MNT_MAC)
{
  String str="";
	String strTemp="";
	java.util.Collection col_mac = home_a.getAttivaManutenzione_TAB_View(COD_MAC, COD_MNT_MAC);
	str="<table border='0' align='left' width='650' id='MacchinaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='230'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.svolta") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Esito") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.manutenzione") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.pianificazione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='Macchina' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+COD_MNT_MAC+"'>";
	str+="<td class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td></tr>";
		java.util.Iterator it_mac = col_mac.iterator();
 		while(it_mac.hasNext()){
			AttivaManutenzione_TAB_View mac=(AttivaManutenzione_TAB_View)it_mac.next();
    	str+="<tr INDEX='"+COD_MNT_MAC+"' ID='"+mac.COD_SCH_ATI_MNT+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 230px;' class='inputstyle'  value=\""+Formatter.format(mac.ATI_SVO)+"\"></td>";
			strTemp=(mac.ESI_ATI_MNT==null)?"":(mac.ESI_ATI_MNT.equals("P"))?"POSITIVO":"NEGATIVO";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+strTemp+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(mac.DAT_ATI_MNT)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(mac.DAT_PIF_INR)+"\"></td>";
			str+="</tr>";
	}
	str+="</table>";

	return str;
} 
%>
