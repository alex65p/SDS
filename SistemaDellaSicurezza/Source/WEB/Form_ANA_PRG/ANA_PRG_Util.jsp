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
< file>
  < versions>	
    < version number="1.0" date="05/02/2004" author="Podmasteriev Alexandr">		
      < comments>
			   < comment date="05/02/2004" author="Podmasteriev Alexandr">
				   Interfaces dlia objecta SchedaAttivitaSegnalazione
			   < /comment>		
      < /comments> 
    < /version>
  < /versions>
< /file> 
*/
%>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%!
//===============================================================================================================
// ------------ combobox for Capitoli---------------
String BuildSezioneComboBox(IGestioniSezioniHome home, long SELECTED_ID, long lCOD_AZL)
{
	String str="";
	
	java.util.Collection col = home.getGestioniSezioni_Paragrafo_View(lCOD_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		GestioniSezioni_Paragrafo_View obj=(GestioniSezioni_Paragrafo_View)it.next();
		String strSEL="";
		if(SELECTED_ID==obj.COD_ARE) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_ARE)+"'>"+Formatter.format(obj.NOM_ARE)+"</option>";
  	}
	return str;
}

String RebuildCapitoloComboBox(IGestioniSezioniHome home, long lCOD_ARE, long lCOD_AZL, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL);
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		GestioniSezioni_CplAre_View obj=(GestioniSezioni_CplAre_View)it.next();
		String strSEL="";
		if(SELECTED_ID==obj.COD_CPL) strSEL="selected";
	    str=str+"<option "+strSEL+" value='"+Formatter.format(obj.COD_CPL)+"'>"+Formatter.format(obj.strNOM_CPL)+"</option>";
  	}
	return str;
}

GestioniSezioni_CplAre_View BuildCapitolo(IGestioniSezioniHome home, long lCOD_ARE, long lCOD_AZL)
{
	String str="";
	java.util.Collection col = home.getGestioniSezioni_CplAre_View(lCOD_ARE, lCOD_AZL);
	java.util.Iterator it = col.iterator();
	GestioniSezioni_CplAre_View obj=null;
	while(it.hasNext()){
		obj=(GestioniSezioni_CplAre_View)it.next();
  }
	return obj;
}
//----------------------------------------

//---------------FUNCTIONS FOR TABS-------------------------


 String BuildParagrafoDocumentiTab(IParagrafoHome home, long lCOD_PRG)
{
	String str = "";
	java.util.Collection col = home.getParagrafoDocumentiByID_View(lCOD_PRG);
	
	str="<table border='0' align='left' width='650' id='DocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='300'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Titolo.documento")+"</strong></td>";
	str+="<td width='200'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Responsabile")+"</strong></td>";
	str+="<td width='150'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Data.revisione")+"</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='Documenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PRG)+"'>";
	str+="<td class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='RSP_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		ParagrafoDocumentiByID_View obj=(ParagrafoDocumentiByID_View)it.next();
    	str+="<tr INDEX='"+Formatter.format(lCOD_PRG)+"' ID='"+obj.COD_DOC+"'>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 300px;' class='inputstyle'  value=\""+Formatter.format(obj.TIT_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(obj.RSP_DOC)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(obj.DAT_REV_DOC)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildCollegamentoInternetTab(ICollegamentiHome home, long lCOD_PRG)
{
	String str = "";
	java.util.Collection col = home.getCollegamentoInternet_View(lCOD_PRG);
	
	str="<table border='0' align='left' width='650' id='CollegamentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='325'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Indirizzo")+"</strong></td>";
	str+="<td width='325'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Descrizione")+"</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='Collegamenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PRG)+"'>";
	str+="<td class='dataTd'><input type='text' name='IDZ_COL_INT' class='dataInput' readonly  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DES_COL_INT' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		CollegamentoInternet_View obj=(CollegamentoInternet_View)it.next();
    str+="<tr INDEX='"+Formatter.format(lCOD_PRG)+"' ID='"+Formatter.format(obj.COD_COL_INT_PRG)+"'>";
		str+="<td class='dataTd'><input type='text' readonly class='inputstyle' style='width: 325px;'  value=\""+Formatter.format(obj.IDZ_COL_INT)+"\"></td>";
		str+="<td class='dataTd'><input type='text' readonly class='inputstyle' style='width: 325px;'  value=\""+Formatter.format(obj.DES_COL_INT)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}

String BuildGestioneTabellareTab(IGestioneTabellareHome home, long lCOD_PRG)
{
	String str = "";
	java.util.Collection col = home.getGestioneTabellare_View(lCOD_PRG);
	
	str="<table border='0' align='left' width='650' id='TabellareHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr>";
	str+="<td width='650'><strong>&nbsp;"+ApplicationConfigurator.LanguageManager.getString("Titolo")+"</strong></td>";
	str+="</tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='650' id='Tabellare' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_PRG)+"'>";
	str+="<td width='650' class='dataTd'><input type='text' name='TIT_TAB' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		GestioneTabellare_View obj=(GestioneTabellare_View)it.next();
    str+="<tr INDEX='"+Formatter.format(lCOD_PRG)+"' ID='"+Formatter.format(obj.COD_TAB_UTN)+"'>";
		str+="<td class='dataTd'><input type='text' readonly  style='width: 650px;' class='inputstyle' value=\""+Formatter.format(obj.TIT_TAB)+"\"></td>";
		str+="</tr>";
	}
	str+="</table>";
	return str;
}
%>
