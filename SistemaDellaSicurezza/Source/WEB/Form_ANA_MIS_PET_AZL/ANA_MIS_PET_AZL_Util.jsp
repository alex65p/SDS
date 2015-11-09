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
<%
/*
<file>
  <versions>	
    <version number="1.0" date="04/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="04/02/2004" author="AlexKyba">
				   <description>ANA_MIS_PET_AZL_Util.jsp-functions for ANA_MIS_PET_AZL_Form.jsp</description>
				   <description>Functions for comboboxes and tabs</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
String qqq= new String();
//---------------FUNCTIONS FOR TABS-------------------------
String BuildEmptyAnagraficaDocumentiTab(){
	String str;
	str="<table border='0' id='AnagraficaDocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='60%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Titolo.documento")+
                "</strong></td>";
	str+="<td width='25%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Responsabile")+
                "</strong></td>";
		str+="<td width='15%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Data.revisione")+
                "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='AnagraficaDocumenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:' ID='' INDEX=''><td width='60%' class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly  value=''></td>";
	str+="<td width='25%' class='dataTd'><input type='text' name='RSP_DOC' class='inputstyle'  value=''></td>";
	str+="<td width='15%' class='dataTd'><input type='text' name='DAT_REV_DOC' class='inputstyle'  value=''></td></tr>";
	str+="</table>";
	return str;
}

String BuildAnagraficaDocumentiTab(IMisurePreventProtettiveAz bean){
	String str;
	java.util.Collection col = bean.getAnagraficaDocumentiView();
	
	str="<table border='0' align='left' width='790' id='AnagraficaDocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='450'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Titolo.documento")+
                "</strong></td>";
	str+="<td width='200'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Responsabile")+
                "</strong></td>";
		str+="<td width='140'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Data.revisione")+
                "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='790' id='AnagraficaDocumenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td width='450' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td width='140' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			MPAZ_AnagraficaDocumentiView view=(MPAZ_AnagraficaDocumentiView)it.next();
			str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_DOC)+"' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td class='dataTd'><input name='TIT_DOC' class='inputstyle' readonly style='width: 450px;' value=\""+Formatter.format(view.strTIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(view.strRSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(view.dtDAT_REV_DOC)+"\"></td></tr>";
	}
	str+="</table>";
	return str;
}
String BuildEmptyNormativeSentenzeView(){
	String str;
		str="<table border='0' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
		str+="<tr><td width='50%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza")+
                "</strong></td>";
		str+="<td width='50%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Data.normativa/sentenza")+
                "</strong></td></tr>";
		str+="</table>";
		str+="<table border='1' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
		str+="<tr style='display:' ID='' INDEX=''><td width='30%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
		str+="<td width='30%' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
		str+="</table>";
	return str;
}
String BuildNormativeSentenzeView(IMisurePreventProtettiveAz bean){
	String str;
	java.util.Collection col = bean.getNormativeSentenzeView();
	
	str="<table border='0' align='left' width='790' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='590'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza")+
                "</strong></td>";
	str+="<td width='200'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Data.normativa/sentenza")+
                "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='790' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td width='590' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			MPAZ_NormativeSentenzeView view=(MPAZ_NormativeSentenzeView)it.next();
			str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_NOR_SEN)+"' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td class='dataTd'><input type='text' name='TIT_DOC' class='inputstyle' readonly style='width: 590px;'  value=\""+Formatter.format(view.strTIT_NOR_SEN)+"\"></td>";
			str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(view.dtDAT_NOR_SEN)+"\"></td></tr>";
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
String BuildAttivitaLavorativaComboBox(IAttivitaLavorativeHome home, long SELECTED_ID){
	String str="";
	long lCOD_AZL=Security.getAzienda();
	java.util.Collection col = home.getAttivitaLavorative_Name_View(lCOD_AZL);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		AttivitaLavorative_Name_View dt=(AttivitaLavorative_Name_View)it.next();
		String strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_MAN){strSEL="selected";} }
	    str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_MAN)+"'>"+Formatter.format(dt.NOM_MAN)+"</option>";
  	}
	return str;
}



String BuildLuoghiFisiciComboBox(IAnagrLuoghiFisiciHome home, long SELECTED_ID){
	String str="";
	java.util.Collection col = home.getAllAnagrLuoghiFisici_List_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		AnagrLuoghiFisici_List_View dt=(AnagrLuoghiFisici_List_View)it.next();
		String strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_LUO_FSC){strSEL="selected";} }
	    str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_LUO_FSC)+"'>"+Formatter.format(dt.NOM_LUO_FSC)+"</option>";
  	}
	return str;
}

String BuildRischiByAttivtaLavorativa(java.util.Collection col, long lCOD_RSO_MAN){
	String str="";
	String selected="";
			java.util.Iterator it = col.iterator();
			while(it.hasNext()){
				RischiByAttivataLavorativaView view=(RischiByAttivataLavorativaView)it.next();
				if (lCOD_RSO_MAN==view.lCOD_RSO_MAN) selected="selected"; else selected="";
				str+="<option value='"+view.lCOD_RSO_MAN+"' "+selected+" cod_rso='"+view.lCOD_RSO+"'>"+view.strNOM_RSO+ "</option>";	
			}	
	return str;
}

String BuildRischiByLuoghiFisici(java.util.Collection col, long lCOD_RSO_LUO_FSC){
	String str="";		
	String selected="";	
			java.util.Iterator it = col.iterator();
			while(it.hasNext()){
				RischiByLuoghiFisiciView view=(RischiByLuoghiFisiciView)it.next();
				if (lCOD_RSO_LUO_FSC==view.lCOD_RSO_LUO_FSC) selected="selected"; else selected="";		
				str+="<option value='"+view.lCOD_RSO_LUO_FSC+"' "+selected+" cod_rso='"+view.lCOD_RSO+"'>"+view.strNOM_RSO+ "</option>";
			}	
	return str;
}
//----------------------------------------

%>
