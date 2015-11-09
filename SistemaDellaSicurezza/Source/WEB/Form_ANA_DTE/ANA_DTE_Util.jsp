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
    <version number="1.0" date="28/01/2004" author="Roman Chumachenko">
	      <comments>
				  <comment date="28/01/2004" author="Roman Chumachenko">
				   <description>ANA_DTE_Util.jsp-functions for ANA_DTE_Form.jsp</description>
				   <description>Functions for comboboxes</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>

<%!
//---------------FUNCTIONS FOR TABS-------------------------
/* 	IDittaEsterna bean = exsempliar of DittaEsternaBean
*/
String BuildDocAssociatiTab(IDittaEsterna bean)
{
	String str="", strTIT_DOC;
	java.util.Collection col = bean.getDocumentiAssociatiView();
	str+="<table border='1' align='left' width='816' id='DocAssociatiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='298'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='298'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='110'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Documento") + "</strong></td>";
	str+="<td width='110'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='816' id='DocAssociati' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_DTE())+"'>";
	str+="<td width='298' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='298' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td width='110' class='dataTd'><input type='text' name='DOC_CSG_RCR' readonly class='dataInput'  value=''></td>";
	str+="<td width='110' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput '  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			DittaEsterna_DocAssociati_View rc=(DittaEsterna_DocAssociati_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_DTE())+"' ID='"+rc.COD_DOC+"'>";
			strTIT_DOC=Formatter.format(rc.TIT_DOC);
			str+="<td class='dataTd'><input type='text' readonly style='width: 298px;'  class='inputstyle'  value=\""+strTIT_DOC+"\" ></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 298px;' class='inputstyle'  value=\""+Formatter.format(rc.RSP_DOC)+"\"></td>";
			String type="CONSEGNATO";
			if(Formatter.format(rc.DOC_CSG_RCR).equals("R")){type="RICEVUTO";}
			str+="<td class='dataTd'><input type='text' readonly style='width: 110px;' class='inputstyle'  value=\""+type+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 110px;' class='inputstyle'  value=\""+Formatter.format(rc.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}

//----------------------------------------
/* 	IDittaEsterna bean = exsempliar of DittaEsternaBean
*/
String BuildLuoghiFisiciTab(IDittaEsterna bean)
{
	String str;
	java.util.Collection col = bean.getLuoghiFisiciView();
	
	str="<table border='0' align='left' width='816' id='LuoghiFisiciHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='408'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Luogo.fisico") + "</strong></td>";
	str+="<td width='408'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='816' id='LuoghiFisici' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_DTE())+"'><td width='408' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='dataInput' readonly  value=''></td>";
	str+="<td width='408' class='dataTd'><input type='text' name='DES_LUO_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			DittaEsterna_LuoghiFisici_View rc=(DittaEsterna_LuoghiFisici_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_DTE())+"' ID='"+rc.COD_LUO_FSC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 408px;' class='inputstyle'  value=\""+Formatter.format(rc.NOM_LUO_FSC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 408px;' class='inputstyle'  value=\""+Formatter.format(rc.DES_LUO_FSC)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}

//----------------------------------------
//----------------------------------------
/* 	IDittaEsterna bean = exsempliar of DittaEsternaBean
*/
String BuildDTETelefoniTab(IDittaEsterna bean)
{
String str;
	java.util.Collection col = bean.getDTETelefoniView();
	
	str="<table border='0' align='left' width='816' id='DTETelefoniHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'><tr>";
	str+="<td width='408'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologia") + "</strong></td>";
	str+="<td width='408'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero") + "</strong></td>";
	str+="</tr></table>";
	str+="<table border='0' align='left' width='816' id='DTETelefoni' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_DTE())+"'><td width='408' class='dataTd'><input type='text' name='TPL_NUM_TEL' class='dataInput' readonly  value=''></td>";
	str+="<td width='408' class='dataTd'><input type='text' name='NUM_TEL' readonly class='dataInput'  value=''></td></tr>";
	if ( bean!=null ){
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			DittaEsterna_DTETelefoni_View rc=(DittaEsterna_DTETelefoni_View)it.next();
	    	str+="<tr INDEX='"+Formatter.format(bean.getCOD_DTE())+"' ID='"+rc.COD_NUM_TEL_DTE+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 408px;' class='inputstyle'  value=\""+Formatter.format(rc.TPL_NUM_TEL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 408px;' class='inputstyle'  value=\""+Formatter.format(rc.NUM_TEL)+"\"></td>";
			str+="</tr>";
  		}
	}// bean = null	
	str+="</table>";
	return str;
}
//=======================================================================


//=======================================================================
// ------------ combobox for nazionalita ---------------
/* 	INazionalitaHome home = home interface of NazionalitaBean
	long SELECTED_ID = ID (COD_STA) of current azienda, if not exists then =0
*/
String BuildNazionalitaComboBox(INazionalitaHome home, long SELECTED_ID, long COD_LNG)
{
	String str="";
	String strSEL="";
	java.util.Collection col = home.getNazionalita_Names_View(COD_LNG);
	java.util.Iterator it = col.iterator();
 	while(it.hasNext()){
		Nazionalita_Names_View dt=(Nazionalita_Names_View)it.next();
		strSEL="";
		if(SELECTED_ID!=0){ if(SELECTED_ID==dt.COD_STA){strSEL="selected";} }
		str=str+"<option "+strSEL+" value='"+Formatter.format(dt.COD_STA)+"'>"+Formatter.format(dt.NOM_STA)+"</option>";
  	}
	return str;
}
//=========================================================================
%>
