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
    <version number="1.0" date="30/01/2004" author="Treskina Maria">
	      <comments>
				  <comment date="30/01/2004" author="Treskina Maria">
				   <description>TPL_DPI_Util.jsp-functions for TPL_DPI_Form.jsp</description>
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
/* 	--- Normative di Riferimento
  ITipologiaDPIHome home = Home intarface of TipologiaDPI
	String COD_TPL_DPI = COD_TPL_DPI of current Tipologia
*/
String BuildNormativeRiferimentoTab(ITipologiaDPIHome home, String COD_TPL_DPI)
{
	String str;
	java.util.Collection col_nr = home.getNormativeSentenzeByTPLID_View(new Long(COD_TPL_DPI).longValue());
	
	str="<table border='0' id='NormativeRiferimentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='70%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='15%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero") + "</strong></td>";
	str+="<td width='15%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='NormativeRiferimento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TPL_DPI)+"'><td width='70%' class='dataTd'><input type='text' name='TIT_NOR_SEN' class='dataInput' readonly  value=''></td>";
  str+="<td width='15%' class='dataTd'><input type='text' name='NUM_DOC_NOR_SEN' readonly class='dataInput'  value=''></td>";
	str+="<td width='15%' class='dataTd'><input type='text' name='DAT_NOR_SEN' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TPL_DPI.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			NormativeSentenzeByTPLID_View nr=(NormativeSentenzeByTPLID_View)it_nr.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_TPL_DPI)+"' ID='"+nr.COD_NOR_SEN+"'>";
			str+="<td class='dataTd' width='70%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.TIT_NOR_SEN)+"\"></td>";
			str+="<td class='dataTd' width='15%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.NUM_DOC_NOR_SEN)+"\"></td>";
			str+="<td class='dataTd' width='15%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.DAT_NOR_SEN)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null	
	str+="</table>";
	return str;
}

/* 	--- Documenti
  ITipologiaDPIHome home = Home intarface of TipologiaDPI
	String COD_TPL_DPI = COD_TPL_DPI of current Tipologia DPI
*/
String BuildDocumentoTab(ITipologiaDPIHome home, String COD_TPL_DPI)
{
	String str;
	java.util.Collection col_nr = home.getDocumentByTPLDPIID_View(new Long(COD_TPL_DPI).longValue());
	
	str="<table border='0' id='DocumentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='50%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='30%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='20%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='Documento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TPL_DPI)+"'><td width='50%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
  str+="<td width='30%' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TPL_DPI.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			DocumentByTPLDPIID_View nr=(DocumentByTPLDPIID_View)it_nr.next();
	    str+="<tr INDEX='"+Formatter.format(COD_TPL_DPI)+"' ID='"+nr.COD_DOC+"'>";
			str+="<td class='dataTd' width='50%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.DAT_REV_DOC)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null	
	str+="</table>";
	return str;
}

/* 	--- Lotti DPI
  ILottiDPIHome home = Home intarface of LottiDPIDPI
	String COD_TPL_DPI = COD_TPL_DPI of current Tipologia DPI
*/
String BuildLottiDPITab(ILottiDPIHome home, String COD_TPL_DPI)
{
	String str;
	java.util.Collection col_nr = home.getLottiDPIByTPLDPIID_View(new Long(COD_TPL_DPI).longValue());
	
	str="<table border='0' id='LottiDPIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='50%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fornitore") + "</strong></td>";
	str+="<td width='30%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo.lotto") + "</strong></td>";
	str+="<td width='20%'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.consegna") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='LottiDPI' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TPL_DPI)+"'><td width='50%' class='dataTd'><input type='text' name='RAG_SOC_FOR_AZL' class='dataInput' readonly  value=''></td>";
  str+="<td width='30%' class='dataTd'><input type='text' name='IDE_LOT_DPI' readonly class='dataInput'  value=''></td>";
	str+="<td width='20%' class='dataTd'><input type='text' name='DAT_CSG_LOT' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TPL_DPI.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			LottiDPIByTPLDPIID_View nr=(LottiDPIByTPLDPIID_View)it_nr.next();
	    str+="<tr INDEX='"+Formatter.format(COD_TPL_DPI)+"' ID='"+nr.COD_LOT_DPI+"'>";
			str+="<td class='dataTd' width='50%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.RAG_SOC_FOR_AZL)+"\"></td>";
			str+="<td class='dataTd' width='30%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.IDE_LOT_DPI)+"\"></td>";
			str+="<td class='dataTd' width='20%'><input type='text' readonly class='dataInput'  value=\""+Formatter.format(nr.DAT_CSG_LOT)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null	
	str+="</table>";
	return str;
}
%>
