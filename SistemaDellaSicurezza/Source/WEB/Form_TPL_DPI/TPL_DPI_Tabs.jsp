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
    <version number="1.0" date="13/02/2004" author="Treskina Mary">		
      <comments>
			   <comment date="13/02/2004" author="Treskina Mary">
				RischioFattore
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.TipologiaDPI.*" %>
<%@ page import="com.apconsulting.luna.ejb.LottiDPI.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="../_scripts/Alert.js"></script>
<script>
	var err = false;
</script>
<div id="dContent">

<% long lCOD_TPL_DPI=0;
   String s;
	ITipologiaDPI bean=null;
	String strID = (String)request.getParameter("ID_PARENT");
	try{
		ITipologiaDPIHome home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_TPL_DPI=bean.getCOD_TPL_DPI();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}

try{
	if (bean!=null){	
		String strCOD_TPL_DPI = new Long(lCOD_TPL_DPI).toString();
		if(request.getParameter("TAB_NAME").equals("tab1")){
			ITipologiaDPIHome nr_home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
			s=BuildNormativeRiferimentoTab(nr_home, strCOD_TPL_DPI);
			out.println(s);
			
		}else
		if(request.getParameter("TAB_NAME").equals("tab2")){
			ITipologiaDPIHome d_home=(ITipologiaDPIHome)PseudoContext.lookup("TipologiaDPIBean");
			s=BuildDocumentoTab(d_home, strCOD_TPL_DPI);
			out.print(s);
		}else
		if(request.getParameter("TAB_NAME").equals("tab3")){
			ILottiDPIHome l_home=(ILottiDPIHome)PseudoContext.lookup("LottiDPIBean");
			s=BuildLottiDPITab(l_home, strCOD_TPL_DPI);
			out.println(s);
		}
		else{
			return;
		}
	}
}
catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	return;
}
	 %>
</div>	
 <script>
 if (!err){
	  parent.tabbar.ReloadTabTable(document);
 }	
 </script>
 
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
	
	str="<table border='0' align='left' width='858' id='NormativeRiferimentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='580'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Numero") + "</strong></td>";
	str+="<td width='138'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='NormativeRiferimento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TPL_DPI)+"'><td width='580' class='dataTd'><input type='text' name='TIT_NOR_SEN' class='dataInput' readonly  value=''></td>";
  str+="<td width='140' class='dataTd'><input type='text' name='NUM_DOC_NOR_SEN' readonly class='dataInput'  value=''></td>";
	str+="<td width='138' class='dataTd'><input type='text' name='DAT_NOR_SEN' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TPL_DPI.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			NormativeSentenzeByTPLID_View nr=(NormativeSentenzeByTPLID_View)it_nr.next();
	    	str+="<tr INDEX='"+Formatter.format(COD_TPL_DPI)+"' ID='"+nr.COD_NOR_SEN+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 580px;' class='inputstyle'  value=\""+Formatter.format(nr.TIT_NOR_SEN)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(nr.NUM_DOC_NOR_SEN)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 138px;' class='inputstyle'  value=\""+Formatter.format(nr.DAT_NOR_SEN)+"\"></td>";
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
	
	str="<table border='0' align='left' width='858' id='DocumentoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='520'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo") + "</strong></td>";
	str+="<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>";
	str+="<td width='138'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858' id='Documento' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TPL_DPI)+"'><td class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
  str+="<td class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TPL_DPI.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			DocumentByTPLDPIID_View nr=(DocumentByTPLDPIID_View)it_nr.next();
	    str+="<tr INDEX='"+Formatter.format(COD_TPL_DPI)+"' ID='"+nr.COD_DOC+"'>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 520px;' class='inputstyle'  value=\""+Formatter.format(nr.TIT_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 200px;' class='inputstyle'  value=\""+Formatter.format(nr.RSP_DOC)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 138px;' class='inputstyle'  value=\""+Formatter.format(nr.DAT_REV_DOC)+"\"></td>";
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
	
	str="<table border='0' align='left' width='858' id='LottiDPIHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='580'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Fornitore") + "</strong></td>";
	str+="<td width='140'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo.lotto") + "</strong></td>";
	str+="<td width='138'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.consegna") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='858'  id='LottiDPI' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(COD_TPL_DPI)+"'><td class='dataTd'><input type='text' name='RAG_SOC_FOR_AZL' class='dataInput' readonly  value=''></td>";
  str+="<td class='dataTd'><input type='text' name='IDE_LOT_DPI' readonly class='dataInput'  value=''></td>";
	str+="<td class='dataTd'><input type='text' name='DAT_CSG_LOT' readonly class='dataInput'  value=''></td></tr>";
	if ( !COD_TPL_DPI.equals("") ){
		java.util.Iterator it_nr = col_nr.iterator();
 		while(it_nr.hasNext()){
			LottiDPIByTPLDPIID_View nr=(LottiDPIByTPLDPIID_View)it_nr.next();
	    str+="<tr INDEX=\""+Formatter.format(COD_TPL_DPI)+"\" ID=\""+nr.COD_LOT_DPI+"\">";
			str+="<td class='dataTd'><input type='text' readonly style='width: 580px;' class='inputstyle'  value=\""+Formatter.format(nr.RAG_SOC_FOR_AZL)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 140px;' class='inputstyle'  value=\""+Formatter.format(nr.IDE_LOT_DPI)+"\"></td>";
			str+="<td class='dataTd'><input type='text' readonly style='width: 138px;' class='inputstyle'  value=\""+Formatter.format(nr.DAT_CSG_LOT)+"\"></td>";
			str+="</tr>";
  		}
	}// Fornitore = null	
	str+="</table>";
	return str;
}
 %>
