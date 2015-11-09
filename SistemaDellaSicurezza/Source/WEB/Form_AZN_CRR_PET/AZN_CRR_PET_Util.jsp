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
    <version number="1.0" date="02/02/2004" author="Alexey Kolesnik">
	      <comments>
				  <comment date="02/02/2004" author="Alexey Kolesnik">
				   <description> added required functions </description>
				 </comment>
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%!
//===============================================================================================================
// ------------ combobox for Intervento d' Audit ---------------
String BuildInterventoAudutComboBox(IInterventoAudutHome home, long SELECTED_ID)
{
	String str="";
	java.util.Collection col = home.getInterventoAudut_Combo_View();
	java.util.Iterator it = col.iterator();
	while(it.hasNext()){
		InterventoAudut_Combo_View obj = (InterventoAudut_Combo_View)it.next();
		String strSEL="";
		if(SELECTED_ID == obj.COD_INR_ADT) strSEL="selected";
	    str=str+"<option "+strSEL+" value=\""+Formatter.format(obj.COD_INR_ADT)+"\">"+Formatter.format(obj.DES_INR_ADT)+"</option>";
  	}
	return str;
}
//----------------------------------------
String GetRichiesta(String strTPL_ATT)
{
	if (strTPL_ATT.equals("U")) return "Attivata con urgenza";
	if (strTPL_ATT.equals("R")) return "Rimandata";
	if (strTPL_ATT.equals("E")) return "Respinta";
	if (strTPL_ATT.equals("N")) return "Non attivata";
	return "";
}
// ------------  ---------------
String GetAzione(String strTPL_AZN)
{
	if (strTPL_AZN.equals("C")) return "Concluca efficacemente";
	if (strTPL_AZN.equals("R")) return "Non risolta";
	if (strTPL_AZN.equals("S")) return "Sospesa";
	if (strTPL_AZN.equals("N")) return "Nessura";
	return "";
}
//---------------FUNCTIONS FOR TABS-------------------------
/* 	--- Documenti
  IAzioniCorrectivePreventiveHome home = Home intarface of AzioniCorrectivePreventive
	String COD_AZN_CRR_PET = COD_AZN_CRR_PET of current AzioniCorrectivePreventive
*/
String BuildDocumentoTab(IAzioniCorrectivePreventiveHome acp_home, String COD_AZN_CRR_PET)
{
	String str;
	java.util.Collection col_nr = acp_home.getDocumentByAZN_CRR_ID_View(new Long(COD_AZN_CRR_PET).longValue());
	
	str="<table border='0' align='left' width='855' id='DocumentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='505'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='855' id='Documento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_AZN_CRR_PET)+"\">";
	str+="<td class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
  str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_AZN_CRR_PET.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			DocumentByAZN_CRR_ID_View nr=(DocumentByAZN_CRR_ID_View)it_nr.next();
	    str+="<tr INDEX=\""+Formatter.format(COD_AZN_CRR_PET)+"\" ID=\""+nr.COD_DOC+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 505px;' class='inputstyle'  value=\""+Formatter.format(nr.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(nr.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 150px;' class='inputstyle'  value=\""+Formatter.format(nr.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	return str;
}
//-----------------------------------------------------------------------
%>
