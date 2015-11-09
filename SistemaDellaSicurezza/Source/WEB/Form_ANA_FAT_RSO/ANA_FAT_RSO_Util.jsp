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
    <version number="1.0" date="23/01/2004" author="Pogrebnoy Yura">
	      <comments>
				  <comment date="23/01/2004" author="Pogrebnoy Yura">
				   <description>ANA_COU_Util.jsp-functions for ANA_COU_Form.jsp</description>
				   <description>Functions for comboboxes</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
/*/---------------FUNCTION FOR TAB-------------------------
String BuildCollegamentoInternetTab(ICollegamentoInternetHome home, String strCOD_FAT_RSO){
	String str="";
	java.util.Collection col_int = home.getCollegamentoInternet_View(strCOD_FAT_RSO);
	str="<table border='0' id='CollegamentoInternetHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td align='center' width='100%'><strong>Indirizzo Coll. Internet</strong></td></tr>";
	str+="<table border='2' id='CollegamentoInternet' class='dataTable' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='' style='display:none'>";
	str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=''></td></tr>";
	if ( !strCOD_FAT_RSO.equals("") ){
		java.util.Iterator it_int = col_int.iterator();
 		while(it_int.hasNext()){
			CollegamentoInternet_View ci=(CollegamentoInternet_View)it_int.next();
			str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='"+Formatter.format(ci.COD_COL_INT)+"'>";
			str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=\""+ci.IDZ_COL_INT+"\"></td>";
			str+="</tr>";
  	}
	}
	str+="</table>";
	return str;
}//-------end of BuildCollegamentoInternetTab func

String BuildIndirizzoPostaElettronicaTab(IIndirizzoPostaElettronicaHome home, String strCOD_FAT_RSO){
	String str="";
	java.util.Collection col_ipe = home.getIndirizzoPostaElettronica_View(strCOD_FAT_RSO);
	str="<table border='0' id='IndirizzoPostaElettronicaHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td align='center' width='100%'><strong>Indirizzo Posta Elettronica</strong></td></tr>";
	str+="<table border='2' id='IndirizzoPostaElettronica' class='dataTable' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='' style='display:none'>";
	str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=''></td></tr>";
	if ( !strCOD_FAT_RSO.equals("") ){
		java.util.Iterator it_ipe = col_ipe.iterator();
 		while(it_ipe.hasNext()){
			IndirizzoPostaElettronica_View ipe=(IndirizzoPostaElettronica_View)it_ipe.next();
			str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='"+Formatter.format(ipe.COD_IDZ_PSA_ELT)+"'>";
			str+="<td class='dataTd' width='100%'><input type='text' readonly class='dataInput'  value=\""+ipe.IDZ_PSA_ELT+"\"></td>";
			str+="</tr>";
  	}
	}
	str+="</table>";
	return str;
}
String BuildAnagraficaDocumenteTab(IAnagrDocumentoHome home, String strCOD_FAT_RSO){
	String str="";
	java.util.Collection col_andoc = home.getAnagraficaDocumente_View(strCOD_FAT_RSO);
	str="<table border='0' id='AnagraficaDocumenteHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='500'>";
	str+="<tr><td align='center' width='30%'><strong>Responsabile Documento</strong></td>";
	str+="<td align='center'  width='30%'><strong>Data Revisione</strong></td>";
	str+="<td align='center' width='40%'><strong>Titolo Documento</strong></td></tr>";
	str+="<table border='2' id='AnagraficaDocumente' class='dataTable' cellpadding='0' cellspacing='0' width='500'>";
	str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='' style='display:none'>";
	str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput' style='display:none' value=''></td>";
	str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput' style='display:none' value=''></td>";
	str+="<td class='dataTd' width='40%'><input type='text' readonly class='dataInput' style='display:none' value=''></td>";
	str+="</tr>";
	if ( !strCOD_FAT_RSO.equals("") ){
		java.util.Iterator it_andoc = col_andoc.iterator();
 		while(it_andoc.hasNext()){
			Documente_View andoc_view=(Documente_View)it_andoc.next();
			str+="<tr INDEX='"+strCOD_FAT_RSO+"' id='"+Formatter.format(andoc_view.COD_DOC)+"'>";
			str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(andoc_view.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(andoc_view.DAT_REV_DOC)+"\"></td>";
			str+="<td class='dataTd' width='40%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(andoc_view.TIT_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}*/

//===============================================================================================================
// ------------ combobox for consulente stato ---------------
String BuildCategorioRischioComboBox(Collection crcol, String strCOD_CAG_FAT_RSO)
{
	String str="";
  Iterator it = crcol.iterator();
 	while(it.hasNext()){
  	String selstr="";
	  CategorioRischio_Name_Address_View  view = (CategorioRischio_Name_Address_View)it.next();
		if(strCOD_CAG_FAT_RSO.equals(Formatter.format(view.COD_CAG_FAT_RSO)))selstr="selected";
    str=str+"<option "+selstr+" value='"+Formatter.format(view.COD_CAG_FAT_RSO)+"'>"+Formatter.format(view.NOM_CAG_FAT_RSO)+"</option>";
 	}
	return str;
}
//----------------------------------------
%>
