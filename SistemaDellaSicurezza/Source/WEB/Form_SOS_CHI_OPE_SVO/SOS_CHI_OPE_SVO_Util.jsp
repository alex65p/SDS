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
//---------------FUNCTIONS FOR TABS--------------------------------------------
/* 	IAssociativaAgentoChimico bean = exsempliar of AssociativaAgentoChimicoBean
*/
String BuildRischiAgenteTab(IAssociativaAgentoChimico bean, long lCOD_AZL)
{
	String str="";
	java.util.Collection col = bean.getRischiAgente_View(lCOD_AZL);
	str+="<table border='0' align='left' width='660' id='RischiAgenteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='260' valign='bottom'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Rischio")+"</strong></td>";
	str+="<td width='200' valign='bottom'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Entità.danno")+"</strong></td>";
	str+="<td width='200'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Rifacimento.valutazione")+"</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='660' id='RischiAgente' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(bean.getCOD_SOS_CHI())+"\">";
	str+="<td width='260' class='dataTd'><input type='text' name='NOM_RSO' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='ENT_DAN' class='dataInput' readonly  value=''></td>";
	str+="<td width='200' class='dataTd'><input type='text' name='VLU_RSO' class='dataInput' readonly  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			RischiAgente_View rc=(RischiAgente_View)it.next();
	    	str+="<tr INDEX=\""+Formatter.format(bean.getCOD_SOS_CHI())+"\" ID=\""+rc.COD_RSO+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 260px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_RSO)+"\" ></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(rc.ENT_DAN)+"\" ></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(rc.RFC_VLU_RSO_MES)+"\" ></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------------

//---------------FUNCTIONS FOR COMBOBOXES--------------------------------------

// ------------ combobox for Classificazione ---------------
/* 	IClassificazioneAgentiChimiciHome home = home interface of ClassificazioneAgentiChimiciBean
	long SELECTED_ID = ID (COD_STA_FSC) of selected ClassificazioneAgentiChimici, if not exists then =0
*/
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
		str=str+"<option "+strSEL+" value=\""+Formatter.format(dt.lCOD_CLF_SOS)+"\">"+Formatter.format(dt.strDES_CLF_SOS)+"</option>";
  	}
	return str;
}
// ------------ combobox for Stato Fisico ---------------
/* 	IStatoFisicoHome home = home interface of StatoFisicoBean
	long SELECTED_ID = ID (COD_STA_FSC) of selected StatoFisico, if not exists then =0
*/
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
		str=str+"<option "+strSEL+" value=\""+Formatter.format(dt.lCOD_STA_FSC)+"\">"+Formatter.format(dt.strDES_STA_FSC)+"</option>";
  	}
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
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.lCOD_PTA_FSC)+"'>"+Formatter.format(dt.strDES_PTA_FSC)+"</option>";
	}
	return str;
}
// ------------ combobox for Tipo Rischio Chimico ---------------
String BuildTipoRischioComboBox(IAssociativaAgentoChimicoHome home, String sTIP_RSO)
{
	String str="";
	if(sTIP_RSO==null)
		sTIP_RSO="N";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("N") ? "selected ":"")+"value='N'></option>";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("I") ? "selected ":"")+"value='I'>"+
                ApplicationConfigurator.LanguageManager.getString("Rischio.per.inalazione")+
                "</option>";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("C") ? "selected ":"")+"value='C'>"+
                ApplicationConfigurator.LanguageManager.getString("Rischio.per.contatto")+
                "</option>";
	str+="<option "+(sTIP_RSO.equalsIgnoreCase("E") ? "selected ":"")+"value='E'>"+
                ApplicationConfigurator.LanguageManager.getString("Entrambi")+
                "</option>";
	return str;
}
%>
