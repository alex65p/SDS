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
    <version number="1.0" date="16/02/2004" author="Alexey Kolesnik">		
      <comments>
			   <comment date="16/02/2004" author="Alexey Kolesnik">
				Anagrafica Luoghi Fisici Tabs
			   </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); 		//HTTP 1.0
response.setDateHeader ("Expires", 0); 			//prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Macchina.*" %>
<%@ page import="com.apconsulting.luna.ejb.AnagrLuoghiFisici.*" %>
<%@ page import="com.apconsulting.luna.ejb.LuogoFisicoRischio.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>

<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<script>
	var err = false;
</script>
<script src="../_scripts/Alert.js"></script>
<div id="dContent">
<%
 	long   lCOD_LUO_FSC = 0;					 //UID Luoghi Fisici
	long   lCOD_AZL = Security.getAzienda();

  IAnagrLuoghiFisici bean = null;
  ILuogoFisicoRischio ris_bean = null;
  ILuogoFisicoRischioHome ris_home=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");
  IMacchinaHome mac_home=(IMacchinaHome)PseudoContext.lookup("MacchinaBean");

	String strID = (String)request.getParameter("ID_PARENT");
	try{
		IAnagrLuoghiFisiciHome home=(IAnagrLuoghiFisiciHome)PseudoContext.lookup("AnagrLuoghiFisiciBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_LUO_FSC=bean.getCOD_LUO_FSC();
	}
	catch(Exception ex){
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
                ex.printStackTrace();
                return;
	}

try{
	if (bean!=null){	
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildRischiTab(ris_home, Formatter.format(lCOD_AZL), Formatter.format(lCOD_LUO_FSC)));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab2")){
			out.println(BuildInfortuniIncidentiTab(bean.getInfortuniIncidentiView(), lCOD_LUO_FSC));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab3")){
			out.println(BuildDpiTab(bean.getDpiView(), lCOD_LUO_FSC));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab4")){
			out.println(BuildCorsiTab(bean.getCorsiView(), lCOD_LUO_FSC));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab5")){
			out.println(BuildDocumentiTab(bean.getDocumentiView(), lCOD_LUO_FSC));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab6")){
			out.println(BuildMacchineAttrezatureTab(mac_home, Formatter.format(lCOD_LUO_FSC)));
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
String BuildRischiTab(ILuogoFisicoRischioHome home, String lCOD_AZL, String lCOD_LUO_FSC)
{
	java.util.Collection col = home.getLuogoFisicoRischio_Tab_View(new Long(lCOD_AZL).longValue(), new Long(lCOD_LUO_FSC).longValue());

	StringBuffer str = new StringBuffer();					
	str.append("<table border='0' align='left' width='802' id='RischiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='800'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Rischio.trasmissibile") + "</strong>");
			str.append("<input type='hidden' name='COD_LUO_FSC' value=''></td>");
		str.append("</tr>");	
	str.append("</table>");
	
	str.append("<table border='0' align='left' width='802' id='RischiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_LUO_FSC)+"'>");
				str.append("<td class='dataTd' width='802'><input type='text' readonly class='inputstyle'></td>");
		str.append("</tr>");	
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogoFisicoRischio_Tab_View v=(LuogoFisicoRischio_Tab_View)it.next();
		    str.append("<tr INDEX='"+Formatter.format(lCOD_LUO_FSC)+"' ID='"+v.COD_RSO_LUO_FSC+"'>");
					str.append("<td class='dataTd'><input type='text' readonly style='width: 802px;' class='inputstyle' value=\""+Formatter.format(v.NOM_RSO)+"\"></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}

String BuildInfortuniIncidentiTab(java.util.Collection col, long lCOD_LUO_FSC)
{
	StringBuffer str = new StringBuffer();				
	str.append("<table border='0' align='left' width='802' id='InfortuniIncidentiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='268'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Lavoratore") + "</strong>");
			str.append("<input type='hidden' name='lCOD_LUO_FSC' value=''></td>");
			str.append("<td width='267'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Natura.lesione") + "</strong></td>");
			str.append("<td width='267'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipo.accertamento") + "</strong></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='802' id='InfortuniIncidentiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_LUO_FSC)+"'>");
				str.append("<td class='dataTd' width='268'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='267'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='267'><input type='text' readonly class='dataInput'></td>");
		str.append("</tr>");
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogiInfortuniIncidenti_View v=(LuogiInfortuniIncidenti_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_LUO_FSC)+"' ID='"+v.lCOD_LUO_FSC+"'>");
					str.append("<td class='dataTd'><input type='hidden' name='COD_LUO_FSC' value=\""+Formatter.format(v.lCOD_LUO_FSC)+"\">");
					str.append("<input type='text' readonly style='width: 268px;' class='dataInput'  value=\""+Formatter.format(v.strNOM_DPD)+" "+Formatter.format(v.strCOG_DPD)+"\"></td>");
					str.append("<td class='dataTd'><input type='text' readonly style='width: 267px;' class='inputstyle'  value=\""+Formatter.format(v.strNOM_NAT_LES)+"\"></td>");
					str.append("<td class='dataTd'><input type='text' readonly style='width: 267px;' class='inputstyle'  value=\""+Formatter.format(v.strNOM_TPL_FRM_INO)+"\"></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}

String BuildDpiTab(java.util.Collection col, long lCOD_LUO_FSC)
{
	StringBuffer str = new StringBuffer();				
	str.append("<table border='0' align='left' width='802' id='BuildDpiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='802'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Tipologie.D.P.I.") + "</strong>");
			str.append("<input type='hidden' name='COD_TPL_DPI' value=''></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='802' id='BuildDpiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX=\""+Formatter.format(lCOD_LUO_FSC)+"\">");
				str.append("<td class='dataTd' width='802'><input type='text' readonly class='inputstyle'></td>");
		str.append("</tr>");
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				RischioDpi_View v=(RischioDpi_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_LUO_FSC)+"' ID='"+v.lCOD_TPL_DPI+"'>");
					str.append("<td class='dataTd'><input type='hidden' style='width: 802px;' name='COD_TPL_DPI' value='"+Formatter.format(v.lCOD_TPL_DPI)+"'>");
					str.append("<input type='text' readonly class='dataInput'  value=\""+Formatter.format(v.strNOM_TPL_DPI)+"\"></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}

String BuildCorsiTab(java.util.Collection col, long lCOD_LUO_FSC)
{
	StringBuffer str = new StringBuffer();				
	str.append("<table border='0' align='left' width='802' id='BuildCorsiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='802'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.del.corso") + "</strong>");
			str.append("<input type='hidden' name='COD_COR' value=''></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='802' id='BuildCorsiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_LUO_FSC)+"'>");
				str.append("<td class='dataTd' width='802'><input type='text' readonly class='inputstyle'></td>");
		str.append("</tr>");
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogiCorsi_View v=(LuogiCorsi_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_LUO_FSC)+"' ID='"+v.lCOD_COR+"'>");
					str.append("<td class='dataTd'><input type='hidden' name='COD_COR' value=\""+Formatter.format(v.lCOD_COR)+"\">");
					str.append("<input type='text' readonly style='width: 802px;' class='inputstyle'  value=\""+Formatter.format(v.strNOM_COR)+"\"></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}

String BuildDocumentiTab(java.util.Collection col, long lCOD_LUO_FSC)
{
	StringBuffer str = new StringBuffer();				
	str.append("<table border='0' align='left' width='802' id='BuildDocumentiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='325'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong>");
			str.append("<input type='hidden' name='COD_DOC' value=''></td>");
			str.append("<td width='325'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Responsabile") + "</strong></td>");
			str.append("<td width='152'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.revisione") + "</strong></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='802' id='BuildDocumentiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_LUO_FSC)+"'>");
				str.append("<td class='dataTd' width='325'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='325'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='152'><input type='text' readonly class='dataInput'></td>");
		str.append("</tr>");
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogiDocumenti_View v=(LuogiDocumenti_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_LUO_FSC)+"' ID='"+v.lCOD_DOC+"'>");
					str.append("<td class='dataTd'><input type='hidden' name='COD_DOC' value=\""+Formatter.format(v.lCOD_DOC)+"\">");
					str.append("<input type='text' readonly style='width: 325px;' class='inputstyle'  value=\""+Formatter.format(v.strTIT_DOC)+"\"></td>");
					str.append("<td class='dataTd'><input type='text' readonly style='width: 325px;' class='inputstyle'  value=\""+Formatter.format(v.strRSP_DOC)+"\"></td>");
					str.append("<td class='dataTd'><input type='text' readonly style='width: 152px;' class='inputstyle'  value=\""+Formatter.format(v.dtDAT_REV_DOC)+"\"></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}

String BuildMacchineAttrezatureTab(IMacchinaHome home, String lCOD_LUO_FSC)
{
	java.util.Collection col = home.getMacchineAttrezzature_View(lCOD_LUO_FSC);
	StringBuffer str = new StringBuffer();				
	str.append("<table border=\"0\" align='left' width='802' id=\"MacchineAttrezzatureTab\" class=\"dataTableHeader\" cellpadding=\"0\" cellspacing=\"0\">");
		str.append("<tr>");
			str.append("<td width=\"202\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Identificativo") + "</strong>");
			str.append("<input type=\"hidden\" name=\"COD_MAC\" value=\"\"></td>");
			str.append("<td width=\"600\"><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border=\"0\" align='left' width='802' id=\"MacchineAttrezzatureTab1\" class=\"dataTable\" cellpadding=\"0\" cellspacing=\"0\" style=\"border:1\">");
		str.append("<tr style=\"display:none\" ID=\"\" INDEX=\""+Formatter.format(lCOD_LUO_FSC)+"\">");
				str.append("<td class=\"dataTd\" width=\"202\"><input type=\"text\" size=\"1\" readonly class='inputstyle'></td>");
				str.append("<td class=\"dataTd\" width=\"600\"><input type=\"text\" size=\"1\" readonly class='inputstyle'></td>");
		str.append("</tr>");
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				MacchineAttrezzature_View v=(MacchineAttrezzature_View)it.next();
		    	str.append("<tr INDEX=\""+Formatter.format(lCOD_LUO_FSC)+"\" ID=\""+v.COD_MAC+"\">");
					str.append("<td class=\"dataTd\"><input type=\"hidden\" name=\"COD_MAC\" value=\""+Formatter.format(v.COD_MAC)+"\">");
					str.append("<input type=\"text\" readonly style='width: 202px;' class='inputstyle' value=\""+Formatter.format(v.IDE_MAC)+"\"></td>");
					str.append("<td class=\"dataTd\"><input type=\"text\" readonly  style='width: 600px;' class='inputstyle'  value=\""+Formatter.format(v.DES_MAC)+"\"></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}
%>
