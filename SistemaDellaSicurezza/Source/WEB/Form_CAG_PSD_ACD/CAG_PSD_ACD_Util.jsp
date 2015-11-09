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
<%

/*
<file>
  <versions>	
    <version number="1.0" date="26/01/2004" author="Podmasteriev Alexandr">
	      <comments>
				  <comment date="26/01/2004" author="Podmasteriev Alexandr">
				   <description>CAG_PSD_ACD_Util.jsp-functions for CAG_PSD_ACD_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
//String BuildResTab(ICategoriePresideHome home, String COD_FOR_AZL, String FOR_COD_CAG_PSD_ACD)
String BuildResTab(ICategoriePresideHome home,long COD_FOR_AZL,String FOR_COD_CAG_PSD_ACD)
{
  String str="";
	java.util.Collection col_mac = home.getResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View(COD_FOR_AZL, new Long(FOR_COD_CAG_PSD_ACD).longValue());
	str="<table border='0' align='left' width='692' id='MacchinaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='271'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Cognome") + "</strong></td>";
	str+="<td width='271'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Matricola") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='692' id='Macchina' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+FOR_COD_CAG_PSD_ACD+"\">";
	str+="<td class='dataTd'><input type='text' name='IDE_MAC' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='IDE_MAC1' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DES_MAC' readonly class='dataInput'  value=''></td></tr>";
	if ( !FOR_COD_CAG_PSD_ACD.equals("") ){
		java.util.Iterator it_mac = col_mac.iterator();
 		while(it_mac.hasNext()){
			ResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View mac=(ResronsabilitiByFORAZLID__FOR_COD_CAG_PSD_ACD_View)it_mac.next();
    	str+="<tr INDEX=\""+FOR_COD_CAG_PSD_ACD+"\" ID=\""+mac.COD_DPD+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 271px;' class='inputstyle'  value=\""+Formatter.format(mac.COG_DPD)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 271px;' class='inputstyle'  value=\""+Formatter.format(mac.NOM_DPD)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(mac.MTR_DPD)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
} 
%>
