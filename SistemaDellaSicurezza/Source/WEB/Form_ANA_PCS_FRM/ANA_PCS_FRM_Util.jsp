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
    <version number="1.0" date="25/01/2004" author="Khomenko Juliya">
	      <comments>
				  <comment date="25/01/2004" author="Khomenko Juliya">
				   <description>ANA_PCS_FRM_Util.jsp-functions for ANA_PCS_FRM_Form.jsp</description>
				   <description>Function for tabs</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//---------------FUNCTIONS FOR TABS-------------------------
/* 	IPercorsiFormativiHome home = Home intarface of PercorsiFormativi
	String COD_PCS_FRM = COD_PCS_FRM of current Siti Aziendali
*/
String PercorsiFormativiCorsiTab(IPercorsiFormativiHome home, String COD_PCS_FRM)
{
	String str;
	java.util.Collection col_are = home.getPercorsiFormativiCorsiByID_View(new Long(COD_PCS_FRM).longValue());
	
	str="<table border='0' align='left' width='652' id='PercorsiFormativiCorsiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='326'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td>";
	str+="<td width='326'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='652' id='PercorsiFormativiCorsi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_PCS_FRM)+"'>";
	str+="<td width='326' class='dataTd'><input type='text' name='NOM_COR' readonly class='dataInput'  value=''></td>";
	str+="<td width='326' class='dataTd'><input type='text' name='DES_COR' readonly class='dataInput'  value=''></td>";
	str+="</tr>";
	if ( !COD_PCS_FRM.equals("") ){
		java.util.Iterator it_are = col_are.iterator();
 		while(it_are.hasNext()){
			PercorsiFormativiCorsiByID_View are=(PercorsiFormativiCorsiByID_View)it_are.next();
	    str+="<tr INDEX='"+Formatter.format(COD_PCS_FRM)+"' ID='"+are.COD_COR+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 326px;' class='inputstyle'  value=\""+Formatter.format(are.NOM_COR)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 326px;' class='inputstyle'  value=\""+Formatter.format(are.DES_COR)+"\"></td>";
			str+="</tr>";
  		}
	}// 	 
	str+="</table>";
	return str;
}
%>
