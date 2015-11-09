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
    <version number="1.0" date="22/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="22/01/2004" author="Mike Kondratyuk">
				   <description>ANA_SIT_AZL_Util.jsp-functions for ANA_SIT_AZL_Form.jsp</description>
				   <description>Function for tabs</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.Immobili3lv.*" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
/* 	IAnagrLuoghiFisiciHome home = Home intarface of AnagrLuoghiFisici
	String COD_SIT_AZL = COD_SIT_AZL of current Siti Aziendali
*/
String BuildLuoghiFisiciTab(IAnagrLuoghiFisiciHome home, long COD_SIT_AZL)
{
	String str;
	java.util.Collection col_alf = home.getAnagrLuoghiFisici_Sit_Azl_View(new Long(COD_SIT_AZL).longValue());
	str="<table border='0' align='left' width='914 id='LuoghiFisiciHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='457'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nominativo.luogo.fisico") + "</strong></td>";
	str+="<td width='457'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Preposto.luogo.fisico") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='914' id='LuoghiFisici' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_SIT_AZL)+"'><td width='457' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='dataInput' readonly  value=''></td>";
	str+="<td width='457' class='dataTd'><input type='text' name='NOM_RSP_LUO_FSC' readonly class='dataInput'  value=''></td></tr>";
	if (COD_SIT_AZL > 0){
		java.util.Iterator it_alf = col_alf.iterator();
 		while(it_alf.hasNext()){
			AnagrLuoghiFisici_Sit_Azl_View alf=(AnagrLuoghiFisici_Sit_Azl_View)it_alf.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_SIT_AZL)+"' ID='"+alf.COD_LUO_FSC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 457px;' class='inputstyle'  value=\""+Formatter.format(alf.NOM_LUO_FSC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 457px;' class='inputstyle'  value=\""+Formatter.format(alf.NOM_RSP_LUO_FSC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}

String BuildImmobiliTab(IImmobili3lvHome home, long COD_AZL, long COD_SIT_AZL)
{
	String str;
        java.util.Collection col_imm = home.findEx
                (COD_AZL, COD_SIT_AZL, null, null, null, null, null, null, null, 0);
	str="<table border='0' align='left' width='914 id='ImmobiliHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='914'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='914' id='Immobili' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_SIT_AZL)+"'><td width='914' class='dataTd'><input type='text' name='NOM_IMM' class='dataInput' readonly  value=''></td></tr>";
	if (COD_SIT_AZL > 0){
		java.util.Iterator it_imm = col_imm.iterator();
 		while(it_imm.hasNext()){
			Immobili3liv_View imm = (Immobili3liv_View)it_imm.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_SIT_AZL)+"' ID='"+imm.COD_IMM+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 914px;' class='inputstyle'  value=\""+Formatter.format(imm.NOM_IMM)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}
%>
