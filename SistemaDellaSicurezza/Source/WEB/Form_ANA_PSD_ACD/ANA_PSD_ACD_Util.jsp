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


/* String BuildPresidiDocumentiTab(IPresidiHome home, long lCOD_PSD_ACD)
{
	String str = "";
	java.util.Collection col = home.getPresidiDocumentiByID_View(lCOD_PSD_ACD);
	
	str="<table border='0' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td  align='center' width='60%'><strong>Titolo Documento</strong></td>";
	str+="<td  align='center' width='20%'><strong>Responsabile</strong></td>";
	str+="<td  align='center' width='20%'><strong>Data Revizione</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='1' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PSD_ACD)+"'>";
	str+="<td width='60%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		PresidiDocumentiByID_View obj=(PresidiDocumentiByID_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_PSD_ACD)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd' width='60%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.TIT_DOC)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.RSP_DOC)+"\"></td>";
		str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_REV_DOC)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}


String BuildSchedeInterventoPSDTab(ISchedeInterventoPSDHome home, long lCOD_PSD_ACD)
{
	String str = "";
	java.util.Collection col = home.getSchedeInterventoPSD_ForPresidi_View(lCOD_PSD_ACD);
	
	str="<table border='0' id='SchedeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td  align='center' width='65%'><strong>Nome Responsabile Intervento</strong></td>";
	str+="<td  align='center' width='10%'><strong>Data Planificaz.</strong></td>";
	str+="<td  align='center' width='10%'><strong>Data Intervento</strong></td>";
	str+="<td  align='center' width='15%'><strong>Esito Intervento</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='1' id='Schede' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PSD_ACD)+"'>";
	str+="<td width='65%' class='dataTd'><input type='text' name='NOM_RSP_INR' class='dataInput' readonly  value=''></td>";
	str+="<td width='10%' class='dataTd'><input type='text' name='DAT_PIF_INR' class='dataInput' readonly  value=''></td>";
	str+="<td width='10%' class='dataTd'><input type='text' name='DAT_INR' class='dataInput' readonly  value=''></td>";
	str+="<td width='15%' class='dataTd'><input type='text' name='ESI_INR' class='dataInput' readonly  value=''></td>";	
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		SchedeInterventoPSD_ForPresidi_View obj=(SchedeInterventoPSD_ForPresidi_View)it.next();
    str+="<tr INDEX='"+Formatter.format(lCOD_PSD_ACD)+"' ID='"+Formatter.format(obj.COD_SCH_INR_PSD)+"'>";
		str+="<td class='dataTd' width='65%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.NOM_RSP_INR)+"\"></td>";
		str+="<td class='dataTd' width='10%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_PIF_INR)+"\"></td>";
		str+="<td class='dataTd' width='10%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.DAT_INR)+"\"></td>";
		str+="<td class='dataTd' width='15%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(obj.ESI_INR)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}*/


//===============================================================================================================
// ------------ combobox for CategoriePreside ---------------
String BuildCategoriePresideComboBox(ICategoriePresideHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getCategoriePreside_Categoria_RagSoc_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		CategoriePreside_Categoria_RagSoc_View obj=(CategoriePreside_Categoria_RagSoc_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_CAG_PSD_ACD)) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_CAG_PSD_ACD)+"'>"+Formatter.format(obj.NOM_CAG_PSD_ACD)+"</option>";
  	}
	return str;
}
//----------------------------------------

// ------------ combobox for AnagrLuoghiFisici ---------------
String BuildAnagrLuoghiFisiciComboBox(IAnagrLuoghiFisiciHome luohome, long SELECTED_ID, long AZL_ID)
{
	String str="";
	java.util.Collection col = luohome.getAnagrLuoghiFisici_List_View(AZL_ID);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		AnagrLuoghiFisici_List_View obj=(AnagrLuoghiFisici_List_View)it.next();
		String strSEL="";
		if((SELECTED_ID!=0) && (SELECTED_ID==obj.COD_LUO_FSC)) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_LUO_FSC)+"'>"+Formatter.format(obj.NOM_LUO_FSC)+"</option>";
  	}
	return str;
}
//----------------------------------------
%>
