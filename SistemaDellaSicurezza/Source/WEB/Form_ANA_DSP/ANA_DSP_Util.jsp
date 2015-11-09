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

<%@page import="com.apconsulting.luna.ejb.AnagrDisposizioni.IAnagrDisposizioniHome"%>
<%@page import="com.apconsulting.luna.ejb.RischioFattore.FattoreRischio_View"%>
<%@page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.Rischi_View"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioniHome"%>
<%@page import="com.apconsulting.luna.ejb.AnagrConstatazioni.IAnagrConstatazioni"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %><%!
// ------------ combobox for Classificazione ---------------

String BuildRischiTab(IAnagrDisposizioniHome home, long lCOD_DSP)
{
	String str = "";
	long lCOD_AZL = Security.getAzienda();
	java.util.Collection col = home.getRischi_View(lCOD_DSP, lCOD_AZL);
	
	str="<table border='0' align='left' width='665' id='RischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='400'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>";
   str+="<td width='260'><strong>&nbsp;" + "Fattori di Rischio" + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='665' id='Rischi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_DSP)+"'>";
   str+="<td width='400' class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
      str+="<td width='260' class='dataTd'><input type='text' name='NOM_FAT_RSO' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischi_View obj=(Rischi_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_DSP)+"' ID='"+obj.COD_RSO+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 400px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_RSO)+"\"></td>";
                str+="<td class='dataTd'><input type='text' readonly style='width: 260px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_FAT_RSO)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

%>
