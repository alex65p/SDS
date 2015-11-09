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
    <version number="1.0" date="19/02/2004" author="Alex Kyba">
	      <comments>
				  <comment date="19/02/2004" author="Alex Kyba">
					   <description>Kod dlia refresha tabov</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/ 
%>
<%@ page import="com.apconsulting.luna.ejb.UnitaOrganizzativa.*" %>

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
String curTab = new String();
boolean isError = false;
java.util.Collection  col;
java.util.Iterator it;

	IUnitaOrganizzativa bean=null;
	IUnitaOrganizzativaHome home=(IUnitaOrganizzativaHome)PseudoContext.lookup("UnitaOrganizzativaBean");

if (request.getParameter("ID_PARENT")!=null){
	Long ID = new Long(request.getParameter("ID_PARENT"));
	out.println(ID);
	try{
		bean=home.findByPrimaryKey(ID);
	}
	catch(Exception ex){
		err= "Cannot find record with ID="+ID.toString();
		err+="<br>"+ex.getMessage();
		out.println("<script>err = true</script>");
		out.print("<div id='errContent'>"+err+"</div>");
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
		curTab = "Luoghi Fisici";
		out.println("tab1");
		str=BuildLuogoFisicoTab(bean);
		out.print(str);
	}	
	if (!isError && nameTab.equals("tab2")){
		curTab = "Attivita Lavorativa";
		out.println("tab2");
		str=BuildAttivitaLavorativaTab(bean);
		out.print(str);
	}
}	
catch(Exception ex){
		out.println("</div>");
		err= "Impossible rebuild "+curTab+" tab content";
		err+="<br>"+ex.getMessage();
		out.println("<script>err = true</script>");
		out.print("<div id='errContent'>"+err+"</div>");
		//return;
	}	
 %>
 </div>
 <script>
 if (!err){
	 parent.tabbar.ReloadTabTable(document);
 }
 else{
 	alert(errContent.innerText);
 }	
 
 </script>
 
 <%!
 
String BuildLuogoFisicoTab(IUnitaOrganizzativa bean){
	String str="";
	
	str="<table border='0' align='left' width='538' id='LuoFscHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='538' id='LuoFsc' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(bean.getCOD_UNI_ORG())+"\"><td width='538' class='dataTd'><input type='text' name='NOM_LUO_FSC' class='inputstyle' readonly  value=''></td></tr>";
	
		if (bean!=null){
			java.util.Collection col = bean.getLuoghiFisiciView();
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				LuoghiFisiciView view=(LuoghiFisiciView)it.next();
				str+="<tr style='display:' ID=\""+Formatter.format(view.lCOD_LUO_FSC)+"\" INDEX=\""+Formatter.format(bean.getCOD_UNI_ORG())+"\"><td class='dataTd'><input type='text' name='NOM_LUO_FSC' class='inputstyle' readonly style='width: 538px;'  value=\""+Formatter.format(view.strNOM_LUO_FSC)+"\"></td></tr>";
			}
		}	
	str+="</table>";
	return str;
}

String BuildAttivitaLavorativaTab(IUnitaOrganizzativa bean){
	String str="";

	str="<table border='0' align='left' width='538' id='AttLavHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='538' id='AttLav' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX=\""+Formatter.format(bean.getCOD_UNI_ORG())+"\"><td width='538' class='dataTd'><input type='text' name='NOM_MAN' class='inputstyle' readonly  value=''></td></tr>";
	if (bean!=null){	
		java.util.Collection col = bean.getAttivitaLavorativaView();	
		java.util.Iterator it = col.iterator(); 
 		while(it.hasNext()){
			AttivitaLavorativaView view=(AttivitaLavorativaView)it.next();
			str+="<tr style='display:' ID=\""+Formatter.format(view.lCOD_MAN)+"\" INDEX=\""+Formatter.format(bean.getCOD_UNI_ORG())+"\"><td class='dataTd'><input type='text' name='NOM_MAN' class='inputstyle' readonly style='width: 538px;'  value=\""+Formatter.format(view.strNOM_MAN)+"\"></td></tr>";
		}
	}	
	str+="</table>";
	return str;
}

 %>
