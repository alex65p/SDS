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
    <version number="1.0" date="05/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="05/02/2004" author="Alex Kyba">
				   <description>ANA_MIS_PET_AZL_Util.jsp-functions for ANA_MIS_PET_Form.jsp</description>
				   <description>Functions for comboboxes and tabs</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
String qqq= new String();
//---------------FUNCTIONS FOR TABS-----------------------

String BuildAnagraficaDocumentiTab(IMisuraPreventiva bean){
	String str;
	java.util.Collection col = bean.getAnagraficaDocumentiView();
	
	str="<table border='0' align='left' width='745' id='AnagraficaDocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='445'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
		str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='745' id='AnagraficaDocumenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET())+"'><td width='445' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AnagraficaDocumentiView view=(AnagraficaDocumentiView)it.next();
			str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_DOC)+"' INDEX='"+Formatter.format(bean.getCOD_MIS_PET())+"'><td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 445px;'  value=\""+Formatter.format(view.strTIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(view.strRSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly style='width: 100px;' class='inputstyle'  value=\""+Formatter.format(view.dtDAT_REV_DOC)+"\"></td></tr>";
	}
	str+="</table>";
	return str;
}

String BuildNormativeSentenzeView(IMisuraPreventiva bean){
	String str;
	java.util.Collection col = bean.getNormativeSentenzeView();
	
	str="<table border='0' align='left' width='745' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='545'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.normativa/sentenza") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='745' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET())+"'><td width='545' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			NormativeSentenzeView view=(NormativeSentenzeView)it.next();
			str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_NOR_SEN)+"' INDEX='"+Formatter.format(bean.getCOD_MIS_PET())+"'><td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 545px;'  value=\""+Formatter.format(view.strTIT_NOR_SEN)+"\"></td>";
			str+="<td width='200' class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(view.dtDAT_NOR_SEN)+"\"></td></tr>";
	}
	str+="</table>";
	return str;
}


//===============================================================================================================
// ------------ combobox for assotiated aziendas ---------------
/* 	IAziendaHome home = home interface of current azienda
	long BesidesID = COD_AZL of current azienda
	long SELECTED_ID = COD_AZL_ASC of current azienda, if it not exists then =0
*/
String BuildTipologiaMisureCombobox(java.util.Collection col, long lCOD_TPL_MIS_PET){	
	String str="";
	String selected="";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
			TipologiaView view =(TipologiaView)it.next();
			if (lCOD_TPL_MIS_PET==view.lCOD_TPL_MIS_PET) selected="selected"; else selected="";
				str+="<option value='"+view.lCOD_TPL_MIS_PET+"' "+selected+" >"+view.strDES_TPL_MIS_PET+ "</option>";	
	}	
	return str;		
}


//----------------------------------------

%>
