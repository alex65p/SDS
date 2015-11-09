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
    <version number="1.0" date="30/01/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="30/01/2004" author="Alexey Kolesnik">
				   <description>ANA_SGZ_Util.jsp-functions for ANA_ATI_SGZ_Form.jsp</description>
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
String BuildAttivitaSegnalazioneTab_NOT_USED(IRapportiniSegnalazioneHome home, String COD_SGZ) {
	String str;
//	java.util.Collection col_rst = home.getRapportiniSegnalazioneRisposteByDMDID_View(new Long(COD_SGZ).longValue());
	
	str="<table border='0' id='RapportiniSegnalazioneHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='80%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione.attività") + "</strong></td>";
	str+="<td width='20%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.scadenza") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='RapportiniSegnalazione' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_SGZ)+"'>";
	str+="<td width='80%' class='dataTd'><input type='text' name='COD_SGZ' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='DAT_SCA' class='dataInput' readonly  value=''></td></tr>";
/*	if ( !COD_SGZ.equals("") ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			RapportiniSegnalazioneRisposteByDMDID_View rst=(RapportiniSegnalazioneRisposteByDMDID_View)it_rst.next();
	    str+="<tr INDEX='"+Formatter.format(COD_SGZ)+"' ID='"+rst.COD_RST+"'>";
			str+="<td class='dataTd' width='80%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(rst.NOM_RST)+"\"></td>";
			str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(rst.RST_ESI)+"\"></td>";
			str+="</tr>";
  		}
	}*/
	str+="</table>";
	return str;
}
%>
