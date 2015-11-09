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
    <version number="1.0" date="20/02/2004" author="Alexey Kolesnik">		
      <comments>
			   <comment date="20/02/2004" author="Alexey Kolesnik">
				Assosiazione Luogo Fisico/Rischio Tabs
			   </comment>
			   <comment date="29/03/2004" author="Roman Chumachenko">
				   <description>New recording of PRS_MIS_PET</description>
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
&nbsp;
<%
 	long   lCOD_RSO_LUO_FSC = 0;			 //UID Assosiacione Luoghi Fisici
 	long   lCOD_LUO_FSC = 0;					 //UID Luoghi Fisici
	long   lCOD_AZL = Security.getAzienda();

	ILuogoFisicoRischio bean = null;

	String strID = (String)request.getParameter("ID_PARENT");
	String strCOD_LUO_FSC = (String)request.getParameter("COD_LUO_FSC");
	try{
		ILuogoFisicoRischioHome home=(ILuogoFisicoRischioHome)PseudoContext.lookup("LuogoFisicoRischioBean");
		bean = home.findByPrimaryKey(new Long(strID));
		lCOD_RSO_LUO_FSC=bean.getCOD_RSO_LUO_FSC();
		out.print(lCOD_RSO_LUO_FSC);
	}

	catch(Exception ex){
		//out.print(ex);
		out.print(printErrAlert("divErr", "Error.showNotFound", ex));
		return;
	}



try{
	if (bean!=null){	
		
		if(request.getParameter("TAB_NAME").equals("tab1")){
			out.println(BuildMisureTab(bean.getLuogiFisicoMisureView(), lCOD_RSO_LUO_FSC));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab2")){
			out.println(BuildDocumentiTab(bean.getLuogiFisicoDocumentiView(), lCOD_RSO_LUO_FSC));
		}
		
		else if(request.getParameter("TAB_NAME").equals("tab3")){
			out.println(BuildNormativeTab(bean.getLuogiFisicoNormativeView(), lCOD_RSO_LUO_FSC));
		}
		else{
			return;
		}
	}
}

catch(Exception ex){
	out.print(printErrAlert("divErr", "Error.alert", ex));
	//out.print(ex);
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
String BuildMisureTab(java.util.Collection col, long lCOD_RSO_LUO_FSC)
{
	StringBuffer str = new StringBuffer();
	String strFlag = "";
	String strRead = "";
	str.append("<table border='0' id='BuildMisureTab' align='left' width='811' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='511'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Misura.di.prevenzione") + "</strong>");
			str.append("<input type='hidden' name='COD_MIS_RSO_LUO' value=''></td>");
			str.append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Versione") + "</strong></td>");
			str.append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.inizio") + "</strong></td>");
			str.append("<td width='100'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data.fine") + "</strong></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='811' id='BuildMisureTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO_LUO_FSC)+"'>");
				str.append("<td class='dataTd' width='511'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='100'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='100'><input type='text' readonly class='dataInput'></td>");
				str.append("<td class='dataTd' width='100'><input type='text' readonly class='dataInput'></td>");
		str.append("</tr>");
		
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogiFisicoMisure_View v=(LuogiFisicoMisure_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_RSO_LUO_FSC)+"' ID='"+Formatter.format(v.lCOD_MIS_RSO_LUO)+"'>");
					str.append("<td class='dataTd' ><input type='hidden' name='COD_MIS_RSO_LUO' value=\""+Formatter.format(v.lCOD_MIS_RSO_LUO)+"\">");
					str.append("<input type='text' readonly style='width: 511px;'  class='inputstyle'  value=\""+Formatter.format(v.strNOM_MIS_PET)+"\"></td>");
					str.append("<td class='dataTd' ><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\""+Formatter.format(v.lVER_MIS_PET)+"\"></td>");
					str.append("<td class='dataTd' ><input type='text' readonly style='width: 100px;' class='inputstyle'  value=\""+Formatter.format(v.dtDAT_INZ)+"\"></td>");
					str.append("<td class='dataTd' ><input type='text' readonly style='width: 100px;' name=\"inpDatFine\"  class='inputstyle'  value=\""+Formatter.format(v.dtDAT_FIE)+"\" id='DAT_FIE_"+Formatter.format(v.lCOD_MIS_RSO_LUO)+"'></td>");
					//----- new checkboxes ---------
					if(Formatter.format(v.strPRS_MIS_PET).equals("S")) 
						{strFlag = " checked ";}else{strFlag = " disabled ";}
					if(v.dtDAT_FIE==null)
						strFlag = strFlag+" onclick='setDAT_FIE(this)' ";
					str.append("<td align='center' class='dataTd' width='5%'><input name='CHK_PRS_MIS_PET'  id='CHK_PRS_MIS_PET_"+v.lCOD_MIS_RSO_LUO+"' type='checkbox'  value='"+v.lCOD_MIS_RSO_LUO+"' class='dataInput'  "+strFlag+"><input name='CHK_PRS_MIS_HID' type='checkbox'  value='"+v.lCOD_MIS_RSO_LUO+"' style='display:none'  id='CHK_PRS_MIS_HID_"+v.lCOD_MIS_RSO_LUO+"'></td>");
					
					//------------------------------
					/*if (Formatter.format(v.strPRS_MIS_PET)!=null && Formatter.format(v.strPRS_MIS_PET).equals("S")){ 
					strFlag = "checked"; 
					strRead = "onClick=\"javascript:chBoxClick('"+Formatter.format(v.lCOD_MIS_RSO_LUO)+"');\" "; 
					}else{ 
					strFlag = " disabled "; 
					strRead = "onClick=\"javascript:return false;\" "; } 
					str.append("<td class='dataTd' width='4%'><input type='checkbox' name=\"chDatFine\" value=\""+Formatter.format(v.lCOD_MIS_RSO_LUO)+"\" "+strRead+" class='dataInput' "+strFlag+"></td>");
					*/
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}
//---
String BuildDocumentiTab(java.util.Collection col, long lCOD_RSO_LUO_FSC)
{
	StringBuffer str = new StringBuffer();				
	str.append("<table border='0' align='left' width='811' id='BuildDocumentiTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='811'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong>");
			str.append("<input type='hidden' name='COD_DOC' value=''></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='811' id='BuildDocumentiTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO_LUO_FSC)+"'>");
				str.append("<td class='dataTd'><input type='text' readonly class='dataInput'></td>");
		str.append("</tr>");
		
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogiFisicoDocumenti_View v=(LuogiFisicoDocumenti_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_RSO_LUO_FSC)+"' ID='"+v.lCOD_DOC+"'>");
					str.append("<td class='dataTd' width='100%'><input type='hidden' name='COD_DOC' value='"+Formatter.format(v.lCOD_DOC)+"'>");
					str.append("<input type='text' readonly style='width: 811px;' class='inputstyle'  value='"+Formatter.format(v.strTIT_DOC)+"'></td>");
				str.append("</tr>");
			}
		str.append("</table>");
	return str.toString();
}

String BuildNormativeTab(java.util.Collection col, long lCOD_RSO_LUO_FSC)
{
	StringBuffer str = new StringBuffer();				
	str.append("<table border='0' align='left' width='811' id='BuildNormativeTab' class='dataTableHeader' cellpadding='0' cellspacing='0'>");
		str.append("<tr>");
			str.append("<td width='811'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Titolo.documento") + "</strong>");
			str.append("<input type='hidden' name='COD_NOR_SEN' value=''></td>");
		str.append("</tr>");	
	str.append("</table>");
	str.append("<table border='0' align='left' width='811' id='BuildNormativeTab1' class='dataTable' cellpadding='0' cellspacing='0'>");
		str.append("<tr style='display:none' ID='' INDEX='"+Formatter.format(lCOD_RSO_LUO_FSC)+"'>");
				str.append("<td class='dataTd'  width='100%'><input type='text' readonly class='dataInput'></td>");
		str.append("</tr>");
		

			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuogiFisicoNormative_View v=(LuogiFisicoNormative_View)it.next();
		    	str.append("<tr INDEX='"+Formatter.format(lCOD_RSO_LUO_FSC)+"' ID='"+v.lCOD_NOR_SEN+"'>");
					str.append("<td class='dataTd'><input type='hidden' name='COD_NOR_SEN' value='"+Formatter.format(v.lCOD_NOR_SEN)+"'>");
					str.append("<input type='text' readonly style='width: 811px;'  class='inputstyle'  value='"+Formatter.format(v.strTIT_NOR_SEN)+"'></td>");
				str.append("</tr>");
			}

		str.append("</table>");
	return str.toString();
}

%>
