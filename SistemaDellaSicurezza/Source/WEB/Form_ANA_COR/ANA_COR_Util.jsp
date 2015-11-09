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
//---------------FUNCTIONS FOR TABS-------------------------
/* 
*/

/*===============Moved to Tabs File======================================================================

String BuildTestVerificaTab(ICorsiHome home, long lCOD_COR)
{
	String str = "";
	java.util.Collection col = home.getTestVerifica_View(lCOD_COR);
	
	str="<table border='0' id='TestVerificaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td  align='center' width='50%'><strong>Nome Test</strong></td>";
	str+="<td  align='center' width='20%'><strong>Punteggio Minimo</strong></td>";
	str+="<td  align='center' width='20%'><strong>Punteggio Massimo</strong></td>";
	str+="<td  align='center' width='10%'><strong>N. Domande</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='1' id='TestVerifica' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_COR)+"'>";
	str+="<td width='50%' class='dataTd'><input type='text' name='NOM_TES_VRF' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='NUM_MIN_PTG' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='NUM_MAX_PTG' class='dataInput' readonly  value=''></td>";
	str+="<td width='10%' class='dataTd'><input type='text' name='TOT_DMD' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		TestVerifica_View obj=(TestVerifica_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_COR)+"' ID='"+obj.COD_TES_VRF+"'>";
		str+="<td class='dataTd' width='50%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NOM_TES_VRF)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NUM_MIN_PTG)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NUM_MAX_PTG)+"\"></td>";
		str+="<td class='dataTd' width='10%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.TOT_DMD)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildMaterialeCorsoTab(ICorsiHome home, long lCOD_COR)
{
	String str = "";
	java.util.Collection col = home.getMaterialeCorso_View(lCOD_COR);
	
	str="<table border='0' id='MaterialeCorsoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td  align='center' width='30%'><strong>Titolo Documento</strong></td>";
	str+="<td  align='center' width='20%'><strong>Data Di Emissione</strong></td>";
	str+="<td  align='center' width='30%'><strong>Responsabile Documento</strong></td>";
	str+="<td  align='center' width='20%'><strong>File</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='1' id='MaterialeCorso' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_COR)+"'>";
	str+="<td width='30%' class='dataTd'><input type='text' name='NOM_TES_VRF' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='30%' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='NOME_FILE' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		MaterialeCorso_View obj=(MaterialeCorso_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_COR)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.TIT_DOC)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_REV_DOC)+"\"></td>";
		str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.RSP_DOC)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NOME_FILE)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildDocentiCorsoTab(IDocentiCorsoHome home, long lCOD_COR)
{
	String str = "";
	java.util.Collection col = home.getDocentiCorso_View(lCOD_COR);
	
	str="<table border='0' id='DocentiCorsoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td  align='center' width='60%'><strong>Docenti</strong></td>";
	str+="<td  align='center' width='20%'><strong>Fin</strong></td>";
	str+="<td  align='center' width='20%'><strong>Inizio</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='1' id='DocentiCorso' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_COR)+"'>";
	str+="<td width='60%' class='dataTd'><input type='text' name='NOM_DCT' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='DAT_FIE' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='DAT_INZ' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		DocentiCorso_View obj=(DocentiCorso_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_COR)+"' ID='"+obj.COD_DCT_COR+"'>";
		str+="<td class='dataTd' width='60%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NOM_DCT)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_FIE)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_INZ)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}
========================================================================================*/

//===============================================================================================================
// ------------ combobox for Tipologia Corso---------------
String BuildTplCorsiComboBox(ITipologiaCorsiHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getTipologiaCorsi_Name_Address_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		TipologiaCorsi_Name_Address_View obj=(TipologiaCorsi_Name_Address_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_TPL_COR)) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_TPL_COR)+"'>"+Formatter.format(obj.NOM_TPL_COR)+"</option>";
  	}
	return str;
}
//----------------------------------------
%>
