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

<% /*
<file>
  <versions>	
    <version number="1.0" date="09/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="09/02/2004" author="Alex Kyba">
					   <description>Kod dlia refresha tabov</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/ %>
<%@ page import="com.apconsulting.luna.ejb.MisurePreventProtettiveAz.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>

<%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>
<%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script>
	err = false;
</script>
<div id="dContent">
<%
String nameTab=new String();
String err= new String();
String str = new String();
boolean isError = false;
java.util.Collection  col;
java.util.Iterator it;

IMisurePreventProtettiveAz bean=null;
IMisurePreventProtettiveAzHome home=(IMisurePreventProtettiveAzHome)PseudoContext.lookup("MisurePreventProtettiveAzBean");

if (request.getParameter("ID_PARENT")!=null){
	Long ID = new Long(request.getParameter("ID_PARENT"));
	out.println(ID);
	try{
		bean=home.findByPrimaryKey(ID);
	}
	catch(Exception ex){
		err= "Cannot find record with ID="+ID.toString();
		err+="\\n"+ex.getMessage();
		out.print("<script>alert(\""+err+"\");</script>");
		return;
	}
}
	
if  (request.getParameter("TAB_NAME")!=null){
	nameTab = request.getParameter("TAB_NAME");
}
else{
	err = "Parameter TAB_NAME not defined";
	out.print("<script>err = true</script>");
}
try{
	if (!isError && nameTab.equals("tab1")){
		str=BuildAnagraficaDocumentiTab(bean);
		out.print(str);
	}
	if (!isError && nameTab.equals("tab2")){
		str=BuildNormativeSentenzeView(bean);
		out.print(str);
	}
}	
catch(Exception ex){
		err= "Impossible rebuild tab content";
		err+="\\n"+ex.getMessage();
		out.print("<script>alert(\""+err+"\");</script>");
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
String qqq= new String();
//---------------FUNCTIONS FOR TABS-------------------------

String BuildAnagraficaDocumentiTab(IMisurePreventProtettiveAz bean){
	String str;
	java.util.Collection col = bean.getAnagraficaDocumentiView();
	
	str="<table border='0' align='left' width='900' id='AnagraficaDocumentiHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='30%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Titolo.documento")+
                "</strong></td>";
	str+="<td width='30%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Responsabile")+
                "</strong></td>";
		str+="<td width='30%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Data.revisione")+
                "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='AnagraficaDocumenti' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td width='30%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='30%' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=''></td>";
	str+="<td width='30%' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			MPAZ_AnagraficaDocumentiView view=(MPAZ_AnagraficaDocumentiView)it.next();
			str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_DOC)+"' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td width='30%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=\""+Formatter.format(view.strTIT_DOC)+"\"></td>";
			str+="<td width='30%' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=\""+Formatter.format(view.strRSP_DOC)+"\"></td>";
			str+="<td width='30%' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=\""+Formatter.format(view.dtDAT_REV_DOC)+"\"></td></tr>";
	}
	str+="</table>";
	return str;
}

String BuildNormativeSentenzeView(IMisurePreventProtettiveAz bean){
	String str;
	java.util.Collection col = bean.getNormativeSentenzeView();
	
	str="<table border='0' id='NormativeSentenzeHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='50%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Titolo.normativa/sentenza")+
                "</strong></td>";
	str+="<td width='50%'><strong>&nbsp;"+
                ApplicationConfigurator.LanguageManager.getString("Data.normativa/sentenza")+
                "</strong></td></tr>";
	str+="</table>";
	str+="<table border='1' id='NormativeSentenze' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td width='50%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=''></td>";
	str+="<td width='50%' class='dataTd'><input type='text' name='DAT_REV_DOC' readonly class='dataInput'  value=''></td></tr>";
	
		java.util.Iterator it = col.iterator();
 		while(it.hasNext()){
			MPAZ_NormativeSentenzeView view=(MPAZ_NormativeSentenzeView)it.next();
			str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_NOR_SEN)+"' INDEX='"+Formatter.format(bean.getCOD_MIS_PET_AZL())+"'><td width='50%' class='dataTd'><input type='text' name='TIT_DOC' class='dataInput' readonly  value=\""+Formatter.format(view.strTIT_NOR_SEN)+"\"></td>";
			str+="<td width='50%' class='dataTd'><input type='text' name='RSP_DOC' readonly class='dataInput'  value=\""+Formatter.format(view.dtDAT_NOR_SEN)+"\"></td></tr>";
	}
	str+="</table>";
	return str;
}
%>
