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
    <version number="1.0" date="25/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="25/01/2004" author="Mike Kondratyuk">
				   <description>SCH_ATI_MNT_Util.jsp-functions for SCH_ATI_MNT_Tabs.jsp</description>
				   <description>Functions for comboboxes and tab</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
//===================== combobox ===================
//====================================================
// ------------ combobox for fornitore ---------------
String BuildShedeDocumenteTab(ISchedaAttivitaSegnalazioneHome home_a, long COD_SCH_ATI_MNT)
{
  String str="";
	java.util.Collection col_mac = home_a.getDocuments__View( COD_SCH_ATI_MNT);
	str="<table border='0' align='left' width='603' id='MacchinaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='250'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='103'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='603' id='Macchina' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+COD_SCH_ATI_MNT+"'>";
	str+="<td width='250' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td width='250' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td width='103' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td></tr>";
		java.util.Iterator it_mac = col_mac.iterator();
 		while(it_mac.hasNext()){
			Documents__View mac=(Documents__View)it_mac.next();
    	str+="<tr INDEX='"+COD_SCH_ATI_MNT+"' ID='"+mac.COD_DOC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='dataInput'  value=\""+Formatter.format(mac.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 250px;' class='dataInput'  value=\""+Formatter.format(mac.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 103px;' class='dataInput'  value=\""+Formatter.format(mac.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
	}
	str+="</table>";/**/

	return str;
} 
%>
