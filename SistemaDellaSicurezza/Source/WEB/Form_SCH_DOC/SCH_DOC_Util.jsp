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
String BuildAziendeComboBox(IAziendaHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getAzienda_Name_ByID_View(Security.getAziende());
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Azienda_Name_ByID_View obj=(Azienda_Name_ByID_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_AZL)) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_AZL)+"'>"+Formatter.format(obj.RAG_SCL_AZL)+"</option>";
  	}
	return str;
}

String BuildTPLComboBox(ITipologiaDocumentiHome tpl_home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = tpl_home.getComboView();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		TipologiaDocumenti_ComboView  tpl = (TipologiaDocumenti_ComboView)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==tpl.lCOD_TPL_DOC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+tpl.strNOM_TPL_DOC+"'>"+tpl.strNOM_TPL_DOC+"</option>";
  	}
	return str;
} 

String BuildCAGComboBox(ICategoriaDocumentoHome cag_home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = cag_home.getComboView();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		CategoriaDocumento_ComboView  cag = (CategoriaDocumento_ComboView)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==cag.lCOD_CAT_DOC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+cag.strNOM_CAT_DOC+"'>"+cag.strNOM_CAT_DOC+"</option>";
  	}
	return str;
}
 
%>
