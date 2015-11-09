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
<%@ page import="com.apconsulting.luna.ejb.InterventoAudut.*" %>

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

	//----Intervento d'audit----
	IInterventoAudut bean=null;
	IInterventoAudutHome home=(IInterventoAudutHome)PseudoContext.lookup("InterventoAudutBean");
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
		curTab = "Non Conformita";
		out.println("tab1");
		str=BuildNonConformitaTab(bean);
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
 
String BuildNonConformitaTab(IInterventoAudut bean){
	String str="";
	str="<table border='0' align='left' width='663' id='NonCfoHeader' class='dataTableHeader' cellpadding='0' cellspacing='0'>";
	str+="<tr><td width='313'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Descrizione") + "</strong></td>"+
                "<td width='200'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Nome.rilevatore") + "</strong></td>"+
                "<td width='150'><strong>&nbsp;" + ApplicationConfigurator.LanguageManager.getString("Data") + "</strong></td></tr>";
	str+="</table>";
	str+="<table border='0' align='left' width='663' id='NonCfo' class='dataTable' cellpadding='0' cellspacing='0'>";
	str+="<tr style='display:none' ID='' INDEX='"+Formatter.format(bean.getCOD_INR_ADT())+"'><td  class='dataTd'><input type='text' name='DES_NON_CFO' class='dataInput' readonly  value=''></td>";
	str+="<td  class='dataTd'><input type='text' name='NOM_RIL_NON_CFO' class='dataInput' readonly  value=''></td>";
	str+="<td  class='dataTd'><input type='text' name='DAT_RIL_NON_CFO' class='dataInput' readonly  value=''></td>";
	str+="</tr>";
		if (bean!=null){
			java.util.Collection col = bean.getNonConformita();
			java.util.Iterator it = col.iterator();
	 		while(it.hasNext()){
				NonConformitaView view=(NonConformitaView)it.next();
                                str+="<tr style='display:' ID='"+Formatter.format(view.lCOD_NON_CFO)+"' INDEX='"+Formatter.format(bean.getCOD_INR_ADT())+"'><td class='dataTd'><input type='text' name='DES_NON_CFO' class='inputstyle' readonly style='width: 313px;'  value=\""+Formatter.format(view.strDES_NON_CFO)+"\"></td>";
                                str+="<td  class='dataTd'><input type='text' name='NOM_LUO_FSC' class='inputstyle' readonly style='width: 200px;'  value=\""+Formatter.format(view.strNOM_RIL_NON_CFO)+"\"></td>";
                                str+="<td  class='dataTd'><input type='text' name='DAT_RIL_NON_CFO' class='inputstyle'' readonly style='width: 150px;'  value=\""+Formatter.format(view.dtDAT_RIL_NON_CFO)+"\"></td>";
			}
		}	
	str+="</table>";
	return str;
}
 %>
