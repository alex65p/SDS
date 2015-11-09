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
    <version number="1.0" date="27/02/2004" author="Roman Chumachenko">
	      <comments>
			<comment date="27/02/2004" author="Roman Chumachenko">
				<description>MIS_PET_MAN_Util.jsp</description>
			</comment>
			
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
String BuildAuditTab(IAssMisuraAttivita bean)
{
	String str="";
	java.util.Collection col = bean.getAudit_View();
	str+="<table border='0' id='AuditHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='735'><tr>";
	str+="<td width='735'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Intervento.di.audit") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='1' id='Audit' class='dataTable' cellpadding='0' cellspacing='0' width=''>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_MAN())+"'>";
	str+="<td width='735' class='dataTd'><input type='text' name='DES_INR_ADT' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssMP_Audit_View rc=(AssMP_Audit_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_MIS_PET_MAN())+"' ID='"+rc.COD_INR_ADT+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width=735' class='inputstyle'  value='"+Formatter.format(rc.DES_INR_ADT)+"'></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//----------------------------------------------------------------------------------------------


/* 	IAssMisuraAttivita bean = exsempliar of AssMisuraAttivitaBean
*/
String BuildDocumentiTab(IAssMisuraAttivita bean)
{
	String str="";
	java.util.Collection col = bean.getDocumenti_View();
	str+="<table border='0' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='735'><tr>";
	str+="<td width='400'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='235'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
	
	str+="</tr></table>";
	str+="<table border='0' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"'>";
	str+="<td width='400' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='235' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssMP_Documenti_View rc=(AssMP_Documenti_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"' ID='"+rc.COD_DOC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width=400' class='inputstyle'  value='"+Formatter.format(rc.TIT_DOC)+"' ></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width=235' class='inputstyle'  value='"+Formatter.format(rc.RSP_DOC)+"' ></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width=100' class='inputstyle'  value='"+Formatter.format(rc.DAT_REV_DOC)+"' ></td>";
			str+="</tr>";
		}
	}// bean = null 
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
/*  IAssMisuraAttivita bean = exsempliar of AssMisuraAttivitaBean
*/
String BuildNormativeSentenzeTab(IAssMisuraAttivita bean)
{
	String str="";
	java.util.Collection col = bean.getNormativeSentenze_View();
	str+="<table border='0' id='NormativeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='735'><tr>";
	str+="<td width='635'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.normativa") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' id='Normative' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"'>";
	str+="<td width='635' class='dataTd'><input type='text' name='TIT_NOR_SEN' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='DAT_NOR_SEN' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssMP_NormativeSentenze_View rc=(AssMP_NormativeSentenze_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"' ID='"+rc.COD_NOR_SEN+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width=635' class='inputstyle'  value='"+Formatter.format(rc.TIT_NOR_SEN)+"' ></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width=100' class='inputstyle'  value='"+Formatter.format(rc.DAT_NOR_SEN)+"' ></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
/*  IAssMisuraAttivita bean = exsempliar of AssMisuraAttivitaBean
*/
String BuildAttivitaSegnalazioneTab(IAssMisuraAttivita bean)
{
	String str="";
	java.util.Collection col = bean.getAttivitaSegnalazione_View();
	str+="<table border='0' id='AttSegnHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='735'><tr>";
	str+="<td width='635'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Attività.segnalazione") + "</strong></td>";
	str+="<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.attività") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' id='AttSegn' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"'>";
	str+="<td width='635' class='dataTd'><input type='text' name='DES_ATI_SGZ' class='dataInput' readonly  value=''></td>";
	str+="<td width='100' class='dataTd'><input type='text' name='DAT_CSA' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			AssMP_AttivitaSegnalazione_View rc=(AssMP_AttivitaSegnalazione_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_RSO_MAN())+"' ID='"+rc.COD_ATI_SGZ+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width=635' class='inputstyle'  value='"+Formatter.format(rc.DES_ATI_SGZ)+"' ></td>";
			str+="<td class='dataTd'    ><input type='text' readonly style='width=100' class='inputstyle'  value='"+Formatter.format(rc.DAT_SCA)+"' ></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------------------------
//=======================================================================
// ------------ combobox for Adotatta ---------------
/* 	ITipologiaMisurePreventiveHome home = home interface of TipologiaMisurePreventiveBean
	long SELECTED_ID = ID (COD_TPL_MIS_PET) of current item, if not exists then =0
*/
String BuildAdotattaComboBox(ITipologiaMisurePreventiveHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getTipologia_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		TipologiaView dt=(TipologiaView)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.lCOD_TPL_MIS_PET){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.lCOD_TPL_MIS_PET)+"'>"+Formatter.format(dt.strDES_TPL_MIS_PET)+"</option>";
  	}
	return str;
}
//-----------------------------------------------------------------------------------------------
%>
