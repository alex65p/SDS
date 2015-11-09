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

<%!
//---------------FUNCTIONS FOR TABS-------------------------
/* 	IGestioniSezioniHome home = Home intarface of GestioniSezioni
	String COD_SIT_AZL = COD_SIT_AZL of current Siti Aziendali
*/
String BuildGestioniSezioniTab(IGestioniSezioniHome home, long lCOD_ARE, long lCOD_AZL)
{
	String str;
	java.util.Collection col = home.getGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL);
	
	str="<table border='0' align='left' width='663' id='GestioniSezioniHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='663'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='663' id='GestioniSezioni' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(lCOD_ARE)+"\"><td width='100%' class='dataTd'><input type='text' name='DES_CPL_ARE' class='dataInput' readonly  value=''></td></tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		GestioniSezioni_CplAre_View obj=(GestioniSezioni_CplAre_View)it.next();
    	str+="<tr INDEX=\""+Formatter.format(lCOD_ARE)+"\" ID='"+obj.COD_CPL+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 663px;' class='inputstyle'  value=\""+Formatter.format(obj.strNOM_CPL)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}
%>
