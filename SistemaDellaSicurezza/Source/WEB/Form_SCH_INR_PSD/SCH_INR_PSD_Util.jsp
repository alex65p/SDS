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
/*
<file>
  <versions>	
    <version number="1.0" date="25/01/2004" author="Kushkarov Yura">
	      <comments>
				  <comment date="25/01/2004" author="Kushkarov Yura">
				   <description>Shablon formi NAT_LES_Form.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/

String SchedeInterventoPSDTab(ISchedeInterventoPSDHome home, String COD_SCH_INR_PSD)
{
	String str;
	java.util.Collection col_rst = home.getSchedeInterventoPSD_ForTab_View(new Long(COD_SCH_INR_PSD).longValue());
	
	str="<table border='0' id='SchedeInterventoPSDHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td align='center' width='40%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td align='center' width='40%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td align='center' width='20%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' id='SchedeInterventoPSD' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_SCH_INR_PSD)+"\"><td width='' class='dataTd'><input type='text' name='RSP_DOC' class='inputstyle' readonly  value=''></td>";
	str+="<td width='' class='dataTd'><input type='text' name='TIT_DOC' readonly class='inputstyle'  value=''></td><td width='' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='inputstyle'  value=''></td></tr>";
	if ( !COD_SCH_INR_PSD.equals("") ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			SchedeInterventoPSD_ForTab_View rst=(SchedeInterventoPSD_ForTab_View)it_rst.next();
	    str+="<tr INDEX=\""+Formatter.format(COD_SCH_INR_PSD)+"\" ID=\""+rst.COD_DOC+"\">";
			str+="<td class='dataTd' width='40%'><input type='text' class='inputstyle' readonly  value=\""+Formatter.format(rst.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd' width='40%'><input type='text' class='inputstyle' readonly  value=\""+Formatter.format(rst.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd' width='20%'><input type='text' class='inputstyle' readonly  value=\""+Formatter.format(rst.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}// 	
	str+="</table>";
	return str;
}
/* 	IAziendaHome home = home interface of AziendaBean
	long SELECTED_ID = ID (COD_AZL) of current fornitore, if not exists then =0
*/
String BuildACDBox(ISchedeInterventoPSDHome aHome, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = aHome.getSchedeInterventoPSD_SelectData_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
	  SchedeInterventoPSD_SelectData_View  dt = (SchedeInterventoPSD_SelectData_View)it.next();
	  long var1=dt.COD_PSD_ACD;
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==var1){strSEL="selected";} }
		str=str+"<option "+strSEL+" value=\""+var1+"\">"+dt.IDE_PSD_ACD+"&nbsp;&nbsp;&nbsp;&nbsp;"+dt.NOM_CAG_PSD_ACD+"&nbsp;&nbsp;&nbsp;&nbsp;"+dt.NOM_LUO_FSC+"</option>";
  	}
	return str;
}
%>
