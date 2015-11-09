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

<%!
//
String BuildMANComboBox(IAttivitaLavorativeHome home, long SELECTED_ID)
{
	long lCOD_AZL=Security.getAzienda();
	String str="";
	String strSEL="";
	java.util.Collection col = home.getAttivitaLavorative_Name_View(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		AttivitaLavorative_Name_View  man = (AttivitaLavorative_Name_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==man.COD_MAN){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+man.COD_MAN+"'>"+man.NOM_MAN+"</option>";
  	}
	return str;
}
//

String BuildTipologiaContrattiCombobox(java.util.Collection col, long lCOD_TPL_CON){
	String str="";
	String selected="";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
                TipologiaContratti_View view =(TipologiaContratti_View)it.next();
		if (lCOD_TPL_CON==view.lCOD_TPL_CON) selected="selected"; else selected="";
                str+="<option value='"+view.lCOD_TPL_CON+"' "+selected+" >"+view.strNOM_TPL_CON+ "</option>";
	}
	return str;
}
//
%>
