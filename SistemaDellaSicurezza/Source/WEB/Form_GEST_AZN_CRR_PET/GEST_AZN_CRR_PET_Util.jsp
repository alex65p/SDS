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
    <version number="1.0" date="27/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="27/01/2004" author="Mike Kondratyuk">
				   <description>Create util functions for GEST_AZN_CRR_PET_Form.jsp</description>
				 </comment>		
				  <comment date="02/02/2004" author="Alexey Kolesnik">
				   <description> added required functions for documents tab</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%!
/*
	SELECT \"cod_inr_adt\", \"des_inr_adt\"	FROM \"ana_inr_adt_tab\"
*/
//===============================================================================================================
// ------------ combobox for Intervento d' Audut ---------------
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

//---------------FUNCTIONS FOR TABS-------------------------

/* 	--- Documenti
  IAzioniCorrectivePreventiveHome home = Home intarface of AzioniCorrectivePreventive
	String COD_AZN_CRR_PET = COD_AZN_CRR_PET of current AzioniCorrectivePreventive

String BuildDocumentoTab(IAzioniCorrectivePreventiveHome acp_home, String COD_AZN_CRR_PET)
{
	String str;
	java.util.Collection col_nr = acp_home.getDocumentByAZN_CRR_ID_View(new Long(COD_AZN_CRR_PET).longValue());
	
	str="<table border='0' id='DocumentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0' width='100%'>";
	str+="<tr><td  align='center' width='50%'><strong>Titolo Documento</strong></td>";
	str+="<td align='center' width='30%'><strong>Responsabile</strong></td>";
	str+="<td align='center' width='20%'><strong>Data Rivisione</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' id='Documento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(COD_AZN_CRR_PET)+"\">";
	//TIT_DOC RSP_DOC DAT_REV_DOC
	str+="<td width='50%' class='dataTd'><input type='text' name='' class='dataInput' readonly  value=''></td>";
	str+="<td width='30%' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_AZN_CRR_PET.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			DocumentByAZN_CRR_ID_View nr=(DocumentByAZN_CRR_ID_View)it_nr.next();
	    str+="<tr INDEX=\""+Formatter.format(COD_AZN_CRR_PET)+"\" ID=\""+nr.COD_DOC+"\">";
			str+="<td class='dataTd' width='50%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}
	str+="</table>";
	
	return str;
}*/
%>
