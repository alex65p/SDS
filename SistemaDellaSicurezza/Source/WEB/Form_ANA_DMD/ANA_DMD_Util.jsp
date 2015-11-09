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
    <version number="1.0" date="23/01/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="23/01/2004" author="Alexey Kolesnik">
				   <description>ANA_DMD_Util.jsp-functions for ANA_DMD_Form.jsp</description>
				 </comment>		
				  <comment date="26/02/2004" author="Alexey Kolesnik">
				   <description> DomandeRisposteTab Commented </description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
//---------------FUNCTIONS FOR TABS-------------------------
/* 	IDomandeHome home = Home intarface of Domande
	String COD_DMD = COD_DMD of current Domande
*/
/*
String DomandeRisposteTab(IDomandeHome home, String COD_DMD)
{
	String str;
	java.util.Collection col_rst = home.getDomandeRisposteByDMDID_View(new Long(COD_DMD).longValue());
	
	str="<table border='0' id='DomandeRisposteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td  align='center' width='90%'><strong>&nbsp;</strong></td>";
	str+="<td align='center' width='10%'><strong>Esito Ris.</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='DomandeRisposte' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_DMD)+"'><td width='90%' class='dataTd'><input type='text' name='COD_RST' class='dataInput' readonly  value=''></td>";
	str+="<td width='10%' class='dataTd'><input type='text' name='RST_ESI' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_DMD.equals("") ){
		java.util.Iterator it_rst = col_rst.iterator();
 		while(it_rst.hasNext()){
			DomandeRisposteByDMDID_View rst=(DomandeRisposteByDMDID_View)it_rst.next();
	    str+="<tr INDEX='"+Formatter.format(COD_DMD)+"' ID='"+rst.COD_RST+"'>";
			str+="<td class='dataTd' width='90%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(rst.NOM_RST)+"\"></td>";
			str+="<td class='dataTd' width='10%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(rst.RST_ESI)+"\"></td>";
			str+="</tr>";
  		}
	}// 	
	str+="</table>";
	return str;
}
*/
%>
