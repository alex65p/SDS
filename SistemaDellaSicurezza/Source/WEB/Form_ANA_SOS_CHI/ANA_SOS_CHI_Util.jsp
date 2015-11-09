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


<%@page import="com.apconsulting.luna.ejb.AssociativaAgentoChimico.IAssociativaAgentoChimicoHome"%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %><%!
// ------------ combobox for Classificazione ---------------
String BuildClassificazioneComboBox(IClassificazioneAgentiChimiciHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getClassificazione_View();
	java.util.Iterator it = col.iterator();
   while(it.hasNext()){
		Classificazione_View dt=(Classificazione_View)it.next();
       strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.lCOD_CLF_SOS){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.lCOD_CLF_SOS)+"'>"+Formatter.format(dt.strDES_CLF_SOS)+"</option>";
  	}
	return str;
}
 
// ------------ combobox for Stato Fisico ---------------
String BuildStatoFisicoComboBox(IStatoFisicoHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getStatoFisico_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		StatoFisico_View dt=(StatoFisico_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.lCOD_STA_FSC){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.lCOD_STA_FSC)+"'>"+Formatter.format(dt.strDES_STA_FSC)+"</option>";
  	}
	return str;
}

// ------------ combobox for Stato Fisico ---------------
/* IStatoFisicoHome home = home interface of StatoFisicoBean
	long SELECTED_ID = ID (COD_STA_FSC) of selected StatoFisico, if not exists then =0
*/
String BuildSimboloComboBox(ISimboloHome home, long SELECTED_ID)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getSimbolo_View();
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Simbolo_View dt=(Simbolo_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.lCOD_SIM){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.lCOD_SIM)+"'>"+Formatter.format(dt.strDES_SIM)+"</option>";
  	}
	return str;
}

//---------------FUNCTIONS FOR TABS-------------------------
/* 	IGestioniSezioniHome home = Home intarface of GestioniSezioni
	long lCOD_SOS_CHI = code of current parent record
*/
String BuildRischiTab(IAssociativaAgentoChimicoHome home, long lCOD_SOS_CHI)
{
	String str = "";
	long lCOD_AZL = Security.getAzienda();
	java.util.Collection col = home.getRischi_View(lCOD_SOS_CHI, lCOD_AZL);
	
	str="<table border='0' align='left' width='858' id='RischiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='560'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio") + "</strong></td>";
   str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Entità.danno") + "</strong></td>";
   str+="<td width='158'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rifacimento.valutazione") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='Rischi' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_SOS_CHI)+"'>";
   str+="<td width='560' class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
   str+="<td width='140' class='dataTd'><input type='text' name='ENT_DAN' class='dataInput' readonly  value=''></td>";
   str+="<td width='158' class='dataTd'><input type='text' name='NB_RFC_VLU_RSO_MES' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Rischi_View obj=(Rischi_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_SOS_CHI)+"' ID='"+obj.COD_RSO+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 560px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_RSO)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(obj.ENT_DAN)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 158px;' class='inputstyle'  value=\""+Formatter.format(obj.NB_RFC_VLU_RSO_MES)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildLuoghiFisiciTab(IAssociativaAgentoChimicoHome home, long lCOD_SOS_CHI)
{
	String str = "";
	long lCOD_AZL = Security.getAzienda();
	java.util.Collection col = home.getLuoghiFisici_View(lCOD_SOS_CHI, lCOD_AZL);
	
	str="<table border='0' align='left' width='858' id='LuoghiFisiciHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='558'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo") + "</strong></td>";
   str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Quantità.in.uso") + "</strong></td>";
   str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Quantità.in.giacenza") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='LuoghiFisici' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_SOS_CHI)+"'>";
   str+="<td width='558' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='dataInput' readonly  value=''></td>";
   str+="<td width='150' class='dataTd'><input type='text' name='QTA_USO' class='dataInput' readonly  value=''></td>";
   str+="<td width='150' class='dataTd'><input type='text' name='QTA_GIA' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		LuoghiFisici_View obj=(LuoghiFisici_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_SOS_CHI)+"' ID='"+obj.COD_LUO_FSC+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 558px;' class='inputstyle'  value=\""+Formatter.format(obj.NOM_LUO_FSC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.QTA_USO)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.QTA_GIA)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildFrasiRTab(IAssociativaAgentoChimicoHome home, long lCOD_SOS_CHI)
{
	String str = "";
	java.util.Collection col = home.getFrasiR_View(lCOD_SOS_CHI);
	
	str="<table border='0' align='left' width='858' id='FrasiRHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='158'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Frase.R") + "</strong></td>";
   str+="<td width='700'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='FrasiR' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_SOS_CHI)+"'>";
   str+="<td width='158' class='dataTd'><input type='text' name='NUM_FRS_R' class='dataInput' readonly  value=''></td>";
   str+="<td width='700' class='dataTd'><input type='text' name='DES_FRS_R' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		FrasiR_View obj=(FrasiR_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_SOS_CHI)+"' ID='"+obj.COD_FRS_R+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 158px;' class='inputstyle'  value=\""+Formatter.format(obj.NUM_FRS_R)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 700px;' class='inputstyle'  value=\""+Formatter.format(obj.DES_FRS_R)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildFrasiSTab(IAssociativaAgentoChimicoHome home, long lCOD_SOS_CHI)
{
	String str = "";
	java.util.Collection col = home.getFrasiS_View(lCOD_SOS_CHI);
	
	str="<table border='0' align='left' width='858' id='FrasiSHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='158'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Frase.S") + "</strong></td>";
   str+="<td width='700'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='FrasiS' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_SOS_CHI)+"'>";
   str+="<td width='158' class='dataTd'><input type='text' name='NUM_FRS_S' class='dataInput' readonly  value=''></td>";
   str+="<td width='700' class='dataTd'><input type='text' name='DES_FRS_S' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		FrasiS_View obj=(FrasiS_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_SOS_CHI)+"' ID='"+obj.COD_FRS_S+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 158px;' class='inputstyle'  value=\""+Formatter.format(obj.NUM_FRS_S)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 700px;' class='inputstyle'  value=\""+Formatter.format(obj.DES_FRS_S)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildDocumentiTab(IAssociativaAgentoChimicoHome home, long lCOD_SOS_CHI)
{
	String str = "";
	java.util.Collection col = home.getDocumenti_View(lCOD_SOS_CHI);
	
	str="<table border='0' align='left' width='858' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='500'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
   str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
   str+="<td width='158'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_SOS_CHI)+"'>";
   str+="<td width='500' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
   str+="<td width='200' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
   str+="<td width='158' class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		Documenti_View obj=(Documenti_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_SOS_CHI)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 500px;' class='inputstyle'  value=\""+Formatter.format(obj.TIT_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(obj.RSP_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 158px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_REV_DOC)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildNormSentTab(IAssociativaAgentoChimicoHome home, long lCOD_SOS_CHI)
{
	String str = "";
	java.util.Collection col = home.getNormSent_View(lCOD_SOS_CHI);
	
	str="<table border='0' align='left' width='858' id='NormSentHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
   str+="<td width='548'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza") + "</strong></td>";
   str+="<td width='160'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("N.Normativa/Sentenza") + "</strong></td>";
   str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td>";
   str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='NormSent' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_SOS_CHI)+"'>";
   str+="<td width='548' class='dataTd'><input type='text' name='TIT_NOR_SEN' class='dataInput' readonly  value=''></td>";
   str+="<td width='160' class='dataTd'><input type='text' name='NUM_DOC_NOR_SEN' class='dataInput' readonly  value=''></td>";
   str+="<td width='150' class='dataTd'><input type='text' name='DAT_NOR_SEN' class='dataInput' readonly  value=''></td>";
   str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		NormSent_View obj=(NormSent_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_SOS_CHI)+"' ID='"+obj.COD_NOR_SEN+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 548px;' class='inputstyle'  value=\""+Formatter.format(obj.TIT_NOR_SEN)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 160px;' class='inputstyle'  value=\""+Formatter.format(obj.NUM_DOC_NOR_SEN)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_NOR_SEN)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

// ------------ combobox for Proprietà Chimico Fisiche ---------------
String BuildProprietaChiFisComboBox(IAssociativaAgentoChimicoHome home, long lCOD_PTA_FSC)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getProprietaChimicoFisiche_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		ProprietaChimicoFisiche_View dt=(ProprietaChimicoFisiche_View) it.next();
		strSEL="";
		if(lCOD_PTA_FSC!=0){ 
			if(lCOD_PTA_FSC==dt.lCOD_PTA_FSC){
				strSEL="selected";
			}
		}
		str+="<option "+strSEL+" value='"+Formatter.format(dt.lCOD_PTA_FSC)+"'>";
		str+=Formatter.format(dt.strDES_PTA_FSC)+"</option>";
	}
	return str;
}

// ------------ combobox for Tipo Rischio Chimico ---------------
String BuildTipoRischioComboBox(IAssociativaAgentoChimicoHome home, String sTIP_RSO)
{
	String str="";
	if(sTIP_RSO == null)
		sTIP_RSO="N";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("N") ? "selected ":"")+"value='N'></option>";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("I") ? "selected ":"")+"value='I'>"+ApplicationConfigurator.LanguageManager.getString("Rischio.per.inalazione")+"</option>";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("C") ? "selected ":"")+"value='C'>"+ApplicationConfigurator.LanguageManager.getString("Rischio.per.contatto")+"</option>";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("E") ? "selected ":"")+"value='E'>"+ApplicationConfigurator.LanguageManager.getString("Entrambi")+"</option>";
	return str;
}
%>
